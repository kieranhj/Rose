#!/usr/bin/env python3
"""
jit_verify.py — Python simulation of jit.asm

Reads bytecodes.bin + constants.bin for a given example, simulates exactly
what jit.asm does to emit ARM words, applies fixups, and verifies the result
against the expected sizes from instructions.asm.

Usage:
    python jit_verify.py <example_dir>
    python jit_verify.py arc/examples/everyway
    python jit_verify.py arc/examples/ball  --verbose

Outputs:
    - Per-procedure word count vs AOT
    - WAIT continuation address checks
    - PROC fixup address checks
    - Total word count vs _JIT_CODE_WORDS
    - Disassembly of generated code (with --verbose or --disasm)
"""

import argparse
import struct
import sys
import os
import re

# ============================================================================
# Bytecode constants (from rose2arc.py)
# ============================================================================
BC_DONE=0x00; BC_ELSE=0x01; BC_END=0x02; BC_RAND=0x03
BC_DRAW=0x04; BC_TAIL=0x05; BC_PLOT=0x06; BC_PROC=0x07
BC_POP=0x08; BC_DIV=0x09; BC_WAIT=0x0A; BC_SINE=0x0B
BC_SEED=0x0C; BC_NEG=0x0D; BC_MOVE=0x0E; BC_MUL=0x0F
BC_WHEN=0x10; BC_FORK=0x20; BC_OP=0x30; BC_WLOCAL=0x40
BC_WSTATE=0x50; BC_RLOCAL=0x60; BC_RSTATE=0x70; BC_CONST=0x80
END_OF_SCRIPT=0xFF; BIG_CONSTANT_BASE=126

# ============================================================================
# ARM instruction encodings (from jit.asm jit_insns table)
# ============================================================================
STR_R0_R3_M4W  = 0xE5230004   # str r0, [r3, #-4]!      PUSH r0
LDR_R0_R3_P4   = 0xE4930004   # ldr r0, [r3], #4         POP  r0
LDR_R1_R3_P4   = 0xE4931004   # ldr r1, [r3], #4         POP  r1
LDR_R0_LIT     = 0xE59F0000   # ldr r0, [pc, #0]
LDR_R1_LIT     = 0xE59F1000   # ldr r1, [pc, #0]
B_SKIP1        = 0xEA000000   # b   .+8  (skip 1 word)
MOV_PC_LR      = 0xE1A0F00E   # mov pc, lr
MOV_PC_R2      = 0xE1A0F002   # mov pc, r2
RSB_R0_0       = 0xE2600000   # rsb r0, r0, #0
ADDS           = 0xE0900001   # adds r0, r0, r1
SUBS           = 0xE0500001   # subs r0, r0, r1
CMP_R0_R1      = 0xE1500001   # cmp  r0, r1
ANDS           = 0xE0100001   # ands r0, r0, r1
ORAS           = 0xE1900001   # orrs r0, r0, r1
STR_LR_SP      = 0xE52DE004   # str  lr, [sp, #-4]!
LDR_LR_SP      = 0xE49DE004   # ldr  lr, [sp], #4
ADD_R2_R5_4    = 0xE2852004   # add  r2, r5, #4
LDMIA_R2_R8_11 = 0xE8920F00   # ldmia r2, {r8-r11}
MOV_R0_R8_ASR16= 0xE1A00848   # mov  r0, r8, asr #16
MOV_R1_R9_ASR16= 0xE1A01849   # mov  r1, r9, asr #16
MOV_R2_R10_A16 = 0xE1A0284A   # mov  r2, r10, asr #16
MOV_R9_R11_L16 = 0xE1A0982B   # mov  r9, r11, lsr #16
LDR_R10_R6_M12 = 0xE516A00C   # ldr  r10, [r6, #-12] (circle)
LDR_R10_R6_M8  = 0xE5168008   # ldr  r10, [r6, #-8]  (square)
ORR_R10_R10_R2 = 0xE18AA002   # orr  r10, r10, r2
LDR_R2_R6_M4   = 0xE5162004   # ldr  r2, [r6, #-4]   (r_FreeState)
STR_R2_R5_0    = 0xE5852000   # str  r2, [r5]
STR_R5_R6_M4   = 0xE5065004   # str  r5, [r6, #-4]
STR_R1_R5_0    = 0xE5851000   # str  r1, [r5, #0]    (st_proc)
LDR_R2_R5_28   = 0xE595201C   # ldr  r2, [r5, #28]   (st_time)
ADD_R2_R2_R0   = 0xE0822000   # add  r2, r2, r0
STR_R2_R5_28   = 0xE585201C   # str  r2, [r5, #28]
BIC_R2_R2_C000 = 0xE3C22CC0   # bic  r2, r2, #0xc000
LDR_R1_R6_R2   = 0xE7961722   # ldr  r1, [r6, r2, lsr #14]
STR_R1_R3_M4W  = 0xE5231004   # str  r1, [r3, #-4]!
STR_R3_R6_R2   = 0xE7863722   # str  r3, [r6, r2, lsr #14]
STR_R5_R3_M4W  = 0xE5235004   # str  r5, [r3, #-4]!  (WAIT)
LDR_R2_R5_0    = 0xE5952000   # ldr  r2, [r5, #0]    (TAIL: st_proc)
MOV_R0_ASL8    = 0xE1A00400   # mov  r0, r0, asl #8
MOV_R0_ASR16   = 0xE1A00840   # mov  r0, r0, asr #16
MOV_R1_ASL8    = 0xE1A01401   # mov  r1, r1, asl #8
MOV_R1_ASR16   = 0xE1A01841   # mov  r1, r1, asr #16
MUL_R0_R1_R0   = 0xE0000091   # mul  r0, r1, r0
MOV_R1_0x10000 = 0xE3A01801   # mov  r1, #0x10000
SUB_R1_4       = 0xE2411004   # sub  r1, r1, #4
AND_R0_R0_R1   = 0xE0000001   # and  r0, r0, r1
LDR_R0_R7_R0   = 0xE7970000   # ldr  r0, [r7, r0]
MOV_R0_ASL2    = 0xE1A00100   # mov  r0, r0, asl #2
BIC_R1_R0_FF24 = 0xE3C014FF   # bic  r1, r0, #0xff000000
BIC_R1_R1_FF16 = 0xE3C118FF   # bic  r1, r1, #0x00ff0000
MOV_R2_R0_L16  = 0xE1A02800   # mov  r2, r0, lsl #16
ORR_R0_R2_R0R16= 0xE1820820   # orr  r0, r2, r0, lsr #16
LDR_R0_R5_20   = 0xE5950014   # ldr  r0, [r5, #20]   (st_rand)
STR_R0_R5_20   = 0xE5850014   # str  r0, [r5, #20]
MOV_R0_LSR16   = 0xE1A00820   # mov  r0, r0, lsr #16
MUL_R1_R2_R1   = 0xE0011292   # mul  r1, r2, r1
ADD_R0_R0_R1   = 0xE0800001   # add  r0, r0, r1
MOV_R1_R1_LSR16= 0xE1A01821   # mov  r1, r1, lsr #16
AND_R1_R1_63   = 0xE201103F   # and  r1, r1, #63
MOVS_ASR_R1    = 0xE1B00150   # movs r0, r0, asr r1
MOVS_LSR_R1    = 0xE1B00130   # movs r0, r0, lsr r1
MOVS_LSL_R1    = 0xE1B00110   # movs r0, r0, lsl r1
MOVS_ROR_R1    = 0xE1B00170   # movs r0, r0, ror r1
MOVS_R0_R0     = 0xE1B00000   # movs r0, r0
CONST_9D3D     = 0x00009D3D
MOV_R0_IMM_BASE= 0xE3A00000   # mov r0, #imm12 base
LDR_R0_R4_BASE = 0xE5940000   # ldr r0, [r4, #imm12] base
LDR_R0_R5_NEG  = 0xE5150000   # ldr r0, [r5, #-imm12]
LDR_R0_R5_POS  = 0xE5950000   # ldr r0, [r5, #imm12]
STR_R0_R5_NEG  = 0xE5050000   # str r0, [r5, #-imm12]
STR_R0_R5_POS  = 0xE5850000   # str r0, [r5, #imm12]
MOV_R1_IMM_BASE= 0xE3A01000   # mov r1, #imm12 base (FORK)
LDR_R2_PC_LIT  = 0xE59F2000   # ldr r2, [pc, #0] (RAND literal)

