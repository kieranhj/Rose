# Everyway — Script Analysis

**Author:** Hoffman (Ian Hoffman)
**Original platform:** Amiga 64k intro, Sundown 2016
**Script length:** ~3700 lines, ~100 procedures

---

## 1. Overall Structure

The demo is divided into eight named scenes, sequenced by a single `proc main` that forks each scene in turn and waits the correct number of frames before starting the next:

```
proc main:
  fork sparksintro     wait 22*32   (~650 frames)
  fork funkydrummer    wait 22*32
  fork boxgrids        wait 22*32
  fork arrows          wait 22*32
  fork fibberspart2    wait 88*8
  fork reese           wait 88*16
  fork brokenbeatspart wait 88*16
  fork rotoboxes       wait 88*16
  fork endspikesprog   wait (88*8)-22
  fork finalfire       wait 22
  fork creditsprog
```

The unit `22` is one beat at roughly 22 frames/bar in the music's tempo at 50 fps. `88` is four beats (one musical phrase). All timing throughout the script is expressed as multiples of these.

A separate top-level `plan` block handles all palette animation independently from the turtle procedures. It runs concurrently for the entire duration.

---

## 2. The `plan` Block — Palette Animation

The `plan` block is the colour designer. It issues a linear sequence of `N:RGB` palette assignments (tint index → 12-bit colour) and `wait` statements.

```
plan
    0:fff  1:000  2:000  3:000   wait 22*16
    0:000  1:fff               wait 22*16
    ...
```

Tint 0 is the **background/erase colour** throughout almost the entire demo — typically black (`000`). Tints 1–3 are the three foreground colours used by drawing procedures.

### Technique: Flash cuts

For the "transition" between boxgrids and arrows (lines 63–79) the plan changes all four tints one step per frame across 16 frames:

```
0:606  1:FF0  wait 1
0:717  1:FF1  wait 1
...
0:FFF  1:DDD  wait 1
```

This produces a rapid palette fade that acts as a wipe between scenes without any turtle code, at zero CPU cost.

### Technique: Tint pulse on beat

For the "arrows" section (lines 90–123) tint 3 is used for a colour that flashes through a warm→cool ramp on every bar:

```
3:FF0  wait 2  3:FF1  wait 2  3:EE1  wait 2 ... 3:888
wait 22
(repeated 8 times)
```

The 16-step ramp covers exactly one bar (16 × 2 frames = 32 frames = ~22 + some ≈ a musical bar). This produces a glowing "pulse" that follows the beat without any code in the drawing procedures at all.

### Technique: Flash white on kick

For the "broken beats" section the background tint 0 flashes from `000` to `004` (dark blue) for two frames on every beat:

```
0:004 wait 2  0:003 wait 2  0:002 wait 2  0:001 wait 2  0:000 wait 2
```

A five-step fade from dark blue back to black across 10 frames gives the impression of a screen flash on the kick drum. Again this is entirely in the plan — the drawing procedures are unaware of it.

### Technique: Slow cross-fade between scenes

At the "beams → rotoboxes" transition (lines 432–447) all four tints are ramped from their scene-specific values to pure white over 16 frames (one per frame), creating a bright white flash that disguises the scene change.

---

## 3. Sparks Intro

**Procedures:** `sparksintro`, `sparksloop`, `sparks`, `spark`, `sparkdraw`, `sparkchika`

### Effect

Streams of bright sparks radiate outward from a series of positions across the screen, each forming a fan of short trails.

### Technique: Recursive spark trails

`spark(count, xpos, ypos)` is the core primitive. Each call:
1. Jumps back to the stored origin `(xpos, ypos)`.
2. Draws a circle of radius `count+1` at the origin.
3. Moves `(count+1)*2` forward, forks `sparkdraw(count)` to draw a receding trail.
4. Turns 180°, moves `(count+1)*4` the other way, forks another `sparkdraw`.
5. Waits 1 frame, jumps back to origin, erases with a large tint-0 square (`size 56 plot`).
6. Forks `spark(count-1, ...)` — the next generation.

`sparkdraw(count)` is a pure drawing helper: it draws circles decreasing in size by 1 each step, moving forward between each, until `count` reaches ~0. This creates the "tail" of each spark generation.

