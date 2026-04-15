#!/bin/bash

# Auto-cd to project root so script can be run from anywhere
PROJ_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJ_ROOT" || exit 1

source ~/openlane_v2_env/bin/activate
echo "Starting OpenLane 2 Pipeline Synth Check..."
# Parse config.json and execute Full RTL-to-GDSII Classic Flow
openlane --dockerized --docker-no-tty --pdk-root ~/.ciel --pdk sky130A --flow Classic config.json


# Logic Synthesis: Yosys.Synthesis
# Floorplanning: OpenROAD.Floorplan
# Standard Cell Placement: OpenROAD.GlobalPlacement & OpenROAD.DetailedPlacement
# Clock Tree Synthesis (CTS): OpenROAD.CTS
# Signal Routing: OpenROAD.GlobalRouting & OpenROAD.DetailedRouting
# Static Timing Analysis (STA): OpenROAD.STAPostPNR
# Signoff Verification: Magic.DRC and Netgen.LVS
# openlane --dockerized --docker-no-tty --pdk-root ~/.ciel --pdk sky130A --flow Classic --last-run --only OpenROAD.Floorplan config.json
