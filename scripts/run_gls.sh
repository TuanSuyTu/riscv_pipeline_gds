#!/bin/bash

# Auto-cd to project root so script can be run from anywhere
PROJ_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJ_ROOT" || exit 1

# ==============================================================================
# GLS RUNNER
# Compile and simulate the Gate-Level Netlist of the RISC-V SoC
# Uses: Icarus Verilog
# ==============================================================================

export PDK_ROOT=~/.ciel
export PDK_VERILOG=$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/verilog
export SRAM_VERILOG=$PDK_ROOT/sky130A/libs.ref/sky130_sram_macros/verilog

# Find the latest OpenLane run directory
LATEST_RUN=$(ls -td runs/RUN_* | head -n 1)
NETLIST="$LATEST_RUN/final/nl/soc_top.nl.v"

echo "========================================================="
echo "🛠️ RUNNING GATE-LEVEL SIMULATION (POST-LAYOUT)"
echo "=> Netlist Target: $NETLIST"
echo "========================================================="

if [ ! -f "$NETLIST" ]; then
    echo "❌ Original Netlist file not found! Please run the OpenLane flow first."
    exit 1
fi

echo ">> Compiling components via Icarus Verilog..."
iverilog -o gls_sim.vvp \
    -Ttyp \
    -D FUNCTIONAL \
    -D UNIT_DELAY=#1 \
    $PDK_VERILOG/primitives.v \
    $PDK_VERILOG/sky130_fd_sc_hd.v \
    $SRAM_VERILOG/sky130_sram_1kbyte_1rw1r_32x256_8.v \
    $NETLIST \
    tb/tb_gls.v

if [ $? -eq 0 ]; then
    echo ">> Compilation successful! Initiating Simulation..."
    vvp gls_sim.vvp
    
    echo ">> VVP execution complete. Output captured in tb_gls.vcd."
else
    echo "❌ Error during iverilog compilation."
    exit 1
fi
