/*
 * Module:  alu
 *
 * Description:
 *   Arithmetic Logic Unit for RV32I.
 *   Implements adder sharing for ADD/SUB/SLT/SLTU to reduce area.
 *   Logical shifts are processed efficiently using generic operators.
 *   Zero flag is explicitly bypassed for faster branch evaluation.
 */

`timescale 1ns / 1ps

module alu (
    input  [31:0] a,
    input  [31:0] b,
    input  [3:0]  alu_ctrl, // 4-bit Control interface
    output reg [31:0] result,
    output zero
);
    // ==========================================================
    // ALU Opcodes
    // ==========================================================
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

    // ==========================================================
    // Hardware Optimization: Shared Adder Datapath
    //
    // Purpose:
    //   Instead of instantiating separate adders and comparators, 
    //   ADD, SUB, SLT, and SLTU operations share a single 33-bit adder.
    //
    // Method:
    //   - Invert operand B for subtraction/comparison
    //   - Append a 0-bit at MSB for unsigned 33-bit carry evaluation
    // ==========================================================
    wire is_sub = (alu_ctrl == SUB) || (alu_ctrl == SLT) || (alu_ctrl == SLTU);
    wire [31:0] b_inv = is_sub ? ~b : b;
    wire [32:0] sum_ext = {1'b0, a} + {1'b0, b_inv} + {32'd0, is_sub};
    wire [31:0] sum = sum_ext[31:0];

    // ==========================================================
    // Zero & Comparison Logic
    //
    // Assumptions:
    //   - BEQ/BNE logic relies directly on the `zero` flag asynchronously
    //   - SLTU relies on the carry-out (sum_ext[32])
    // ==========================================================
    wire slt_res  = (a[31] != b[31]) ? a[31] : sum[31];
    wire sltu_res = ~sum_ext[32];
    
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
