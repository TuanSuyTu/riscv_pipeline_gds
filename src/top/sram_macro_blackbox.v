/*
 * Module:  sky130_sram_1kbyte_1rw1r_32x256_8 (Blackbox)
 *
 * Description:
 *   Blackbox declaration for Sky130 SRAM macro.
 *   Satisfies linter (Verilator) semantics without Behavioral timing delays
 *   that would disrupt Yosys synthesis logic optimization.
 */

(* blackbox *)
module sky130_sram_1kbyte_1rw1r_32x256_8 (
    // Port 0: RW
    input  clk0,
    input  csb0,
    input  web0,
    input  [3:0] wmask0,
    input  [7:0] addr0,
    input  [31:0] din0,
    output [31:0] dout0,
    
    // Port 1: R
    input  clk1,
    input  csb1,
    input  [7:0] addr1,
    output [31:0] dout1
);
    // Blackbox - No logic implemented here.
    // Synthesis tool (Yosys) will link this to the physical macro via .lib and .lef files.
endmodule
