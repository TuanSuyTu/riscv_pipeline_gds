/*
 * Module:  ex_stage
 *
 * Description:
 *   Unified Execute Stage.
 *   Merges ALU operand preparation, execution, branch comparison,
 *   and target address calculation into a single combinational stage.
 *   Implements a 2-level MUX tree for forwarding.
 */

`timescale 1ns / 1ps

module ex_stage (
    // === Data Inputs from ID/EX Register ===
    input  [31:0] rs1_data_ex,
    input  [31:0] rs2_data_ex,
    input  [31:0] imm_ex,
    input  [31:0] pc_ex,

    // === Control Inputs from ID/EX Register ===
    input  [1:0]  alu_op_ex,
    input  [2:0]  funct3_ex,
    input         funct7_5_ex,
    input         alu_src_ex,
    input         lui_ex,
    input         auipc_ex,
    input         branch_ex,
    input         jump_ex,
    input         is_jalr_ex,

    // === Forwarding Inputs ===
    input  [1:0]  forward_a,       // From forwarding unit
    input  [1:0]  forward_b,       // From forwarding unit
    input  [31:0] alu_result_mem,  // Forwarded from EX/MEM pipeline reg
    input  [31:0] wd_data_wb,      // Forwarded from WB stage

    // === Outputs to EX/MEM Register ===
    output [31:0] alu_result,      // ALU computation result
    output [31:0] forwarded_b_out, // rs2 data for Store instructions

    // === Outputs to IF Stage (Branch/Jump control) ===
    output        pc_sel,          // Redirect PC on branch taken / jump
    output [31:0] jump_tgt         // Target address for branch/jump
);

    // Forwarding MUXes: Level 1 (EX/MEM) -> Level 2 (MEM/WB)
    wire [31:0] fwd_a_l1   = forward_a[1] ? alu_result_mem : rs1_data_ex;
    wire [31:0] forwarded_a = forward_a[0] ? wd_data_wb    : fwd_a_l1;

    wire [31:0] fwd_b_l1   = forward_b[1] ? alu_result_mem : rs2_data_ex;
    wire [31:0] forwarded_b = forward_b[0] ? wd_data_wb    : fwd_b_l1;

    // ALU Input MUXes
    wire [31:0] alu_in_a = lui_ex   ? 32'd0  :
                           auipc_ex ? pc_ex   : forwarded_a;

    wire [31:0] alu_in_b = alu_src_ex ? imm_ex : forwarded_b;


    wire [3:0] alu_ctrl;
    alu_control alu_control_inst (
        .alu_op(alu_op_ex),
        .funct3(funct3_ex),
        .funct7_5(funct7_5_ex),
        .lui(lui_ex),
        .alu_ctrl(alu_ctrl)
    );


    wire alu_zero;
    alu alu_inst (
        .a(alu_in_a),
        .b(alu_in_b),
        .alu_ctrl(alu_ctrl),
        .result(alu_result),
        .zero(alu_zero)
    );

    // Branch evaluation using forwarded operands
    wire signed_lt   = ($signed(forwarded_a) < $signed(forwarded_b));
    wire unsigned_lt = (forwarded_a < forwarded_b);

    wire branch_taken =
        (funct3_ex == 3'b000) ?  alu_zero    : // BEQ
        (funct3_ex == 3'b001) ? ~alu_zero    : // BNE
        (funct3_ex == 3'b100) ?  signed_lt   : // BLT
        (funct3_ex == 3'b101) ? ~signed_lt   : // BGE
        (funct3_ex == 3'b110) ?  unsigned_lt : // BLTU
        (funct3_ex == 3'b111) ? ~unsigned_lt : // BGEU
        1'b0;

    // Target Address Calculation
    wire [31:0] br_jal_tgt = pc_ex + imm_ex;
    wire [31:0] jalr_tgt   = {alu_result[31:1], 1'b0};

    assign pc_sel   = jump_ex | (branch_ex & branch_taken);
    assign jump_tgt = is_jalr_ex ? jalr_tgt : br_jal_tgt;

    // Pass-through rs2 for Store data
    assign forwarded_b_out = forwarded_b;

endmodule
