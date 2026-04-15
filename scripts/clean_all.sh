#!/bin/bash

# Auto-cd to project root so script can be run from anywhere
PROJ_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJ_ROOT" || exit 1

echo "========================================================="
echo "🧹 WORKSPACE CLEANER"
echo "========================================================="

echo ">> Removing simulation executables (*.vvp)..."
rm -f *.vvp

echo ">> Removing binary waveform files (*.vcd)..."
rm -f *.vcd
rm -f tb/*.vcd

echo ">> Cleaning up OpenLane temporary logs..."
# Do not delete 'runs/' because it takes hours to generate; only clean up stray logs.
find . -name "*.log" -type f -delete 2>/dev/null

echo "✅ Clean up complete! Workspace is now clean."
