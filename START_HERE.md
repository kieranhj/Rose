# Rose: start here

Rose, Aske Simon Christensen's language for animated turtle graphics, in the user's fork: an
Acorn Archimedes engine (`arc/`, ARM, with a JIT) that plays Rose demos (Hoffman's Amiga intros
ported), and a BBC Micro dialect, Rose Nano (`bbc/`). A language/engine port; effectively the
user's project now (upstream last changed 2020).

| | |
|---|---|
| GitHub | https://github.com/kieranhj/Rose (public, fork) |
| Upstream | https://github.com/askeksa/Rose (remote `upstream`; last commit 2020-04-09) |
| Local path | D:\archie\mine\Rose (moved from OneDrive\Archie\Repos\Rose on 2026-11-22) |
| Branch | rose-nano (54 commits ahead of master); others: master, bbc-feasibility, claude-session-tree, wip/amigarchie, wip/archie-4kb, wip/bss-segment, wip/dual-playfield, wip/inline-functions, wip/metronome-test, wip/new-makefile, wip/overscan, wip/rose-experiments, wip/vlink, wip/vlink-attempt-2 |
| Last commit | 2026-07-30: Nano: a BBC render mode for the Rose visualizer |

## What's in here
- `visualizer/`: the Windows C++ visualizer/compiler (OpenGL, SableCC parser), own Makefile.
- `arc/`: Archimedes engine (`arc/engine/`, JIT in `jit.asm`), demos in `arc/examples/`, own Makefile.
- `bbc/`: BBC Micro work: `docs/` (feasibility, rose-micro, rose-nano, rose-nano-v1), `nano/`
  (Nano compiler `nanoc.py`, runtime, `build.sh`), `bench/`, `tools/` (budget and verify scripts).
- `examples/`: Rose sources; `engine/`: upstream's Amiga engine.
- `CLAUDE.md` (build and architecture notes), `progress.md` (an older session handover), `README.txt` (language manual).

## Build and run
- `make` (top level): info only, lists the per-target builds (added 2026-11-22).
- `arc/Makefile`: `make all` / `make ball` ... uses `rm`, `cp`, `mkdir -p`, so needs a POSIX shell
  (Git Bash); outputs go to `../../arculator/hostfs` (D:\archie\mine\arculator\hostfs). Not run.
- `visualizer/Makefile`: needs `x86_64-w64-mingw32-g++` (not on PATH) and GLFW/GLEW/PortAudio at
  `../../../Libs` = D:\archie\Libs, which **does not exist** (Libs moved to D:\tools\archie\Libs;
  pass `EXTERNAL=D:/tools/archie/Libs` or add a junction). Not run.
- `bbc/nano/build.sh <name>` (Git Bash): compiles `examples/<name>.nano` to `build/<name>.ssd` with
  beebasm (default path is D:\tools\beeb\Bin\beebasm.exe, the canonical build, since 2026-11-26). Not run.

## Local changes
- 2026-11-22: beebasm default path changed from OneDrive to D: in `bbc/bench/build.sh`,
  `bbc/bench/paintbuild.sh`, `bbc/bin/build.sh`, `bbc/bin/buildtube.sh`, `bbc/nano/build.sh` (uncommitted).
- Unpushed: wip/dual-playfield is 1 ahead of origin (1f4cfb9, 2022-09-28 "Make BC_MUL use signed
  multiplication matching muls.w"); wip/amigarchie has no upstream but its tip is in origin/master.
- `bbc/tools/pixelverify.mjs` and `runverify.mjs` point at a jsbeeb copy in an old Claude scratchpad
  under AppData\Local\Temp (likely gone).
- No stashes.

## Status and next steps
- Latest work (2026-07): Rose Nano for the BBC Micro: v1 compiler, runtime and verification
  harness; experiments 1-6 recorded in `bbc/docs/rose-nano-v1.md`; a BBC render mode in the visualizer.
- `progress.md` describes an older state (claude-session-tree branch, JIT fixes) and its cleanup list.

## See also
- CLAUDE.md, README.txt, progress.md, bbc/docs/*.md. (The `arc/engine/*_design.md` docs progress.md
  mentions are not in this checkout.)