The key technique is **storing the origin as procedure arguments** (`xpos`, `ypos`) so the turtle can always jump back to the launch point regardless of where its chain of movements has taken it. The decreasing `count` controls both the size and lifetime of each generation. As `count` decreases the sparks get smaller and move less, naturally producing the visual impression of a spark dying out.

### Technique: Spraying from a position

`sparks(xjump)` launches 8 spark turtles at once from the current position, each with a different `face` direction (0, 64/straight up, 96/diagonal). Each fork also stores its origin offset by `xjump` so the set of sparks appears to emanate from a shifted copy of the current position:

```
face 96
fork spark 6 x y    wait 11    jump x+xjump y
face 0
fork spark 6 x y    wait 11    jump x+xjump y
...
```

The `wait 11` between each fork staggers the launches in time, so the sparks don't all appear simultaneously.

### Technique: `sparkchika` — expanding ring

`sparkchika(count)` draws two concentric circles (tint 2 and tint 0) at sizes `count*4` and `count*3`, waits, erases, moves 32 units forward, then forks `sparkchika(count+1)`. This produces an expanding ring of dots that grows and moves outward over ~20 frames — used as the accent at the end of the intro.

---

## 4. Funky Drummer — Percussion Visualisation

**Procedures:** `funkydrummer`, `beat1`, `beat2`, `kick`, `snare`, `snarerev`, `chikas`, `chikasclear`, `chikasdraw`

### Effect

Each drum hit (kick, snare, hi-hat) is visualised as a burst of circles at the centre of the screen. The pattern exactly mirrors the drum rhythm in the music.

### Technique: Percussion as shrinking circle stacks

`kick(ksize, kcount)` draws four concentric circles in tints 1, 2, 3, 0 (largest to smallest) at sizes `ksize`, `ksize*0.75`, `ksize*0.5`, `ksize*0.25`, then after 1 frame erases with a tint-0 square, then forks `kick(ksize-3, kcount-1)`. This produces a circle that shrinks by 3 units per frame across `kcount` frames — a visual "decay" matching the attack/decay of a kick drum.

`snare` does the same with squares (`plot`) instead of circles (`draw`), matching the brighter, sharper sonic character of a snare.

### Technique: Hi-hat lines (`chikas`)

Hi-hats are rendered as a row of small dots spread across the screen. `chikas` positions a turtle near one corner of the screen, faces diagonally, then forks `chikasdraw` which plots at a fixed position and moves 40 units (jumping from corner to corner in 3–4 plots). The turtle is positioned at two mirrored corners so the hi-hat appears as two symmetric lines.

`chikasclear` redraws the same pattern in tint 0 at a slightly larger size to erase it. The `total` parameter controls how many of the four possible hi-hat positions are populated, so `chikas 4` draws a "closed hi-hat" and `chikas 1` draws a single "open" accent.

### Technique: Beat sequencer via explicit waits

`beat1` is a handwritten sequencer. Rather than a loop, it is a linear sequence of `fork kick`, `fork snare`, `fork chikas` calls separated by exact wait amounts:

```
fork kick  drumsize  20
wait 11*2

fork snare drumsize 20
wait 11
fork chikas 4
wait 11*2
size 8 fork chikasclear 4

fork kick  drumsize 10
wait 11
...
```

Each line corresponds to one event in the drum pattern. `11` is a quaver (eighth note) and `22` a crotchet (quarter note) at the demo's tempo. The pattern repeats for four bars before `beat2` introduces a variation.

---

## 5. Box Grids

**Procedures:** `boxgrids`, `boxgridedge`, `boxgridfull`, `boxgridcopy`, `boxgriddraw`, `boxgridfills*`, `boxstab`, `boxpulseup`, `boxpulsedown`

### Effect

A 4×4 grid of squares drawn with a square-wave "stabbing" motion — each cell flashes in and out of existence sequentially, with diagonal sweeps and pulses that travel along the grid lines.

### Technique: Grid coordinates by arithmetic

The grid cells are at positions `(80 + 66*col, 39 + 66*row)`. Rather than a data table, all cell positions are computed by moving in multiples of 66 pixels:

