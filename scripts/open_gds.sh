#!/bin/bash

# Auto-cd to project root so script can be run from anywhere
PROJ_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJ_ROOT" || exit 1

# Script to open the physical GDS-II Layout drawing using the Sky130 Foundry tech file
echo "🛠️ Loading GDS Layer drawing via KLayout..."

source ~/openlane_v2_env/bin/activate
openlane --dockerized --pdk-root ~/.ciel --pdk sky130A --flow OpenInKLayout --last-run config.json
