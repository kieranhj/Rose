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

import sys
import struct
from pathlib import Path

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


def make_colorscript(data):
    """Decode colorscript.bin and quantise 12-bit RGB to the 8 TTL colours.

    Emits 3-byte records: frame lo, frame hi, (logical<<4)|physical,
    terminated by frame &FFFF. Physical bit = channel >= 8.
    """
    words = struct.unpack(f">{len(data) // 2}H", data)
    t = -1
    lines = [".rose_colorscript"]
    for w in words:
        if w == 0x8000:
            break
        if w & 0x8000:
            t += 0x10000 - w            # negative word = frame delta
        else:
            tint = w >> 12
            r, g, b = (w >> 8) & 15, (w >> 4) & 15, w & 15
            phys = (1 if r >= 8 else 0) | (2 if g >= 8 else 0) | (4 if b >= 8 else 0)
            lines.append(f"    EQUB &{t & 0xFF:02X}, &{(t >> 8) & 0xFF:02X}, "
                         f"&{(tint << 4) | phys:02X}  ; frame {t}: tint {tint} -> {phys}")
    lines.append("    EQUB &FF, &FF, &00")
    return "\n".join(lines) + "\n"


# --- SWRAM span filler generation -------------------------------------------
# One routine per (left pixel offset o 0-3, span pixel length L 1-125), with
# edge masks baked in. Two 16KB bank images: bank 4 holds o=0,1; bank 5 o=2,3.
# Bank layout: vec lo[125] at +0, vec hi at +128, second o at +256/+384,
# code from +512. Routines end by jumping into the shared middle-store chain
# in main RAM (fixed at CHAIN_RTS - 4k, chain at &0E00) or rts.
# These addresses must match interp.asm:
SPAN_SCR = 0x8D             # zp screen pointer
SPAN_RFILL = 0x0CB5         # SCRATCH+53
SPAN_TMPB = 0x0CC3          # SCRATCH+67
CHAIN_RTS = 0x0E7C          # &0E00 chain: 31 units of 4 bytes, rts at +124
MASK_L = [0xFF, 0x77, 0x33, 0x11]
MASK_R = [0x88, 0xCC, 0xEE, 0xFF]
SPAN_MAXL = 125


def _masked_write(mask, indexed):
    """new = old ^ ((old ^ fill) & mask) at (scr) or (scr),y."""
    lda = 0xB1 if indexed else 0xB2
    sta = 0x91 if indexed else 0x92
    return bytes([lda, SPAN_SCR,
                  0x8D, SPAN_TMPB & 0xFF, SPAN_TMPB >> 8,
                  0x4D, SPAN_RFILL & 0xFF, SPAN_RFILL >> 8,
                  0x29, mask,
                  0x4D, SPAN_TMPB & 0xFF, SPAN_TMPB >> 8,
                  sta, SPAN_SCR])


def _span_routine(o, L):
    n = (o + L - 1) // 4 + 1            # bytes touched
    o1 = (o + L - 1) & 3
    ml = MASK_L[o]
    mr = MASK_R[o1]
    lda_rfill = bytes([0xAD, SPAN_RFILL & 0xFF, SPAN_RFILL >> 8])
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
    row data (floor(sqrt(r^2-dy^2)) per scanline) from +256."""
    lo = bytearray(128)
    hi = bytearray(128)
    data = bytearray()
    for r in range(maxr + 1):
        addr = 0x8100 + len(data)
        lo[r] = addr & 0xFF
        hi[r] = addr >> 8
        data += bytes(int((r * r - dy * dy) ** 0.5) for dy in range(-r, r + 1))
    img = bytes(lo) + bytes(hi) + bytes(data)
    assert len(img) <= 0x4000
    return img


def main():
    if len(sys.argv) < 3:
        print("usage: rose2bbc.py <build_dir> <out_dir> [maxradius]")
        sys.exit(1)
    build = Path(sys.argv[1])
    out = Path(sys.argv[2])
    maxr = int(sys.argv[3]) if len(sys.argv) > 3 else 45

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
            w(f"    EQUB &07 : EQUW rose_p{extra[0]}  ; PROC {extra[0]}")
        elif extra:
            w(f"    EQUB &{op:02X}, &{extra[0]:02X}")
        else:
            w(f"    EQUB &{op:02X}")
    (out / "rose_data.asm").write_text("\n".join(lines) + "\n")
    # Colorscript in its own file: the single-CPU build includes it with CODE
    # (before .rose_data_end); the Tube build includes it in HOST only.
    (out / "colorscript.asm").write_text(
        make_colorscript((build / "colorscript.bin").read_bytes()) + "\n")

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
