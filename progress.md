# Progress

## Current Status

The JIT compiler (`arc/engine/jit.asm`) had two ARM instruction encoding bugs that caused a frame-2 crash. Both have been fixed and committed (commit `84cb6eb`). Three technical documentation files were written covering the JIT compiler design, the Rose engine internals, and a scene-by-scene analysis of the Everyway demo. The repo is on branch `claude-session-tree` with a handful of unstaged changes (`.gitignore`, a deleted file, and untracked `.claude/` and `arc/docs/` directories).

---

## Completed Work

- **Committed `84cb6eb`**: Fixed two constants in `arc/engine/jit.asm`:
  - `ji_LDR_R10_R6_M8`: `0xE5168008` → `0xE516A008` (bits[15:12] was 0x8=R8, should be 0xA=R10). Effect: BC_PLOT was loading `plot_square_instruction` into R8 instead of R10, corrupting self-modifying circle draw code → crash on frame 2.
  - `ji_MUL_R1_R2_R1`: `0xE0011292` → `0xE0010192` (Rs field was R2 instead of R1, Rn was 1 instead of 0). Effect: LFSR step was computing R2² (constant) instead of R2×R1 → broken random number generation.

- **`arc/engine/jit_design.md`** (new file, untracked): Comprehensive JIT compiler design document covering memory layout, register conventions, encoding constant table, push_pending/load_without_op optimisation, all 25 bytecode handlers, fixup resolution, and 13 improvement suggestions (compiler code size, JIT output size, correctness, performance).

- **`arc/engine/engine_design.md`** (new file, untracked): Rose engine technical document covering 16.16 fixed-point representation, turtle state block layout, free list and state list scheduling, startup sequence, RunFrame, full turtle lifecycle (fork/wait/free), all fundamental commands (move, turn, face, size, tint, draw, plot, sine, rand, seed, divide, wire/temp variables), RunColorScript, and compile-time configuration.

- **`examples/everyway_analysis.md`** (new file, untracked): Scene-by-scene analysis of `examples/Everyway.rose` (~3700 lines, Amiga 64k intro by Hoffman, Sundown 2016). Covers all 14 named sections plus 8 recurring cross-cutting techniques (tint-0 eraser, recursive countdown timer, origin capture in args, s² geometric scaling, parallel draw/erase, sub-frame timing, dot-matrix text via bit fields, Fibonacci as drawing parameter).

---

## Cleanup Needed

- **`arc/examples/euphoria/euphoria.asm`** is staged for deletion (6150 lines removed). This appears intentional (matches the `9268b41` "Remove instruction.asm files" commit message pattern) but hasn't been committed. Verify this deletion is deliberate before committing.
- **`.gitignore`** has unstaged modifications — check whether the new `arc/docs/` directory and `.claude/` should be added to `.gitignore`.
- **`arc/docs/`** is an untracked directory — contents unknown; may need to be committed or gitignored.
- The three `.md` documentation files (`jit_design.md`, `engine_design.md`, `everyway_analysis.md`) are untracked. Decide whether to commit them.

---

## Immediate Next Steps

1. Check `arc/docs/` contents: `ls arc/docs/` — decide whether to commit or gitignore.
2. Review `.gitignore` changes: `git diff .gitignore` — confirm what was added/changed.
3. Commit or discard the `euphoria.asm` deletion: `git diff --cached arc/examples/euphoria/euphoria.asm` to confirm it's staged, then commit if intentional.
4. Decide fate of the three documentation `.md` files — commit them (e.g. `git add arc/engine/*.md examples/everyway_analysis.md`) or add `*.md` to `.gitignore` if docs are not tracked.
5. Merge or rebase `claude-session-tree` into `master` once cleanup is done.

---

## Longer-term Backlog

- Implement any of the 13 JIT improvement suggestions from `jit_design.md` (the highest-value items are: branch-offset shortcutting to eliminate fixup table overhead, literal pool for large constants not encodable as imm12, and dead-store elimination in the push_pending window).
- Consider adding more Rose examples or demos targeting Archimedes hardware.
- The `visualizer/` build has not been touched in this session; no known issues but it hasn't been verified recently.

---

## Key Notes

- **ARM instruction encoding**: All JIT constants in `jit.asm` are 32-bit ARM words. Field layout matters — double-check Rd (bits[15:12]), Rn (bits[19:16]), Rm/Rs (bits[3:0] / bits[11:8]) against the ARM Architecture Reference Manual whenever adding new constants.
- **MUL constraint**: ARM MUL requires Rd ≠ Rm (bits[15:12] ≠ bits[3:0]) and Rn (bits[19:16]) must be 0 for a plain multiply. The `ji_MUL_R1_R2_R1` bug violated both of these.
- **Self-modifying code**: `arc/engine/rose.asm` stores `plot_circle_instruction` and `plot_square_instruction` as words at `[r6,#-12]` and `[r6,#-8]`. BC_PLOT JIT code loads the appropriate one into R10, then `str r10, circle_loop` patches the draw loop at runtime. Getting R10 wrong silently corrupts the instruction stream.
- **Fixed-point**: All Rose values are 16.16. `$XXXXXXXX` hex literals are raw 32-bit fixed-point. Negation uses `~` not `-`.
- **Branch `claude-session-tree`**: This is not `master`. All work done in this session is on this branch.
