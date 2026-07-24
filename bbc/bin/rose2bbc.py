#!/usr/bin/env python3
# ============================================================================
# rose2bbc.py — convert Rose compiled bytecode to BeebAsm source for the
# BBC Micro engine.
#
# Inputs (from the visualizer, written next to its CWD on compile):
#   bytecodes.bin   — Rose bytecode (big-endian escape bytes inline)
#   constants.bin   — 32-bit big-endian 16.16 constants
#
# Outputs:
#   rose_data.asm     — constants table + transformed bytecode (labels)
#   sine_quarter.bin  — 4097 x u16 LE quarter sine table, Q14, exact match
#                       for the visualizer's polynomial (interpret.h sin())
#
# Transformed encoding (deviations from the ARM/visualizer stream, resolved
# offline so the 6502 interpreter needs no back-patching):
#   WHEN cond (0x10+c) : opcode byte + 2-byte LE absolute branch target
#   ELSE      (0x01)   : opcode byte + 2-byte LE absolute jump target
#   DONE      (0x00)   : removed (label only)
#   PROC      (0x07)   : opcode byte + 2-byte LE absolute proc address
#                        (replaces the 1-byte proc index)
# Everything else is byte-for-byte the original encoding, including the
# big-constant escape (0xFE + extra byte).
# ============================================================================

import math
import sys
import struct
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "tools"))

BC_DONE, BC_ELSE, BC_END, BC_RAND, BC_DRAW, BC_TAIL, BC_PLOT, BC_PROC = range(8)
BC_POP, BC_DIV, BC_WAIT, BC_SINE, BC_SEED, BC_NEG, BC_MOVE, BC_MUL = range(8, 16)
BC_WHEN = 0x10
BC_FORK = 0x20
BC_CONST = 0x80
BIG_CONSTANT_BASE = 126
END_OF_SCRIPT = 0xFF


def make_sine_quarter():
    """Exact replica of interpret.h sin() for na in 0..4096 (Q14 output)."""
    out = []
    for na in range(4097):
        if na == 4096:
            out.append(16384)
            continue
        na2 = (na * na) >> 8
        r = (((((((2373 * na2) >> 16) - 21073) * na2) >> 16) + 51469) * na) >> 13
        out.append(r)
    return out


def scan(bc):
    """Return list of (offset, opcode, extra_bytes) instructions."""
    ins = []
    i = 0
    while i < len(bc):
        op = bc[i]
        if op == END_OF_SCRIPT:
            ins.append((i, op, b""))
            break
        if op == BC_PROC:
            ins.append((i, op, bc[i + 1:i + 2]))
            i += 2
        elif op >= BC_CONST and (op & 0x7F) == BIG_CONSTANT_BASE:
            ins.append((i, op, bc[i + 1:i + 2]))
            i += 2
        else:
            ins.append((i, op, b""))
            i += 1
    return ins


PHYS_RGB = [(0, 0, 0), (15, 0, 0), (0, 15, 0), (15, 15, 0),
            (0, 0, 15), (15, 0, 15), (0, 15, 15), (15, 15, 15)]


def _cdist(a, b):
    """Perceptually weighted squared distance between two 0-15 RGB triples."""
    return (0.30 * (a[0] - b[0]) ** 2 + 0.59 * (a[1] - b[1]) ** 2
            + 0.11 * (a[2] - b[2]) ** 2)


def _fid(src, p):
    """Fidelity cost of showing source RGB as physical colour p.

    Luma-weighted distance alone maps dark saturated colours to the wrong
    hue (dark violet lands on red, never magenta, because the blue channel
    barely weighs), so for saturated sources add a hue term: the source
    normalised to full brightness compared against the (non-black) target.
    Greys are untouched — their max-min is 0 — and black stays hue-neutral.
    """
    d = _cdist(src, PHYS_RGB[p])
    mx = max(src)
    if mx and p != 0:
        sat = (mx - min(src)) / 15.0
        if sat:
            scaled = tuple(c * 15.0 / mx for c in src)
            d += sat * _cdist(scaled, PHYS_RGB[p])
    return d


