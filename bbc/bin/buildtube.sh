#!/bin/sh
# Build a Rose demo for the BBC Master Turbo (Tube). Usage:
#   bin/buildtube.sh <name> [<RoseFileName>] [<WIDE>]
# Produces build/<name>-tube/beeb-<name>-rose-tube.ssd:
#   !BOOT -> *SRLOAD banks -> *RUN PARA;
# PARA (parasite, 4MHz) interprets, HOST (2MHz) renders.
# Verify with: JSBEEB_TUBE=1 node tools/runverify.mjs build/<name>-tube
set -e
cd "$(dirname "$0")/.."
NAME="$1"
ROSE="${2:-$NAME}"
WIDE="${3:-0}"
MAXT="${4:-128}"
STATESZ="${5:-128}"
STATEBASE=$(( 0xF800 - MAXT * STATESZ ))
BEEBASM="${BEEBASM:-/c/Users/khcon/OneDrive/BEEB/Repos/beebasm/beebasm.exe}"
mkdir -p "build/$NAME-tube"
cd "build/$NAME-tube"
export PATH=/mingw64/bin:$PATH   # libwinpthread for the visualizer objects
../../tools/roseplots.exe "../../../examples/$ROSE.rose" expected_plots.bin | tee stats.txt
MAXR=$(grep MAXRADIUS stats.txt | cut -d' ' -f2)
python ../../bin/rose2bbc.py . . "${MAXR:-45}"
cp ../../engine/interp.asm ../../engine/tube.asm ../../engine/*.inc.asm .
printf '*SRLOAD SPANS4 8000 4 Q\r*SRLOAD SPANS5 8000 5 Q\r*SRLOAD CIRCS 8000 6 Q\r*RUN PARA\r' > boot.txt
rm -f ./*.ssd
"$BEEBASM" -i tube.asm -do "beeb-$NAME-rose-tube.ssd" -opt 3 -D WIDE="$WIDE" -D TUBE=1 \
    -D TMAXT="$MAXT" -D STATESZ="$STATESZ" -D STATEBASE="$STATEBASE" > beebasm.log 2>&1 || { cat beebasm.log; exit 1; }
cat beebasm.log
echo "OK: build/$NAME-tube/beeb-$NAME-rose-tube.ssd"
