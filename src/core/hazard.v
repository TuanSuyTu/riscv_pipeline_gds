// =============================================================================
// Project: RISC-V 5-Stage Pipelined Processor
// Module: hazard
// Description: Hazard Detection Unit responsible for pipeline stalls.
//
// Classic 5-stage only needs ONE hazard case:
//   Load-Use: LOAD instruction in EX has rd matching next instruction's rs1/rs2 in ID.
//   Action:   Stall PC + IF/ID for 1 cycle, inject NOP bubble into ID/EX.
//
// All other RAW hazards are resolved by the Forwarding Unit with ZERO stalls.
// =============================================================================

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

    // Load-Use Hazard Detection:
    // If the instruction in EX is a LOAD, and its destination register
    // matches either source register of the instruction in ID,
    // we must stall for 1 cycle to wait for the load data.
    //
    // After the stall, the LOAD advances to MEM, and the forwarding unit
    // can bypass the loaded data from MEM/WB to EX in the next cycle.
    assign stall_loaduse = id_ex_mem_read &&
                           (id_ex_rd != 5'd0) &&
                           ((id_ex_rd == if_id_rs1) || (id_ex_rd == if_id_rs2));

endmodule
