// =============================================================================
// Project:      RISC-V 5-Stage Pipelined SoC
// Module:       soc_top
// Description:  Top-level SoC wrapper integrating the CPU core with physical 
//               Sky130 SRAM macros for Instruction (IMEM) and Data Memory (DMEM).
// Features:
//   - IMEM: Dual-port SRAM. Port 0 acts as a firmware programming frontdoor.
//           Port 1 serves as the instruction fetch interface.
//   - DMEM: Combinational read/write signals originating from the EX stage 
//           to achieve 1-cycle access latency, leveraging internal SRAM latches.
//           Data unpacking logic resides here to synchronize with SRAM timing.
// =============================================================================

`timescale 1ns / 1ps

module soc_top (
`ifdef USE_POWER_PINS
    inout vccd1,
    inout vssd1,
`endif
    input clk,
    input rst,

    // =========================================================================
    // 1. External Programming Interface (Frontdoor Loader)
    // =========================================================================
    input         prog_we,          // Active-high Write Enable for IMEM
    input  [7:0]  prog_addr,        // Word address (0-255)
    input  [31:0] prog_data,        // 32-bit Instruction Payload

    // =========================================================================
    // 2. Debug Observation Ports
    // =========================================================================
    output [31:0] dbg_imem_addr,
    output [31:0] dbg_imem_data,
    output [31:0] dbg_dmem_addr,
    output [31:0] dbg_dmem_wdata,
    output [31:0] dbg_dmem_rdata,
    output        dbg_dmem_we
);

    // =========================================================================
    // 3. CPU Core Instantiation
    // =========================================================================
    wire [31:0] imem_addr;
    wire [31:0] imem_data;
    
    wire        dmem_we;
    wire        dmem_re;
    wire [2:0]  dmem_funct3;
    wire [31:0] dmem_addr;
    wire [31:0] dmem_wdata;
    wire [31:0] dmem_rdata;
    
    top cpu_core (
        .clk(clk),
        .rst(rst),
        .imem_addr(imem_addr),
        .imem_data(imem_data),
        .dmem_we(dmem_we),
        .dmem_re(dmem_re),
        .dmem_funct3(dmem_funct3),
        .dmem_addr(dmem_addr),
        .dmem_wdata(dmem_wdata),
        .dmem_rdata(dmem_rdata)
    );

    // =========================================================================
    // 4. Instruction Memory (Sky130 SRAM Macro)
    //    - Port 0 (RW): Firmware loading via frontend programmer (prog_ pins).
    //    - Port 1 (R):  CPU Instruction Fetch (always enabled).
    // =========================================================================
    wire [31:0] imem_dout;

    sky130_sram_1kbyte_1rw1r_32x256_8 imem_sram (
        // Port 0: Programming interface (external write)
        .clk0(clk),
        .csb0(~prog_we),               // active-low: enable when prog_we=1
        .web0(~prog_we),               // active-low: write when prog_we=1
        .wmask0(4'b1111),              // always write full 32-bit word
        .addr0(prog_addr),
        .din0(prog_data),
        /* verilator lint_off PINCONNECTEMPTY */
        .dout0(),                      // Port 0 read is unused
        /* verilator lint_on PINCONNECTEMPTY */
        
        // Port 1: CPU Instruction Fetch (read-only)
        .clk1(clk),
        .csb1(1'b0),                   // always enable read
        .addr1(imem_addr[9:2]),        // word address from PC
        .dout1(imem_dout)
    );

    assign imem_data = imem_dout;

    // =========================================================================
    // 5. Data Memory System + Write Masking / Read Unpacking
    //    - Uses Port 0 exclusively for bidirectional data memory access.
    // =========================================================================
    wire [31:0] dmem_dout;
    wire [3:0]  dmem_wmask;
    wire [1:0]  byte_offset = dmem_addr[1:0];
    
    // Write Mask Decoding (Byte lane selection)
    assign dmem_wmask = 
        (dmem_we && dmem_funct3[1:0] == 2'b10) ? 4'b1111 :                        // SW
        (dmem_we && dmem_funct3[1:0] == 2'b01 && byte_offset[1] == 1'b0) ? 4'b0011 : // SH thấp
        (dmem_we && dmem_funct3[1:0] == 2'b01 && byte_offset[1] == 1'b1) ? 4'b1100 : // SH cao
        (dmem_we && dmem_funct3[1:0] == 2'b00 && byte_offset == 2'b00) ? 4'b0001 :   // SB byte 0
        (dmem_we && dmem_funct3[1:0] == 2'b00 && byte_offset == 2'b01) ? 4'b0010 :   // SB byte 1
        (dmem_we && dmem_funct3[1:0] == 2'b00 && byte_offset == 2'b10) ? 4'b0100 :   // SB byte 2
        (dmem_we && dmem_funct3[1:0] == 2'b00 && byte_offset == 2'b11) ? 4'b1000 :   // SB byte 3
        4'b0000;
        
    // Data Alignment (Duplicating payload across byte lanes)
    wire [31:0] dmem_din = 
        (dmem_funct3[1:0] == 2'b01) ? {2{dmem_wdata[15:0]}} :   // SH
        (dmem_funct3[1:0] == 2'b00) ? {4{dmem_wdata[7:0]}}  :   // SB
        dmem_wdata;                                             // SW

    // Data Memory SRAM Macro
    sky130_sram_1kbyte_1rw1r_32x256_8 dmem_sram (
        // Port 0: RW (Exclusively used for Data Memory)
        .clk0(clk),
        .csb0(~(dmem_re | dmem_we)),
        .web0(~dmem_we),
        .wmask0(dmem_wmask),
        .addr0(dmem_addr[9:2]),
        .din0(dmem_din),
        .dout0(dmem_dout),
        
        // Port 1: R (Unused for Data Memory)
        .clk1(clk),
        .csb1(1'b1),
        .addr1(8'h00),
        /* verilator lint_off PINCONNECTEMPTY */
        .dout1()
        /* verilator lint_on PINCONNECTEMPTY */
    );

    // =========================================================================
    // Read Data Unpacking (Sign/Zero extension based on Funct3)
    // Latches the access type variables by 1 cycle to synchronize with SRAM
    // =========================================================================
    reg [2:0] funct3_r;
    reg [1:0] byte_offset_r;
    reg       mem_read_r;
    
    always @(posedge clk) begin
        funct3_r <= dmem_funct3;
        byte_offset_r <= byte_offset;
        mem_read_r <= dmem_re;
    end
    
    reg [31:0] dmem_rdata_comb;
    always @(*) begin
        if (mem_read_r) begin
            case (funct3_r)
                3'b000: begin // LB: Load Byte
                    case (byte_offset_r)
                        2'b00: dmem_rdata_comb = {{24{dmem_dout[7]}},  dmem_dout[7:0]};
                        2'b01: dmem_rdata_comb = {{24{dmem_dout[15]}}, dmem_dout[15:8]};
                        2'b10: dmem_rdata_comb = {{24{dmem_dout[23]}}, dmem_dout[23:16]};
                        2'b11: dmem_rdata_comb = {{24{dmem_dout[31]}}, dmem_dout[31:24]};
                    endcase
                end
                3'b001: begin // LH: Load Halfword
                    case (byte_offset_r[1])
                        1'b0: dmem_rdata_comb = {{16{dmem_dout[15]}}, dmem_dout[15:0]};
                        1'b1: dmem_rdata_comb = {{16{dmem_dout[31]}}, dmem_dout[31:16]};
                    endcase
                end
                3'b010: dmem_rdata_comb = dmem_dout; // LW
                3'b100: begin // LBU: Load Byte Unsigned
                    case (byte_offset_r)
                        2'b00: dmem_rdata_comb = {24'd0, dmem_dout[7:0]};
                        2'b01: dmem_rdata_comb = {24'd0, dmem_dout[15:8]};
                        2'b10: dmem_rdata_comb = {24'd0, dmem_dout[23:16]};
                        2'b11: dmem_rdata_comb = {24'd0, dmem_dout[31:24]};
                    endcase
                end
                3'b101: begin // LHU: Load Half Unsigned
                    case (byte_offset_r[1])
                        1'b0: dmem_rdata_comb = {16'd0, dmem_dout[15:0]};
                        1'b1: dmem_rdata_comb = {16'd0, dmem_dout[31:16]};
                    endcase
                end
                default: dmem_rdata_comb = dmem_dout;
            endcase
        end else begin
            dmem_rdata_comb = 32'd0;
        end
    end
    
    assign dmem_rdata = dmem_rdata_comb;

    assign dbg_imem_addr = imem_addr;
    assign dbg_imem_data = imem_data;
    assign dbg_dmem_addr = dmem_addr;
    assign dbg_dmem_wdata = dmem_wdata;
    assign dbg_dmem_rdata = dmem_rdata;
    assign dbg_dmem_we = dmem_we;
    
endmodule
