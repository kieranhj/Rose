#!/bin/sh
# Build a Rose demo for the BBC Master. Usage: bin/build.sh <name>
# e.g. bin/build.sh circle  (expects ../examples/<name>.rose)
#
# Pipeline: visualizer compile (via roseplots, which also dumps the ground
# truth plot list and the .bin triple) -> rose2bbc.py -> beebasm -> rose.ssd
#
# Verify by running in jsbeeb: *LOAD CODE 2000 / CALL &2000, then dump
# &7002 (LOGCNT at &7000) and compare with bin/verify_plots.py against
# build/<name>/expected_plots.bin.
set -e
cd "$(dirname "$0")/.."
NAME="$1"
ROSE="${2:-$NAME}"
BEEBASM="${BEEBASM:-/c/Users/khcon/OneDrive/BEEB/Repos/beebasm/beebasm.exe}"
mkdir -p "build/$NAME"
cd "build/$NAME"
export PATH=/mingw64/bin:$PATH   # libwinpthread for the visualizer objects
../../tools/roseplots.exe "../../../examples/$ROSE.rose" expected_plots.bin
python ../../bin/rose2bbc.py . .
cp ../../engine/interp.asm .
"$BEEBASM" -i interp.asm -do rose.ssd
echo "OK: build/$NAME/rose.ssd"
