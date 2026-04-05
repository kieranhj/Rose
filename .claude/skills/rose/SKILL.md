---
name: rose
description: Write, iterate on, and debug Rose scripts (temporal turtle graphics language). Use this when asked to create or modify .rose files.
argument-hint: "[description of what to create]"
allowed-tools: Read, Write, Edit, Bash(build/rose.exe *)
---

Write a Rose script based on: $ARGUMENTS

## Workflow

1. Write the `.rose` file to `visualizer/examples/`
2. Test with the visualizer: `build/rose.exe visualizer/examples/<file>.rose -o /tmp/out.png -f <N>`
3. Read the output PNG to check the result
4. For animations, check multiple frames: `-f 0-<last>` with a `%03d` filename pattern
5. Iterate until the result looks right

## Language Rules (non-obvious — check every script against these)

**Syntax**
- All keywords are exactly 4 letters: `proc`, `fork`, `move`, `turn`, `wait`, `tint`, `size`, `draw`, `plot`, `jump`, `face`, `when`, `done`, `else`, `wire`, `temp`, `fact`, `form`, `plan`, `part`, `seed`, `rand`, `sine`, `look`, `fade`, `defy`
- Whitespace-agnostic; comments with `#`
- All numbers are 16.16 fixed-point. Hex literals (`$XXXXXXXX`) are raw 32-bit fixed-point (last 4 digits are fractional). E.g. `$8000` = 0.5, `$C000` = 0.75

**Procedures**
- The **first** `proc` in the file is the entry point and **must have no parameters**
- There are **no direct procedure calls** — every invocation is `fork`
- `fork proc [args]` spawns a new turtle running `proc`; the **current turtle continues** executing after the fork
- For recursion, use a chain: `fork stem dist - 2` (the forked turtle is the "recursive call")

**Negation**
- Use `~` for unary negation, not `-`: write `~3`, not `-3`
- Binary subtraction uses `-`: `dist - 2` is fine
- Common mistake: `turn ~x ~x` is two expressions — use `turn ~(x + x)` or `turn ~x * 2`

**Variables**
- `wire var = expr` — global, inherited by forked turtles
- `temp var = expr` — local to current turtle
- Built-in read-only: `x`, `y`, `dir` (current position/direction)

**Direction & trig**
- Directions: 256 units = full circle, clockwise from right (0=right, 64=down, 128=left, 192=up)
- `turn expr` turns clockwise by expr/256 of a circle
- `face expr` sets absolute direction
- `sine(x)` computes sin(2π·x) — not radians

**Animation**
- `wait expr` pauses the current turtle for `expr` frames
- `fork` spawns immediately (same frame) unless the parent has waited
- To grow a structure over time: add `wait 1` inside the drawing loop, and `wait len/2` in the branching proc before spawning children

**Colors**
- `form W H layers colors_per_layer` — default is `form 352 280 1 4`
- `plan` block sets color script: `0:RGB` sets tint 0 to color RGB (3-digit hex)
- First tint in each layer except layer 0 is transparent
- `tint expr` sets current turtle's color index (integer part used)

## Common Patterns

**Drawing a line segment** (dots every N pixels):
```rose
proc stem dist
  when dist > 1
    draw
    move 2
    wait 1          # omit for static, keep for animated
    fork stem dist - 2
  done
```

**Recursive branching** (static):
```rose
proc branch len
  when len > 4
    fork stem len
    move len
    turn spread
    fork branch len * 2 / 3
    turn ~(spread + spread)
    fork branch len * 2 / 3
  done
```

**Recursive branching** (animated — grows over time):
```rose
proc branch len
  when len > 4
    fork stem len   # draws segment over time
    move len
    wait len / 2    # wait for stem to finish
    turn spread
    fork branch len * 2 / 3
    turn ~(spread + spread)
    fork branch len * 2 / 3
  done
```

**Circular motion**:
```rose
proc orbit t
  temp px = sine(t) * radius
  temp py = sine(t + $4000) * radius   # $4000 = 0.25, quarter turn = cosine
  jump cx + px cy + py
  draw
  wait 1
  fork orbit t + speed
```

## Common Errors and Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| `expecting: 'fork' ...` at a proc name | Direct call instead of fork | Change `stem dist` → `fork stem dist` |
| `Entry procedure must not have any parameters` | First proc has params | Put `proc main` (no params) first |
| `'uint64_t' does not name a type` | Missing cstdint include | Add `#include <cstdint>` to interpret.h |
| Turn does nothing / wrong direction | Used `-x` not `~x` | Change `-expr` → `~expr` |
| Two values after turn/move | Used `~x ~x` | Change to `~(x + x)` |

## Checking Your Work

```bash
# Static script — check frame 0
build/rose.exe visualizer/examples/myscript.rose -o /tmp/out.png

# Animation — check specific frame
build/rose.exe visualizer/examples/myscript.rose -o /tmp/out.png -f 50

# Animation — render sequence to inspect
build/rose.exe visualizer/examples/myscript.rose -o /tmp/frame_%03d.png -f 0-100

# Live preview (interactive)
build/rose.exe visualizer/examples/myscript.rose x3
```

Read the output PNG with the Read tool to inspect the result and iterate.
