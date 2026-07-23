#!/bin/sh
# Build a Rose demo for the BBC Master Turbo (Tube). Usage:
#   bin/buildtube.sh <name> [<RoseFileName>] [<WIDE>]
# Produces build/<name>-tube/rose.ssd: !BOOT -> *SRLOAD banks -> *RUN PARA;
# PARA (parasite, 4MHz) interprets, HOST (2MHz) renders.
# Verify with: JSBEEB_TUBE=1 node tools/runverify.mjs build/<name>-tube
set -e
cd "$(dirname "$0")/.."
NAME="$1"
ROSE="${2:-$NAME}"
WIDE="${3:-0}"
BEEBASM="${BEEBASM:-/c/Users/khcon/OneDrive/BEEB/Repos/beebasm/beebasm.exe}"
mkdir -p "build/$NAME-tube"
cd "build/$NAME-tube"
export PATH=/mingw64/bin:$PATH   # libwinpthread for the visualizer objects
../../tools/roseplots.exe "../../../examples/$ROSE.rose" expected_plots.bin | tee stats.txt
MAXR=$(grep MAXRADIUS stats.txt | cut -d' ' -f2)
python ../../bin/rose2bbc.py . . "${MAXR:-45}"
cp ../../engine/interp.asm ../../engine/tube.asm ../../engine/*.inc.asm .
printf '*SRLOAD SPANS4 8000 4 Q\r*SRLOAD SPANS5 8000 5 Q\r*SRLOAD CIRCS 8000 6 Q\r*RUN PARA\r' > boot.txt
"$BEEBASM" -i tube.asm -do rose.ssd -opt 3 -D WIDE="$WIDE" -D TUBE=1 > beebasm.log 2>&1 || { cat beebasm.log; exit 1; }
cat beebasm.log
echo "OK: build/$NAME-tube/rose.ssd"