def _assign_phys(cur, prev, changed, claims, stable=None):
    """Map each defined tint to one of the 8 TTL colours, jointly.

    Independent nearest-colour merges distinct dark tints into black and
    loses detail, so the whole palette is solved together: fidelity plus
    a flat-plus-distance penalty when two tints with distinct source RGB
    share a physical colour (doubled when one is the background, since
    drawing that merges into the background disappears entirely; waived
    for near-identical sources), plus a hysteresis cost against
    re-mapping tints whose source didn't change this frame. Background
    (tint 0) fidelity is double-weighted since it covers most of the
    screen. The penalty is soft: a dark colour still shares black rather
    than jump to a wildly wrong bright primary. With <= 4 tints and 8
    colours the 8^n brute force is at most 4096 combos.

    claims[p] is the set of tints whose upcoming source values map
    strongly onto physical colour p (lookahead in make_colorscript): a
    changed tint avoids parking on a colour some other tint is about to
    need, or a cyclic fade would trap it into sharing every cycle.
    """
    from itertools import product
    tints = sorted(cur)
    best, best_cost = None, None
    for combo in product(range(8), repeat=len(tints)):
        cost = 0.0
        for i, tint in enumerate(tints):
            f = _fid(cur[tint], combo[i])
            cost += 2.0 * f if tint == 0 else f
            if tint in prev and tint not in changed and combo[i] != prev[tint]:
                # A remap recolours the tint's whole screen history (Rose
                # never clears), so a tint whose source didn't change only
                # moves under real collision pressure (eviction), and never
                # moves back for a mere fidelity gain — cyclic palette
                # fades would otherwise ping-pong bystander tints.
                cost += 40.0
            if (tint in changed and f >= 8.0
                    and claims.get(combo[i], set()) - {tint}):
                cost += 30.0            # weak match parking on a colour
                                        # another tint is about to need
        for i in range(len(tints)):
            for j in range(i + 1, len(tints)):
                if combo[i] == combo[j]:
                    d = _cdist(cur[tints[i]], cur[tints[j]])
                    fire = d >= 1.0     # near-identical sources may share...
                    if (not fire and d > 0.0 and stable is not None
                            and tints[i] == 0 and stable.get(tints[j])):
                        # ...but a STABLE drawing tint one shade off the
                        # background must not vanish into it (logicos logo:
                        # 444 art on 333 bg for thousands of frames). Fade
                        # transients (source changing again within a few
                        # frames) keep the waiver so fade starts stay dark.
                        fire = True
                    if fire:
                        pen = 15.0 + 2.0 * d
                        if tints[i] == 0:
                            pen *= 2.0  # merging into the background is worst
                        cost += pen
        if best_cost is None or cost < best_cost:
            best_cost, best = cost, combo
    return {tint: best[i] for i, tint in enumerate(tints)}


def _flatten_events(events, plots_bin):
    """Flatten an 8-tint (2 layers x depth 4) event stream to the 4 MODE 1
    logical colours.

    The render path draws pixel value tint & 3, so tints t and t+4 share a
    logical slot; this picks which of the pair *owns* the slot's palette
    entry over time, weighted by upcoming plot counts from
    expected_plots.bin (the tint about to draw wins). Slot 0 is always
    owned by tint 0: tint 4 is the layer-1 transparent index, invisible on
    the Archimedes too, so flattened it becomes erase-to-background.
    Returns a frame-ordered (frame, slot, rgb) stream for the joint solve.
    """
    W = 384                             # lookahead window (frames)
    lastf = max(f for f, _, _ in events)
    NF = lastf + 2
    cnt = [[0] * (NF + W + 1) for _ in range(8)]
    for i in range(0, len(plots_bin) - 9, 10):
        t, x, y, r, c = struct.unpack_from("<5h", plots_bin, i)
        if 0 <= t < NF + W:
            cnt[(~c if c < 0 else c) & 7][t] += 1
    pre = []
    for c in cnt:
        acc = [0]
        for v in c:
            acc.append(acc[-1] + v)
        pre.append(acc)

    def wsum(tint, f):
        return pre[tint][min(f + W, NF + W)] - pre[tint][min(f, NF + W)]

    src = {}                            # tint -> latest source RGB
    owner = [0, 1, 2, 3]                # slot -> owning tint
    out = []
    ei = 0
    for f in range(NF):
        while ei < len(events) and events[ei][0] <= f:
            _, tint, rgb = events[ei]
            ei += 1
            src[tint] = rgb
            if owner[tint & 3] == tint:
                out.append((f, tint & 3, rgb))
        for L in (1, 2, 3):             # owner challenge (slot 0 fixed)
            o = owner[L]
            c = o ^ 4
            if src.get(c) is None:
                continue
            wc = wsum(c, f)
            if wc >= 8 and wc > 2 * wsum(o, f):
                owner[L] = c
                if src[c] != src.get(o):
                    out.append((f, L, src[c]))
    return out