```
proc boxgridfull boxtint
    jump ~16 ~60       # start before the grid
    face 0
    fork boxgridcopy 3 boxtint
    jump x+66 y+66
    fork boxgridcopy 3 boxtint
    ...
```

`~16` means `−16` (the `~` prefix is negation in Rose). The turtle starts slightly off-screen, then jumps in 66-pixel steps to each row start. `boxgridcopy(3, boxtint)` forks `boxgriddraw` at the current position and moves `66*2` to the next position, recursing 3 times — covering three cells per row.

### Technique: Drawing a square by walking its perimeter

`boxgriddraw(drawcount, side, sidecount, turns, boxtint)` draws a square by moving 3 pixels at a time, turning 90° after `sidecount` steps:

```
proc boxgriddraw drawcount side sidecount turns boxtint
    tint boxtint
    when drawcount
        when x>0
            plot
        done
        wait 1
        when sidecount
            move 3
            fork boxgriddraw drawcount-1 side sidecount-1 turns boxtint
        else
            turn 64
            move 3
            fork boxgriddraw drawcount-1 side side turns-1 boxtint
        done
    done
```

`64` is a quarter-turn in Rose's 256-unit circle. After `sidecount` steps the turtle turns and resets `sidecount` to `side`, drawing the next edge. The `when x>0` guard clips the left edge so dots don't appear off-screen. Each step takes 1 frame, so a 21×21 cell square takes 84 frames to trace.

### Technique: Pulse via `boxstab`

`boxstab` is the fundamental "stab" unit: plot at full size, wait 3 frames, then plot with tint 0 (erase). The box appears for exactly 3 frames. By forking `boxstab` at staggered positions along a row (with `wait 6` or `wait 5` between forks) the stabs travel along the grid edge as a wave.

### Technique: Size-animated pulses

`boxpulseup(bcount, bsize)` draws a square that grows by 2 units per frame:

```
proc boxpulseup bcount bsize
    when bcount
        size bsize
        plot
        wait 1
        fork boxpulseup bcount-1 bsize+2
    else
        tint 0 plot
    done
```

`boxpulsedown` shrinks by 2 per frame. These pulses mark the "accent" at the end of each grid animation, giving a satisfying blooming or collapsing effect on the final note of each pattern.

---

## 6. Arrows

**Procedures:** `arrows`, `fibbers`, `arrowcopyright/left`, `arrowprogright/left`, `arrowturn`, `arrowmatemove`, `arrow`, `arrowplot`, `arrowplot2`, `arrowclear`

### Effect

A rotating arrow shape orbits the grid area, sweeping in an arc across all four quadrants. Simultaneously, Fibonacci spirals emerge from the centre.

### Technique: Arrow shape from relative geometry

`arrow` constructs an arrowhead entirely from relative moves and turns:

```
proc arrow
    size 3
    move 9*2           # move forward to arrowhead tip
    turn 128           # face backward
    fork arrowplot 5   # draw 5 dots along the shaft
    fork arrowplot2 2  # draw 2 V-shapes for the flanges
    turn 64*3
    fork arrowplot2 2
```

`arrowplot2` zigzags diagonally with `turn 64; move 9; turn ~64; move 9; plot` to create the angled wings of the arrowhead. The entire shape is expressed in directional steps with no absolute coordinates.

### Technique: Rotation via per-frame turn accumulation

`arrowturn(count, aturn, amove)` drives the arrow's rotation. Each frame it forks the current arrow shape, turns by `aturn` (≈ 1.45°), optionally moves by `amove`, waits 1 frame, erases the previous arrow, then recurses:

```
proc arrowturn count aturn amove
    when count
        fork arrow
        turn aturn
        move amove
        wait 1
        fork arrowclear
        fork arrowturn count-1 aturn amove
    done
```

`1.454545` is `256/176 ≈ 1.4545...`, chosen so that 176 frames (8 bars at 22 fps/bar) covers exactly one full rotation (176 × 1.4545 ≈ 256 units). This gives clean loop-back alignment with the music.

### Technique: Fibonacci sequence as drawing parameter