# Shift op table (indexed by nibble 0..7)
SHIFT_INSNS = [
    MOVS_ASR_R1, MOVS_LSR_R1, MOVS_ROR_R1, MOVS_ROR_R1,
    MOVS_LSL_R1, MOVS_LSL_R1, MOVS_LSL_R1, MOVS_LSL_R1,
]
# Non-shift op table (indexed by nibble 8..15)
OP_INSNS = {
    8: ORAS, 9: SUBS, 11: CMP_R0_R1, 12: ANDS, 13: ADDS
}

# WHEN condition code table (nibble -> ARM condition field for negated branch)
WHEN_CONDS = [0,0,0,0,0,0, 1,0, 0,0,0,0, 10,11,12,13]


def try_encode_imm12(value):
    """Try to encode value as ARM 8-bit rotated immediate.
    Returns (rotation, 8bit_val) or None if not encodable."""
    v = value & 0xFFFFFFFF
    for rot in range(16):
        # rotate right by 2*rot
        candidate = ((v << (2*rot)) | (v >> (32 - 2*rot))) & 0xFFFFFFFF
        if candidate < 0x100:
            return (rot, candidate)
    return None


def build_mov_imm12(value):
    """Build MOV r0, #value instruction. Returns None if not encodable."""
    enc = try_encode_imm12(value)
    if enc is None:
        return None
    rot, val = enc
    return MOV_R0_IMM_BASE | (rot << 8) | val


