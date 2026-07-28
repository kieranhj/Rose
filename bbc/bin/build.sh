#!/bin/sh
# Build a Rose demo for the BBC Master. Usage: bin/build.sh <name>
# e.g. bin/build.sh circle  (expects ../examples/<name>.rose)
#
# Pipeline: visualizer compile (via roseplots, which also dumps the ground
# truth plot list and the .bin triple) -> rose2bbc.py -> beebasm
#   -> build/<name>/beeb-<name>-rose.ssd
#
# Run in jsbeeb: *LOAD CODE / CALL &1000 (renders in shadow MODE 1 and spins
# when done — poll DONEFLAG &7006). Verify: LOGCNT &7000, LOGCHK &7002,
# prefix records &7008; compare with bin/verify_plots.py against
# build/<name>/expected_plots.bin.
set -e
cd "$(dirname "$0")/.."
NAME="$1"
ROSE="${2:-$NAME}"
WIDE="${3:-0}"
FRAMES="${4:-10000}"
WIRES="${5:-0}"
BEEBASM="${BEEBASM:-/c/Users/khcon/OneDrive/BEEB/Repos/beebasm/beebasm.exe}"
case "$ROSE" in
  *.rose) ROSEFILE="$ROSE" ;;
  *)      ROSEFILE="../../../examples/$ROSE.rose" ;;
esac
mkdir -p "build/$NAME"
cd "build/$NAME"
export PATH=/mingw64/bin:$PATH   # libwinpthread for the visualizer objects
../../tools/roseplots.exe "$ROSEFILE" expected_plots.bin "$FRAMES" | tee stats.txt
MAXR=$(grep MAXRADIUS stats.txt | cut -d' ' -f2)
FORMW=$(grep '^FORM ' stats.txt | cut -d' ' -f2)
FORMH=$(grep '^FORM ' stats.txt | cut -d' ' -f3)
python ../../bin/rose2bbc.py . . "${MAXR:-45}" "$FRAMES" "${FORMW:-352}" "${FORMH:-280}"
cp ../../engine/interp.asm ../../engine/*.inc.asm .
printf '*SRLOAD SPANS4 8000 4 Q\r*SRLOAD SPANS5 8000 5 Q\r*SRLOAD CIRCS 8000 6 Q\r*RUN CODE\r' > boot.txt
rm -f ./*.ssd
"$BEEBASM" -i interp.asm -do "beeb-$NAME-rose.ssd" -opt 3 -D WIDE="$WIDE" -D TUBE=0 \
    -D TMAXT=128 -D STATESZ=128 -D STATEBASE=32768 \
    -D VERIFY="${VERIFY:-1}" -D FRAMES="$FRAMES" -D WIRES="$WIRES" -D PBUFN=250 > beebasm.log 2>&1 || { cat beebasm.log; exit 1; }
cat beebasm.log
echo "OK: build/$NAME/beeb-$NAME-rose.ssd"
