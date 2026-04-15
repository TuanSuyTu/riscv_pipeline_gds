// =============================================================================
// Project: RISC-V 5-Stage Pipelined Processor
// Module: ex_mem_reg
// Description: Pipeline stage register between Execute (EX) and Memory (MEM).
//              OPT-1: Simplified — SRAM now receives combinational signals
//              from EX stage directly, so mem_read/mem_write/funct3/rs2_data
//              are no longer piped through here for SRAM use.
//              Remaining signals are for forwarding + write-back path only.
// =============================================================================

module ex_mem_reg (
    input clk, rst,
    input flush,      // Flush on branch taken (inject NOP)

    input        reg_write_in, mem_to_reg_in,
    input        jump_in,
    input [31:0] alu_result_in, pc_plus4_in,
    input [4:0]  rd_addr_in,

    output reg        reg_write_out, mem_to_reg_out,
    output reg        jump_out,
    output reg [31:0] alu_result_out, pc_plus4_out,
    output reg [4:0]  rd_addr_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            {reg_write_out, mem_to_reg_out, jump_out,
             alu_result_out, pc_plus4_out,
             rd_addr_out} <= 0;
        end else begin
            if (flush) begin
                // Inject NOP bubble
                {reg_write_out, mem_to_reg_out, jump_out,
                 alu_result_out, pc_plus4_out,
                 rd_addr_out} <= 0;
            end else begin
                reg_write_out  <= reg_write_in;
                mem_to_reg_out <= mem_to_reg_in;
                jump_out       <= jump_in;
                alu_result_out <= alu_result_in;
                pc_plus4_out   <= pc_plus4_in;
                rd_addr_out    <= rd_addr_in;
            end
        end
    end
endmodule
