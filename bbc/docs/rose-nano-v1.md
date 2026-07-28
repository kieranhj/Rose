# Rose Nano v1 — report

2026-07-28, overnight session. Branch `rose-nano`.

**Rose Nano runs on a stock BBC Model B.** A compiler, a runtime and a
verification harness exist; three example programs build, boot in jsbeeb, draw,
and match a Python reference model **byte-for-byte across all 20,480 bytes of
screen RAM**. The remaining feasibility experiments are done and two of them
changed the design.

![bloom on the machine](mockups/nano-v1-bloom-beeb.png)

*`bloom.nano`, screenshot straight out of jsbeeb. Eight colours; the oranges,
pinks, creams and greys are 50/50 dither pairs.*

---

## 1. What to look at first

| | |
|---|---|
| The picture | `bbc/docs/mockups/nano-v1-bloom-beeb.png` — real emulator output |
| Growth over time | `bbc/docs/mockups/nano-v1-bloom-sheet.png` — frames 20/60/120/300 |
| The language | `bbc/nano/examples/bloom.nano` (39 lines, does all of the above) |
| Build and run | `sh bbc/nano/build.sh bloom 600 && node bbc/nano/run.mjs bloom 600` |
| Verify | `python bbc/nano/nanoref.py examples/bloom.nano 600 --check build/bloom.screen.bin` |
| Preview without a build | `python bbc/nano/nanoref.py examples/bloom.nano --sheet 20,60,120,300 out.png` |

Docs updated in place: `rose-nano.md` §13 (experiment 3), §14 (experiment 1),
and amendment boxes in §1, §2, §3, §4.1, §8, §9, §10, §12.

---

## 2. Experiments — all six now run

| # | Experiment | Verdict |
|---|---|---|
| 1 | MODE 2 layout + stamp cost | **Passed the assumption, failed the estimate.** §14 |
| 2 | RAM budget | **Passed with room to spare.** §3 below |
| 3 | Grid render — does it look like Rose? | **Passed, and refuted §3's fixed size.** §13 |
| 4 | Dither-pair survey | **27 usable colours, not 36 and not 8.** §4 below |
| 5 | Palette cycling study | **Passed, and it is the best thing here.** §2 below |
| 6 | Compiled vs interpreted turtle step | **Measured on the real engine.** §5 below |

### Experiment 2 — RAM

Measured on the machine: MODE 2 on a Model B with DFS 1.2 gives `PAGE=&1900`,
`HIMEM=&3000` — **5,888 bytes** with DFS left alive, before any of §2's escape
valves.

What v1 actually occupies, from the build:

| program | engine + code + tables + turtle pool | free |
|---|---|---|
| `bloom` (3 procs, 8 tints) | 2,654 B | 3,234 B |
| `stress` (3 procs) | 2,335 B | 3,553 B |

That includes the 48-turtle pool (15 arrays × 48 = 720 B), a 128-entry move
table per distinct distance (512 B each), the row-base and span tables, and the
whole runtime.

**The doc's binding constraint turns out not to bind.** §2 called bytes "the
binding constraint… every design decision below should be read with 8.5KB in
mind", and warned that experiment 2 could kill the MODE 2 configuration
outright. In fact v1 uses **45% of the smaller 5,888-byte budget** and never
needs to reclaim DFS workspace, shrink the screen, or fall back to MODE 5. The
headroom is real: ~6 more move distances, or a 128-turtle pool, or the §7.4
shadow grid at 40×32 (1,280 B) all fit.

The reason is §5's arithmetic paying off — an 11-byte turtle against the port's
144 — plus the decision to compile rather than interpret, which puts the program
in code rather than in a bytecode array *and* a jump table.

### Experiment 5 — palette cycling

Built into the engine and demonstrated. A `spin lo hi rate` declaration rotates
a range of logical colours every `rate` frames; the runtime rewrites eight
entries to the video ULA at &FE21, which costs about **50 cycles a frame**.

`cycle.nano` draws six arms once, over 26 frames, and then every turtle dies.
`palseq.mjs` then screenshots the machine at six later frames *and dumps screen
RAM at each one*:

![palette cycling](mockups/nano-v1-palette-cycle.png)

```
frame 200: screen bytes identical to the first shot
frame 203: screen bytes identical to the first shot
frame 206: screen bytes identical to the first shot
frame 209: screen bytes identical to the first shot
frame 212: screen bytes identical to the first shot
frame 215: screen bytes identical to the first shot
```

**All 20,480 bytes are identical in every frame. Nothing is drawn. The picture
moves anyway.** The check is the point: it proves the motion is the palette and
not a redraw.

§4.2 claimed this was the most Nano-specific expressive idea in the design — the
only mechanism that adds on-screen motion for zero interpreter time, and the one
that composes with persistent trails so that a trail keeps moving after the
turtle that drew it is gone. That is exactly what the strip shows, and it works
because the dither patterns hold *logical* colour numbers, so remapping
logical→physical recolours everything already on screen.

