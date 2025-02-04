# Convert Rose bytecode to ARM asm.

import argparse
import binascii
import sys
import os
import struct
from enum import Enum
from unittest.mock import NonCallableMagicMock

INLINE_FREESTATE=1
INLINE_WAITSTATE=1
INLINE_PLOTDRAW=1

BC_DONE=0x00
BC_ELSE=0x01
BC_END=0x02
BC_RAND=0x03
BC_DRAW=0x04
BC_TAIL=0x05
BC_PLOT=0x06
BC_PROC=0x07
BC_POP=0x08
BC_DIV=0x09
BC_WAIT=0x0A
BC_SINE=0x0B
BC_SEED=0x0C
BC_NEG=0x0D
BC_MOVE=0x0E
BC_MUL=0x0F
BC_WHEN=0x10
BC_FORK=0x20
BC_OP=0x30
BC_WLOCAL=0x40
BC_WSTATE=0x50
BC_RLOCAL=0x60
BC_RSTATE=0x70
BC_CONST=0x80

END_OF_SCRIPT=0xFF
BIG_CONSTANT_BASE=126

# Negated condition branch nibble (for WHEN)
CMP_EQ=6
CMP_NE=7
CMP_LT=12
CMP_GE=13
CMP_LE=14
CMP_GT=15

# Instruction nibble (for OP)
# Shift/rotate opcodes go into bits 8,4,3
# Other ops go into bits 15-12
OP_ASR=0
OP_LSR=1
OP_ROXR=2
OP_ROR=3
OP_ASL=4
OP_LSL=5
OP_ROXL=6
OP_ROL=7
OP_OR=8
OP_SUB=9
OP_CMP=11
OP_AND=12
OP_ADD=13

# RSTATE and WSTATE offsets
ST_PROC=0
ST_X=1
ST_Y=2
ST_SIZE=3
ST_TINT=4
ST_RAND=5
ST_DIR=6
ST_TIME=7

STATE_NAMES = ["ST_PROC", "ST_X", "ST_Y", "ST_SIZE", "ST_TINT", "ST_RAND", "ST_DIR", "ST_TIME",
    "ST_WIRE0", "ST_WIRE1", "ST_WIRE2", "ST_WIRE3", "ST_WIRE4", "ST_WIRE5", "ST_WIRE6", "ST_WIRE7" ]

# Push or pop?
MIN_INPUT=0x08
MAX_INPUT=0x5F