def make_colorscript(data, plots_bin=None):
    """Decode colorscript.bin and quantise 12-bit RGB to the 8 TTL colours.

    Emits 3-byte records: frame lo, frame hi, (logical<<4)|physical,
    terminated by frame &FFFF. Changes are batched per frame and the
    palette re-solved jointly (see _assign_phys); a record is emitted for
    every tint whose physical colour moved, so one source change may emit
    extra records to pull a colliding tint onto a free colour.
    Dual-playfield demos (tints 4-7 present) are first flattened to the
    4 logical slots via _flatten_events.
    """
    words = struct.unpack(f">{len(data) // 2}H", data)
    t = -1
    events = []                         # (frame, tint, rgb), frame-ordered
    for w in words:
        if w == 0x8000:
            break
        if w & 0x8000:
            t += 0x10000 - w            # negative word = frame delta
        else:
            events.append((t, w >> 12, ((w >> 8) & 15, (w >> 4) & 15, w & 15)))

    flattened = False
    if events and max(tint for _, tint, _ in events) > 3:
        if plots_bin is None:
            raise SystemExit("colorscript uses tints 4-7: expected_plots.bin "
                             "needed to flatten to 4 colours")
        events = _flatten_events(events, plots_bin)
        flattened = True

    from bisect import bisect_right
    evframes = {}                       # tint -> sorted event frames, for the
    for f, tint, _ in events:           # stability lookahead (flatten only)
        evframes.setdefault(tint, []).append(f)

    # strong claims for the lookahead: events whose source maps cleanly
    # onto one physical colour (a grey "wants" nothing; pure yellow does)
    strong = [(f, tint, min(range(8), key=lambda p: _fid(rgb, p)))
              for f, tint, rgb in events
              if min(_fid(rgb, p) for p in range(8)) < 8.0]

    cur = {}                            # tint -> source RGB (0-15 triple)
    emitted = {}                        # tint -> last physical colour sent
    lines = [".rose_colorscript"]
    i = 0
    while i < len(events):
        t = events[i][0]
        changed = set()
        while i < len(events) and events[i][0] == t:
            _, tint, rgb = events[i]
            cur[tint] = rgb
            changed.add(tint)
            i += 1
        claims = {}
        for f, tint, p in strong:
            if t < f <= t + 128:
                claims.setdefault(p, set()).add(tint)
        stable = None
        if flattened:
            stable = {}
            for tint in cur:
                fl = evframes.get(tint, [])
                k = bisect_right(fl, t)
                stable[tint] = k >= len(fl) or fl[k] - t > 24
        phys = _assign_phys(cur, emitted, changed, claims, stable)
        for tint in sorted(phys, key=lambda k: (k not in changed, k)):
            if emitted.get(tint) != phys[tint]:
                r, g, b = cur[tint]
                lines.append(
                    f"    EQUB &{t & 0xFF:02X}, &{(t >> 8) & 0xFF:02X}, "
                    f"&{(tint << 4) | phys[tint]:02X}"
                    f"  ; frame {t}: tint {tint} ({r:X}{g:X}{b:X}) -> {phys[tint]}")
                emitted[tint] = phys[tint]
    lines.append("    EQUB &FF, &FF, &00")
    return "\n".join(lines) + "\n"


def _emit_plots(build, bc, constants, frames):
    """Plots in the ENGINE's emission order (pyinterp = bit-exact model),
    cached as pyplots.bin. Multiset-checked against expected_plots.bin."""
    import collections
    cache = build / "pyplots.bin"
    bcf = build / "bytecodes.bin"
    if cache.exists() and cache.stat().st_mtime > bcf.stat().st_mtime:
        d = cache.read_bytes()
        return [struct.unpack_from("<5h", d, i) for i in range(0, len(d) - 9, 10)]
    import pyinterp
    plots = pyinterp.run(bc, constants, frames)
    exp = (build / "expected_plots.bin").read_bytes()
    expl = [struct.unpack_from("<5h", exp, i) for i in range(0, len(exp) - 9, 10)]
    if collections.Counter(plots) != collections.Counter(expl):
        raise SystemExit("pyinterp emission model does not match "
                         "expected_plots.bin — fix that before trusting the "
                         "tint-4 drop mask")
    cache.write_bytes(b"".join(struct.pack("<5h", *p) for p in plots))
    return plots


