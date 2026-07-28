#!/usr/bin/env python3
# Reference model of the BBC engine: interprets original Rose bytecode with
# the exact semantics interp.asm implements (32-bit wrap, FIFO buckets).
# Used to validate the engine design against the visualizer's plot list.
import os
import struct
import sys
import collections

M32 = 0xFFFFFFFF
TRACE_ROR = os.environ.get("ROSE_TRACE_ROR") == "1"


def s32(v):
    v &= M32
    return v - 0x100000000 if v & 0x80000000 else v


def s16(v):
    v &= 0xFFFF
    return v - 0x10000 if v & 0x8000 else v


def sinq(a):
    na = a & 8191
    if na == 4096:
        r = 16384
    else:
        if na > 4096:
            na = 8192 - na
        na2 = (na * na) >> 8
        r = (((((((2373 * na2) >> 16) - 21073) * na2) >> 16) + 51469) * na) >> 13
    return -r if a & 8192 else r


def rand_iter(v):
    return s32(((v & 0xFFFF) * 0x9D3D) + s32(((v & M32) << 16 | ((v >> 16) & 0xFFFF)) & M32))


class Turtle:
    __slots__ = ("pc time x y size tint rand dir stk "
                 "w0 w1 w2 w3 w4 w5 w6 w7").split()

    def __init__(self):
        self.w0 = self.w1 = self.w2 = self.w3 = 0
        self.w4 = self.w5 = self.w6 = self.w7 = 0


def scan_procs(bc):
    procs = [0]
    i = 0
    while i < len(bc):
        op = bc[i]
        if op == 0xFF:
            break
        if op == 0x07 or (op >= 0x80 and (op & 0x7F) == 126):
            i += 2
        else:
            i += 1
        if op == 0x02 and i < len(bc) and bc[i] != 0xFF:
            procs.append(i)
    return procs


def resolve_when(bc):
    """target[i] for WHEN/ELSE at offset i (original stream semantics)."""
    target = {}
    stack = []
    i = 0
    while i < len(bc):
        op = bc[i]
        if op == 0xFF:
            break
        if 0x10 <= op <= 0x1F:
            stack.append(i)
        elif op == 0x01:
            target[stack.pop()] = i + 1
            stack.append(i)
        elif op == 0x00:
            target[stack.pop()] = i
        if op == 0x07 or (op >= 0x80 and (op & 0x7F) == 126):
            i += 2
        else:
            i += 1
    return target


def oplen(bc, i):
    """Encoded length of the opcode at offset i (PROC and the big-constant
    escape carry a byte operand; everything else is one byte)."""
    op = bc[i]
    return 2 if (op == 0x07 or (op >= 0x80 and (op & 0x7F) == 126)) else 1


