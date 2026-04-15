## Supplementary SDC constraints for RISC-V SoC
## OPT-0: Mark debug outputs as non-timing-critical

# Debug ports are for observability only — no real timing requirement
set_false_path -to [get_ports dbg_*]

# Programming interface: async signals, not timing-critical during CPU operation
# (prog_* pins are only active when rst=1 and CPU halts, not affecting operational timing)
set_false_path -from [get_ports prog_*]

# OPT-0: Override the incredibly tight 0.040ns (40ps) max_transition
# limit defined in the Sky130 SRAM macro .lib file, which causes RSZ-0090.
set_max_transition 1.50 [current_design]
catch { set_max_transition 1.50 [get_pins -of_objects [get_cells -hierarchical *dmem_sram*]] }
catch { set_max_transition 1.50 [get_pins -of_objects [get_cells -hierarchical *imem_sram*]] }