class JitSimulator:
    """Simulates jit.asm's compilation of a bytecode stream."""

    def __init__(self, bytecodes, constants, base_addr=0x00DD000, verbose=False):
        self.bytecodes = bytecodes
        self.constants = constants
        self.base_addr = base_addr  # assumed JIT buffer base address
        self.verbose = verbose

        # Output buffer: list of (word, annotation_string)
        self.words = []

        # State tracking (mirrors jit.asm R11/R12)
        self.push_pending = False
        self.load_without_op = False

        # Proc / fixup / label tracking
        self.proc_no = 0
        self.proc_table = {}       # proc_no -> word_offset
        self.fixup_table = []      # list of (patch_word_offset, proc_idx)
        self.label_stack = []      # stack of (branch_word_offset, cond_byte)

        # Continuation addresses (for WAIT verification)
        self.wait_continuations = []  # list of (wait_word_offset, cont_word_offset)

        # Error tracking
        self.errors = []
        self.warnings = []

        # Per-procedure stats
        self.proc_start_offsets = []  # word offset of each proc's first word

        # Bytecode read position
        self.bc_pos = 0

    def read_byte(self):
        if self.bc_pos >= len(self.bytecodes):
            return None
        b = self.bytecodes[self.bc_pos]
        self.bc_pos += 1
        return b

    def emit(self, word, note=''):
        """Emit one ARM word to the output buffer."""
        offset = len(self.words)
        self.words.append((word, note))
        return offset

    def word_addr(self, offset):
        return self.base_addr + offset * 4

    # ---- Helper: jit_do_load_var ----
    def do_load_var(self):
        if self.push_pending:
            self.emit(STR_R0_R3_M4W, 'str r0,[r3,#-4]!  ; flush push_pending')
            self.push_pending = False
        self.load_without_op = True

    # ---- Helper: jit_do_pop_r0 ----
    def do_pop_r0(self):
        if self.push_pending:
            self.push_pending = False
            # r0 already has the value, no emit needed
        else:
            self.emit(LDR_R0_R3_P4, 'ldr r0,[r3],#4    ; pop r0')

    # ---- Helper: jit_do_pop_r1 (always emits) ----
    def do_pop_r1(self):
        self.emit(LDR_R1_R3_P4, 'ldr r1,[r3],#4    ; pop r1')

    # ---- Helper: emit_rand_iter ----
    def emit_rand_iter(self):
        self.emit(BIC_R1_R0_FF24, 'bic r1,r0,#0xff000000')
        self.emit(BIC_R1_R1_FF16, 'bic r1,r1,#0x00ff0000')
        self.emit(MOV_R2_R0_L16,  'mov r2,r0,lsl #16')
        self.emit(ORR_R0_R2_R0R16,'orr r0,r2,r0,lsr #16')
        self.emit(LDR_R2_PC_LIT,  'ldr r2,[pc,#0]  ; load 0x9D3D')
        self.emit(B_SKIP1,         'b .+8           ; skip literal')
        self.emit(CONST_9D3D,      '.long 0x9D3D')
        self.emit(MUL_R1_R2_R1,   'mul r1,r2,r1')
        self.emit(ADD_R0_R0_R1,   'add r0,r0,r1')

    # ---- Helper: emit_bl(target_addr) ----
    def emit_bl(self, target_addr, note=''):
        """Emit BL instruction to target_addr from current position."""
        cur_addr = self.base_addr + len(self.words) * 4
        offset = (target_addr - cur_addr - 8) >> 2
        if offset < -(1 << 23) or offset >= (1 << 23):
            self.errors.append(f'BL offset {offset} out of range at word {len(self.words)}')
        word = 0xEB000000 | (offset & 0xFFFFFF)
        self.emit(word, f'bl {note} (target=0x{target_addr:08X})')

    # ---- Compile the full bytecode stream ----
    def compile(self):
        # Record proc_0 start
        self.proc_table[0] = len(self.words)
        self.proc_start_offsets.append(0)

        while True:
            bc = self.read_byte()
            if bc is None or bc == END_OF_SCRIPT:
                break

            if bc >= BC_CONST:
                self._handle_const(bc)
            elif bc >= BC_RSTATE:
                self._handle_rstate(bc)
            elif bc >= BC_RLOCAL:
                self._handle_rlocal(bc)
            elif bc >= BC_WSTATE:
                self._handle_wstate(bc)
            elif bc >= BC_WLOCAL:
                self._handle_wlocal(bc)
            elif bc >= BC_OP:
                self._handle_op(bc)
            elif bc >= BC_FORK:
                self._handle_fork(bc)
            elif bc >= BC_WHEN:
                self._handle_when(bc)
            else:
                handler = {
                    BC_DONE: self._handle_done,
                    BC_ELSE: self._handle_else,
                    BC_END:  self._handle_end,
                    BC_RAND: self._handle_rand,
                    BC_DRAW: self._handle_draw,
                    BC_TAIL: self._handle_tail,
                    BC_PLOT: self._handle_plot,
                    BC_PROC: self._handle_proc,
                    BC_POP:  self._handle_pop,
                    BC_DIV:  self._handle_div,
                    BC_WAIT: self._handle_wait,
                    BC_SINE: self._handle_sine,
                    BC_SEED: self._handle_seed,
                    BC_NEG:  self._handle_neg,
                    BC_MOVE: self._handle_move,
                    BC_MUL:  self._handle_mul,
                }.get(bc)
                if handler is None:
                    self.errors.append(f'Unknown bytecode 0x{bc:02X} at pos {self.bc_pos-1}')
                else:
                    handler(bc)

        # Apply fixups
        self._apply_fixups()

        # Verify WAIT continuations are within buffer
        self._verify_waits()

    def _apply_fixups(self):
        """Patch .long 0 placeholders with actual proc addresses."""
        total_words = len(self.words)
        for patch_offset, proc_idx in self.fixup_table:
            if proc_idx not in self.proc_table:
                self.errors.append(f'Fixup for proc {proc_idx}: proc not found in table')
                continue
            proc_word_offset = self.proc_table[proc_idx]
            proc_addr = self.base_addr + proc_word_offset * 4
            old_word, old_note = self.words[patch_offset]
            if old_word != 0:
                self.warnings.append(f'Fixup at word {patch_offset}: expected 0, found 0x{old_word:08X}')
            self.words[patch_offset] = (proc_addr, old_note + f' -> patched=proc_{proc_idx}@0x{proc_addr:08X}')

    def _verify_waits(self):
        """Verify all WAIT continuation addresses point within the JIT buffer."""
        total_words = len(self.words)
        for wait_offset, cont_offset in self.wait_continuations:
            if cont_offset < 0 or cont_offset >= total_words:
                self.errors.append(
                    f'WAIT at word {wait_offset}: cont word {cont_offset} out of buffer '
                    f'(buffer size {total_words})')
            else:
                cont_addr = self.base_addr + cont_offset * 4
                # Verify the literal word at wait_offset+2 was patched
                lit_word, _ = self.words[wait_offset + 2]
                if lit_word != cont_addr:
                    self.errors.append(
                        f'WAIT at word {wait_offset}: literal=0x{lit_word:08X}, '
                        f'expected cont_addr=0x{cont_addr:08X}')

    # ============================================================
    # Bytecode handlers
    # ============================================================

    def _handle_const(self, bc):
        index = bc & 0x7F
        if index >= BIG_CONSTANT_BASE:
            extra = self.read_byte()
            index += extra if extra is not None else 0
        self.do_load_var()

        if index < len(self.constants):
            val = self.constants[index]
            mov_word = build_mov_imm12(val)
            if mov_word is not None:
                self.emit(mov_word, f'mov r0,#0x{val:08X}  ; const[{index}]={val/(1<<16):.4f}')
            else:
                offset = index * 4
                self.emit(LDR_R0_R4_BASE | offset, f'ldr r0,[r4,#{offset}]  ; const[{index}]=0x{val:08X}')
        else:
            self.errors.append(f'BC_CONST: index {index} out of range ({len(self.constants)} constants)')
            self.emit(0, f'?const[{index}]?')

        self.push_pending = True

    def _handle_rstate(self, bc):
        field = bc & 0x0F
        self.do_load_var()
        offset = field * 4
        self.emit(LDR_R0_R5_POS | offset, f'ldr r0,[r5,#{offset}]  ; rstate[{field}]')
        self.push_pending = True

    def _handle_rlocal(self, bc):
        index = bc & 0x0F
        self.do_load_var()
        offset = (index + 1) * 4
        self.emit(LDR_R0_R5_NEG | offset, f'ldr r0,[r5,#-{offset}]  ; rlocal[{index}]')
        self.push_pending = True

    def _handle_wstate(self, bc):
        field = bc & 0x0F
        self.do_pop_r0()
        offset = field * 4
        self.emit(STR_R0_R5_POS | offset, f'str r0,[r5,#{offset}]  ; wstate[{field}]')
        self.push_pending = False

    def _handle_wlocal(self, bc):
        index = bc & 0x0F
        self.do_pop_r0()
        offset = (index + 1) * 4
        self.emit(STR_R0_R5_NEG | offset, f'str r0,[r5,#-{offset}]  ; wlocal[{index}]')
        self.push_pending = False

    def _handle_op(self, bc):
        nibble = bc & 0x0F
        self.load_without_op = False
        self.do_pop_r0()
        self.do_pop_r1()

        if nibble <= 7:
            self.emit(MOV_R1_R1_LSR16, 'mov r1,r1,lsr #16')
            self.emit(AND_R1_R1_63,    'and r1,r1,#63')
            self.emit(SHIFT_INSNS[nibble], f'shift op {nibble}')
        else:
            insn = OP_INSNS.get(nibble)
            if insn is None:
                self.errors.append(f'BC_OP: unknown nibble {nibble}')
                insn = 0
            self.emit(insn, f'op_{nibble}')

        self.push_pending = (nibble != 11)  # CMP doesn't push

    def _handle_fork(self, bc):
        num_args = bc & 0x0F
        self.do_pop_r0()  # consume proc address
        self.emit(MOV_R1_IMM_BASE | num_args, f'mov r1,#{num_args}  ; fork num_args')
        self.emit(STR_LR_SP, 'str lr,[sp,#-4]!')
        # BL ForkState — use placeholder addr 0; will be correct in real binary
        self.emit(0xEB000000, 'bl ForkState (placeholder)')
        self.emit(LDR_LR_SP, 'ldr lr,[sp],#4')
        self.push_pending = False

    def _handle_when(self, bc):
        nibble = bc & 0x0F
        if self.load_without_op:
            self.emit(MOVS_R0_R0, 'movs r0,r0  ; refresh flags')
        cond = WHEN_CONDS[nibble] if nibble < len(WHEN_CONDS) else 0
        branch_word = (cond << 28) | 0x0A000000
        branch_offset = len(self.words)
        self.emit(branch_word, f'b<cond_{cond}> (forward placeholder, patch at DONE/ELSE)')
        self.label_stack.append((branch_offset, branch_word))
        self.push_pending = False
        self.load_without_op = False

    def _handle_done(self, bc):
        # Patch the pending branch to point to here
        if not self.label_stack:
            self.errors.append(f'BC_DONE: label_stack underflow at bc_pos={self.bc_pos}')
            return
        branch_offset, branch_word = self.label_stack.pop()
        target = len(self.words)
        offset = (target - branch_offset - 2)  # branch offset in words (ARM: -2 for pipeline)
        patched = (branch_word & 0xFF000000) | (offset & 0xFFFFFF)
        old_w, old_n = self.words[branch_offset]
        self.words[branch_offset] = (patched, old_n + f' -> patched to word {target}')

    def _handle_else(self, bc):
        if not self.label_stack:
            self.errors.append(f'BC_ELSE: label_stack underflow at bc_pos={self.bc_pos}')
            return
        branch_offset, branch_word = self.label_stack.pop()
        # Patch the WHEN branch to point to here+1 (after the unconditional B)
        else_b_offset = len(self.words)
        target = else_b_offset + 1  # after the B we're about to emit
        offset = (target - branch_offset - 2)
        patched = (branch_word & 0xFF000000) | (offset & 0xFFFFFF)
        old_w, old_n = self.words[branch_offset]
        self.words[branch_offset] = (patched, old_n + f' -> patched to word {target}')

        # Emit unconditional B placeholder
        b_offset = len(self.words)
        self.emit(0xEA000000, 'b (else-end placeholder)')
        self.label_stack.append((b_offset, 0xEA000000))
        self.push_pending = False
        self.load_without_op = False

    def _handle_end(self, bc):
        # Inline FreeState
        self.emit(LDR_R2_R6_M4, 'ldr r2,[r6,#-4]  ; FreeState')
        self.emit(STR_R2_R5_0,  'str r2,[r5]')
        self.emit(STR_R5_R6_M4, 'str r5,[r6,#-4]')
        self.emit(MOV_PC_LR,    'mov pc,lr  ; return (END proc)')

        # Advance proc_no, record new proc start
        self.proc_no += 1
        start_offset = len(self.words)
        self.proc_table[self.proc_no] = start_offset
        self.proc_start_offsets.append(start_offset)
        self.push_pending = False
        self.load_without_op = False

    def _handle_rand(self, bc):
        self.do_load_var()
        self.emit(LDR_R0_R5_20, 'ldr r0,[r5,#20]  ; st_rand')
        self.emit_rand_iter()
        self.emit(STR_R0_R5_20, 'str r0,[r5,#20]  ; st_rand')
        self.emit(MOV_R0_LSR16, 'mov r0,r0,lsr #16')
        self.push_pending = True

    def _handle_draw(self, bc):
        self.do_load_var()
        self.emit(ADD_R2_R5_4,    'add r2,r5,#4')
        self.emit(LDMIA_R2_R8_11, 'ldmia r2,{r8-r11}')
        self.emit(MOV_R0_R8_ASR16,'mov r0,r8,asr #16  ; X')
        self.emit(MOV_R1_R9_ASR16,'mov r1,r9,asr #16  ; Y')
        self.emit(MOV_R2_R10_A16, 'mov r2,r10,asr #16 ; RADIUS')
        self.emit(MOV_R9_R11_L16, 'mov r9,r11,lsr #16 ; TINT')
        self.emit(LDR_R10_R6_M12, 'ldr r10,[r6,#-12]  ; circle_insn')
        self.emit(STR_LR_SP,      'str lr,[sp,#-4]!')
        self.emit(0xEB000000,     'bl link_circle (placeholder)')
        self.emit(LDR_LR_SP,      'ldr lr,[sp],#4')
        self.push_pending = False

    def _handle_tail(self, bc):
        self.emit(LDR_R2_R5_0, 'ldr r2,[r5,#0]  ; st_proc')
        self.emit(MOV_PC_R2,   'mov pc,r2  ; tail call')

    def _handle_plot(self, bc):
        self.do_load_var()
        self.emit(ADD_R2_R5_4,    'add r2,r5,#4')
        self.emit(LDMIA_R2_R8_11, 'ldmia r2,{r8-r11}')
        self.emit(MOV_R0_R8_ASR16,'mov r0,r8,asr #16  ; X')
        self.emit(MOV_R1_R9_ASR16,'mov r1,r9,asr #16  ; Y')
        self.emit(MOV_R2_R10_A16, 'mov r2,r10,asr #16 ; RADIUS')
        self.emit(MOV_R9_R11_L16, 'mov r9,r11,lsr #16 ; TINT')
        self.emit(LDR_R10_R6_M8,  'ldr r10,[r6,#-8]   ; square_insn')
        self.emit(ORR_R10_R10_R2, 'orr r10,r10,r2      ; set radius')
        self.emit(STR_LR_SP,      'str lr,[sp,#-4]!')
        self.emit(0xEB000000,     'bl link_circle (placeholder)')
        self.emit(LDR_LR_SP,      'ldr lr,[sp],#4')
        self.push_pending = False

    def _handle_proc(self, bc):
        proc_idx = self.read_byte()
        if proc_idx is None:
            self.errors.append(f'BC_PROC: missing proc_index byte at bc_pos={self.bc_pos}')
            return
        self.do_load_var()

        lit_offset = len(self.words) + 2  # .long word is 2 words after LDR
        self.emit(LDR_R0_LIT, 'ldr r0,[pc,#0]  ; load proc addr literal')
        self.emit(B_SKIP1,    'b .+8          ; skip literal')
        placeholder = len(self.words)
        self.emit(0, f'.long 0  ; proc_{proc_idx} addr (fixup pending)')
        self.fixup_table.append((placeholder, proc_idx))
        self.push_pending = True

    def _handle_pop(self, bc):
        self.do_pop_r0()
        self.push_pending = False

    def _handle_div(self, bc):
        self.do_pop_r0()
        self.do_pop_r1()
        self.emit(MOV_R1_ASL8,  'mov r1,r1,asl #8')
        self.emit(MOV_R1_ASR16, 'mov r1,r1,asr #16')
        self.emit(STR_LR_SP,    'str lr,[sp,#-4]!')
        self.emit(0xEB000000,   'bl divide (placeholder)')
        self.emit(LDR_LR_SP,    'ldr lr,[sp],#4')
        self.emit(MOV_R0_ASL8,  'mov r0,r0,asl #8')
        self.push_pending = True

    def _handle_wait(self, bc):
        self.do_pop_r0()
        self.load_without_op = False

        wait_start = len(self.words)
        self.emit(LDR_R1_LIT,   'ldr r1,[pc,#0]   ; load cont_addr')
        self.emit(B_SKIP1,       'b .+8            ; skip literal')
        lit_offset = len(self.words)
        self.emit(0,             '.long 0          ; cont_addr (patched below)')

        # Inline WaitState
        self.emit(STR_R1_R5_0,  'str r1,[r5,#0]   ; st_proc = cont_addr')
        self.emit(STR_R5_R3_M4W,'str r5,[r3,#-4]! ; push p_State')
        self.emit(LDR_R2_R5_28, 'ldr r2,[r5,#28]  ; st_time')
        self.emit(ADD_R2_R2_R0, 'add r2,r2,r0     ; += wait_frames')
        self.emit(STR_R2_R5_28, 'str r2,[r5,#28]')
        self.emit(BIC_R2_R2_C000,'bic r2,r2,#0xc000')
        self.emit(LDR_R1_R6_R2, 'ldr r1,[r6,r2,lsr #14]')
        self.emit(STR_R1_R3_M4W,'str r1,[r3,#-4]!')
        self.emit(STR_R3_R6_R2, 'str r3,[r6,r2,lsr #14]')
        self.emit(MOV_PC_LR,    'mov pc,lr  ; return (WAIT)')

        # Patch the literal with the continuation address (current word offset)
        cont_offset = len(self.words)
        cont_addr = self.base_addr + cont_offset * 4
        old_w, old_n = self.words[lit_offset]
        self.words[lit_offset] = (cont_addr, old_n + f' -> cont=word_{cont_offset}')

        # Record for later verification
        self.wait_continuations.append((wait_start, cont_offset))
        self.push_pending = False

    def _handle_sine(self, bc):
        self.do_pop_r0()
        self.emit(MOV_R1_0x10000,'mov r1,#0x10000')
        self.emit(SUB_R1_4,      'sub r1,r1,#4    ; r1=0xFFFC')
        self.emit(AND_R0_R0_R1,  'and r0,r0,r1')
        self.emit(LDR_R0_R7_R0,  'ldr r0,[r7,r0]  ; sinus[r0]')
        self.emit(MOV_R0_ASL2,   'mov r0,r0,asl #2')
        self.push_pending = True

    def _handle_seed(self, bc):
        self.do_pop_r0()
        self.emit_rand_iter()
        self.emit_rand_iter()
        self.emit(STR_R0_R5_20, 'str r0,[r5,#20]  ; st_rand = seed result')
        self.push_pending = False

    def _handle_neg(self, bc):
        self.do_pop_r0()
        self.emit(RSB_R0_0, 'rsb r0,r0,#0  ; negate')
        self.push_pending = True

    def _handle_move(self, bc):
        self.do_pop_r0()
        self.emit(STR_LR_SP,  'str lr,[sp,#-4]!')
        self.emit(0xEB000000, 'bl DoMove (placeholder)')
        self.emit(LDR_LR_SP,  'ldr lr,[sp],#4')
        self.push_pending = False

    def _handle_mul(self, bc):
        self.do_pop_r0()
        self.do_pop_r1()
        self.emit(MOV_R0_ASL8,  'mov r0,r0,asl #8')
        self.emit(MOV_R0_ASR16, 'mov r0,r0,asr #16')
        self.emit(MOV_R1_ASL8,  'mov r1,r1,asl #8')
        self.emit(MOV_R1_ASR16, 'mov r1,r1,asr #16')
        self.emit(MUL_R0_R1_R0, 'mul r0,r1,r0')
        self.push_pending = True


