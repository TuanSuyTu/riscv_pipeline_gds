/*
 * Module:  hazard
 *
 * Description:
 *   Hazard Detection Unit responsible for pipeline stalls.
 *
 * Method:
 *   - Only ONE condition requires stall: Load-Use hazard.
 *   - Detects if EX stage is executing a LOAD whose target (rd) is
 *     needed by current ID stage (rs1/rs2).
 *   - Action: Stall PC and IF/ID for 1 cycle; inject NOP to ID/EX.
 *
 * Constraints:
 *   - All other arithmetic RAW hazards are assumed resolved by 'forward'.
 */

module hazard (
    // Inputs from ID/EX pipeline register (instruction in EX stage)
    input        id_ex_mem_read,   // Is EX stage instruction a LOAD?
    input  [4:0] id_ex_rd,         // EX stage destination register

    // Inputs from IF/ID pipeline register (instruction in ID stage)
    input  [4:0] if_id_rs1,        // ID stage source register 1
    input  [4:0] if_id_rs2,        // ID stage source register 2

    // Output
    output       stall_loaduse     // Stall signal for Load-Use hazard
);

    // ==========================================================
    // Load-Use Detection Logic
    //
    // Trigger condition:
    //   - EX stage instruction is a LOAD (id_ex_mem_read = 1)
    //   - Target is not x0 (id_ex_rd != 0)
    //   - Target matches an ID stage source operand (id_ex_rd == rs1|rs2)
    // ==========================================================
    assign stall_loaduse = id_ex_mem_read &&
                           (id_ex_rd != 5'd0) &&
                           ((id_ex_rd == if_id_rs1) || (id_ex_rd == if_id_rs2));

endmodule