def run(bc, constants, frames=10000, trace_frames=None, stats=None, pairs=None):
    """If `stats` is a list, append (Counter of executed opcode bytes, turtle
    activations, live turtles) per frame — the input to bbc/tools/budget.py.

    If `pairs` is a dict, fill it with the input to bbc/tools/pairs.py (R5
    fusion): `pairs["fall"]` counts, per bytecode offset, how often the op
    there was followed by its statically adjacent successor, and
    `pairs["entry"]` is the set of offsets ever reached any other way (branch
    target, tail, proc entry, wait resume). Only a pair whose second op is
    absent from `entry` can be fused into one opcode."""
    if pairs is not None:
        pairs.setdefault("fall", collections.Counter())
        pairs.setdefault("entry", set())
        PFALL, PENTRY = pairs["fall"], pairs["entry"]
    procs = scan_procs(bc)
    target = resolve_when(bc)
    plots = []
    buckets = collections.defaultdict(collections.deque)

    t0 = Turtle()
    t0.pc = procs[0]
    t0.time = 0
    t0.x = t0.y = t0.dir = 0
    t0.size = 2 << 16
    t0.tint = 1 << 16
    t0.rand = s32(0xBABEFEED)
    t0.stk = []
    buckets[0].append(t0)
    alive = 1

    frame = 0
    while frame < frames and alive > 0:
        q = buckets[frame & 0xFF]
        deferred = collections.deque()
        C = collections.Counter() if stats is not None else None
        acts = 0
        while q:
            t = q.popleft()
            if (t.time >> 16) & 0xFFFF != frame & 0xFFFF or t.time >> 16 != frame:
                deferred.append(t)
                continue
            acts += 1
            # run turtle until wait/end (stack persists on the turtle)
            stk = t.stk
            pc = t.pc
            pend = None
            while True:
                if pairs is not None:
                    if pend == pc:
                        PFALL[pstart] += 1
                    else:
                        PENTRY.add(pc)
                    pstart, pend = pc, pc + oplen(bc, pc)
                op = bc[pc]
                pc += 1
                if C is not None:
                    C[op] += 1
                if op >= 0x80:
                    idx = op & 0x7F
                    if idx == 126:
                        idx = 126 + bc[pc]
                        pc += 1
                    stk.append(constants[idx])
                elif op >= 0x70:
                    f = op & 15
                    stk.append([t.pc, t.x, t.y, t.size, t.tint, t.rand, t.dir,
                                t.time][f] if f < 8 else getattr(t, f"w{f - 8}"))
                elif op >= 0x60:
                    stk.append(stk[op & 15])
                elif op >= 0x50:
                    v = stk.pop()
                    f = op & 15
                    if f == 0:
                        t.pc = v & 0xFFFF
                    elif f == 1:
                        t.x = v
                    elif f == 2:
                        t.y = v
                    elif f == 3:
                        t.size = v
                    elif f == 4:
                        t.tint = v
                    elif f == 5:
                        t.rand = v
                    elif f == 6:
                        t.dir = v
                    elif f == 7:
                        t.time = v
                    else:
                        setattr(t, f"w{f - 8}", v)
                elif op >= 0x40:
                    stk[op & 15] = stk.pop()
                elif op >= 0x30:
                    o = op & 15
                    a = stk.pop()      # left (top)
                    b = stk.pop()      # right
                    if o == 13:
                        stk.append(s32(a + b))
                    elif o in (9, 11):
                        stk.append(s32(a - b))
                    elif o == 12:
                        stk.append(s32((a & M32) & (b & M32)))
                    elif o == 8:
                        stk.append(s32((a & M32) | (b & M32)))
                    elif o == 0:               # ASR (interpret.h semantics)
                        sh = (b >> 16) & 63
                        stk.append(-1 if sh >= 32 else s32(a >> sh))
                    elif o == 1:               # LSR
                        sh = (b >> 16) & 63
                        stk.append(0 if sh >= 32 else s32((a & M32) >> sh))
                    elif o == 3:               # ROR
                        sh = (b >> 16) & 31
                        r = (a if sh == 0
                             else s32(((a & M32) >> sh) | (a << (32 - sh))))
                        if TRACE_ROR:
                            print(f"ROR {a & M32:08x} {b & M32:08x} {r & M32:08x}")
                        stk.append(r)
                    elif o in (4, 5):          # ASL / LSL
                        sh = (b >> 16) & 63
                        stk.append(0 if sh >= 32 else s32(a << sh))
                    elif o == 7:               # ROL
                        sh = (b >> 16) & 31
                        stk.append(a if sh == 0
                                   else s32((a << sh) | ((a & M32) >> (32 - sh))))
                    else:
                        raise Exception(f"OP {o} @ {pc-1}")
                elif op >= 0x20:
                    n = op & 15
                    proc = stk.pop()
                    args = [stk.pop() for _ in range(n)][::-1]  # reversed pops
                    c = Turtle()
                    c.pc = proc & 0xFFFF
                    c.time, c.x, c.y = t.time, t.x, t.y
                    c.size, c.tint, c.rand, c.dir = t.size, t.tint, t.rand, t.dir
                    for wi in range(8):        # wires inherit through fork
                        setattr(c, f"w{wi}", getattr(t, f"w{wi}"))
                    c.stk = args
                    buckets[(c.time >> 16) & 0xFF].append(c)
                    alive += 1
                elif op >= 0x10:
                    v = stk.pop()
                    c = op & 15
                    take = {6: v != 0, 7: v == 0, 12: v >= 0, 13: v < 0,
                            14: v > 0, 15: v <= 0}[c]
                    if take:
                        pc = target[pc - 1]
                else:
                    if op == 0x00:
                        pass                       # DONE
                    elif op == 0x01:
                        pc = target[pc - 1]        # ELSE
                    elif op == 0x02:
                        alive -= 1                 # END
                        break
                    elif op == 0x03:               # RAND
                        t.rand = rand_iter(t.rand)
                        stk.append((t.rand >> 16) & 0xFFFF)
                    elif op in (0x04, 0x06):       # DRAW / PLOT
                        f = s16(t.time >> 16)
                        if 0 <= f < frames:
                            c = s16(t.tint >> 16)
                            plots.append((f, s16(t.x >> 16), s16(t.y >> 16),
                                          s16(t.size >> 16),
                                          c if op == 0x04 else s16(~c)))
                    elif op == 0x05:               # TAIL
                        pc = t.pc & 0xFFFF
                    elif op == 0x07:               # PROC
                        stk.append(procs[bc[pc]])
                        pc += 1
                    elif op == 0x08:
                        stk.pop()
                    elif op == 0x09:               # DIV
                        a = stk.pop()
                        b = stk.pop()
                        d = s16(s32(b << 8) >> 16)
                        quo = abs(a) // abs(d)
                        if (a < 0) != (d < 0):
                            quo = -quo
                        stk.append(s32(quo << 8))
                    elif op == 0x0A:               # WAIT
                        w = stk.pop()
                        if w >= 0:
                            t.time = s32(t.time + w)
                            nf = t.time >> 16
                            if nf >= frames:
                                alive -= 1
                            else:
                                t.pc = pc
                                buckets[nf & 0xFF].append(t)
                            break
                    elif op == 0x0B:               # SINE
                        v = stk.pop()
                        stk.append(s32(sinq((v & 0xFFFF) >> 2) << 2))
                    elif op == 0x0C:               # SEED
                        t.rand = rand_iter(rand_iter(stk.pop()))
                    elif op == 0x0D:
                        stk.append(s32(-stk.pop()))
                    elif op == 0x0E:               # MOVE
                        m = stk.pop()
                        i14 = (t.dir >> 16 == 0 and 0 or 0)  # placeholder
                        idx = ((t.dir & M32) >> 10) & 0x3FFF
                        sa = sinq(idx)
                        ca = sinq((idx + 4096) & 0x3FFF)
                        if -(32 << 16) < m < (32 << 16):
                            v16 = s16((s32(m << 10) & M32) >> 16)
                            t.x = s32(t.x + ((v16 * ca) >> 8))
                            t.y = s32(t.y + ((v16 * sa) >> 8))
                        else:
                            v16 = s16((s32(m << 2) & M32) >> 16)
                            t.x = s32(t.x + v16 * ca)
                            t.y = s32(t.y + v16 * sa)
                    elif op == 0x0F:               # MUL
                        a = stk.pop()
                        b = stk.pop()
                        stk.append(s32(s16(s32(a << 8) >> 16) * s16(s32(b << 8) >> 16)))
                    else:
                        raise Exception(f"op {op:02x} @ {pc-1}")
        if stats is not None:
            stats.append((C, acts, alive))
        if deferred:
            buckets[frame & 0xFF] = deferred
        else:
            buckets.pop(frame & 0xFF, None)
        frame += 1
    return plots


def main():
    import pathlib
    d = pathlib.Path(sys.argv[1])
    frames = int(sys.argv[2]) if len(sys.argv) > 2 else 10000
    bc = (d / "bytecodes.bin").read_bytes()
    cb = (d / "constants.bin").read_bytes()
    constants = [struct.unpack(">i", cb[i:i + 4])[0] for i in range(0, len(cb), 4)]
    plots = run(bc, constants, frames)
    e = (d / "expected_plots.bin").read_bytes()
    exp = [struct.unpack("<5h", e[i:i + 10]) for i in range(0, len(e), 10)]
    print(f"python model: {len(plots)} plots, expected {len(exp)}")
    cm, ce = collections.Counter(plots), collections.Counter(exp)
    if cm == ce:
        print("MULTISET MATCH")
    else:
        missing = ce - cm
        extra = cm - ce
        print(f"missing {sum(missing.values())}, extra {sum(extra.values())}")
        for p in list(missing)[:6]:
            print("  missing:", p)
        for p in list(extra)[:6]:
            print("  extra:", p)


if __name__ == "__main__":
    main()