`fib(a, b, count)` implements the Fibonacci sequence directly as procedure arguments. Each recursion computes `next = a + b` and uses it simultaneously as:
- A **turn amount** (`turn next`) — making the spiral's curvature grow with the sequence
- A **size** (`size next/3.1`) — larger circles further along the spiral
- A **move distance** (`move next*0.90`) — longer steps further out

```
proc fib a b count
    when count
        temp next = a+b
        size (next/3.1)
        turn next
        move next*0.90
        draw
        fork fib next a count-1
    done
```

Starting with `fib 8 5 3` seeds the sequence at 8, 5 — the 6th and 5th Fibonacci numbers. The result is a natural logarithmic spiral with circles growing exponentially, which is the characteristic Fibonacci/golden-ratio spiral shape.

---

## 7. Fibbers Part 2 — Large Fibonacci Spirals

**Procedures:** `fibberspart2`, `fibberslarge`, `fibberslarge2`, `fibrot2`, `fib2`, `fibrot2clr`, `fiblargeend`

### Effect

Four large Fibonacci spirals emanate from the centre simultaneously, slowly rotating and then converging into a cross-shaped wipe.

### Technique: Four-way symmetry by pre-turning

`fibberslarge` launches four `fibrot2` turtles at 90° intervals by turning 128 (half-circle) between pairs and 64 (quarter-circle) between groups:

```
proc fibberslarge dur rot durc
    jump 175 140
    tint 2
    fork fibrot2 dur rot    # right
    turn 128
    fork fibrot2 dur rot    # left
    turn 64
    tint 1
    fork fibrot2 dur rot    # up (tint 1)
    turn 128
    fork fibrot2 dur rot    # down
    tint 0
    ...clearers...
```

Each turtle draws the same spiral but starts facing a different direction, producing perfect 4-fold symmetry from a single procedure.

### Technique: Timed erasure via parallel clearers

A separate set of `fibrot2clr` turtles runs with `tint 0` (erase). They are launched `durc` frames of duration, giving the visual impression of the spiral "consuming" itself from behind. The colour and erase spirals rotate at the same rate (`rot` parameter) so the erase tracks at a fixed lag behind the drawing.

### Technique: Fractal arm scaling

`fib2(a, b, count)` uses `count` directly as the tint index (`tint count`), so the innermost circles of each arm use tint 3 and the outermost use tint 1, automatically creating a depth gradient without any explicit colour code:

```
proc fib2 a b count
    when count
        tint count        # outermost = tint 1, middle = tint 2, inner = tint 3
        move 5
        temp next = a+b
        size (next)
        turn next
        move next*3
        draw
        fork fib2 next a count-1
    done
```

### Technique: Wipe transition via moving large squares

`fiblargeend` ends the scene by launching large erasing squares (`size 70`) at each of the four compass points in sequence, each moving across the screen:

```
proc fiblargewipe count
    when count
        plot
        wait 1
        move 20
        fork fiblargewipe count-1
    done
```

With size 70 and moving 20 units per frame, each square sweeps a wide band across the screen, wiping the spirals clean in 10 frames — a directional wipe used as a scene transition.

---

## 8. Reese Breakdown — Outward Spirals and Wave Patterns

**Procedures:** `reese`, `outboxes`, `outboxspiral`, `outblip`, `reesewave`, `reesecopy`, `reeseturncopy`, `reeseboxudx`, `reeseboxudxdo`, `reeseboxup`

### Effect

A square spiral unwinds outward from the centre in a series of coloured arms, followed by two wave patterns of growing/shrinking square-circle hybrids.

### Technique: Square spiral by turning after N steps

`outboxspiral(a, b, msize)` draws an Archimedes-style spiral by moving a distance proportional to `a` and then turning 90°, with `a` incrementing each recursion:

```
proc outboxspiral a b msize
    when a < b
        fork outplot a msize a
        move msize*a
        turn 64
        wait a
        fork outboxspiral a+1 b msize
    ...
```

At step `a` it moves `msize*a` units before turning — so each side of the spiral is `a` units longer than the previous. With `msize=22` and 14 iterations this produces a square spiral starting small at the centre and expanding to roughly screen width.

### Technique: Growing blip on each step

`outplot(count, msize, a)` does not draw directly. Instead it forks `outblip(0)` — a separate turtle that starts at size 0 and grows by 1 unit every 2 frames up to size 29:

