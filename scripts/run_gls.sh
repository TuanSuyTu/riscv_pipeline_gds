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
NETLIST="$LATEST_RUN/final/pnl/soc_top.pnl.v"
SDF_FILE="$LATEST_RUN/final/sdf/nom_tt_025C_1v80/soc_top__nom_tt_025C_1v80.sdf"

echo "========================================================="
echo "🛠️ RUNNING GATE-LEVEL SIMULATION (POST-LAYOUT)"
echo "=> Netlist Target: $NETLIST"
echo "=> SDF Target:     $SDF_FILE"
echo "========================================================="

if [ ! -f "$NETLIST" ]; then
    echo "❌ Original Netlist file not found! Please run the OpenLane flow first."
    exit 1
fi

echo ">> Compiling components via Icarus Verilog..."

# Default variables for zero-delay functional mode
IVERILOG_OPTS="-Ttyp -D FUNCTIONAL -D UNIT_DELAY=#1"

# Automatically switch to SDF mode if SDF file exists
if [ -f "$SDF_FILE" ]; then
    echo "⚡ SDF file detected! Switching to back-annotated timing simulation..."
    # -gspecify: enable specify block (SDF timings)
    IVERILOG_OPTS="-Ttyp -gspecify -D USE_SDF -D USE_POWER_PINS -D SDF_PATH=\"$SDF_FILE\""
else
    echo "⚠️ No SDF file found. Running ZERO-DELAY functional simulation..."
fi

iverilog -o gls_sim.vvp \
    $IVERILOG_OPTS \
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