# ============================================================================
# Parse instructions.asm to extract expected sizes
# ============================================================================
def parse_instructions_asm(asm_path):
    """Extract _JIT_CODE_WORDS, _JIT_MAX_PROCS, _JIT_MAX_FIXUPS, _JIT_MAX_LABELS."""
    result = {}
    try:
        with open(asm_path) as f:
            for line in f:
                m = re.match(r'\.equ\s+(_JIT_\w+),\s*(\d+)', line.strip())
                if m:
                    result[m.group(1)] = int(m.group(2))
    except FileNotFoundError:
        pass
    return result


# ============================================================================
# Simple ARM disassembler for key instructions
# ============================================================================
def disasm_word(word, addr):
    """Return a short disassembly string for common JIT-emitted words."""
    if word == 0:
        return '.long 0 (placeholder)'

    cond = (word >> 28) & 0xF
    cond_str = ['EQ','NE','CS','CC','MI','PL','VS','VC','HI','LS','GE','LT','GT','LE','AL','NV'][cond]

    # Branch
    if (word & 0x0E000000) == 0x0A000000:
        L = (word >> 24) & 1
        offset = word & 0xFFFFFF
        if offset & 0x800000:
            offset -= 0x1000000
        target = addr + 8 + offset * 4
        return f'B{"L" if L else ""}{cond_str} 0x{target:08X}'

    # Data processing
    if (word & 0x0C000000) == 0:
        opcode = (word >> 21) & 0xF
        S = (word >> 20) & 1
        Rn = (word >> 16) & 0xF
        Rd = (word >> 12) & 0xF
        I = (word >> 25) & 1
        ops = ['AND','EOR','SUB','RSB','ADD','ADC','SBC','RSC','TST','TEQ','CMP','CMN','ORR','MOV','BIC','MVN']
        if I:
            rot = (word >> 8) & 0xF
            imm = word & 0xFF
            val = (imm >> (rot*2)) | (imm << (32-rot*2)) if rot else imm
            val &= 0xFFFFFFFF
            return f'{ops[opcode]}{"S" if S else ""} r{Rd},r{Rn},#0x{val:X}'
        else:
            Rm = word & 0xF
            shift_type = (word >> 5) & 3
            shift_amt = (word >> 7) & 0x1F
            shift_reg = (word >> 8) & 0xF
            by_reg = (word >> 4) & 1
            shifts = ['LSL','LSR','ASR','ROR']
            if by_reg:
                return f'{ops[opcode]}{"S" if S else ""} r{Rd},r{Rn},r{Rm},{shifts[shift_type]} r{shift_reg}'
            elif shift_amt:
                return f'{ops[opcode]}{"S" if S else ""} r{Rd},r{Rn},r{Rm},{shifts[shift_type]} #{shift_amt}'
            else:
                return f'{ops[opcode]}{"S" if S else ""} r{Rd},r{Rn},r{Rm}'

    # LDR/STR
    if (word & 0x0C000000) == 0x04000000:
        P = (word >> 24) & 1
        U = (word >> 23) & 1
        B = (word >> 22) & 1
        W = (word >> 21) & 1
        L = (word >> 20) & 1
        Rn = (word >> 16) & 0xF
        Rd = (word >> 12) & 0xF
        I = (word >> 25) & 1
        op = 'LDR' if L else 'STR'
        bstr = 'B' if B else ''
        if I == 0:
            off = word & 0xFFF
            sign = '+' if U else '-'
            wb = '!' if W and P else ''
            if P:
                return f'{op}{bstr} r{Rd},[r{Rn},#{sign}{off}]{wb}'
            else:
                return f'{op}{bstr} r{Rd},[r{Rn}],#{sign}{off}'
        else:
            Rm = word & 0xF
            shift_type = (word >> 5) & 3
            shift_amt = (word >> 7) & 0x1F
            shifts = ['LSL','LSR','ASR','ROR']
            sign = '+' if U else '-'
            if shift_amt:
                return f'{op}{bstr} r{Rd},[r{Rn},{sign}r{Rm},{shifts[shift_type]} #{shift_amt}]'
            else:
                return f'{op}{bstr} r{Rd},[r{Rn},{sign}r{Rm}]'

    # MUL
    if (word & 0x0FC000F0) == 0x00000090:
        Rd = (word >> 16) & 0xF
        Rs = (word >> 8) & 0xF
        Rm = word & 0xF
        return f'MUL r{Rd},r{Rm},r{Rs}'

    # LDM/STM
    if (word & 0x0E000000) == 0x08000000:
        L = (word >> 20) & 1
        Rn = (word >> 16) & 0xF
        regs = [f'r{i}' for i in range(16) if (word >> i) & 1]
        return f'{"LDM" if L else "STM"} r{Rn},{{{",".join(regs)}}}'

    return f'.long 0x{word:08X}'


