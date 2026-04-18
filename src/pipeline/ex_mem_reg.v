/*
 * Module:  ex_mem_reg
 *
 * Description:
 *   Pipeline register between Execute (EX) and Memory (MEM).
 *   Carries only the signals needed for forwarding and write-back.
 *   Note: DMEM address and write signals are driven combinationally 
 *   from EX directly to SRAM (no register overhead).
 *
 * Notes:
 *   flush=1 : inject NOP bubble on branch taken
 */

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
