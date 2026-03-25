# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Project Is

**Rose** is a domain-specific language for *temporal turtle graphics* — programs produce animations drawn by multiple "turtles" moving on a canvas. Each turtle has position (x, y), direction, pen size, color index (tint), and RNG state.

The project has two execution targets:
1. **Visualizer** — a Windows C++ desktop app (`visualizer/`) for development
2. **Archimedes** — ARM assembly engine (`arc/`) targeting vintage Acorn Archimedes computers

## Building

### Visualizer (C++)

```bash
cd visualizer
make          # builds build/rose
make clean    # clean build artifacts
make dist     # create distributable in ../dist/Rose
```

Requires external libraries at `../../../Libs/`: GLFW 3.3.4 (WIN64), GLEW 2.1.0, PortAudio.

The parser is auto-generated from `rose.sablecc` using SableCC (Java). Regenerate with:
```bash
/c/Program\ Files\ \(x86\)/Java/jre1.8.0_291/bin/java -jar tools/sablecc.jar -t cxx -d parser rose.sablecc
```

Run the visualizer:
```
rose <filename.rose> [x<scale>] [<framerate> [<music.wav>]]
# e.g.: rose examples/circle.rose x3 50
```

### Archimedes Demos

```bash
cd arc
make all                     # build all demos
make ball                    # build a single demo
make circle everyway         # build specific demos
make clean
```

Each demo build: assembles with `vasm`, links with `vlink`, optionally compresses with `lz4`, then copies to `../../arculator/hostfs/`. Requires Python 3 (`python` on PATH), `dos2unix`, and the tools in `arc/bin/`.

The `rose2arc.py` script converts pre-compiled bytecode/constants/colorscript `.bin` files into ARM assembly (`instructions.asm`) that is then included in the engine build.

## Architecture

### Compilation Pipeline

**Visualizer path:** Rose source → SableCC parse → AST (`ast.h`) → symbol linking (`symbol_linking.h`) → bytecode codegen (`code_generator.h`) → interpret (`interpret.h`) → `RoseResult` (plots + color changes) → OpenGL render (`renderer.cpp`)

**Archimedes path:** Rose source → `rose2arc.py` → `instructions.asm` → vasm assemble → vlink → optional lz4 compress → Archimedes app folder

### Key Files

| File | Role |
|------|------|
| `visualizer/translate.cpp` | Main compilation orchestration |
| `visualizer/bytecode.h` | Bytecode instruction set (shared semantics) |
| `visualizer/interpret.h` | Bytecode interpreter (desktop) |
| `visualizer/renderer.cpp` | OpenGL rendering of plots |
| `arc/bin/rose2arc.py` | Bytecode→ARM assembly converter |
| `arc/engine/rose.asm` | Archimedes entry point |
| `arc/engine/engine.asm` | Archimedes bytecode interpreter |
| `arc/engine/circles.asm` | Circle drawing with pre-computed trig |
| `visualizer/rose.sablecc` | Language grammar (SableCC format) |

### Data Flow

The visualizer compiles a Rose program to a `RoseResult` containing:
- `plots` — all drawing commands with (time, x, y, radius, tint)
- `colors` — color changes with timestamps
- `width`, `height`, `layer_count`, `layer_depth` — canvas config

Rendering replays these pre-computed plots at the appropriate frame.

### Archimedes Engine Assembly Defines

When assembling for Archimedes, key build-time defines control behavior:
- `_FORM_WIDTH`, `_FORM_HEIGHT` — canvas dimensions
- `_SCREEN_MODE` — 98 (352×280 overscan PAL) or 97 (320×180 widescreen)
- `_DUAL_PLAYFIELD` — 0 or 1 (widescreen uses dual playfield)
- `_ENABLE_MUSIC` — 0 or 1
- `MAX_FRAMES` — total frame count
- `MAX_STACK` — turtle stack depth (default varies; some demos use 31)

## Rose Language Notes

- All numeric values are **16.16 fixed-point**. Hex literals (`$XXXXXXXX`) are used as raw 32-bit fixed-point representations.
- Use `~` for negation (not `-`), including for negative numbers: `~3` not `-3`.
- Keywords are all exactly **4 letters**.
- `fork` spawns a new turtle; both the forked turtle and the original continue executing in parallel.
- `wire` variables are global and inherited through forks; `temp` variables are local.
- The **first procedure** in the file is the entry point.
- `part "filename"` includes another Rose file (path relative to the including file).
- `sine(x)` computes sine of 2π·x (not radians).
- Directions use 256 units per full circle (not degrees or radians).

## Visualizer Keyboard Shortcuts

- `SPACE` — play/pause
- `LEFT`/`RIGHT` — step ±1 frame
- `PGUP`/`PGDN` — step ±50 frames
- `HOME` — go to frame 0
- `BACKSPACE` — return to last start frame
- `TAB` — toggle stats overlay
- `ESC` — quit
