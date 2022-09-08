; rose2arc.py
; input = ball.bin

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

; r3 = State Stack Ptr.
; r4 = r_Constants.
; r5 = State Ptr.
; r6 = r_StateSpace.
; r7 = r_Sinus.

proc_0_start:
	; BC_CONST [85]
	ldr r0, [r4, #5*4]			; r0=rConstants[5]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; push r0
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; pop r1
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=R0
	; BC_CONST [86]
	ldr r0, [r4, #6*4]			; r0=rConstants[6]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr from program stack.
	; BC_CONST [85]
	ldr r0, [r4, #5*4]			; r0=rConstants[5]
	; BC_NEG [0d]
	rsb r0, r0, #0		; r0=0-r0
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; push r0
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; pop r1
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=R0
	; BC_PROC [07]
	ldr r0, [r6, #1*4]			; r0=r_Procedures[1]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=R0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_0_end:

proc_1_start:
	; BC_CONST [81]
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=R0
	; BC_CONST [83]
	ldr r0, [r4, #3*4]			; r0=rConstants[3]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=R0
	; BC_DRAW [04]
	ldmia r5, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr from program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=R0
	; BC_CONST [84]
	ldr r0, [r4, #4*4]			; r0=rConstants[4]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=R0
	; BC_DRAW [04]
	ldmia r5, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr from program stack.
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr from program stack.
	; BC_CONST [81]
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_0
	str lr, [sp, #-4]!			; Push lr on program stack.
	; r0=wait_frames, r1=&continue
	bl WaitState					; Add r5 to StateList
	ldr pc, [sp], #4				; Return
proc_1_continue_0:
	; BC_PROC [07]
	ldr r0, [r6, #1*4]			; r0=r_Procedures[1]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=R0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_1_end:


; Procedures.
r_Procedures:
	.long proc_0_start
	.long proc_1_start