# ============================================================================
# Main
# ============================================================================
def main():
    parser = argparse.ArgumentParser(description='JIT simulator/verifier for rose2arc')
    parser.add_argument('example_dir', help='Path to example directory (contains bytecodes.bin, constants.bin, instructions.asm)')
    parser.add_argument('--verbose', '-v', action='store_true', help='Show per-procedure disassembly')
    parser.add_argument('--disasm', '-d', action='store_true', help='Show full disassembly of generated code')
    parser.add_argument('--base-addr', type=lambda x: int(x,0), default=0x00DD000,
                        help='JIT buffer base address for disassembly (default: 0xDD000)')
    args = parser.parse_args()

    example_dir = args.example_dir
    bytecodes_path = os.path.join(example_dir, 'bytecodes.bin')
    constants_path = os.path.join(example_dir, 'constants.bin')
    asm_path = os.path.join(example_dir, 'instructions.asm')

    # Load bytecodes
    with open(bytecodes_path, 'rb') as f:
        bytecodes = f.read()
    print(f'Bytecodes: {len(bytecodes)} bytes')

    # Load constants
    with open(constants_path, 'rb') as f:
        raw_consts = f.read()
    constants = list(struct.unpack_from(f'<{len(raw_consts)//4}I', raw_consts))
    print(f'Constants: {len(constants)} entries')

    # Parse expected sizes from instructions.asm
    expected = parse_instructions_asm(asm_path)
    if expected:
        print(f'Expected from instructions.asm:')
        for k, v in expected.items():
            print(f'  {k} = {v}')
    else:
        print('(No instructions.asm found or no JIT equates)')

    print()

    # Run the simulator
    sim = JitSimulator(bytecodes, constants, base_addr=args.base_addr, verbose=args.verbose)
    sim.compile()

    total_words = len(sim.words)
    print(f'=== JIT Simulation Results ===')
    print(f'Total words emitted:     {total_words}')
    if '_JIT_CODE_WORDS' in expected:
        exp = expected['_JIT_CODE_WORDS']
        diff = total_words - exp
        status = 'OK' if diff == 0 else f'ERROR (diff={diff:+d})'
        print(f'Expected (_JIT_CODE_WORDS): {exp}  -> {status}')
    print(f'Procedures compiled:     {sim.proc_no + 1}')
    if '_JIT_MAX_PROCS' in expected:
        exp = expected['_JIT_MAX_PROCS']
        print(f'Expected (_JIT_MAX_PROCS): {exp}')
    print(f'Fixups:                  {len(sim.fixup_table)}')
    if '_JIT_MAX_FIXUPS' in expected:
        exp = expected['_JIT_MAX_FIXUPS']
        print(f'Expected (_JIT_MAX_FIXUPS): {exp}')
    print(f'WAIT continuations:      {len(sim.wait_continuations)}')
    print(f'Max label nesting:       {expected.get("_JIT_MAX_LABELS", "?")}')

    print()
    if sim.errors:
        print(f'=== ERRORS ({len(sim.errors)}) ===')
        for e in sim.errors:
            print(f'  ERROR: {e}')
    else:
        print('No errors detected.')

    if sim.warnings:
        print(f'\n=== WARNINGS ({len(sim.warnings)}) ===')
        for w in sim.warnings:
            print(f'  WARN: {w}')

    # Show per-procedure summary
    if args.verbose or args.disasm:
        print()
        print('=== Per-procedure word counts ===')
        for i in range(len(sim.proc_start_offsets)):
            start = sim.proc_start_offsets[i]
            end = sim.proc_start_offsets[i+1] if i+1 < len(sim.proc_start_offsets) else total_words
            print(f'  proc_{i}: words {start}..{end-1} ({end-start} words)')

    # WAIT continuations detail
    if args.verbose:
        print()
        print('=== WAIT continuations ===')
        for wait_off, cont_off in sim.wait_continuations:
            wait_addr = args.base_addr + wait_off * 4
            cont_addr = args.base_addr + cont_off * 4
            lit_word, _ = sim.words[wait_off + 2]
            ok = 'OK' if lit_word == cont_addr else f'FAIL (literal=0x{lit_word:08X})'
            print(f'  WAIT@word_{wait_off}(0x{wait_addr:08X}) cont=word_{cont_off}(0x{cont_addr:08X}) {ok}')

    # Full disassembly
    if args.disasm:
        print()
        print('=== Disassembly ===')
        proc_starts = {v: k for k, v in sim.proc_table.items()}
        wait_starts = {w: c for w, c in sim.wait_continuations}
        for i, (word, note) in enumerate(sim.words):
            addr = args.base_addr + i * 4
            if i in proc_starts:
                print(f'\n; --- proc_{proc_starts[i]}_start ---')
            if i in wait_starts:
                print(f'; (continuation from WAIT at word {wait_starts[i]})')
            dasm = disasm_word(word, addr)
            print(f'  {addr:08X}: {word:08X}  {dasm:40s}  ; {note}')

    return 0 if not sim.errors else 1


if __name__ == '__main__':
    sys.exit(main())