Worth noting for composition: rotating a range that a dither pair straddles
gives a shimmer rather than a flat colour change, because the pair's two halves
move independently. `cycle.nano` uses solid tints to make the effect legible;
the shimmer is the more interesting case and is untried.

### Experiment 4 — how many colours are actually there

All 36 fifty-fifty combinations of the eight physicals, mixed in linear light
and de-duplicated by weighted perceptual distance:

**27 distinct colours: 8 solids + 19 dithers.** The count is stable for any
threshold between 40 and 100, which is a strong signal — the set does not
degrade gracefully, it just is 27.

The nine that collapse are exactly the *opposite* pairs — red+green, red+blue,
yellow+blue, magenta+cyan and so on. That is a pleasing convergence: the pairs
that are numerically redundant are the same ones §13.4 found do not fuse at a
MODE 2 pixel. **There is no tension between "looks right" and "adds a colour".**

So §4.1's "roughly 90 apparent tints" was optimistic and §9's worry that Nano
might be "an 8-colour system" was pessimistic. It is a 27-colour system, for
zero cycles.

---

## 3. What was built

```
bbc/nano/
  nanoc.py       compiler: .nano -> 6502 (beebasm source)
  runtime.asm    scheduler, allocator, mover, stamper
  nanoref.py     reference model + verifier + preview renderer
  build.sh       nanoc -> beebasm -> .ssd
  run.mjs        boot in jsbeeb, dump screen RAM, screenshot
  profile.mjs    frame cost under load (experiment 6)
  examples/      bloom, rain, spiral, stress, stress0
```

### The language

Rose's shape, kept deliberately: `plan` for the palette, `proc` with parameters,
first proc is the entry, `~` for negation, four-letter keywords, and the Rose
recursion idiom — `fork self n-1` then fall off the end and die — as the only
loop.

```
proc walk n
    draw
    move 3
    turn rand 8
    turn ~4
    wait 1
    when n > 0
        fork walk n-1
    done
```

Statements: `jump face tint size move turn draw wait fork when/else/done`.
Expressions are deliberately the smallest grammar that expresses that idiom:
constant, local, `local±constant`, and `rand N`. No division, **no multiply
either** — `move` is two table lookups and two 16-bit adds (§5.2).

### The engine

- **Compiled, not interpreted** (§6.4). Each proc is straight-line 6502 with
  turtle state in structure-of-arrays indexed by X (`lda tdir,x`), and `wait`
  saves PC and jumps to the scheduler, which resumes with `jmp (PCV)`. Zero
  dispatch.
- **48-turtle pool**, 11 bytes each, allocator scanning from slot 0, turtles
  dying at the end of a proc.
- **The renderer is the point.** Experiment 1 established that a 40×32 grid cell
  is 4px × 8 rows = **16 contiguous bytes**. So painting a cell is one unrolled
  run of 16 stores — no mask, no read-modify-write, no per-line setup — and
  stepping to the next cell is `+16`. Blob size is a four-entry table of cell
  radii; clipping is two comparisons on 6-bit integers.
