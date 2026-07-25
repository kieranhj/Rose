# Feasibility: the Hoffman demos (logicos, rageos, technova, waytoorude)

2026-07-24. Assessment of the four remaining `arc/examples` demos for the BBC
port. Verdict up front: **logicos** is the best candidate and the pilot for
4-colour flattening; **technova** is buildable but the densest demo of the
whole set; **rageos** needs the bins-only pipeline (no source); **waytoorude**
is blocked on turtle-state capacity.

## Sources and pipeline

The BBC build consumes `.rose` source (`build.sh` → `roseplots.exe`, which
emits the `.bin` triple, `expected_plots.bin` ground truth, and capacity
stats in one run). The four demos ship only compiled bins in
`arc/examples/<name>/`, but full sources exist locally:

- `C:\Users\khcon\OneDrive\Archie\Repos\Hoffman\{logicos,technova,waytoorude}`
  — all compile cleanly through roseplots today.
- **rageos has no source** (bins only, Apr 2023). Its colorscript is
  byte-identical to logicos's — clearly a LogicOS derivative. Ground truth
  for it would come from `bbc/tools/pyinterp.py`, which interprets the bin
  pair directly with the engine's exact semantics (validated bit-exact
  against the visualizer on the current nine demos). pyinterp needs the
  shift/rotate ops added first (these demos use them; the current nine
  don't).

Tool gap: `roseplots.cpp` hardcodes `translate(file, 10000, ...)` — the
form line in source overrides canvas/layers, but the 10,000-frame cap
truncates logicos/rageos/waytoorude (~12.3–14.3K frames). Needs a frames
argument, matched by the engine-side frame cap.

## Measured stats (roseplots on source; rageos pending pyinterp)

| demo | frames | plots | avg/frame | peak/frame | peak turtles | stack | wires | max r |
|------------|--------|---------|------|----|-----|----|---|----|
| logicos    | ~13.7K | 120,281 | 8.8  | 97 | 160 | 31 | 8 | 60 |
| technova   | ~6.4K  | 172,814 | 27   | 85 | 167 | 19 | 5 | 70 |
| waytoorude | ~12.3K | 176,003 | 14.3 | 86 | 451 | 19 | 3 | 70 |
| rageos     | ~14.3K | (pyinterp run pending) | | | | | | |

All four are `form 320 180 2 4`: widescreen 320×180, **two layers × depth 4
= 8 logical tints**, layer-1 index 0 transparent (top playfield erases to
reveal the bottom one). All are music-synced `.mod` demos (BBC music is
still unbuilt phase 5). Radii ≤ 70 fit the existing circle tables.

## Upstream bug found on the way (fixed in visualizer/interpret.h)

`jump X Y` with side-effecting expressions (`rand`) diverged between the
AST reference and compiled bytecode: interpret.h evaluated X then Y, but
code_generator.h emits Y then X (its keep-same-x/y optimization forces
that shape). logicos `alien_corrupt` (`jump centre_x+rand*40
centre_y+rand*40`, frame ~8743) drew its corruption squares with the two
rand draws swapped — 4,679 plots at transposed offsets. The Archimedes has
always played the bytecode order; interpret.h now evaluates Y first to
match. No other demo hits the pattern (the nine verified ports would have
failed long ago). Found by tracing every ROR on both sides (identical) and
diffing plot multisets (pyinterp vs roseplots).

Also discovered: the engine's shift/rotate group was never implemented
(`op_op` fell through to err_unimpl — "full opcode set" only covered the
ops the first nine demos used). logicos hits ROR/ASR/ASL through the
`>><`-style operators (glyph bitmaps, `rand>><6` alien text), which is
what the post-splash hang was. Implemented in interp.asm with interpret.h
semantics exactly (count = (right>>16)&63, &31 for rotates; >=32
saturates to 0, ASR to -1); pyinterp gained shifts + wires and now
multiset-matches the 14,000-frame logicos ground truth (166,987 plots).

## What the engine is missing

1. **Wires** — all three sourced demos use them (logicos uses all 8). The
   ops are nearly free: `op_rstate`/`op_wstate` already index fields 1–15
   generically and the state layout reserves bytes 32–63 for wire slots.
   The real work: the intrusive list links live in wire slot 0's bytes
   (TL_LO/TL_HI = 32/33), so they must relocate (top-of-state via a build
   define) and fork must copy the wire block to the child
   (`wire_values(parent.wire_values)` semantics).
2. **Stack 31** (logicos) → STATESZ 192 (= 64 + 31×4 + link spare). Already
   a build parameter.
3. **Capacity**: roseplots' "Max turtles alive" OVERCOUNTS the engine's
   real requirement — it counts turtles active per frame
   (survived+died+1), not concurrent state blocks. The engine-exact model
   says logicos peaks at 118 concurrent states (roseplots: 160), so it
   builds as MAXT=128 / STATESZ=190 / PBUFN=128 and the parasite image
   fits with ~600B spare (sq1 multiply tables now generated at init into
   free low RAM &0500-&08FF on Tube builds, saving 1KB of image). Re-run
   the model per demo before trusting roseplots for MAXT. Both logicos and
   technova exceed the single-CPU bank-7 budget → Tube-only, like
   tree/chiperia. **waytoorude's 451 (roseplots) turtles need re-measuring
   with the model**, but even ~350 real states would not fit — likely
   still blocked on a new state-storage scheme.
4. **Colour: the big one.** MODE 1 = 4 colours vs 8 tints + transparency.
   - Plan A (this pilot): flatten `tint & 3` — the render path already does
     exactly this, so pixels need zero engine change. The colorscript solve
     extends to 8 sources competing for 4 logical slots (tint t and t+4
     share slot t&3); weight the contenders by upcoming plot counts from
     expected_plots.bin. Layer-1 erase (tint 4) becomes erase-to-background.
   - Plan B (if A looks bad): MODE 2 renderer — 16 colours but 160 pixels
     wide (halved X), software compositing of two 2bpp layer buffers.
     Substantially new render path.
5. **Geometry**: 320×180 form wants XOFF=0/YOFF=0, SCRH~180–184 with CRTC
   R6/R7 letterboxing (fewer lines = less to clear/draw — helps, not
   hurts). Verify tools need form-aware dimensions instead of the baked
   352×280/XOFF 16/YOFF 12.

## logicos pilot: 4-colour flatten results (2026-07-24)

Built and verified: `bin/buildtube.sh logicos <Hoffman>/logicos/main.rose 2
128 190 14000 1 128` → bit-exact (166,987 plots, chk match) AND
pixel-perfect (0/81920) in 1280M cycles ≈ 2.3× authored length ≈ 22fps
average. WIDE=2 = 320×180 letterbox (R6=23/R7=30, TICKFIRST/GATEBASE
variants). Verify with `pixelverify build/logicos-tube 4000 320 180 0 0`.

Palette flatten quality (8 sample scenes rendered vs a two-layer
reference): login, tracker grid, messaging, scanner, download, cracker,
endpart all read correctly and look strikingly good in blue/yellow/white.
Two solver lessons baked into rose2bbc:

- Slot ownership + joint solve works as designed (records ~330).
- A STABLE drawing tint one shade off the background must not share the
  background's colour (the 444-on-333 logo checkers landed on black =
  invisible; also d(444,333) floats to 0.999... so the d>=1.0 share
  penalty never fired). _assign_phys now takes a stability map (next
  source change > 24 frames away) and always penalises bg-sharing for
  stable tints; fade transients keep the waiver. Flatten mode only — the
  nine 1-layer demos are byte-identical.