```
proc outblip count
    when count < 30
        size count
        plot
        wait 2
        fork outblip count+1
    done
```

Each step of the spiral leaves behind a circle that inflates and stays, meaning the spiral visually "blossoms" into existence rather than appearing instantaneously.

### Technique: Orthogonal wave pattern

`reeseboxup(count)` produces a shape that alternates between `draw` (circle) and `plot` (square) based on a bit test, growing from size 0 upward:

```
proc reeseboxup count
    when count <= 9*3
        size count
        when (count/15 & 1) == 0
            plot
        else
            draw
        done
        wait 2
        fork reeseboxup count+1
    done
```

`(count/15 & 1)` changes every 15 steps, so the shape alternates between circle and square segments every 15 size-units. At small sizes these blend together; at larger sizes the boundary between circle and square becomes visible. The effect looks like a pulsing organism that morphs between two shapes as it grows.

---

## 9. Broken Beats — Rotating Squares, Tunnels, Edge Lines

**Procedures:** `brokenbeatspart`, `brokenbeats`, `square`, `square2`, `squarerot`, `squareshrink`, `squareclr`, `tunnels`, `tunny2`, `tundrawa/b/c/d`, `brokedges`, `broklinerplotmove`, `brokcircprog`, `brokcirc`

### Effect

Three main sub-effects run simultaneously: a rotating square motif (broken beats), a tunnel zoom, and radiating edge lines.

### Technique: Square drawn as four recursive shrinking arms

`square(s)` draws a diamond/square shape as four arms, each arm being a recursive sequence of smaller and smaller circles:

```
proc square s
    size s*s draw     # central circle
    turn 32
    fork square2 s
    turn 64
    fork square2 s
    turn 64
    fork square2 s
    turn 64
    fork square2 s
```

`square2(s)` moves in the arm direction, draws a circle of size `(s-1)²`, then recurses with `s-1`. The step length is `(s + (s-1)) * sqrt(2) ≈ (s+s-1)*1.4140625` (the diagonal of a square with side `s`), which is the pixel distance between centres when the turtle turns 45° and moves diagonally. This creates a chain of circles on a diagonal axis whose sizes follow a square-law: `s², (s-1)², (s-2)², ...`

Using `s²` instead of `s` for sizing makes the circles grow quadratically — small ones near the tips are nearly invisible while the large central circle dominates, giving a natural "bright centre, fading arms" look without any explicit brightness calculation.

### Technique: Rotation by per-frame direction accumulation

`squarerot(count, rot)` rotates the square by drawing it, turning by `rot`, waiting one frame, erasing (`squareclr`), and recursing:

```
proc squarerot count rot
    when count
        fork squareclr 5.5
        fork square 5.5
        turn rot
        wait 1
        fork squarerot count-1 rot
    done
```

`squareclr` draws a single large tint-0 circle centred on the turtle, erasing the previous frame's square. This technique — draw on frame N, erase at the start of frame N+1, draw new position — produces clean single-frame persistence for the rotating shape.

### Technique: `squareclr` uses clamped size

`squareclr(s)` computes `newsize = s*s*2` (twice the arm size squared) for the erase circle, but clamps it to 53:

```
proc squareclr s
    temp newsize = s*s*2
    when newsize < 53
        size s*s*2
    else
        size 53
    done
    tint 0 draw
```

This ensures the erase circle is always large enough to cover the largest circle drawn by `square2` at that size, without being so large it blots out neighbouring content.

### Technique: Tunnel zoom by shrinking concentric rings

`tunny2(rep, s, a)` draws a stack of concentric rings, each slightly smaller than the last:

```
proc tunny2 rep s a
    when rep>=0
        fork tunnyselect a s
        wait 1
        when rep>0
            size s+1
            tint 0 plot
        done
        fork tunny2 rep-1 s*0.966 a
    done
```

Each recursion scales the radius by 0.966 (shrinks by 3.4%). After 20 recursions the radius is `s * 0.966²⁰ ≈ s * 0.50` — halved. Drawing these at 1-frame intervals creates the impression of a ring approaching from a distance, as each successive ring appears at the centre and all previous rings have moved outward. Because the turtle position is fixed (screen centre), the rings are all concentric. The tunnel shape (tundraw variants `a/b/c/d`) adds extra tint layers at 0.75× and 0.50× of the primary size, creating a depth illusion.

