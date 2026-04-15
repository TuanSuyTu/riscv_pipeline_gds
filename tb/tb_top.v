// =============================================================================
// RISC-V 5-Stage Pipeline — Comprehensive Testbench
// Covers: All RV32I ALU ops, LUI, AUIPC, LW/SW, BEQ/BNE, JAL, JALR,
//         EX/MEM forwarding, MEM/WB forwarding, Load-Use hazard
// =============================================================================
`timescale 1ns / 1ps

module tb_top;

    reg clk, rst;
    wire [31:0] imem_addr, imem_data;
    wire        dmem_we, dmem_re;
    wire [2:0]  dmem_funct3;
    wire [31:0] dmem_addr, dmem_wdata, dmem_rdata;

    // === DUT: CPU Core ===
    top dut (
        .clk(clk), .rst(rst),
        .imem_addr(imem_addr), .imem_data(imem_data),
        .dmem_we(dmem_we),     .dmem_re(dmem_re),
        .dmem_funct3(dmem_funct3),
        .dmem_addr(dmem_addr), .dmem_wdata(dmem_wdata),
        .dmem_rdata(dmem_rdata)
    );

    // === Instruction Memory (Combinational Read — no latency) ===
    reg [31:0] imem [0:255];
    assign imem_data = imem[imem_addr[9:2]];

    // === Data Memory (Synchronous Read — 1-cycle latency for BRAM stall) ===
    reg [31:0] dmem_array [0:255];
    reg [31:0] dmem_rdata_reg;

    always @(posedge clk) begin
        if (dmem_we)
            dmem_array[dmem_addr[9:2]] <= dmem_wdata;
        dmem_rdata_reg <= dmem_array[dmem_addr[9:2]];
    end
    assign dmem_rdata = dmem_rdata_reg;

    // === Clock Generation (100 MHz, 10ns period) ===
    always #5 clk = ~clk;

    // === VCD Dump ===
    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);
    end

    // === Load Test Program ===
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            imem[i]      = 32'h00000013; // NOP
            dmem_array[i] = 32'h00000000;
        end

        // =====================================================================
        // COMPACT TEST SEQUENCE (No NOP paddings!)
        // =====================================================================
        imem[0]  = 32'h00A00093; // ADDI x1,  x0, 10
        imem[1]  = 32'h01400113; // ADDI x2,  x0, 20
        imem[2]  = 32'hFFF00193; // ADDI x3,  x0, -1
        imem[3]  = 32'h00208233; // ADD  x4,  x1, x2
        imem[4]  = 32'h401102B3; // SUB  x5,  x2, x1
        imem[5]  = 32'h0020F333; // AND  x6,  x1, x2
        imem[6]  = 32'h0020E3B3; // OR   x7,  x1, x2
        imem[7]  = 32'h0020C433; // XOR  x8,  x1, x2
        imem[8]  = 32'h0020A4B3; // SLT  x9,  x1, x2
        imem[9]  = 32'h0030B533; // SLTU x10, x1, x3
        imem[10] = 32'h00209593; // SLLI x11, x1, 2
        imem[11] = 32'h00115613; // SRLI x12, x2, 1
        imem[12] = 32'h4041D693; // SRAI x13, x3, 4
        imem[13] = 32'h00F17713; // ANDI x14, x2, 0xF
        imem[14] = 32'h1000E793; // ORI  x15, x1, 0x100
        imem[15] = 32'h0FF0C813; // XORI x16, x1, 0xFF
        imem[16] = 32'hABCDE8B7; // LUI   x17, 0xABCDE
        imem[17] = 32'h00000917; // AUIPC x18, 0  @0x44 (68) -> x18 = 0x44
        imem[18] = 32'h00102023; // SW x1, 0(x0)
        imem[19] = 32'h00202223; // SW x2, 4(x0)
        imem[20] = 32'h00002983; // LW x19, 0(x0)
        imem[21] = 32'h00402A03; // LW x20, 4(x0)
        imem[22] = 32'h06400A93; // ADDI x21, x0, 100
        imem[23] = 32'h032A8B13; // ADDI x22, x21, 50
        imem[24] = 32'h016A8BB3; // ADD  x23, x21, x22
        imem[25] = 32'h00402423; // SW x4, 8(x0)
        imem[26] = 32'h00802C03; // LW x24, 8(x0)
        imem[27] = 32'h005C0C93; // ADDI x25, x24, 5       (load use hazard here)
        imem[28] = 32'h00208663; // BEQ x1, x2, +12  @0x70 not taken
        imem[29] = 32'h00100D13; // ADDI x26, x0, 1
        imem[30] = 32'h00000663; // BEQ x0, x0, +12  @0x78 taken to 30+3=33
        imem[31] = 32'h06300D13; // ADDI x26, x0, 99
        imem[32] = 32'h06300D13; // ADDI x26, x0, 99
        imem[33] = 32'h00209663; // BNE x1, x2, +12  @0x84 taken to 33+3=36 (x1=10, x2=20, 10!=20)
        imem[34] = 32'h06300D93; // ADDI x27, x0, 99
        imem[35] = 32'h06300D93; // ADDI x27, x0, 99
        imem[36] = 32'h00200D93; // ADDI x27, x0, 2
        imem[37] = 32'h00C00E6F; // JAL x28, +12     @0x94 taken to 37+3=40. x28=0x98.
        imem[38] = 32'h06300E93; // ADDI x29, x0, 99
        imem[39] = 32'h06300E93; // ADDI x29, x0, 99
        imem[40] = 32'h00000E97; // AUIPC x29, 0     @0xA0 -> x29 = 0xA0.
        imem[41] = 32'h018E8F67; // JALR x30, x29, +24 @0xA4 -> target is 0xA0+24 = 0xB8 (index 46).
        imem[42] = 32'h06300F93; // ADDI x31, x0, 99
        imem[43] = 32'h06300F93; // ADDI x31, x0, 99
        imem[44] = 32'h06300F93; // padding
        imem[45] = 32'h06300F93; // padding
        imem[46] = 32'h02A00F93; // ADDI x31, x0, 42    @0xB8 (landed)
        
        // Final infinite loop delay
        imem[47] = 32'h00000013; // NOP
        imem[48] = 32'h00000013; // NOP
        imem[49] = 32'h00000013; // NOP
        imem[50] = 32'h00000013; // NOP
        imem[51] = 32'h00000063; // BEQ x0, x0, 0
    end

    // =========================================================================
    // Self-Checking Logic
    // =========================================================================
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

    // =========================================================================
    // Main Test Sequence
    // =========================================================================
    initial begin
        clk = 0; rst = 1;
        pass_count = 0; fail_count = 0;

        // Hold reset for 4 cycles
        #40;
        rst = 0;

        // Wait generously for program to complete (~100 cycles + margin)
        #6000;

        $display("");
        $display("============================================================");
        $display("     RISC-V 5-Stage Pipeline Verification Results");
        $display("============================================================");

        // --- Phase 1: I-type ALU Setup ---
        $display("\n  [Phase 1] I-type ALU (Setup)");
        check_reg( 1, 32'd10,         "ADDI x1, x0, 10");
        check_reg( 2, 32'd20,         "ADDI x2, x0, 20");
        check_reg( 3, 32'hFFFFFFFF,   "ADDI x3, x0, -1");

        // --- Phase 2: R-type ALU ---
        $display("\n  [Phase 2] R-type ALU");
        check_reg( 4, 32'd30,         "ADD  x4, x1, x2");
        check_reg( 5, 32'd10,         "SUB  x5, x2, x1");
        check_reg( 6, 32'd0,          "AND  x6, x1, x2");
        check_reg( 7, 32'd30,         "OR   x7, x1, x2");
        check_reg( 8, 32'd30,         "XOR  x8, x1, x2");
        check_reg( 9, 32'd1,          "SLT  x9, x1<x2");
        check_reg(10, 32'd1,          "SLTU x10, x1<ux3");

        // --- Phase 3: Shifts ---
        $display("\n  [Phase 3] Shifts");
        check_reg(11, 32'd40,         "SLLI x11, x1<<2");
        check_reg(12, 32'd10,         "SRLI x12, x2>>1");
        check_reg(13, 32'hFFFFFFFF,   "SRAI x13, x3>>>4");

        // --- Phase 4: I-type ALU (Extended) ---
        $display("\n  [Phase 4] I-type ALU (Extended)");
        check_reg(14, 32'd4,          "ANDI x14, x2&0xF");
        check_reg(15, 32'd266,        "ORI  x15, x1|0x100");
        check_reg(16, 32'd245,        "XORI x16, x1^0xFF");

        // --- Phase 5: LUI + AUIPC ---
        $display("\n  [Phase 5] LUI + AUIPC");
        check_reg(17, 32'hABCDE000,   "LUI  x17, 0xABCDE");
        check_reg(18, 32'h00000044,   "AUIPC x18, 0 @0x44");

        // --- Phase 6: Load / Store ---
        $display("\n  [Phase 6] Load / Store");
        check_reg(19, 32'd10,         "LW x19, 0(x0)");
        check_reg(20, 32'd20,         "LW x20, 4(x0)");

        // --- Phase 7: Forwarding ---
        $display("\n  [Phase 7] EX/MEM + MEM/WB Forwarding");
        check_reg(21, 32'd100,        "ADDI x21=100");
        check_reg(22, 32'd150,        "ADDI x22=x21+50 (fwd)");
        check_reg(23, 32'd250,        "ADD  x23=x21+x22 (dbl)");

        // --- Phase 8: Load-Use Hazard ---
        $display("\n  [Phase 8] Load-Use Hazard");
        check_reg(24, 32'd30,         "LW x24=30");
        check_reg(25, 32'd35,         "ADDI x25=x24+5 (lduse)");

        // --- Phase 9: BEQ ---
        $display("\n  [Phase 9] BEQ (not-taken + taken)");
        check_reg(26, 32'd1,          "x26=1 (BEQ skip ok)");

        // --- Phase 10: BNE ---
        $display("\n  [Phase 10] BNE (taken)");
        check_reg(27, 32'd2,          "x27=2 (BNE taken ok)");

        // --- Phase 11: JAL ---
        $display("\n  [Phase 11] JAL");
        check_reg(28, 32'h00000098,   "JAL x28 link=0x98");

        // --- Phase 12: JALR ---
        $display("\n  [Phase 12] JALR");
        check_reg(29, 32'h000000A0,   "AUIPC x29=0xA0");
        check_reg(30, 32'h000000A8,   "JALR x30 link=0xA8");
        check_reg(31, 32'd42,         "x31=42 (JALR landed)");

        // --- Summary ---
        $display("\n============================================================");
        $display("     TOTAL: %0d PASSED, %0d FAILED", pass_count, fail_count);
        $display("============================================================");
        if (fail_count == 0)
            $display("     >>> ALL TESTS PASSED! <<<");
        else
            $display("     >>> SOME TESTS FAILED — check VCD <<<");
        $display("");

        $finish;
    end

endmodule
