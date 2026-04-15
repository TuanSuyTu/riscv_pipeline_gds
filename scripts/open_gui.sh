#!/bin/bash

# Auto-cd to project root so script can be run from anywhere
PROJ_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJ_ROOT" || exit 1

# Script to auto-launch OpenROAD GUI to inspect physical design (Netlist, Placement, Congestion...)

# 1. Export X11 Display (Required for Docker-on-WSLg)
export DISPLAY=:0

# 2. Activate Python environment containing OpenLane 2
source ~/openlane_v2_env/bin/activate

# 3. Branching Logic: 
#    - If no argument is provided, automatically load the LAST RUN (--last-run)
#    - If a run directory is provided (e.g. ./open_gui.sh runs/RUN_...), open that specific run
if [ -z "$1" ]; then
    echo "🛠️ Loading OpenROAD GUI for the LAST RUN (--last-run)..."
    openlane --dockerized --pdk-root ~/.ciel --pdk sky130A --flow OpenInOpenROAD --last-run config.json
else
    echo "🛠️ Loading OpenROAD GUI for run: $1"
    openlane --dockerized --pdk-root ~/.ciel --pdk sky130A --flow OpenInOpenROAD --run-dir "$1" config.json
fi