### Technique: Edge burst lines (`brokedges`)

`brokedge` moves 170 units from the centre, turns perpendicular, and forks `broklinerplotmove` which plots a line of dots moving outward at 24 units per step:

```
proc broklinerplotmove rep s
    when rep
        fork broklinerplot s
        move 24
        wait 2
        fork broklinerplotmove rep-1 s
    done
```

`broklinerplot(s)` draws a stack of dots decreasing from size `s` down to 0, one per 1.5 frames. The result is a series of dots that appear at the ends of the arms and each decay over ~10 frames — like a spark trail extending radially outward from the central square.

---

## 10. Rotoboxes — Triangles and "EVERYWAY" Text

**Procedures:** `rotoboxes`, `trifullprog`, `trirot`, `trishrink`, `triangle`, `triangle2s`, `every`, `everyway`, `letter_*`

### Effect

Rotating triangular shapes fill the screen, then the word "EVERYWAY" is written in a dot-matrix font that emerges letter by letter.

### Technique: Triangle drawn as four recursive shrinking arms

`triangle(s)` mirrors the `square(s)` technique but starts at 45° offset (`turn 32`):

```
proc triangle s
    size s*s
    turn 32
    tint 3
    fork triangle2s s
    turn 64
    tint 2
    fork triangle2s s
    turn 64
    tint 3
    fork triangle2s s
    turn 64
    tint 2
    fork triangle2s s
```

The 32° initial offset makes the four arms point at 45° angles (NE, NW, SW, SE), giving a diamond/rhombus rather than axis-aligned square. Alternating tints 3 and 2 on opposite arms creates a two-colour cross shape.

### Technique: Shrink/grow animation via parameter delta

`trishrink(rep, s, inc)` animates the triangle shrinking or growing by `inc` per frame:

```
proc trishrink rep s inc
    when rep
        fork triangle s
        wait 1
        fork trishrinkclr
        fork trishrink rep-1 s-inc inc
    done
```

With `inc=~0.175` (negative) the triangle grows from `s` upward over `rep` frames. With `inc=0.175` (positive) it shrinks. The clearing procedure `trishrinkclr` draws four large tint-0 squares at fixed angles, reliably blotting out the previous frame regardless of the triangle's current size.

### Technique: Dot-matrix text via bit-field patterns

Each letter is a procedure that encodes its bitmap as a sequence of bit-field integer constants. `everyplot(rep, val, m)` reads them one bit at a time:

```
proc everyplotrep rep val m
    when rep
        when val&1==1
            plot
        done
        move m
        fork everyplotrep rep-1 val/2 m
    done
```

`val/2` is an integer right-shift (>> 1 in fixed-point). `val&1` tests the LSB. By stepping `m` units between each bit and moving through the value bit by bit, a column of pixels is drawn wherever a 1-bit appears. Each letter procedure calls `everyplot` for each column of the character bitmap. The column spacing and dot size are both passed as the `m` parameter, so the font scales uniformly.

For example, `letter_E` would encode the E character's column bitmaps as integer constants (e.g., `0b1111111` for the full left edge, `0b1001001` for horizontal bars) and fork `everyplot` for each column.

### Technique: Text drawn letter by letter with `move`/`wait` between

`everyway(s, m, w)` sequences the letters by advancing the turtle's position between each:

```
proc everyway s m w
    turn ~64              # face upward (so letters are vertical)
    move m
    turn 64
    fork letter_E m w
    move m*5  wait w*5    # skip 5 columns, 5 frame delay before next
    fork letter_V m w
    move m*6  wait w*6
    ...
```

The `move m*N` positions the turtle at the start of the next letter (N columns wide). The `wait w*N` delays the fork of the next letter by N frames (one frame per column). This produces a left-to-right reveal where each letter appears to scroll in from left, one column at a time, matching the time it takes the previous letter to finish drawing.

---

## 11. Beamers — Radiating Beam Lines

**Procedures:** `beamers`, `beamer`, `beammirror`, `beam`

### Effect