def make_t4mask(build, bc, constants, frames, formw, formh):
    """Verdicts for the erase-class plots (tint & 7 == 4): on the Archimedes
    they erase layer 1 only, flattened they erase everything. A two-layer
    replay in the engine's exact render order (stable (t, y-r) over the
    emission order) marks each one no-op (layer 1 already clear under it ->
    DROP) or effective (KEEP: erase-to-background approximates revealing
    layer 0). Returns (bits, dropped_records): one keep-bit per erase-class
    plot in EMISSION order with r >= 0, consumed by sort_add;
    dropped_records go to t4drop.bin for pixelverify.
    """
    exp = (build / "expected_plots.bin").read_bytes()
    any_t4 = False
    for i in range(0, len(exp) - 9, 10):
        c = struct.unpack_from("<h", exp, i + 8)[0]
        if ((~c if c < 0 else c) & 7) == 4:
            any_t4 = True
            break
    if not any_t4:
        return [], []

    plots = _emit_plots(build, bc, constants, frames)
    order = sorted(range(len(plots)),
                   key=lambda i: (plots[i][0], plots[i][2] - plots[i][3]))
    l1 = bytearray(formw * formh)
    verdict = {}                       # emit index -> keep?
    for i in order:
        t, x, y, r, c = plots[i]
        if r < 0:
            continue
        sq = c < 0
        tint = (~c if sq else c) & 7
        if tint < 4:
            continue                   # layer 0: no effect on layer 1
        idx = tint & 3
        r = min(r, 70)
        touched = False
        for dy in range(-r, r + 1):
            yy = y + dy
            if not 0 <= yy < formh:
                continue
            if sq:
                hw = r
            else:
                v = r * r + r - dy * dy
                hw = math.isqrt(v)
            x0, x1 = max(0, x - hw), min(formw - 1, x + hw)
            if x1 < x0:
                continue
            row = slice(yy * formw + x0, yy * formw + x1 + 1)
            if idx == 0:
                if not touched and any(l1[row]):
                    touched = True
                l1[row] = bytes(x1 - x0 + 1)
            else:
                l1[row] = bytes([idx]) * (x1 - x0 + 1)
        if idx == 0:
            verdict[i] = touched       # no-op erases drop

    bits = []                          # keep-bit per plot in emission order
    dropped = []
    for i in range(len(plots)):
        t, x, y, r, c = plots[i]
        if r < 0 or ((~c if c < 0 else c) & 7) != 4:
            continue
        keep = verdict.get(i, True)
        if not keep:
            dropped.append(plots[i])
        bits.append(keep)
    return bits, dropped


# --- SWRAM span filler generation -------------------------------------------
# One routine per (left pixel offset o 0-3, span pixel length L 1-125), with
# edge masks baked in. Two 16KB bank images: bank 4 holds o=0,1; bank 5 o=2,3.
# Bank layout: vec lo[125] at +0, vec hi at +128, second o at +256/+384,
# code from +512. Routines end by jumping into the shared middle-store chain
# in main RAM (fixed at CHAIN_RTS - 4k, chain at &0E00) or rts.
# These addresses must match interp.asm:
SPAN_SCR = 0x8D             # zp screen pointer
SPAN_RFILL = 0x6E           # zp fill byte
SPAN_TMPB = 0x6F            # zp masked-write temp
CHAIN_RTS = 0x0E7C          # &0E00 chain: 31 units of 4 bytes, rts at +124
MASK_L = [0xFF, 0x77, 0x33, 0x11]
MASK_R = [0x88, 0xCC, 0xEE, 0xFF]
SPAN_MAXL = 125


def _masked_write(mask, indexed):
    """new = old ^ ((old ^ fill) & mask) at (scr) or (scr),y."""
    lda = 0xB1 if indexed else 0xB2
    sta = 0x91 if indexed else 0x92
    return bytes([lda, SPAN_SCR,
                  0x85, SPAN_TMPB,      # sta zp
                  0x45, SPAN_RFILL,     # eor zp
                  0x29, mask,
                  0x45, SPAN_TMPB,
                  sta, SPAN_SCR])


