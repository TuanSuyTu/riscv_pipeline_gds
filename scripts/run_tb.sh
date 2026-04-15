#!/bin/bash

# Auto-cd to project root so script can be run from anywhere
PROJ_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJ_ROOT" || exit 1

echo "========================================================="
echo "💻 RUNNING BASIC RTL SIMULATION (UNIT TEST USING TOP CORE)"
echo "========================================================="

# Remove old simulation files
rm -f tb_top.vvp tb_top.vcd

# Compile CPU source code
echo ">> Compiling Verilog code using Icarus..."
iverilog -g2012 -o tb_top.vvp \
    tb/tb_top.v \
    src/top/top.v \
    src/core/*.v \
    src/pipeline/*.v

if [ $? -eq 0 ]; then
    echo ">> Compilation successful! Running simulation..."
    vvp tb_top.vvp
    echo ">> RTL Simulation completed. Waveform dumped to tb_top.vcd."
else
    echo "❌ RTL Compilation failed. Please check your syntax."
    exit 1
fi