class RoseParser:
    def __init__(self, byte_file, constants) -> None:
        self._num_vars = 0
        self._proc_no = 0
        self._label_no = 0
        self._byte_file = byte_file
        self._label_stack = []
        self._push_pending = False
        self._load_without_op = False
        self._constants = constants

    def get_immediate_for_constant(self, c):
        # Check if constant can be represented as an immediate load.
        if c == 0:
            return True

        first_bit=32
        last_bit=-1

        for bit in range(0, 31):
            if c & (1<<bit) != 0:
                if bit < first_bit:
                    first_bit = bit
                
                if bit > last_bit:
                    last_bit = bit

        bit_range = last_bit - first_bit
        return bit_range <= 8
    
    def push_var(self, reg):
        # TODO: Stack optimisation.
        assert(self._push_pending == False)
        self._push_pending = True
        self._num_vars += 1

    def load_var(self, reg):
        if self._push_pending:
            self._asm_file.write(f'\tstr r{reg}, [r3, #-4]!\t\t\t; Push r{reg} on StateStack.\n')
            self._push_pending = False
        self._load_without_op = True

    def pop_var(self, reg):
        if self._push_pending:
            self._push_pending = False
        else:
            self._asm_file.write(f'\tldr r{reg}, [r3], #4\t\t\t; Pop r{reg} off StateStack.\n')
        self._num_vars -= 1

    def write_const(self, c):
        self._asm_file.write(f'\t; BC_CONST [{c:02x}]\n')
        index = c & 127
        self.load_var(0)
        if index == BIG_CONSTANT_BASE:
            big = int.from_bytes(self._byte_file.read(1), "big")
            index += big

        # Write constant load.
        c = self._constants[index]

        if self.get_immediate_for_constant(c):
            self._asm_file.write(f'\tmov r0, #0x{c:08x}\t\t\t; r0=rConstants[{index}] ({(c/(1<<16)):.4f})\n')
        else:
            self._asm_file.write(f'\tldr r0, [r4, #{index}*4]\t\t\t; r0=rConstants[{index}]=0x{c:08x} ({(c/(1<<16)):.4f})\n')
        self.push_var(0)

    def write_done(self, c):
        self._asm_file.write(f'\t; BC_DONE [{c:02x}]\n')
        self._asm_file.write(f'proc_{self._proc_no}_target_{self._label_stack.pop()}:\n')

    def write_else(self, c):
        self._asm_file.write(f'\t; BC_ELSE [{c:02x}]\n')
        target = self._label_stack.pop()
        self._asm_file.write(f'\tb proc_{self._proc_no}_target_{self._label_no}\n')
        self._label_stack.append(self._label_no)
        self._label_no += 1
        self._asm_file.write(f'proc_{self._proc_no}_target_{target}:\n')
        self._push_pending = False  # TO CHECK!

    def write_end(self, c):
        self._asm_file.write(f'\t; BC_END [{c:02x}]\n')

        if INLINE_FREESTATE:
            self._asm_file.write(f'\tldr r2, [r6, #-4]\t\t\t; (r_FreeState)\n')
            self._asm_file.write(f'\tstr r2, [r5]\t\t\t\t; first word of state block points to prev free state.\n')
            self._asm_file.write(f'\tstr r5, [r6, #-4]\t\t\t; (r_FreeState) this state becomes the next free state.\n')
            self._asm_file.write(f'\tmov pc, lr\t\t\t\t\t; Return.\n')
        else:
            self._asm_file.write(f'\tstr lr, [sp, #-4]!\t\t\t; Push lr on program stack.\n')
            self._asm_file.write(f'\tbl FreeState\t\t\t\t; Add r5 to r_FreeState list.\n')
            self._asm_file.write(f'\tldr pc, [sp], #4\t\t\t; Return.\n')

        self._asm_file.write(f'proc_{self._proc_no}_end:\n\n')
        self._proc_no += 1


    def write_random_iteration(self):
        # return ((v & 0xFFFF) * 0x9D3D) + ((v << 16) | ((v >> 16) & 0xFFFF));
        self._asm_file.write(f'\tbic r1, r0, #0xff000000\n')
        self._asm_file.write(f'\tbic r1, r1, #0x00ff0000\n')
        self._asm_file.write(f'\tmov r2, r0, lsl #16\n')
        self._asm_file.write(f'\torr r0, r2, r0, lsr #16\n')
        self._asm_file.write(f'\tmov r2, #0x9d3d\n')
        self._asm_file.write(f'\tmul r1, r2, r1\n')
        self._asm_file.write(f'\tadd r0, r0, r1\n')


    def write_rand(self, c):
        self._asm_file.write(f'\t; BC_RAND [{c:02x}]\n')
        self.load_var(0)
        self._asm_file.write(f'\tldr r0, [r5, #ST_RAND*4]\n')
        self.write_random_iteration()
        self._asm_file.write(f'\tstr r0, [r5, #ST_RAND*4]\n')
        self._asm_file.write(f'\tmov r0, r0, lsr #16\n')
        self.push_var(0)

    def write_draw(self, c):
        self._asm_file.write(f'\t; BC_DRAW [{c:02x}]\n')
        self.load_var(0)    # this operation will trash r0
        self._asm_file.write(f'\tadd r2, r5, #4\n')
        self._asm_file.write(f'\tldmia r2, {{r8-r11}}\t\t\t; r8=st_x, r9=st_y, r10=st_size, r11=st_tint\n')

        if INLINE_PLOTDRAW:
            self._asm_file.write(f'\tmov r0, r8, asr #16\t\t\t; X\n')
            self._asm_file.write(f'\tmov r1, r9, asr #16\t\t\t; Y\n')
            self._asm_file.write(f'\tmov r2, r10, asr #16\t\t; RADIUS\n')
            self._asm_file.write(f'\tmov r9, r11, lsr #16\t\t; TINT\n')
            self._asm_file.write(f'\tldr r10, [r6, #-12]\t\t\t; (plot_circle_instruction)\n')
            self._asm_file.write(f'\tstr lr, [sp, #-4]!\t\t\t; Push lr on program stack.\n')
            self._asm_file.write(f'\tbl link_circle\n')
            self._asm_file.write(f'\tldr lr, [sp], #4\t\t\t; Pop lr off program stack.\n')
        else:
            self._asm_file.write(f'\tstr lr, [sp, #-4]!\t\t\t; Push lr on program stack.\n')
            self._asm_file.write(f'\tbl PutCircle\n')
            self._asm_file.write(f'\tldr lr, [sp], #4\t\t\t; Pop lr off program stack.\n')


    def write_tail(self, c):
        self._asm_file.write(f'\t; BC_TAIL [{c:02x}]\n')
        self._asm_file.write(f'\tldr r2, [r5, #ST_PROC*4]\t; Jump to State.st_proc\n')
        self._asm_file.write(f'\tmov pc, r2\n')

    def write_plot(self, c):
        self._asm_file.write(f'\t; BC_PLOT [{c:02x}]\n')
        self.load_var(0)    # this operation will trash r0
        self._asm_file.write(f'\tadd r2, r5, #4\n')
        self._asm_file.write(f'\tldmia r2, {{r8-r11}}\t\t\t; r8=st_x, r9=st_y, r10=st_size, r11=st_tint\n')

        if INLINE_PLOTDRAW:
            self._asm_file.write(f'\tmov r0, r8, asr #16\t\t\t; X\n')
            self._asm_file.write(f'\tmov r1, r9, asr #16\t\t\t; Y\n')
            self._asm_file.write(f'\tmov r2, r10, asr #16\t\t; RADIUS\n')
            self._asm_file.write(f'\tmov r9, r11, lsr #16\t\t; TINT\n')
            self._asm_file.write(f'\tldr r10, [r6, #-8]\t\t\t; (plot_square_instruction)\n')
            self._asm_file.write(f'\torr r10, r10, r2\t\t\t; mov r1, #st_size\n')
            self._asm_file.write(f'\tstr lr, [sp, #-4]!\t\t\t; Push lr on program stack.\n')
            self._asm_file.write(f'\tbl link_circle\n')
            self._asm_file.write(f'\tldr lr, [sp], #4\t\t\t; Pop lr off program stack.\n')
        else:
            self._asm_file.write(f'\tstr lr, [sp, #-4]!\t\t\t; Push lr on program stack.\n')
            self._asm_file.write(f'\tbl PutSquare\n')
            self._asm_file.write(f'\tldr lr, [sp], #4\t\t\t; Pop lr off program stack.\n')

    def write_proc(self, c):
        self._asm_file.write(f'\t; BC_PROC [{c:02x}]\n')
        self.load_var(0)
        index = int.from_bytes(self._byte_file.read(1), "big")
        self._asm_file.write(f'\tadr r0, proc_{index}_start\t\t; r0=r_Procedures[{index}]\n')
        self.push_var(0)

    def write_pop_snip(self, c):
        self._asm_file.write(f'\t; BC_POP [{c:02x}]\n')
        self.pop_var(0)

    def write_div(self, c):
        self._asm_file.write(f'\t; BC_DIV [{c:02x}]\n')
        self.pop_var(0)
        self.pop_var(1)
        self._asm_file.write(f'\tmov r1, r1, asl #8\n')
        self._asm_file.write(f'\tmov r1, r1, asr #16\t\t\t; Implement divs.w overflow behaviour!\n')
        self._asm_file.write(f'\tstr lr, [sp, #-4]!\t\t\t; Push lr on program stack.\n')
        self._asm_file.write(f'\tbl divide\t\t\t\t\t; r0=r0/r1\n')
        self._asm_file.write(f'\tldr lr, [sp], #4\t\t\t; Pop lr off program stack.\n')
        self._asm_file.write(f'\tmov r0, r0, asl #8\n')
        self.push_var(0)

    def write_wait(self, c):
        self._asm_file.write(f'\t; BC_WAIT [{c:02x}]\n')
        self.pop_var(0)
        self._asm_file.write(f'\tadr r1, proc_{self._proc_no}_continue_{self._label_no}\n')

        if INLINE_WAITSTATE:
            self._asm_file.write(f'\tstr r1, [r5, #ST_PROC*4]\t; *pState.st_proc = &continue\n')
            self._asm_file.write(f'\tstr r5, [r3, #-4]!\t\t\t; push p_State on StateStack.\n')
            self._asm_file.write(f'\tldr r2, [r5, #ST_TIME*4]\n')
            self._asm_file.write(f'\tadd r2, r2, r0\n')
            self._asm_file.write(f'\tstr r2, [r5, #ST_TIME*4]\t; *pState.st_time += wait_frames\n')
            self._asm_file.write(f'\tbic r2, r2, #0xc000\t\t\t; remove time fractional part.\n')
            self._asm_file.write(f'\tldr r1, [r6, r2, lsr #14]\t; r_StateList[time >> 16 << 2]\n')
            self._asm_file.write(f'\tstr r1, [r3, #-4]!\t\t\t; push previous entry from StateList at that frame.\n')
            self._asm_file.write(f'\tstr r3, [r6, r2, lsr #14]\t; store new p_StateStack for this frame.\n')
            self._asm_file.write(f'\tmov pc, lr\t\t\t\t\t; Return.\n')
        else:
            self._asm_file.write(f'\tstr lr, [sp, #-4]!\t\t\t; Push lr on program stack.\n')
            self._asm_file.write(f'\tbl WaitState\t\t\t\t; Add r5 to StateList, r0=wait_frames, r1=&continue.\n')
            self._asm_file.write(f'\tldr pc, [sp], #4\t\t\t; Return\n')

        self._asm_file.write(f'proc_{self._proc_no}_continue_{self._label_no}:\n')
        self._label_no += 1

    def write_sine(self, c):
        self._asm_file.write(f'\t; BC_SINE [{c:02x}]\n')
        self.pop_var(0)
        self._asm_file.write(f'\tmov r1, #0xfffc\n')
        self._asm_file.write(f'\tand r0, r0, r1\n')
        self._asm_file.write(f'\tldr r0, [r7, r0]\t\t\t; r7=r_Sinus\n')
        self._asm_file.write(f'\tmov r0, r0, asl #2\n')
        self.push_var(0)

    def write_seed(self, c):
        self._asm_file.write(f'\t; BC_SEED [{c:02x}]\n')
        self.pop_var(0)
        self.write_random_iteration()
        self.write_random_iteration()
        self._asm_file.write(f'\tstr r0, [r5, #ST_RAND*4]\n')

    def write_neg(self, c):
        self._asm_file.write(f'\t; BC_NEG [{c:02x}]\n')
        self.pop_var(0)
        self._asm_file.write(f'\trsb r0, r0, #0\t\t\t\t; r0=0-r0\n')
        self.push_var(0)

    def write_move(self, c):
        self._asm_file.write(f'\t; BC_MOVE [{c:02x}]\n')
        self.pop_var(0)
        self._asm_file.write(f'\tstr lr, [sp, #-4]!\t\t\t; Push lr on program stack.\n')
        self._asm_file.write(f'\tbl DoMove\n')
        self._asm_file.write(f'\tldr lr, [sp], #4\t\t\t; Pop lr off program stack.\n')
    
    def write_mul(self, c):
        self._asm_file.write(f'\t; BC_MUL [{c:02x}]\n')
        self.pop_var(0)
        self.pop_var(1)
        self._asm_file.write(f'\tmov r0, r0, asl #8\n')
        self._asm_file.write(f'\tmov r0, r0, asr #16\t\t\t; Implement muls.w (signed)\n')
        self._asm_file.write(f'\tmov r1, r1, asl #8\n')
        self._asm_file.write(f'\tmov r1, r1, asr #16\t\t\t; Implement muls.w (signed)\n')
        self._asm_file.write(f'\tmul r0, r1, r0\t\t\t\t; r0=r0*r1\n')
        self.push_var(0)

    def write_when(self, c):
        self._asm_file.write(f'\t; BC_WHEN [{c:02x}]\n')

        # Need to update status flags after load without op.
        if self._load_without_op:
            self._asm_file.write(f'\tmovs r0, r0\t\t\t\t\t; update Status flags\n')

        cond = c & 0xf
        # NOTE: Uses negated condition for WHEN!
        if cond == CMP_EQ:
            suffix = 'ne'
        elif cond == CMP_NE:
            suffix = 'eq'
        elif cond == CMP_LT:
            suffix = 'ge'
        elif cond == CMP_GE:
            suffix = 'lt'
        elif cond == CMP_LE:
            suffix = 'gt'
        elif cond == CMP_GT:
            suffix = 'le'
        else:
            suffix = 'xx'

        self._asm_file.write(f'\tb{suffix} proc_{self._proc_no}_target_{self._label_no}\n')
        self._label_stack.append(self._label_no)    # Push label.
        self._label_no += 1
        self._push_pending = False  # TO CHECK!

    def write_fork(self, c):
        self._asm_file.write(f'\t; BC_FORK [{c:02x}]\n')
        self.pop_var(0) # Proc.
        num_args = c & 0xf
        self._asm_file.write(f'\tmov r1, #{num_args}\n')
        self._asm_file.write(f'\tstr lr, [sp, #-4]!\t\t\t; Push lr on program stack.\n')
        self._asm_file.write(f'\tbl ForkState\t\t\t\t; r0=proc address, r1=num_args\n')
        self._asm_file.write(f'\tldr lr, [sp], #4\t\t\t; Pop lr off program stack.\n')
        # Note: Args are popped from state stack by ForkState.
        # self._asm_file.write(f'\t; TODO: Pop {num_args} vars from stack?\n')

    def write_op(self, c):
        self._asm_file.write(f'\t; BC_OP [{c:02x}]\n')
        shift = None
        op = c & 0xf
        self.pop_var(0)
        self.pop_var(1)

        if op == OP_ASR:
            opcode = 'movs'
            shift = 'asr'
        elif op == OP_LSR:
            opcode = 'movs'
            shift = 'lsr'
        elif op == OP_ROXR:
            opcode = 'movs'
            shift = 'roxr'
        elif op == OP_ROR:
            opcode = 'movs'
            shift = 'ror'
        elif op == OP_ASL:
            opcode = 'movs'
            shift = 'asl'
        elif op == OP_LSL:
            opcode = 'movs'
            shift = 'lsl'
        elif op == OP_ROXL:
            opcode = 'movs'
            shift = 'roxl'
        elif op == OP_ROL:
            opcode = 'movs'
            shift = 'rol'
        elif op == OP_OR:
            opcode = 'oras'
        elif op == OP_SUB:
            opcode = 'subs'
        elif op == OP_CMP:
            opcode = 'cmp'
        elif op == OP_AND:
            opcode = 'ands'
        elif op == OP_ADD:
            opcode = 'adds'
        else:
            opcode = 'unknown'

        if opcode == 'cmp':
            self._asm_file.write(f'\t{opcode} r0, r1\t\t\t\t\t; r0 {opcode} r1\n')
        else:
            if shift == None:
                self._asm_file.write(f'\t{opcode} r0, r0, r1\t\t\t\t; r0=r0 {opcode} r1\n')
            else:
                self._asm_file.write(f'\tmov r1, r1, lsr #16\t\t\t; swap.w r1\n')
                self._asm_file.write(f'\tand r1, r1, #63\t\t\t\t; only bottom 6 bits are valid.\n')
                self._asm_file.write(f'\t{opcode} r0, r0, {shift} r1\t\t\t; r0=r0 {shift} r1\n')
            self.push_var(0)

        self._load_without_op = False

    def write_wlocal(self, c):
        self._asm_file.write(f'\t; BC_WLOCAL [{c:02x}]\n')
        x = c & 0xf
        self.pop_var(0)
        self._asm_file.write(f'\tstr r0, [r5, #{~x}*4]\t\t\t; StateStack[{~x}]=r0\n')

    def write_wstate(self, c):
        self._asm_file.write(f'\t; BC_WSTATE [{c:02x}]\n')
        x = c & 0xf
        self.pop_var(0)
        self._asm_file.write(f'\tstr r0, [r5, #{STATE_NAMES[x]}*4]\t\t; State[{STATE_NAMES[x]}]=r0\n')

    def write_rlocal(self, c):
        self._asm_file.write(f'\t; BC_RLOCAL [{c:02x}]\n')
        self.load_var(0)
        x = c & 0xf
        self._asm_file.write(f'\tldr r0, [r5, #{~x}*4]\t\t\t; r0=StateStack[{~x}]\n')
        self.push_var(0)

    def write_rstate(self, c):
        self._asm_file.write(f'\t; BC_RSTATE [{c:02x}]\n')
        self.load_var(0)
        x = c & 0xf
        self._asm_file.write(f'\tldr r0, [r5, #{STATE_NAMES[x]}*4]\t\t; r0=State[{STATE_NAMES[x]}]\n')
        self.push_var(0)


    def TranslateByteCode(self, asm_file):
        self._asm_file = asm_file
        c = int.from_bytes(self._byte_file.read(1), "big")
        current_proc = -1
        num_procs = 0

        while c != END_OF_SCRIPT:

            # Proc loop.

            # Write proc address.
            if current_proc != self._proc_no:
                self._asm_file.write(f'proc_{self._proc_no}_start:\n')
                current_proc = self._proc_no
                self._branch_target = 0
                self._branch_call = 0
                num_procs += 1

            # Inst loop.
            if c >= BC_CONST:
                self.write_const(c)        
            elif c == BC_DONE:
                self.write_done(c)
            elif c == BC_ELSE:
                self.write_else(c)
            elif c == BC_END:
                self.write_end(c)
            elif c == BC_RAND:
                self.write_rand(c)
            elif c == BC_DRAW:
                self.write_draw(c)
            elif c == BC_TAIL:
                self.write_tail(c)
            elif c == BC_PLOT:
                self.write_plot(c)
            elif c == BC_PROC:
                self.write_proc(c)
            elif c == BC_POP:
                self.write_pop_snip(c)
            elif c == BC_DIV:
                self.write_div(c)
            elif c == BC_WAIT:
                self.write_wait(c)
            elif c == BC_SINE:
                self.write_sine(c)
            elif c == BC_SEED:
                self.write_seed(c)
            elif c == BC_NEG:
                self.write_neg(c)
            elif c == BC_MOVE:
                self.write_move(c)
            elif c == BC_MUL:
                self.write_mul(c)
            elif c >= BC_WHEN and c <= BC_WHEN + 0xf:
                self.write_when(c)
            elif c >= BC_FORK and c <= BC_FORK + 0xf:
                self.write_fork(c)
            elif c >= BC_OP and c <= BC_OP + 0xf:
                self.write_op(c)
            elif c >= BC_WLOCAL and c <= BC_WLOCAL + 0xf:
                self.write_wlocal(c)
            elif c >= BC_WSTATE and c <= BC_WSTATE + 0xf:
                self.write_wstate(c)
            elif c >= BC_RLOCAL and c <= BC_RLOCAL + 0xf:
                self.write_rlocal(c)
            elif c >= BC_RSTATE and c <= BC_RSTATE + 0xf:
                self.write_rstate(c)

            c = int.from_bytes(self._byte_file.read(1), "big")

        # Write procedure table.
        print(f'Wrote {num_procs} procedures.\n')
        # self._asm_file.write(f'\n; Procedures.\nr_Procedures:\n')
        # for x in range(num_procs):
        #    self._asm_file.write(f'\t.long proc_{x}_start\n')