**Layer-1 erases: drop-mask BUILT.** tint&7==4 plots erase layer 1 on the
Archimedes but erase EVERYTHING on the flattened single playfield.
logicos has 7,831 of them (plus 49,868 layer-1 draws — 30% of all plots).
rose2bbc now replays both layers offline in the engine's exact render
order (pyinterp emission order — cached as pyplots.bin, multiset-checked
against expected_plots.bin — stable-sorted by (t, y−r)) and marks each
erase-class plot no-op (layer 1 clear beneath → DROP) or effective
(KEEP). Verdicts ship as a bitstream (one bit per erase-class record in
emission order, MSB first; logicos: 981 bytes, 1,233 drops) consumed by
sort_add via t4_consume BEFORE the offscreen cull so ordinals align.
Space paid for by re-indexing PROC (2-byte op + proctab, net −593B);
parasite ends at &900E vs the &9100 limit. Drops happen post-hash/log so
runverify is untouched; pixelverify skips the same multiset via the
t4drop.bin sidecar. Verified: logicos bit-exact + pixel-perfect, full
14-build sweep green (PROC encoding changed every demo).

Effective erases still erase-to-background rather than revealing layer-0
content — correct whenever layer 0 is background beneath, approximate
otherwise: cycling the desktop selection box still eats the icons under
it. That is inherent to one playfield — the screen doesn't store what
layer 0 had beneath — and no masking can fix it.