def _span_routine(o, L):
    n = (o + L - 1) // 4 + 1            # bytes touched
    o1 = (o + L - 1) & 3
    ml = MASK_L[o]
    mr = MASK_R[o1]
    lda_rfill = bytes([0xA5, SPAN_RFILL])   # lda zp
    if n == 1:
        m = ml & mr
        if m == 0xFF:
            return lda_rfill + bytes([0x92, SPAN_SCR, 0x60])
        return _masked_write(m, False) + bytes([0x60])
    code = b""
    if ml != 0xFF:
        code += _masked_write(ml, False)
    else:
        code += lda_rfill + bytes([0x92, SPAN_SCR])
    if mr != 0xFF:
        code += bytes([0xA0, (n - 1) * 8]) + _masked_write(mr, True)
        k = n - 2
    else:
        k = n - 1                        # solid right byte joins the chain
    if k == 0:
        return code + bytes([0x60])
    entry = CHAIN_RTS - 4 * k
    return code + lda_rfill + bytes([0x4C, entry & 0xFF, entry >> 8])


def make_span_banks():
    banks = []
    for b in range(2):
        img = bytearray(512)
        code = bytearray()
        for half, o in enumerate((2 * b, 2 * b + 1)):
            base = half * 256
            for L in range(1, SPAN_MAXL + 1):
                addr = 0x8000 + 512 + len(code)
                r = _span_routine(o, L)
                code += r
                img[base + (L - 1)] = addr & 0xFF
                img[base + 128 + (L - 1)] = addr >> 8
        img += code
        assert len(img) <= 0x4000, f"span bank {b} overflows: {len(img)}"
        banks.append(bytes(img))
    return banks


def make_circle_bank(maxr=70):
    """Bank 6 image: half-width row pointers lo[128]/hi[128] at +0/+128,
    fast-path tables at +256, row data from +1024.

    Coverage matches the visualizer's plot shader exactly: the blob sits at
    the pixel centre with radius r+0.5, so pixel (dx,dy) is covered iff
    dx^2 + dy^2 < (r+0.5)^2. With integer dx that gives half-width
    isqrt(r^2 + r - dy^2) — never more than r, rows still -r..r.
    (floor(sqrt(r^2-dy^2)) undersizes: spiky tips, and black eraser blobs
    miss the fringe the visualizer's discs cover.)

    Fast-path tables (render.inc.asm OFFTAB/D8LTAB/D8HTAB at &8100/&8200/
    &8300): four 64-entry rows each, one per x-phase, indexed by half-width.
    With t = phase - hw: OFF = t & 3 (span left offset), D8 = 8 * (t >> 2)
    signed 16-bit (byte shift from the centre column to the span's first
    byte, so screen addr = base(centre column) + D8 with no per-line phase
    arithmetic)."""
    lo = bytearray(128)
    hi = bytearray(128)
    off = bytearray(256)
    d8l = bytearray(256)
    d8h = bytearray(256)
    for p in range(4):
        for h in range(64):
            t = p - h
            o = t & 3
            d8 = ((t - o) >> 2) * 8
            off[p * 64 + h] = o
            d8l[p * 64 + h] = d8 & 0xFF
            d8h[p * 64 + h] = (d8 >> 8) & 0xFF
    data = bytearray()
    for r in range(maxr + 1):
        addr = 0x8400 + len(data)
        lo[r] = addr & 0xFF
        hi[r] = addr >> 8
        data += bytes(math.isqrt(r * r + r - dy * dy) for dy in range(-r, r + 1))
    img = bytes(lo) + bytes(hi) + bytes(off) + bytes(d8l) + bytes(d8h) + bytes(data)
    assert len(img) <= 0x1900, "circle bank reaches SORTBASE (&9900)"
    return img


