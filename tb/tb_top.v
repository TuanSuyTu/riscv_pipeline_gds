/*
 * Module:  tb_top
 *
 * Description:
 *   Comprehensive Testbench for RISC-V 5-Stage Pipeline purely RTL Core.
 *   Covers RV32I ALU ops, Memory Loads/Stores, Control Flow, and Forwarding.
 */
`timescale 1ns / 1ps

module tb_top;

    reg clk, rst;
    wire [31:0] imem_addr, imem_data;
    wire        dmem_we, dmem_re;
    wire [2:0]  dmem_funct3;
    wire [31:0] dmem_addr, dmem_wdata, dmem_rdata;

    // DUT: CPU Core
    top dut (
        .clk(clk), .rst(rst),
        .imem_addr(imem_addr), .imem_data(imem_data),
        .dmem_we(dmem_we),     .dmem_re(dmem_re),
        .dmem_funct3(dmem_funct3),
        .dmem_addr(dmem_addr), .dmem_wdata(dmem_wdata),
        .dmem_rdata(dmem_rdata)
    );

    // Instruction Memory (Synchronous Read — matches Sky130 SRAM 1-cycle latency)
    reg [31:0] imem [0:255];
    reg [31:0] imem_data_reg;
    always @(posedge clk)
        imem_data_reg <= imem[imem_addr[9:2]];
    assign imem_data = imem_data_reg;

    // Data Memory (Synchronous Read)
    reg [31:0] dmem_array [0:255];
    reg [31:0] dmem_rdata_reg;
    
    // Delayed Funct3 and Byte Offset for Read Unpacking
    reg [2:0] funct3_r;
    reg [1:0] byte_offset_r;
    reg       mem_read_r;

    wire [1:0] byte_offset = dmem_addr[1:0];
    
    always @(posedge clk) begin
        if (dmem_we) begin
            // Write Masking Logic
            case (dmem_funct3)
                3'b010: // SW
                    dmem_array[dmem_addr[9:2]] <= dmem_wdata;
                3'b001: // SH
                    if (byte_offset[1] == 1'b0)
                        dmem_array[dmem_addr[9:2]][15:0] <= dmem_wdata[15:0];
                    else
                        dmem_array[dmem_addr[9:2]][31:16] <= dmem_wdata[15:0];
                3'b000: // SB
                    case (byte_offset)
                        2'b00: dmem_array[dmem_addr[9:2]][7:0]   <= dmem_wdata[7:0];
                        2'b01: dmem_array[dmem_addr[9:2]][15:8]  <= dmem_wdata[7:0];
                        2'b10: dmem_array[dmem_addr[9:2]][23:16] <= dmem_wdata[7:0];
                        2'b11: dmem_array[dmem_addr[9:2]][31:24] <= dmem_wdata[7:0];
                    endcase
            endcase
        end
        
        // Synchronous Read Process
        dmem_rdata_reg <= dmem_array[dmem_addr[9:2]];
        funct3_r       <= dmem_funct3;
        byte_offset_r  <= byte_offset;
        mem_read_r     <= dmem_re;
    end
    
    // Unpacking Logic (Comb)
    reg [31:0] dmem_rdata_comb;
    always @(*) begin
        if (mem_read_r) begin
            case (funct3_r)
                3'b000: begin // LB
                    case (byte_offset_r)
                        2'b00: dmem_rdata_comb = {{24{dmem_rdata_reg[7]}},  dmem_rdata_reg[7:0]};
                        2'b01: dmem_rdata_comb = {{24{dmem_rdata_reg[15]}}, dmem_rdata_reg[15:8]};
                        2'b10: dmem_rdata_comb = {{24{dmem_rdata_reg[23]}}, dmem_rdata_reg[23:16]};
                        2'b11: dmem_rdata_comb = {{24{dmem_rdata_reg[31]}}, dmem_rdata_reg[31:24]};
                    endcase
                end
                3'b001: begin // LH
                    if (byte_offset_r[1] == 1'b0)
                        dmem_rdata_comb = {{16{dmem_rdata_reg[15]}}, dmem_rdata_reg[15:0]};
                    else
                        dmem_rdata_comb = {{16{dmem_rdata_reg[31]}}, dmem_rdata_reg[31:16]};
                end
                3'b010: dmem_rdata_comb = dmem_rdata_reg; // LW
                3'b100: begin // LBU
                    case (byte_offset_r)
                        2'b00: dmem_rdata_comb = {24'd0, dmem_rdata_reg[7:0]};
                        2'b01: dmem_rdata_comb = {24'd0, dmem_rdata_reg[15:8]};
                        2'b10: dmem_rdata_comb = {24'd0, dmem_rdata_reg[23:16]};
                        2'b11: dmem_rdata_comb = {24'd0, dmem_rdata_reg[31:24]};
                    endcase
                end
                3'b101: begin // LHU
                    if (byte_offset_r[1] == 1'b0)
                        dmem_rdata_comb = {16'd0, dmem_rdata_reg[15:0]};
                    else
                        dmem_rdata_comb = {16'd0, dmem_rdata_reg[31:16]};
                end
                default: dmem_rdata_comb = dmem_rdata_reg;
            endcase
        end else begin
            dmem_rdata_comb = 32'd0;
        end
    end
    
    assign dmem_rdata = dmem_rdata_comb;

    // Clock Generation (100 MHz)
    always #5 clk = ~clk;

    // VCD Dump
    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);
    end

    // Initialize Memories
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            imem[i]      = 32'h00000013; // NOP
            dmem_array[i] = 32'h00000000;
        end
    end

    task automatic RESET_CPU;
        begin
            rst = 1;
            repeat(3) @(posedge clk);
            @(negedge clk);
            rst = 0;
            @(posedge clk);
        end
    endtask

    task automatic RUN;
        input integer cycles;
        begin
            repeat(cycles) @(posedge clk);
        end
    endtask

    // ==========================================================
    // Self-Checking Logic
    // ==========================================================
    integer pass_count, fail_count;

    task check_reg;
        input [4:0]   rn;
        input [31:0]  expected;
        input [255:0] name;
        begin
            if (dut.regfile_inst.regs[rn] === expected) begin
                $display("  [PASS] x%-2d = 0x%08X  %0s", rn, expected, name);
                pass_count = pass_count + 1;
            end else begin
                $display("  [FAIL] x%-2d = 0x%08X (expected 0x%08X)  %0s",
                         rn, dut.regfile_inst.regs[rn], expected, name);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // ==========================================================
    // Main Test Sequence
    // ==========================================================
    initial begin
        clk = 0; rst = 1;
        pass_count = 0; fail_count = 0;

        $display("");
        $display("============================================================");
        $display("     RISC-V RTL Functional Simulation (4 Phases)");
        $display("============================================================");

        // --- PHASE 1 ---
        $display("\n[PHASE 1] ISA Coverage");
        $readmemh("tb/test_phase1_isa.hex", imem);
        dmem_array[0] = 32'd100;
        dmem_array[1] = 32'd200;
        dmem_array[2] = 32'hFFFFFFFF;
        RESET_CPU();
        RUN(75);

        check_reg(1,  32'd5,         "ADDI");
        check_reg(2,  32'd3,         "ADDI");
        check_reg(3,  32'd8,         "ADD");
        check_reg(4,  32'd2,         "SUB");
        check_reg(5,  32'd1,         "AND");
        check_reg(6,  32'd7,         "OR");
        check_reg(7,  32'd6,         "XOR");
        check_reg(8,  32'd40,        "SLL");
        check_reg(9,  32'd0,         "SRL");
        check_reg(10, 32'd1,         "SLT");
        check_reg(11, 32'd0,         "SLTU");
        check_reg(12, 32'h00001000,  "LUI");
        check_reg(14, 32'd100,       "LW");
        check_reg(15, 32'd200,       "LW+4");

        // --- PHASE 2 ---
        $display("\n[PHASE 2] Hazard & Forwarding");
        $readmemh("tb/test_phase2_hazard.hex", imem);
        dmem_array[0] = 32'd42;
        RESET_CPU();
        RUN(65);

        check_reg(2,  32'd20, "EX-EX");
        check_reg(4,  32'd14, "MEM-EX");
        check_reg(6,  32'd84, "LoadUse");
        check_reg(9,  32'd0,  "BEQ-S");
        check_reg(10, 32'd77, "BEQ-T");

        // --- PHASE 3 ---
        $display("\n[PHASE 3] Integration (Sum 1..10)");
        $readmemh("tb/test_phase3_sum.hex", imem);
        RESET_CPU();
        RUN(150);
        check_reg(1, 32'd55, "Sum");

        // --- PHASE 4 ---
        $display("\n[PHASE 4] Full RV32I Checks");
        $readmemh("tb/test_phase4_full.hex", imem);
        dmem_array[0] = 32'd0;
        dmem_array[1] = 32'd0;
        dmem_array[2] = 32'd0;
        RESET_CPU();
        RUN(120);

        check_reg(3,  32'd5,          "ANDI x3=5&7");
        check_reg(4,  32'd7,          "ORI  x4=5|2");
        check_reg(5,  32'd6,          "XORI x5=5^3");
        check_reg(6,  32'd1,          "SLTI x6=-4<0");
        check_reg(7,  32'd1,          "SLTIU x7=5<10u");
        check_reg(8,  32'd20,         "SLLI x8=5<<2");
        check_reg(9,  32'd10,         "SRLI x9=20>>1");
        check_reg(10, 32'hFFFFFFFE,   "SRAI x10=-4>>>1");
        check_reg(11, 32'hFFFFFFFF,   "SRA x11=-4>>>5");
        check_reg(12, 32'h0000102C,   "AUIPC x12");
        check_reg(13, 32'd5,          "BNE taken");
        check_reg(14, 32'd7,          "BLT taken");
        check_reg(15, 32'd9,          "BGE taken");
        check_reg(16, 32'd11,         "BLTU taken");
        check_reg(17, 32'd13,         "BGEU taken");
        check_reg(18, 32'd136,        "JAL link addr");
        check_reg(19, 32'd0,          "JAL skip check");
        check_reg(20, 32'd152,        "JALR link addr");
        check_reg(21, 32'd7,          "JALR jump check");
        check_reg(23, 32'hFFFFFF89,   "LB signed");
        check_reg(24, 32'd137,        "LBU unsigned");
        check_reg(25, 32'hFFFFB789,   "LH signed");
        check_reg(26, 32'd46985,      "LHU unsigned");
        check_reg(28, 32'd90,         "SB/LBU check");
        check_reg(30, 32'd127,        "SH/LH check");

        $display("\n============================================================");
        $display("     TOTAL: %0d PASSED, %0d FAILED", pass_count, fail_count);
        $display("============================================================");
        if (fail_count == 0)
            $display("     >>> ALL 45 TESTS PASSED! <<<");
        else
            $display("     >>> SOME TESTS FAILED — check VCD <<<");
        $display("");

        $finish;
    end

    // DEBUG TRACE
    integer trace_count;
    always @(posedge clk) begin
        if (rst) trace_count <= 0;
        else trace_count <= trace_count + 1;
        
        if (!rst && trace_count < 20) begin
            $display("[TRACE %2d] pc_if=%h imem_addr=%h imem_data=%h | pc_id=%h id_instr=%h | ex_jump=%b mem_wb_wd=%h We=%b", 
                trace_count, dut.pc_if, imem_addr, imem_data, dut.pc_id, dut.instr_id,
                dut.jump_ex, dut.wd_data_wb, dut.reg_write_wb);
        end
    end

endmodule
