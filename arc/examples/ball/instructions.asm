; ============================================================================
; rose2arc.py
; input = examples/ball/bytecodes.bin.
; ============================================================================

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
.equ ST_WIRE2, 10
.equ ST_WIRE3, 11
.equ ST_WIRE4, 12
.equ ST_WIRE5, 13
.equ ST_WIRE6, 14
.equ ST_WIRE7, 15

; ============================================================================
; r3 = p_StateStack.	(preserve)
; r4 = r_Constants.	(preserve)
; r5 = p_State.		(preserve)
; r6 = r_Statelists	(preserve).
; r7 = r_Sinus.		(preserve)
; ============================================================================

proc_0_start:
	; BC_CONST [84]
	mov r0, #0x00160000			; r0=rConstants[4] (22.0000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x006c0000			; r0=rConstants[7] (108.0000)
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00008000			; r0=rConstants[1] (0.5000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_0_end:

proc_1_start:
	; BC_CONST [83]
	mov r0, #0x00020000			; r0=rConstants[3] (2.0000)
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[2] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00008000			; r0=rConstants[1] (0.5000)
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a00000			; r0=rConstants[8] (160.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[2] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[2] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_1_end:

proc_2_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_2_target_0
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_ELSE [01]
	b proc_2_target_1
proc_2_target_0:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_DONE [00]
proc_2_target_1:
	; BC_CONST [86]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00230000			; r0=rConstants[6] (35.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	mov r0, r8, asr #16			; X
	mov r1, r9, asr #16			; Y
	mov r2, r10, asr #16		; RADIUS
	mov r9, r11, lsr #16		; TINT
	ldr r10, [r6, #-12]			; (plot_circle_instruction)
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl link_circle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [82]
	mov r0, #0x00010000			; r0=rConstants[2] (1.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [85]
	mov r0, #0x001e0000			; r0=rConstants[5] (30.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	mov r0, r8, asr #16			; X
	mov r1, r9, asr #16			; Y
	mov r2, r10, asr #16		; RADIUS
	mov r9, r11, lsr #16		; TINT
	ldr r10, [r6, #-12]			; (plot_circle_instruction)
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl link_circle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [82]
	mov r0, #0x00010000			; r0=rConstants[2] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_2_continue_2
	str r1, [r5, #ST_PROC*4]	; *pState.st_proc = &continue
	str r5, [r3, #-4]!			; push p_State on StateStack.
	ldr r2, [r5, #ST_TIME*4]
	add r2, r2, r0
	str r2, [r5, #ST_TIME*4]	; *pState.st_time += wait_frames
	bic r2, r2, #0xc000			; remove time fractional part.
	ldr r1, [r6, r2, lsr #14]	; r_StateList[time >> 16 << 2]
	str r1, [r3, #-4]!			; push previous entry from StateList at that frame.
	str r3, [r6, r2, lsr #14]	; store new p_StateStack for this frame.
	mov pc, lr					; Return.
proc_2_continue_2:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_2_target_3
	; BC_PROC [07]
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[2] (1.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [44]
	str r0, [r5, #-5*4]			; StateStack[-5]=r0
	; BC_WLOCAL [42]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WLOCAL [41]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_ELSE [01]
	b proc_2_target_4
proc_2_target_3:
	; BC_PROC [07]
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_WLOCAL [44]
	str r0, [r5, #-5*4]			; StateStack[-5]=r0
	; BC_WLOCAL [42]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WLOCAL [41]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_2_target_4:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_2_end:


; ============================================================================
; Constants.
; ============================================================================

r_Constants:
.long 0x00000000				; [0] = 0.0000
.long 0x00008000				; [1] = 0.5000
.long 0x00010000				; [2] = 1.0000
.long 0x00020000				; [3] = 2.0000
.long 0x00160000				; [4] = 22.0000
.long 0x001e0000				; [5] = 30.0000
.long 0x00230000				; [6] = 35.0000
.long 0x006c0000				; [7] = 108.0000
.long 0x00a00000				; [8] = 160.0000

; ============================================================================
; Color Script.
; ============================================================================

r_ColorScript:
.long -1, 0x00443322, 0x01cc3355			; delta_frames=1 [0]
.long 0x80000000	; END_SCRIPT.