- **Dither locked to screen position for free**: within a cell, byte index
  parity *is* scanline parity in both byte-columns, so alternating two pattern
  bytes gives a checkerboard that tiles seamlessly between overlapping blobs
  (§13.4's requirement, at no cost).
- **The canvas is a torus.** 32 rows × 8 = 256 exactly, so y wraps for free; x
  wraps with three instructions. `rain.nano` exists to demonstrate it.

---

## 4. Verification — and it earned itself immediately

`nanoref.py` re-implements the semantics in Python and renders to a
20,480-byte MODE 2 buffer, compared byte-for-byte with screen RAM dumped out of
jsbeeb. It mirrors the runtime deliberately, including the parts that are not
obviously right — 128-direction tables, toroidal wrap, allocation scanning from
slot 0 — because the point is to catch divergence, not to be elegant.

```
bloom:  screen matches the model exactly (20480 bytes)
rain:   screen matches the model exactly (20480 bytes)
spiral: screen matches the model exactly (20480 bytes)
```

**It found a real bug within an hour of existing.** The runtime indexed the
palette and span tables with unmasked `tint` and `size`; the model masked them.
No example exercised it until `rain` was changed to cycle its tints past 7 —
at which point it surfaced as a byte mismatch with an exact address, instead of
as mystery garbage on screen. That is precisely the argument §6 of the Micro
doc makes for the harness being non-negotiable, and it held.

A second, subtler catch: the "finished" flag was originally written to `&7FF0`,
which is *inside* screen RAM. The verifier reported exactly one differing byte.
It was also visible as a stray white dash in the corner of the first screenshot
— but the harness named it before I looked.

---

## 5. Experiment 6 — what a compiled turtle step costs

Measured on the finished engine (`profile.mjs`), not a synthetic benchmark:
built with vsync disabled so frames run back to back, run until the 48-slot pool
saturates, then sampled over long windows.

| blob size | live turtles | cycles/frame | % of a 50Hz frame |
|---|---|---|---|
| size 0 (1 cell) | 47 | **20,725** | 51.8% |
| size 1 (9 cells) | 47 | **50,955** | 127.4% |

Each turtle alternates between a drawing frame and a fork-and-die frame, so
~23 of the 47 draw in any given frame. From the two rows:

- **~164 cycles per extra grid cell** — which independently reproduces
  experiment 1's `8.79 cycles/byte` over a 16-byte cell plus ~20 of per-cell
  overhead. The engine and the microbenchmark agree.
- **~700 cycles for everything that is not the blob** — `move`, `turn`, the
  `when`, the fork, the scheduler pass and the coroutine yield, combined.

That last number is the answer to experiment 6, and it is the one I would put in
front of a sceptic: **Micro's measured cost for `move` alone is 686 cycles**
(§9.3), and the BBC port's is 1,456. A whole compiled Nano turtle step — move,
turn, compare, fork a child, yield, and be rescheduled — costs about what Micro
pays for one `move`. Removing dispatch and narrowing the word did what §6.4 said
they would.

**Practical envelope for 50Hz:** ~23 active turtle-steps per frame with 1-cell
blobs and ~45% of the frame still free; ~10 with 9-cell blobs. `stress.nano` at
47 live turtles and 9-cell blobs is a 25Hz demo, which is an honest number
rather than a disappointing one — it is deliberately the worst case.

---

## 6. What changed in the design tonight

Two things, both from measurement:

**The fusion penalty does not transfer.** §13.4 calibrated `fuse = 0.25` against
a chooser with eight dither levels, where the penalty was scaled by the minority
fraction — so a 1:7 dither was penalised an eighth as hard as a 1:1 one. v1 has
only 50/50 mixes, where that scaling is always 1.0, and 0.25 collapses *every*
colour to a solid. Recalibrated to **0.02**, at which point 880 → black+yellow,
08F → blue+cyan, F80 → red+yellow, exactly as §13.4 wanted. The first `bloom`
build was eight flat colours; the second is the picture at the top.

**RAM is not the binding constraint** (§2, above). Worth propagating into the
doc's framing, which currently leads with it.

---

## 7. Where I stopped, and what I would do next

Not done, in the order I would pick them up:

1. **Compose with the cycling shimmer.** §6's palette rotation works on solid
   tints; rotating a range that a *dither pair* straddles should shimmer rather
   than switch, and nothing has tried it. Cheapest interesting experiment left.
2. **Beam-race the draw order.** v1 draws turtles in slot order, not raster
   order, so a heavy frame can tear. §6.3's counting sort into 32 row buckets is
   cheap and would remove it.
3. **Better examples.** `bloom` is a genuine picture; `rain` and `spiral` are
   mechanism demos. The language is now expressive enough to compose properly,
   and I would rather you did that than me.
4. **Language gaps** worth closing: `move` with a computed distance (currently
   compile-time constants only, because each one costs a 512-byte table),
   expressions richer than `local±constant`, and turtle `life`/eviction (§6.2)
   — v1 turtles die by falling off the end of a proc, and a full pool silently
   drops forks.
5. **The §7 multipliers** — hardware scroll, symmetry, herds, the shadow grid —
   all still deferred, all still cheap, and RAM for the shadow grid now
   demonstrably exists.

### Honest limitations of v1

- Blob sizes 0–3 are compiled but only 0–2 are exercised by the examples.
- A full turtle pool drops forks silently; there is no eviction policy.
- No sound, no `plan` animation, no `part`/include, no `temp` locals beyond proc
  parameters (4 per turtle).
- The 25Hz `stress` case is a real ceiling, not a tuning artefact: 9-cell blobs
  at 23 per frame is simply more than 40,000 cycles buys.
- `spiral.nano` draws a small tight circle — correct, but it is the least
  interesting of the three.

---

## 8. Bottom line

The question the doc has been circling since it was written is whether
designing *for* the BBC rather than squeezing Rose onto it actually buys
anything. Tonight it stopped being a document and started being a machine, and
the answer is yes, with numbers attached:

- palette cycling that moves a finished picture with **byte-identical screen
  memory**, for ~50 cycles a frame;
- an engine and a program in **2.6KB**, on a machine the port needed a Master,
  a coprocessor and sideways-RAM paging to satisfy;
- a compiled turtle step costing about what Micro's `move` costs on its own;
- **27 colours** on an eight-colour display for zero cycles;
- and a verification harness that is byte-exact on the first three programs and
  has already caught two bugs.

What it is not yet is a body of work. The instrument is built and in tune; the
music is the next thing, and that part is yours.
