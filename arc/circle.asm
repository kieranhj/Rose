; rose2arc.py
; input = bytecodes.bin

.equ ST_PROC, 0
.equ ST_X, 1
.equ ST_Y, 2
.equ ST_SIZE, 3
.equ ST_TINT, 4
.equ ST_RAND, 5
.equ ST_DIR, 6
.equ ST_TIME, 7
.equ ST_WIRE0, 8
.equ ST_WIRE1, 9
; R3 = State Stack Ptr.
; R4 = r_Constants.
; R5 = State Ptr.
; R6 = r_StateSpace.
.proc_0_start
; BC_CONST [87]
ldr r0, [r4, #7*4]   ; r0=rConstants[7]
; BC_MOVE [0e]
; TODO: Implement BC_MOVE by R0 units.
; BC_CONST [85]
ldr r0, [r4, #5*4]   ; r0=rConstants[5]
; BC_RSTATE [76]
str r0, [r3, #-4]!   ; push R0
ldr r0, [r5, #ST_DIR*4]   ; R0=State[ST_DIR]
; BC_OP [3d]
ldr r1, [r3], #4     ; pop R1
add r0, r0, r1       ; R0=R0 add R1
; BC_WSTATE [56]
str r0, [r5, #ST_DIR*4]   ; State[ST_DIR]=R0
; BC_CONST [86]
ldr r0, [r4, #6*4]   ; r0=rConstants[6]
; BC_MOVE [0e]
; TODO: Implement BC_MOVE by R0 units.
; BC_CONST [82]
ldr r0, [r4, #2*4]   ; r0=rConstants[2]
; BC_WSTATE [54]
str r0, [r5, #ST_TINT*4]   ; State[ST_TINT]=R0
; BC_CONST [84]
ldr r0, [r4, #4*4]   ; r0=rConstants[4]
; BC_WSTATE [53]
str r0, [r5, #ST_SIZE*4]   ; State[ST_SIZE]=R0
; BC_CONST [82]
ldr r0, [r4, #2*4]   ; r0=rConstants[2]
; BC_CONST [88]
str r0, [r3, #-4]!   ; push R0
ldr r0, [r4, #8*4]   ; r0=rConstants[8]
; BC_PROC [07]
str r0, [r3, #-4]!   ; push R0
ldr r0, [r6, #1*4]   ; R0=r_Procedures[1]
; BC_FORK [22]
; TODO: Implement BC_FORK to proc R0 with 2 arguments.
ldr r0, [r3], #4     ; pop R0
ldr r0, [r3], #4     ; pop R0
; BC_END [02]
; TODO: Add state ptr to r_FreeState list.
mov pc, lr
.proc_1_start
; BC_DRAW [04]
; TODO: Call r_PutCircle with st_x, st_y, st_size, st_tint
; BC_CONST [83]
ldr r0, [r4, #3*4]   ; r0=rConstants[3]
; BC_MOVE [0e]
; TODO: Implement BC_MOVE by R0 units.
; BC_RLOCAL [60]
ldr r0, [r5, #0*4]   ; R0=State[0]
; BC_RSTATE [76]
str r0, [r3, #-4]!   ; push R0
ldr r0, [r5, #ST_DIR*4]   ; R0=State[ST_DIR]
; BC_OP [3d]
ldr r1, [r3], #4     ; pop R1
add r0, r0, r1       ; R0=R0 add R1
; BC_WSTATE [56]
str r0, [r5, #ST_DIR*4]   ; State[ST_DIR]=R0
; BC_CONST [81]
ldr r0, [r4, #1*4]   ; r0=rConstants[1]
; BC_WAIT [0a]
; TODO: Implement BC_WAIT for time R0.
; BC_CONST [80]
ldr r0, [r4, #0*4]   ; r0=rConstants[0]
; BC_RLOCAL [61]
str r0, [r3, #-4]!   ; push R0
ldr r0, [r5, #1*4]   ; R0=State[1]
; BC_OP [3b]
ldr r1, [r3], #4     ; pop R1
cmp r0, r1           ; R0=R0 cmp R1
; BC_WHEN [1f]
bgt proc_1_target_0
; BC_PROC [07]
ldr r0, [r6, #1*4]   ; R0=r_Procedures[1]
; BC_CONST [82]
str r0, [r3, #-4]!   ; push R0
ldr r0, [r4, #2*4]   ; r0=rConstants[2]
; BC_RLOCAL [61]
str r0, [r3, #-4]!   ; push R0
ldr r0, [r5, #1*4]   ; R0=State[1]
; BC_OP [39]
ldr r1, [r3], #4     ; pop R1
sub r0, r0, r1       ; R0=R0 sub R1
; BC_WLOCAL [41]
str r0, [r5, #1*4]   ; State[1]=R0
; BC_WSTATE [50]
ldr r0, [r3], #4     ; pop R0
str r0, [r5, #ST_PROC*4]   ; State[ST_PROC]=R0
; BC_TAIL [05]
ldr r1, [r5]         ; jump to State[st_proc]
mov pc, r1
; BC_DONE [00]
.proc_1_target_0
; BC_END [02]
; TODO: Add state ptr to r_FreeState list.
mov pc, lr