Pairs of thin lines radiate outward from the screen centre, appearing and disappearing at different angles and lengths. Used as a transition effect between scenes.

### Technique: Growing line by recursive draw-and-move

`beam(w, s, ms, ds)` is a growing beam:

```
proc beam w s ms ds
    when s < ms
        size s draw
        move 3
        wait w
        fork beam w s+ds ms ds
    done
```

`ds` is the size increment per step; `ms` is the maximum size. With `ds=0.46` and `ms=35` the beam grows over ~76 steps. Each step draws a dot of increasing size and advances 3 pixels. Because `wait w` is a fraction (w=0.2), the beam moves at 15 pixels per frame — fast enough to read as a continuous line rather than discrete dots.

### Technique: Symmetric mirror beams

`beammirror(a, b)` turns by `a`, draws one beam, then turns by `b`, then `128` (half-circle), then `b` again — placing the second beam at the exact mirror angle across the centre:

```
proc beammirror a b
    turn a
    fork beam 0.2 1 35 0.46
    turn b
    turn 128
    turn b
    fork beam 0.2 1 35 0.46
```

`turn b; turn 128; turn b` = net turn of 128 + 2b. Choosing `a + b` such that the two beams are symmetric about the vertical produces a clean V-shape.

---

## 12. End Spikes

**Procedures:** `endspikesprog`, `endspikes`, `endtrispikerot`, `endspiketri`, `endspike`

### Effect

Triangular clusters of spiraling spikes emerge from two off-centre positions. Each spike is a corkscrew that grows outward while rotating slightly, producing a twisting brush-stroke effect.

### Technique: Corkscrewing spike

`endspike(s, rep, lt)` draws a growing, slightly rotating spike:

```
proc endspike s rep lt
    when rep
        size s*6.3
        move 6
        draw
        wait 0.5
        turn lt
        fork endspike s+0.1 rep-1 lt
    done
```

Each frame the turtle moves 6 units, draws a circle of size `s*6.3` (so ~12 pixels radius at step 2), waits half a frame, turns `lt` (a small angle like ~0.5 or 0.5), and increases `s` by 0.1. The combination of slight turn and growing size produces a path that curves and thickens — a corkscrew that looks like a brushstroke.

### Technique: Equilateral triangle distribution

`endspiketri(t1, t2, t3, lt)` places three spikes at 120° (256/3 ≈ 85 units) apart:

```
proc endspiketri t1 t2 t3 lt
    tint t1  fork endspike 1 17*6 lt
    turn 256/3
    tint t2  fork endspike 1 17*6 lt
    turn 256/3
    tint t3  fork endspike 1 17*6 lt
```

`256/3` in integer arithmetic is 85, which is slightly less than a perfect third of a circle (85.33). The small error accumulates over many `endtrispikerot` iterations, slightly de-aligning the triangle across the animation — which actually looks intentional, like the triangle gradually breathing.

---

## 13. Final Fire

**Procedures:** `finalfire`, `brokefire2`, `bf2`, `brokefire`, `brorrowmove`, `brorrow`, `brorrowplot`

### Effect

Bursts of fire-like sparks radiate from the centre in multiple directions, each burst leaving a trail of shrinking squares.

### Technique: Arrow-shaped fire particle

`brorrow` is the fundamental fire particle — a small cross/arrow shape:

```
proc brorrow
    size 3
    move 18
    plot              # tip
    turn 128
    fork brorrowplot 2    # left flank
    turn 64
    fork brorrowplot 2    # right flank
```

`brorrowplot` zigzags: `turn ~64; move 8; turn 64; move 8; plot` — this draws two dots that bracket the main axis, creating a simple arrowhead motif. Each fire particle is thus a minimal three-dot chevron.

### Technique: Moving fire wall

`brorrowmove(count)` launches a particle every frame while moving 16 units per frame:

```
proc brorrowmove count
    when count
        fork brorrow
        move 8*2
        wait 1
        fork brorrowmove count-1
    done
```

Over 14 frames at 16 pixels/frame the fire wall travels 224 pixels — almost across the screen. Each forked `brorrow` stays at its launch position (no further movement), so the result is a line of 14 fire particles spread across the screen.

### Technique: Shrinking square as erase burst

