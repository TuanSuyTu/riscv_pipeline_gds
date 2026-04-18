/*
 * Module:  regfile
 *
 * Description:
 *   Multi-ported Register File (32 registers).
 *   Features synchronous write and asynchronous (combinational) read.
 *   Includes built-in internal write-bypass logic to resolve Write-After-Write
 *   and simultaneous Read/Write hazards natively.
 */

module regfile (
    input         clk,
    input         we,      // Write Enable
    input  [4:0]  wd_addr, // Write Destination
    input  [31:0] wd_data, // Write Data
    input  [4:0]  rs1_addr,
    input  [4:0]  rs2_addr,
    output [31:0] rs1_data,
    output [31:0] rs2_data
);
    (* keep = "true" *) reg [31:0] regs [0:31];
    integer i;

    // Zero-init registers (x0 is always 0 by convention)
    initial for (i = 0; i < 32; i = i+1) regs[i] = 0;

    always @(posedge clk) begin
        if (we && wd_addr != 5'd0)
            regs[wd_addr] <= wd_data;
    end

    // ==========================================================
    // Internal Write-Bypass Logic
    //
    // Method:
    //   Reads logically bypass the memory array if the requested
    //   read address matches the current write address.
    //   This simulates a "write-first, read-later" behavior in one cycle.
    // ==========================================================
    assign rs1_data = (rs1_addr == 5'd0) ? 32'd0 :
                      (we && (wd_addr == rs1_addr)) ? wd_data : regs[rs1_addr];
                      
    assign rs2_data = (rs2_addr == 5'd0) ? 32'd0 :
                      (we && (wd_addr == rs2_addr)) ? wd_data : regs[rs2_addr];

endmodule