def main():
    if len(sys.argv) < 3:
        print("usage: rose2bbc.py <build_dir> <out_dir> [maxradius] [frames] [formw formh]")
        sys.exit(1)
    build = Path(sys.argv[1])
    out = Path(sys.argv[2])
    maxr = int(sys.argv[3]) if len(sys.argv) > 3 else 45
    frames = int(sys.argv[4]) if len(sys.argv) > 4 else 10000
    formw = int(sys.argv[5]) if len(sys.argv) > 5 else 352
    formh = int(sys.argv[6]) if len(sys.argv) > 6 else 280

    bc = (build / "bytecodes.bin").read_bytes()
    cb = (build / "constants.bin").read_bytes()
    constants = [struct.unpack(">i", cb[i:i + 4])[0] for i in range(0, len(cb), 4)]

    ins = scan(bc)

    # Resolve WHEN/ELSE targets by nesting (mirrors rose2arc.py label stack).
    target = {}          # instruction offset -> target offset (original stream)
    stack = []
    for off, op, extra in ins:
        if BC_WHEN <= op <= BC_WHEN + 0xF:
            stack.append(off)
        elif op == BC_ELSE:
            target[stack.pop()] = off + 1   # branch past the ELSE jump
            stack.append(off)
        elif op == BC_DONE:
            target[stack.pop()] = off       # DONE emits nothing; label = next op

    # Proc boundaries: proc N starts at 0 / after each END.
    proc_start = {0: 0}
    n = 1
    for k, (off, op, extra) in enumerate(ins):
        if op == BC_END and k + 1 < len(ins) and ins[k + 1][1] != END_OF_SCRIPT:
            proc_start[ins[k + 1][0]] = n
            n += 1

    lines = []
    w = lines.append
    w("; Generated by rose2bbc.py — do not edit.")
    w(f"; {len(constants)} constants, {len(bc)} bytecode bytes, {n} procs.")
    w("")
    w(".rose_constants")
    for i, c in enumerate(constants):
        w(f"    EQUD &{c & 0xFFFFFFFF:08X}  ; [{i}] = {c / 65536.0:.4f}")
    w("")
    w(".rose_bytecode")

    label_needed = set(target.values()) | set(proc_start.keys())
    for off, op, extra in ins:
        if off in proc_start:
            w(f".rose_p{proc_start[off]}")
        if off in label_needed:
            w(f".bc_{off}")
        if op == BC_DONE:
            continue  # label only
        if op == BC_ELSE:
            w(f"    EQUB &01 : EQUW bc_{target[off]}  ; ELSE")
        elif BC_WHEN <= op <= BC_WHEN + 0xF:
            w(f"    EQUB &{op:02X} : EQUW bc_{target[off]}  ; WHEN cond={op & 15}")
        elif op == BC_PROC:
            w(f"    EQUB &07, &{extra[0]:02X}  ; PROC {extra[0]} (proctab index)")
        elif extra:
            w(f"    EQUB &{op:02X}, &{extra[0]:02X}")
        else:
            w(f"    EQUB &{op:02X}")

    # Proc address table for the 1-byte PROC index encoding.
    w("")
    w(".proctab_lo")
    for k in range(n):
        w(f"    EQUB <rose_p{k}")
    w(".proctab_hi")
    for k in range(n):
        w(f"    EQUB >rose_p{k}")

    # Erase-class (tint & 7 == 4) drop mask: one verdict bit per erase-class
    # record in emission order, MSB first (1 = keep), consumed by sort_add.
    # Padded with keep bits; empty for single-layer demos.
    bits, dropped = make_t4mask(build, bc, constants, frames, formw, formh)
    w("")
    w(".t4mask")
    padded = bits + [True] * (-len(bits) % 8) + [True] * 16
    for i in range(0, len(padded), 8):
        byte = 0
        for b in padded[i:i + 8]:
            byte = (byte << 1) | (1 if b else 0)
        w(f"    EQUB &{byte:02X}")
    (build / "t4drop.bin").write_bytes(
        b"".join(struct.pack("<5h", *p) for p in dropped))
    if bits:
        print(f"t4mask: {len(bits)} erase-class plots, {len(dropped)} "
              f"dropped, {len(padded) // 8} mask bytes")

    (out / "rose_data.asm").write_text("\n".join(lines) + "\n")
    # Colorscript in its own file: the single-CPU build includes it with CODE
    # (before .rose_data_end); the Tube build includes it in HOST only.
    plots_path = build / "expected_plots.bin"
    (out / "colorscript.asm").write_text(
        make_colorscript((build / "colorscript.bin").read_bytes(),
                         plots_path.read_bytes() if plots_path.exists() else None) + "\n")

    q = make_sine_quarter()
    (out / "sine_quarter.bin").write_bytes(b"".join(struct.pack("<H", v) for v in q))
    circ = make_circle_bank()
    (out / "circles.bin").write_bytes(circ)
    banks = make_span_banks()
    (out / "spans4.bin").write_bytes(banks[0])
    (out / "spans5.bin").write_bytes(banks[1])

    print(f"rose2bbc: {len(constants)} constants, {len(ins)} instructions, "
          f"{n} procs, sine table {2 * len(q)} bytes, circle bank {len(circ)} bytes, "
          f"span banks {len(banks[0])}+{len(banks[1])} bytes")


if __name__ == "__main__":
    main()
