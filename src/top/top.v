// =============================================================================
// Project: RISC-V 5-Stage Pipelined Processor
// Module:  top
// Description: CPU Core top-level. Interfaces with external memory via standard bus.
//              Contains pure CPU logic without internal SRAM macros.
//
// Pipeline Stages (Classic 5-stage):
//   IF -> IF/ID Reg -> ID -> ID/EX Reg -> EX -> EX/MEM Reg -> MEM -> MEM/WB Reg -> WB
//
// Optimizations applied:
//   OPT-1: SRAM-as-pipeline-register — DMEM bus driven combinationally from EX
//           → bram_ctrl eliminated, no LOAD stall
//   OPT-2: PC+4 pipe-through from IF stage (32-bit adder removed from EX)
//   OPT-3: Forwarding MUX 2-level tree (in ex_stage.v)
//   OPT-4: WB MUX parallel AND-OR selection
//
// =============================================================================

`timescale 1ns / 1ps

module top (
    input         clk,
    input         rst,

    // === Instruction Memory Bus (Read-only) ===
    output [31:0] imem_addr,       // Instruction address (= PC)
    input  [31:0] imem_data,       // Fetched instruction data

    // === Data Memory Bus (Read/Write) ===
    output        dmem_we,         // Write Enable
    output        dmem_re,         // Read Enable
    output [2:0]  dmem_funct3,     // Access type (LB/LH/LW/SB/SH/SW)
    output [31:0] dmem_addr,       // Data memory address
    output [31:0] dmem_wdata,      // Target write data
    input  [31:0] dmem_rdata       // Read data from memory
);

    // =========================================================================
    // Global Control Signals
    // =========================================================================
    wire stall_loaduse;  // From hazard unit: stall on Load-Use dependency

    wire pc_sel;         // From ex_stage:    redirect PC on branch/jump
    wire [1:0] forward_a, forward_b; // From forward unit

    // --- Stall Logic (simplified: no more bram stall) ---
    wire stall_front = stall_loaduse;

    // --- Flush Logic ---
    // flush_if_id:   On branch taken → kill fetched instruction
    // flush_id_ex:   On load-use stall (bubble) OR branch taken
    wire flush_if_id = pc_sel;
    wire flush_id_ex = stall_loaduse | pc_sel;

    // =========================================================================
    // IF Stage: Instruction Fetch
    // =========================================================================
    wire [31:0] jump_tgt;
    wire [31:0] pc_if;

    pc_reg pc_reg_inst (
        .clk(clk), .rst(rst),
        .stall(stall_front),
        .pc_sel(pc_sel),
        .branch_tgt(jump_tgt),
        .pc(pc_if)
    );

    // IF Stage: Instruction Memory Bus interface
    assign imem_addr = pc_if;
    wire [31:0] instr_if = imem_data;

    // OPT-2: PC+4 calculated ONCE here in IF, then piped through everything
    wire [31:0] pc_plus4_if = pc_if + 32'd4;

    // =========================================================================
    // IF/ID Pipeline Register
    // =========================================================================
    wire [31:0] pc_id, instr_id, pc_plus4_id;
    if_id_reg if_id_reg_inst (
        .clk(clk), .rst(rst),
        .stall(stall_front), .flush(flush_if_id),
        .pc_in(pc_if),             .pc_out(pc_id),
        .instr_in(instr_if),       .instr_out(instr_id),
        .pc_plus4_in(pc_plus4_if), .pc_plus4_out(pc_plus4_id)
    );

    // =========================================================================
    // ID Stage: Instruction Decode & Register Read
    // =========================================================================
    wire [6:0] opcode      = instr_id[6:0];
    wire [4:0] rs1_addr_id = instr_id[19:15];
    wire [4:0] rs2_addr_id = instr_id[24:20];
    wire [4:0] rd_addr_id  = instr_id[11:7];
    wire [2:0] funct3_id   = instr_id[14:12];
    wire       funct7_5_id = instr_id[30];

    wire reg_write_id, mem_read_id, mem_write_id, mem_to_reg_id;
    wire alu_src_id, branch_id, jump_id, lui_id, auipc_id, is_jalr_id;
    wire [1:0] alu_op_id;

    control control_inst (
        .opcode(opcode),
        .reg_write(reg_write_id), .mem_read(mem_read_id),
        .mem_write(mem_write_id), .mem_to_reg(mem_to_reg_id),
        .alu_src(alu_src_id),     .branch(branch_id),
        .jump(jump_id),           .lui(lui_id),
        .auipc(auipc_id),         .is_jalr(is_jalr_id), .alu_op(alu_op_id)
    );

    wire [31:0] imm_id;
    imm_gen imm_gen_inst (
        .instr(instr_id), .imm_out(imm_id)
    );

    // Write-back feedback path (WB -> ID)
    wire        reg_write_wb;
    wire [4:0]  rd_addr_wb;
    wire [31:0] wd_data_wb;

    wire [31:0] rs1_data_id, rs2_data_id;
    regfile regfile_inst (
        .clk(clk),
        .we(reg_write_wb), .wd_addr(rd_addr_wb), .wd_data(wd_data_wb),
        .rs1_addr(rs1_addr_id), .rs2_addr(rs2_addr_id),
        .rs1_data(rs1_data_id), .rs2_data(rs2_data_id)
    );

    // =========================================================================
    // ID/EX Pipeline Register
    // =========================================================================
    wire        reg_write_ex, mem_read_ex, mem_write_ex, mem_to_reg_ex;
    wire        alu_src_ex, branch_ex, jump_ex, lui_ex, auipc_ex, is_jalr_ex;
    wire [1:0]  alu_op_ex;
    wire [31:0] pc_ex, rs1_data_ex, rs2_data_ex, imm_ex, pc_plus4_ex;
    wire [4:0]  rs1_addr_ex, rs2_addr_ex, rd_addr_ex;
    wire [2:0]  funct3_ex;
    wire        funct7_5_ex;

    id_ex_reg id_ex_reg_inst (
        .clk(clk), .rst(rst),
        .flush(flush_id_ex),
        .stall(1'b0),  // No mid-pipeline stall needed anymore
        .reg_write_in(reg_write_id),   .reg_write_out(reg_write_ex),
        .mem_read_in(mem_read_id),     .mem_read_out(mem_read_ex),
        .mem_write_in(mem_write_id),   .mem_write_out(mem_write_ex),
        .mem_to_reg_in(mem_to_reg_id), .mem_to_reg_out(mem_to_reg_ex),
        .alu_src_in(alu_src_id),       .alu_src_out(alu_src_ex),
        .branch_in(branch_id),         .branch_out(branch_ex),
        .jump_in(jump_id),             .jump_out(jump_ex),
        .lui_in(lui_id),               .lui_out(lui_ex),
        .auipc_in(auipc_id),           .auipc_out(auipc_ex),
        .is_jalr_in(is_jalr_id),       .is_jalr_out(is_jalr_ex),
        .alu_op_in(alu_op_id),         .alu_op_out(alu_op_ex),
        .pc_in(pc_id),                 .pc_out(pc_ex),
        .rs1_data_in(rs1_data_id),     .rs1_data_out(rs1_data_ex),
        .rs2_data_in(rs2_data_id),     .rs2_data_out(rs2_data_ex),
        .imm_in(imm_id),              .imm_out(imm_ex),
        .pc_plus4_in(pc_plus4_id),     .pc_plus4_out(pc_plus4_ex),
        .rs1_addr_in(rs1_addr_id),     .rs1_addr_out(rs1_addr_ex),
        .rs2_addr_in(rs2_addr_id),     .rs2_addr_out(rs2_addr_ex),
        .rd_addr_in(rd_addr_id),       .rd_addr_out(rd_addr_ex),
        .funct3_in(funct3_id),         .funct3_out(funct3_ex),
        .funct7_5_in(funct7_5_id),     .funct7_5_out(funct7_5_ex)
    );

    // =========================================================================
    // EX Stage: Execute (ALU, Branch, Forwarding — all in one stage)
    // =========================================================================
    wire [31:0] alu_result_ex;
    wire [31:0] forwarded_b_ex;
    wire [31:0] alu_result_mem; // fed back from EX/MEM register

    ex_stage ex_stage_inst (
        // Data Inputs from ID/EX
        .rs1_data_ex(rs1_data_ex),
        .rs2_data_ex(rs2_data_ex),
        .imm_ex(imm_ex),
        .pc_ex(pc_ex),
        // Control Inputs from ID/EX
        .alu_op_ex(alu_op_ex),
        .funct3_ex(funct3_ex),
        .funct7_5_ex(funct7_5_ex),
        .alu_src_ex(alu_src_ex),
        .lui_ex(lui_ex),
        .auipc_ex(auipc_ex),
        .branch_ex(branch_ex),
        .jump_ex(jump_ex),
        .is_jalr_ex(is_jalr_ex),
        // Forwarding Inputs
        .forward_a(forward_a),
        .forward_b(forward_b),
        .alu_result_mem(alu_result_mem),
        .wd_data_wb(wd_data_wb),
        // Outputs
        .alu_result(alu_result_ex),
        .forwarded_b_out(forwarded_b_ex),
        .pc_sel(pc_sel),
        .jump_tgt(jump_tgt)
    );

    // =========================================================================
    // OPT-1: Data Memory Bus — COMBINATIONAL from EX Stage
    //        SRAM internal latch replaces EX/MEM pipeline register for address.
    //        Gate writes with ~pc_sel to prevent spurious STORE on branch taken.
    // =========================================================================
    assign dmem_we     = mem_write_ex & ~pc_sel;
    assign dmem_re     = mem_read_ex  & ~pc_sel;
    assign dmem_funct3 = funct3_ex;
    assign dmem_addr   = alu_result_ex;
    assign dmem_wdata  = forwarded_b_ex;

    // =========================================================================
    // EX/MEM Pipeline Register (OPT-1: Simplified — no SRAM signals)
    //   Only carries: control (reg_write, mem_to_reg, jump) + alu_result
    //                 + pc_plus4 + rd_addr for forwarding and WB path.
    // =========================================================================
    wire        reg_write_mem, mem_to_reg_mem, jump_mem;
    wire [31:0] pc_plus4_mem;
    wire [4:0]  rd_addr_mem;

    ex_mem_reg ex_mem_reg_inst (
        .clk(clk), .rst(rst),
        .flush(1'b0),  // EX/MEM is not flushed — branch already resolved in EX
        .reg_write_in(reg_write_ex),    .reg_write_out(reg_write_mem),
        .mem_to_reg_in(mem_to_reg_ex),  .mem_to_reg_out(mem_to_reg_mem),
        .jump_in(jump_ex),              .jump_out(jump_mem),
        .alu_result_in(alu_result_ex),  .alu_result_out(alu_result_mem),
        .pc_plus4_in(pc_plus4_ex),      .pc_plus4_out(pc_plus4_mem),
        .rd_addr_in(rd_addr_ex),        .rd_addr_out(rd_addr_mem)
    );

    // =========================================================================
    // MEM Stage: SRAM reads data (soc_top handles unpack)
    //            dmem_rdata comes from soc_top's unpack logic (1 cycle after
    //            SRAM latched the address we sent combinationally from EX).
    // =========================================================================
    wire [31:0] read_data_mem = dmem_rdata;

    // =========================================================================
    // MEM/WB Pipeline Register
    // =========================================================================
    wire        mem_to_reg_wb, jump_wb;
    wire [31:0] read_data_wb, alu_result_wb, pc_plus4_wb;

    mem_wb_reg mem_wb_reg_inst (
        .clk(clk), .rst(rst),
        .reg_write_in(reg_write_mem),   .reg_write_out(reg_write_wb),
        .mem_to_reg_in(mem_to_reg_mem), .mem_to_reg_out(mem_to_reg_wb),
        .jump_in(jump_mem),             .jump_out(jump_wb),
        .read_data_in(read_data_mem),   .read_data_out(read_data_wb),
        .alu_result_in(alu_result_mem), .alu_result_out(alu_result_wb),
        .pc_plus4_in(pc_plus4_mem),     .pc_plus4_out(pc_plus4_wb),
        .rd_addr_in(rd_addr_mem),       .rd_addr_out(rd_addr_wb)
    );

    // =========================================================================
    // WB Stage: Write-Back MUX (OPT-4: Parallel AND-OR Selection)
    //   wb_sel encoding (one-hot, mutually exclusive):
    //     jump_wb=1       → PC+4 (link address for JAL/JALR)
    //     mem_to_reg_wb=1 → Memory read data (LOAD)
    //     neither         → ALU result
    // =========================================================================
    assign wd_data_wb = ({32{jump_wb}}                     & pc_plus4_wb)  |
                        ({32{mem_to_reg_wb & ~jump_wb}}    & read_data_wb) |
                        ({32{~mem_to_reg_wb & ~jump_wb}}   & alu_result_wb);

    // =========================================================================
    // Support Units: Hazard Detection, Data Forwarding
    //   (bram_ctrl REMOVED — OPT-1: SRAM-as-pipeline-reg eliminates stall)
    // =========================================================================
    hazard hazard_inst (
        .id_ex_mem_read(mem_read_ex),
        .id_ex_rd      (rd_addr_ex),
        .if_id_rs1     (rs1_addr_id),
        .if_id_rs2     (rs2_addr_id),
        .stall_loaduse (stall_loaduse)
    );

    forward forward_inst (
        .id_ex_rs1       (rs1_addr_ex),
        .id_ex_rs2       (rs2_addr_ex),
        .ex_mem_reg_write(reg_write_mem),
        .ex_mem_rd       (rd_addr_mem),
        .mem_wb_reg_write(reg_write_wb),
        .mem_wb_rd       (rd_addr_wb),
        .forward_a       (forward_a),
        .forward_b       (forward_b)
    );

endmodule
