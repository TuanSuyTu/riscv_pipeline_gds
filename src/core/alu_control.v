/*
 * Module:  alu_control
 *
 * Description:
 *   ALU Control unit. Decodes alu_op and funct fields into ALU control signals.
 *   Handles special cases like LUI (PASS_B) and distinguishes between 
 *   arithmetic/logical shifts using funct7_5.
 */

`timescale 1ns / 1ps

module alu_control (
    input  [1:0] alu_op,
    input  [2:0] funct3,
    input        funct7_5,
    input        lui,
    output reg [3:0] alu_ctrl
);
    wire is_rtype = (alu_op == 2'b10);

    always @(*) begin
        // ==========================================================
        // Operation Decoding Logic
        //
        // Method:
        //   - Decode based on primary `alu_op`
        //   - Map AL-ops using standard RV32I funct3 decoding
        //   - Differentiate logical/arithmetic using funct7_5
        // ==========================================================
        case (alu_op)
            2'b00: alu_ctrl = lui ? 4'b1010 : 4'b0000;
            2'b01: alu_ctrl = 4'b0001;
            
            2'b10, 2'b11: begin
                case (funct3)
                    3'b000: alu_ctrl = (is_rtype & funct7_5) ? 4'b0001 : 4'b0000;
                    3'b001: alu_ctrl = 4'b0101;
                    3'b010: alu_ctrl = 4'b1000;
                    3'b011: alu_ctrl = 4'b1001;
                    3'b100: alu_ctrl = 4'b0100;
                    3'b101: alu_ctrl = funct7_5 ? 4'b0111 : 4'b0110;
                    3'b110: alu_ctrl = 4'b0011;
                    3'b111: alu_ctrl = 4'b0010;
                    default: alu_ctrl = 4'b0000;
                endcase
            end
            default: alu_ctrl = 4'b0000;
        endcase
    end
endmodule
