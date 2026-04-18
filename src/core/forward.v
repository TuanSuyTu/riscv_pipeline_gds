/*
 * Module:  forward
 *
 * Description:
 *   Data Forwarding Unit (Bypass) to resolve RAW hazards.
 *
 * Method:
 *   - EX/MEM -> EX forwarding (Priority 1: 1-cycle-old result)
 *   - MEM/WB -> EX forwarding (Priority 2: 2-cycle-old result)
 *
 * Constraints:
 *   - Does not forward from R0 (hardwired zero).
 *   - Load-Use hazards are NOT handled here (delegated to hazard unit).
 */

module forward (
    // Source registers of instruction currently in EX stage (from ID/EX reg)
    input  [4:0] id_ex_rs1,
    input  [4:0] id_ex_rs2,

    // Destination from EX/MEM pipeline register (1 cycle ahead)
    input        ex_mem_reg_write,
    input  [4:0] ex_mem_rd,

    // Destination from MEM/WB pipeline register (2 cycles ahead)
    input        mem_wb_reg_write,
    input  [4:0] mem_wb_rd,

    // Forwarding control outputs to EX stage MUXes
    output reg [1:0] forward_a,  // 00=regfile, 10=EX/MEM, 01=MEM/WB
    output reg [1:0] forward_b   // 00=regfile, 10=EX/MEM, 01=MEM/WB
);

    always @(*) begin
        if (ex_mem_reg_write && (ex_mem_rd != 5'd0) && (ex_mem_rd == id_ex_rs1))
            forward_a = 2'b10;
        else if (mem_wb_reg_write && (mem_wb_rd != 5'd0) && (mem_wb_rd == id_ex_rs1))
            forward_a = 2'b01;
        else
            forward_a = 2'b00;
    end

    always @(*) begin
        if (ex_mem_reg_write && (ex_mem_rd != 5'd0) && (ex_mem_rd == id_ex_rs2))
            forward_b = 2'b10;
        else if (mem_wb_reg_write && (mem_wb_rd != 5'd0) && (mem_wb_rd == id_ex_rs2))
            forward_b = 2'b01;
        else
            forward_b = 2'b00;
    end

endmodule
