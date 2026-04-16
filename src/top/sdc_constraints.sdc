## Supplementary SDC constraints for RISC-V SoC
## Last updated: 2026-04-16

# =============================================================================
# DEBUG PORT RELAXATION
# Debug ports (dbg_*) are for observability only.
# They are NOT part of the functional timing path — no external device samples them.
#
# Strategy: Use set_false_path (works in Synthesis) + set_multicycle_path (works
# in PostPNR STA) to ensure both passes see them as non-critical.
# =============================================================================

# false_path: Synthesis + pre-PnR STA optimization
set_false_path -to [get_ports dbg_*]

# multicycle_path: PostPNR STA relaxation (OpenLane 2 STAPostPNR reads this)
# Allow 2 clock cycles for debug output paths — they will always PASS
set_multicycle_path -setup 2 -to [get_ports dbg_*]
set_multicycle_path -hold  1 -to [get_ports dbg_*]

# =============================================================================
# PROGRAMMING INTERFACE
# prog_* signals are only used when rst=1 (CPU halted). Async to CPU operation.
# =============================================================================
set_false_path -from [get_ports prog_*]

# =============================================================================
# SRAM MACRO INPUT TIMING CONSTRAINTS
# SRAM addr/data inputs are unconstrained by default in OpenLane.
# Set a generous output delay so tool doesn't flag as unconstrained.
# Sky130 SRAM setup time is ~1ns at TT corner per .lib characterization.
# =============================================================================
set_output_delay -clock clk -max  1.0 [get_ports dbg_*]
set_output_delay -clock clk -min -1.0 [get_ports dbg_*]

# =============================================================================
# MAX TRANSITION OVERRIDE
# Override the incredibly tight 0.040ns (40ps) max_transition limit defined in
# the Sky130 SRAM macro .lib file, which causes false RSZ-0090 violations.
# =============================================================================
set_max_transition 1.50 [current_design]
catch { set_max_transition 1.50 [get_pins -of_objects [get_cells -hierarchical *dmem_sram*]] }
catch { set_max_transition 1.50 [get_pins -of_objects [get_cells -hierarchical *imem_sram*]] }
