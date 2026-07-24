#!/bin/sh
# Build a Rose demo for the BBC Master Turbo (Tube). Usage:
#   bin/buildtube.sh <name> [<RoseFileOrName>] [<WIDE>] [<MAXT>] [<STATESZ>] [<FRAMES>] [<WIRES>] [<PBUFN>]
# RoseFileOrName: a name under ../examples/, or a path to a .rose file.
# WIDE: 0 = 320x256 crop, 1 = 352x232 overscan, 2 = 320x180 letterbox.
# FRAMES: frame cap (default 10000), must match the demo's authored length.
# WIRES: 1 if the demo uses wire slots (relocates the state list links to
#   the top of the state; STATESZ must then leave 2 spare bytes above the
#   deepest stack: 64 + 4*max_stack + 2, rounded up).
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
FRAMES="${6:-10000}"
WIRES="${7:-0}"
PBUFN="${8:-250}"
STATEBASE=$(( 0xF800 - MAXT * STATESZ ))
BEEBASM="${BEEBASM:-/c/Users/khcon/OneDrive/BEEB/Repos/beebasm/beebasm.exe}"
case "$ROSE" in
  *.rose) ROSEFILE="$ROSE" ;;
  *)      ROSEFILE="../../../examples/$ROSE.rose" ;;
esac
mkdir -p "build/$NAME-tube"
cd "build/$NAME-tube"
export PATH=/mingw64/bin:$PATH   # libwinpthread for the visualizer objects
../../tools/roseplots.exe "$ROSEFILE" expected_plots.bin "$FRAMES" | tee stats.txt
MAXR=$(grep MAXRADIUS stats.txt | cut -d' ' -f2)
python ../../bin/rose2bbc.py . . "${MAXR:-45}"
cp ../../engine/interp.asm ../../engine/tube.asm ../../engine/*.inc.asm .
printf '*SRLOAD SPANS4 8000 4 Q\r*SRLOAD SPANS5 8000 5 Q\r*SRLOAD CIRCS 8000 6 Q\r*RUN PARA\r' > boot.txt
rm -f ./*.ssd
"$BEEBASM" -i tube.asm -do "beeb-$NAME-rose-tube.ssd" -opt 3 -D WIDE="$WIDE" -D TUBE=1 \
    -D TMAXT="$MAXT" -D STATESZ="$STATESZ" -D STATEBASE="$STATEBASE" \
    -D FRAMES="$FRAMES" -D WIRES="$WIRES" -D PBUFN="$PBUFN" > beebasm.log 2>&1 || { cat beebasm.log; exit 1; }
cat beebasm.log
echo "OK: build/$NAME-tube/beeb-$NAME-rose-tube.ssd"