## Dual-playfield options: MODE 2 mock-up verdict (2026-07-25)

Mock-ups in `mockups/` (rendered offline from the real plot stream +
colorscript; `*-4way.png` panels top→bottom = MODE 2 mock / 1bpp-per-layer
MODE 1 / current flatten / Archimedes reference; script:
scratchpad mode2mock.py):

- **MODE 2 (160×256, 4bpp) — REJECTED for logicos.** The elegant part
  works: pixel = (l1idx<<2) | l0idx and the 16 palette entries computed as
  `l1 ? colour(l1) : colour(l0)` make the ULA do the dual-playfield
  compositing — exact erase-reveals-layer-0 semantics, all 8 tints keep
  their own colour, zero extra RAM, and spans halve in bytes so it renders
  no slower. But the halved X resolution destroys exactly what logicos is
  made of: glyph strokes are one form-pixel wide, so at 2:1 adjacent
  strokes merge — titles smear to mush, the FROM: list text is borderline
  illegible (see logicos-4500-messaging-4way.png). Graphics-heavy scenes
  (scanner) survive fine. A future graphics-led dual-playfield demo could
  still use this.
- **1bpp per playfield in MODE 1 — the viable alternative.** bit 0 =
  layer 0, bit 1 = layer 1; palette 00=bg, 01=layer-0 colour, 1x=layer-1
  colour. Exact dual-playfield semantics at full 320-wide: crisp text AND
  the selection box cycles over the icons without eating them; the whole
  t4 drop-mask apparatus becomes unnecessary. Cost: ONE foreground colour
  per layer at a time (per-scene recolouring via the colorscript still
  works — the solve would pick each layer's plot-weighted dominant tint).
  The messaging mock reads as clean white-on-black — arguably the
  cleanest BBC rendering of the three, at the price of the blue/yellow
  accent variety the flatten keeps. Engineering: a second SWRAM filler
  set doing AND/OR masked writes per layer bit, record layer-class
  decode, per-layer colour solve — same class of work as MODE 2 would
  have been, at today's byte widths.
- **Current 4-colour flatten** — best colour variety, crisp text,
  permanent erase artifacts.

So the real choice is flatten (3 fg colours + artifacts) vs 1bpp dual
playfield (2 fg colours, artifact-free). MODE 2 is out for text-heavy
material.

Tooling trap that cost a debugging round: framedump polling in 4M-cycle
chunks overshoots the target frame by ~100 — the "eaten" logo screenshots
were dumps landing after the scene's own self-wipe at ~950. Poll in 250K
chunks when dumping scene-accurate frames.

## CPU expectations (Tube)

- logicos: 8.8 plots/frame avg — lightest demo in the whole set, could
  pace close to authored speed outside peaks.
- waytoorude: Everyway-class (14.3 avg vs Everyway's 18.7).
- technova: 27 avg — heaviest per-frame density of any demo; expect well
  below Everyway's ~12.5fps average.

## Per-demo verdicts

- **logicos** — feasible now: source ✓, capacity ✓ (STATESZ bump), wires
  (engine work, contained), lightest CPU load. Pilot for 4-colour flatten.
- **technova** — feasible after logicos (same engine work, smaller stack),
  but slowest; expect a slideshow in dense sections.
- **rageos** — likely logicos-class; blocked only on the bins-only ground
  truth path (pyinterp + shifts) since there's no source.
- **waytoorude** — not feasible without solving 451-turtle state storage,
  on top of everything above.