`bf2(rep, s)` draws a tint-0 large square then a tint-1 smaller square, waits 1 frame, and recurses with `s` scaled by 0.80:

```
proc bf2 rep s
    when rep
        tint 0  size 21  plot    # erase circle
        tint 1  size s   plot    # coloured circle
        wait 1
        fork bf2 rep-1 s*0.80
    done
```

Starting at `s=20` and scaling by 0.80 per frame: 20, 16, 12.8, 10.2, 8.2, ... — a geometric decay that mimics the visual dissipation of an explosion. The large tint-0 square ensures the previous frame's circle is always erased, leaving only the current-sized dot.

---

## 14. Credits

**Procedures:** `creditsprog`, `credits`, `hoffman`, `blueberry`, `visuals`, `music`, `engine`, `letter_*`

The credits use the same dot-matrix letter engine as the "EVERYWAY" text (`everyplotrep`, `everyplotrep2`). Three copies of each credit line are drawn in tints 3, 2, 1 in quick succession (6 frames apart), creating a chromatic offset or shadow effect. A second pass with tints 2, 3, 0 acts as a delayed erase/colour-shift.

```
proc creditsprog
    tint 3  fork credits  wait 6
    tint 2  fork credits  wait 6
    tint 1  fork credits
    wait 88*2.9
    tint 2  fork credits  wait 6
    tint 3  fork credits  wait 6
    tint 0  fork credits    # erase
```

The 6-frame stagger between the three tints means the credits display as three slightly offset coloured copies — a simple substitute for anti-aliasing or drop-shadow.

---

## 15. Key Recurring Techniques

### Technique: Tint 0 as eraser

Throughout the demo, drawing with tint 0 (the background colour) is used as the sole erasing mechanism. There is no screen clear between frames. This means:

- Effects persist unless explicitly overwritten.
- Erasing must match the size and position of what was drawn, or artefacts remain.
- "Motion blur" can be achieved by erasing at a slightly larger size than what was drawn.
- This is fundamental to the Archimedes port, where clearing the screen each frame would be far too slow at 50 Hz.

### Technique: Recursive countdown as animation timer

Almost every animated procedure has the form:

```
proc foo count ...
    when count
        ...draw something...
        wait N
        fork foo count-1 ...
    done
```

`count` acts simultaneously as a remaining-frames counter and a state variable (e.g., current size or position index). This eliminates the need for mutable globals and makes every animation duration explicit at the call site.

### Technique: `temp` for origin capture

When a turtle needs to return to a starting position after complex movement, it captures `x`, `y`, and `dir` into `temp` variables before beginning:

```
temp cx = x
temp cy = y
temp cf = dir
... (move around) ...
jump cx cy
face cf
```

This is used extensively in the text procedures (`everyway`, `credits`) where each letter must be positioned relative to a fixed baseline while the turtle moves freely to trace strokes.

### Technique: Geometric scaling via `s*s`

Using `s²` instead of `s` for sizes produces a quadratic size scale. This appears in `square`, `triangle`, `square2`, and `triangle2`. The practical effect is that at small `s` values the circles are tiny (nearly invisible), and they grow rapidly only as `s` approaches its maximum. This makes the geometric shapes look "spiky" — prominent in the centre, almost nothing at the tips — without any explicit threshold check.

### Technique: Simultaneous draw/erase turtles

Many effects use two parallel turtles running the same procedure at different `tint` values, offset in time:

```
fork brokefire 3        # draw tint 3 for 5 frames
wait 5
tint 0
fork brokefire 0        # then erase at same positions
```

The erase turtle follows the draw turtle by the wait offset, consuming exactly the same path. Because both turtles inherit the current position/direction state via `fork`, the erase is geometrically guaranteed to match the drawing.

### Technique: Fixed-point fractions in timing

Waits like `wait 0.5` (half a frame) are meaningful because Rose time is 16.16 fixed-point. `0.5 = 0x00008000`. The scheduler places the turtle in `StateLists[frame]` by taking the integer part of `st_time`, so `wait 0.5` repeated twice advances the turtle by exactly one frame. This is used in `broklineplot` and `beam` to achieve sub-frame-accurate spacing between dots in a line, which halves the step size without costing a full frame of motion.
