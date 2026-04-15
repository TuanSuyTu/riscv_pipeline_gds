#!/bin/bash

# Auto-cd to project root so script can be run from anywhere
PROJ_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJ_ROOT" || exit 1

# ==============================================================================
# POST-SYNTHESIS GLS RUNNER
# Compile and simulate Netlist after Yosys (pre-Place & Route)
# Uses: Icarus Verilog
# ==============================================================================

export PDK_ROOT=~/.ciel
export PDK_VERILOG=$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/verilog
export SRAM_VERILOG=$PDK_ROOT/sky130A/libs.ref/sky130_sram_macros/verilog

# Find the latest OpenLane run directory
LATEST_RUN=$(ls -td runs/RUN_* | head -n 1)
NETLIST="$LATEST_RUN/06-yosys-synthesis/soc_top.nl.v"

echo "========================================================="
echo "🛠️  RUNNING GATE-LEVEL SIMULATION (POST-SYNTHESIS)"
echo "=> Netlist Target: $NETLIST"
echo "========================================================="

if [ ! -f "$NETLIST" ]; then
    echo "❌ Post-synth Netlist file not found!"
    exit 1
fi

echo ">> Compiling via Icarus Verilog..."
iverilog -o postsynth_sim.vvp \
    -Ttyp \
    -D FUNCTIONAL \
    -D UNIT_DELAY=#1 \
    $PDK_VERILOG/primitives.v \
    $PDK_VERILOG/sky130_fd_sc_hd.v \
    $SRAM_VERILOG/sky130_sram_1kbyte_1rw1r_32x256_8.v \
    $NETLIST \
    tb/tb_gls.v

if [ $? -eq 0 ]; then
    echo ">> Compilation successful! Simulating..."
    vvp postsynth_sim.vvp
    echo ">> Post-Synthesis GLS completed."
else
    echo "❌ Error during iverilog compilation."
    exit 1
fi