def TranslateConstants(const_file):
    constants = []
    while True:
        b = const_file.read(4)
        if b == b'':            # binary empty string == EOF
            break
        c = int.from_bytes(b, "big")
        constants.append(c)
    return constants

def WriteConstants(constants, asm_file):
    num_constants = 0
    asm_file.write('\n; ============================================================================\n')
    asm_file.write(f'; Constants.\n')
    asm_file.write('; ============================================================================\n')
    asm_file.write(f'\nr_Constants:\n')
    
    for c in constants:
        asm_file.write(f'.long 0x{c:08x}\t\t\t\t; [{num_constants}] = {(c/(1<<16)):.4f}\n')
        num_constants += 1

    print(f'Wrote {len(constants)} constants.\n')

def TranslateColorScript(color_file, asm_file):
    num_events = 0
    asm_file.write('\n; ============================================================================\n')
    asm_file.write(f'; Color Script.\n')
    asm_file.write('; ============================================================================\n')
    asm_file.write(f'\nr_ColorScript:\n')

    done=False
    total_frames=-1

    while not done:
        b = color_file.read(2)
        if b == b'':            # binary empty string == EOF
            break
        c = int.from_bytes(b, "big")

        if c >= 0x8000:
            # New delta.
            if total_frames >= 0:
                asm_file.write(f'\t\t\t; delta_frames={delta_frames} [{total_frames}]\n')

            if c == 0x8000:
                done=True
                delta_frames = 0x80000000
                asm_file.write(f'.long 0x{delta_frames:08x}')
            else:    
                delta_frames = ((~c)+1)&0xffff
                total_frames += delta_frames

                # asm_file.write(f'.short 0x{c:04x}')
                asm_file.write(f'.long {-delta_frames}')

            num_events += 1
        else:
            # asm_file.write(f', 0x{c:04x}')
            i = c >> 12
            r = (c >> 8) & 0xf
            r = r | r<<4
            g = (c >> 4) & 0xf
            g = g | g<<4
            bl = c & 0xf
            bl = bl | bl<<4
            # asm_file.write(f', 0x{c:08x}')
            asm_file.write(f', 0x{i:02x}{bl:02x}{g:02x}{r:02x}')

    asm_file.write(f'\t; END_SCRIPT.\n')
    print(f'Wrote {num_events} events from ColorScript.\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("input", help="Rose bytecodes file")
    parser.add_argument("-c", "--constants", metavar="<constants>", help="Read constants.bin file and add to asm file.")
    parser.add_argument("-o", "--output", metavar="<output>", help="Write ARM asm file to <output> (default is 'bytecodes.asm')")
    parser.add_argument("-s", "--script", metavar="<script>", help="Read colorscript.bin file and add to asm file.")
    parser.add_argument("-v", "--verbose", action="store_true", help="Print all the debugs")
    args = parser.parse_args()

    global g_verbose
    g_verbose=args.verbose

    src = args.input
    # check for missing files
    if not os.path.isfile(src):
        print(f"ERROR: File '{src}' not found")
        sys.exit(1)

    dst = args.output
    if dst == None:
        dst = "bytecodes.asm"

    byte_file = open(src, 'rb')
    asm_file = open(dst, 'w')

    # Standard header.
    asm_file.write('; ============================================================================\n')
    asm_file.write('; rose2arc.py\n')
    asm_file.write(f'; input = {src}.\n')
    asm_file.write('; ============================================================================\n\n')
    for s in STATE_NAMES:
        asm_file.write(f'.equ {s}, {STATE_NAMES.index(s)}\n')

    asm_file.write('\n; ============================================================================\n')
    asm_file.write('; r3 = p_StateStack.\t(preserve)\n')
    asm_file.write('; r4 = r_Constants.\t(preserve)\n')
    asm_file.write('; r5 = p_State.\t\t(preserve)\n')
    asm_file.write('; r6 = r_Statelists\t(preserve).\n')
    asm_file.write('; r7 = r_Sinus.\t\t(preserve)\n')
    asm_file.write('; ============================================================================\n\n')

    if args.constants is not None:
        const_file = open(args.constants, 'rb')
        constants = TranslateConstants(const_file)
        const_file.close()

    # Output Archie ARM asm.
    parser = RoseParser(byte_file, constants)
    parser.TranslateByteCode(asm_file)

    if constants is not None:
        WriteConstants(constants, asm_file)

    if args.script is not None:
        color_file = open(args.script, 'rb')
        TranslateColorScript(color_file, asm_file)
        color_file.close()

    print(f'Wrote {asm_file.tell()} bytes.\n')

    asm_file.close()
    byte_file.close()
