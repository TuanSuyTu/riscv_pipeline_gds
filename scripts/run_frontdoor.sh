#!/bin/bash

# Auto-cd to project root so script can be run from anywhere
PROJ_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJ_ROOT" || exit 1

echo "========================================================="
echo "🏢 RUNNING FRONTDOOR SIMULATION (EXTERNAL BUS INTERFACE TEST)"
echo "========================================================="

# Environment variables pointing to SKY130 PDK
export PDK_ROOT=~/.ciel
export SRAM_VERILOG=$PDK_ROOT/sky130A/libs.ref/sky130_sram_macros/verilog

# Ensure Skywater SRAM macro model is available
if [ ! -f "$SRAM_VERILOG/sky130_sram_1kbyte_1rw1r_32x256_8.v" ]; then
    echo "❌ Skywater SRAM model not found. Please install OpenLane PDK!"
    exit 1
fi

rm -f tb_frontdoor.vvp tb_frontdoor.vcd

echo ">> Compiling Verilog source including SRAM Model..."
iverilog -g2012 -o tb_frontdoor.vvp \
    tb/tb_frontdoor.v \
    src/top/top.v \
    src/top/soc_top.v \
    src/core/*.v \
    src/pipeline/*.v \
    $SRAM_VERILOG/sky130_sram_1kbyte_1rw1r_32x256_8.v

if [ $? -eq 0 ]; then
    echo ">> Compilation successful! Initiating Frontdoor signal transmission..."
    vvp tb_frontdoor.vvp
    echo ">> Completed! Waveform dumped to tb_frontdoor.vcd."
else
    echo "❌ Frontdoor Compilation failed."
    exit 1
fi
