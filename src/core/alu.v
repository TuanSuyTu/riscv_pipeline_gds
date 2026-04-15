// =============================================================================
// Project: RISC-V 6-Stage Pipelined Processor
// Module: alu
// Description: Arithmetic Logic Unit for RV32I.
//              Optimized with Adder Sharing and Zero-flag bypass.
// =============================================================================

`timescale 1ns / 1ps

module alu (
    input  [31:0] a,
    input  [31:0] b,
    input  [3:0]  alu_ctrl, // 4-bit Control interface
    output reg [31:0] result,
    output zero
);
    // Operation encodings
    localparam ADD    = 4'b0000;
    localparam SUB    = 4'b0001;
    localparam AND    = 4'b0010;
    localparam OR     = 4'b0011;
    localparam XOR    = 4'b0100;
    localparam SLL    = 4'b0101;
    localparam SRL    = 4'b0110;
    localparam SRA    = 4'b0111;
    localparam SLT    = 4'b1000;
    localparam SLTU   = 4'b1001;
    localparam PASS_B = 4'b1010;

    // --- Adder Sharing for ADD, SUB, SLT, SLTU ---
    wire is_sub = (alu_ctrl == SUB) || (alu_ctrl == SLT) || (alu_ctrl == SLTU);
    wire [31:0] b_inv = is_sub ? ~b : b;
    // 33-bit addition for carry out (used for unsigned comparison)
    wire [32:0] sum_ext = {1'b0, a} + {1'b0, b_inv} + {32'd0, is_sub};
    wire [31:0] sum = sum_ext[31:0];

    // --- Bypass Zero and Comparison outputs ---
    wire slt_res  = (a[31] != b[31]) ? a[31] : sum[31];
    wire sltu_res = ~sum_ext[32]; // Carry out indicates a >= b, so ~carry means a < b
    
    // Zero flag bypass (specifically for BEQ/BNE branch checking which uses SUB)
    assign zero = (sum == 32'd0);

    always @(*) begin
        case (alu_ctrl)
            ADD:    result = sum;
            SUB:    result = sum;
            AND:    result = a & b;
            OR:     result = a | b;
            XOR:    result = a ^ b;
            SLL:    result = a << b[4:0];
            SRL:    result = a >> b[4:0];
            SRA:    result = $signed(a) >>> b[4:0];
            SLT:    result = {31'd0, slt_res};
            SLTU:   result = {31'd0, sltu_res};
            PASS_B: result = b;
            default: result = 32'd0;
        endcase
    end

endmodule
