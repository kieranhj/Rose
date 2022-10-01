; ============================================================================
; rose2arc.py
; input = examples/euphoria/bytecodes.bin.
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
; r3 = p_StateStack.
; r4 = r_Constants.
; r5 = p_State.
; r6 = <temp>           ; r_StateSpace.
; r7 = r_Sinus.
; ============================================================================

proc_0_start:
	; BC_CONST [97]
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [a0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x003c0000			; r0=rConstants[32] (60.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00070000			; r0=rConstants[14] (7.0000)
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a80000			; r0=rConstants[44] (168.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	mov r0, #0x00a80000			; r0=rConstants[44] (168.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_0
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
proc_0_continue_0:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	mov r0, #0x00080000			; r0=rConstants[15] (8.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_1
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
proc_0_continue_1:
	; BC_CONST [9e]
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [8d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[13] (6.0000)
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a80000			; r0=rConstants[44] (168.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	mov r0, #0x00a80000			; r0=rConstants[44] (168.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_2
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
proc_0_continue_2:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	mov r0, #0x00080000			; r0=rConstants[15] (8.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_3
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
proc_0_continue_3:
	; BC_CONST [9a]
	mov r0, #0x001e0000			; r0=rConstants[26] (30.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a80000			; r0=rConstants[44] (168.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	mov r0, #0x00a80000			; r0=rConstants[44] (168.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_4
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
proc_0_continue_4:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	mov r0, #0x00080000			; r0=rConstants[15] (8.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_5
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
proc_0_continue_5:
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00040000			; r0=rConstants[10] (4.0000)
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00640000			; r0=rConstants[39] (100.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00630000			; r0=rConstants[38] (99.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_6
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
proc_0_continue_6:
	; BC_CONST [b6]
	mov r0, #0x01360000			; r0=rConstants[54] (310.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00c00000			; r0=rConstants[48] (192.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00420000			; r0=rConstants[34] (66.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_7
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
proc_0_continue_7:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_8
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
proc_0_continue_8:
	; BC_CONST [99]
	mov r0, #0x00180000			; r0=rConstants[25] (24.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [8d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[13] (6.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [b2]
	mov r0, #0x00d20000			; r0=rConstants[50] (210.0000)
	; BC_CONST [bd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #61*4]			; r0=rConstants[61]=0x82088208 (33288.5079)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_9
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
proc_0_continue_9:
	; BC_CONST [b2]
	mov r0, #0x00d20000			; r0=rConstants[50] (210.0000)
	; BC_CONST [c0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #64*4]			; r0=rConstants[64]=0x82089410 (33288.5784)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [aa]
	mov r0, #0x00a50000			; r0=rConstants[42] (165.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_10
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
proc_0_continue_10:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01640000			; r0=rConstants[57] (356.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_11
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
proc_0_continue_11:
	; BC_CONST [ae]
	mov r0, #0x00b90000			; r0=rConstants[46] (185.0000)
	; BC_CONST [8d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[13] (6.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [9d]
	mov r0, #0x00280000			; r0=rConstants[29] (40.0000)
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]=0x8208b508 (33288.7072)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_12
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
proc_0_continue_12:
	; BC_CONST [9d]
	mov r0, #0x00280000			; r0=rConstants[29] (40.0000)
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]=0x82089240 (33288.5713)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a50000			; r0=rConstants[42] (165.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_13
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
proc_0_continue_13:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ae]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00b90000			; r0=rConstants[46] (185.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_14
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
proc_0_continue_14:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_15
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
proc_0_continue_15:
	; BC_CONST [99]
	mov r0, #0x00180000			; r0=rConstants[25] (24.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [8d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[13] (6.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [b2]
	mov r0, #0x00d20000			; r0=rConstants[50] (210.0000)
	; BC_CONST [bd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #61*4]			; r0=rConstants[61]=0x82088208 (33288.5079)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_16
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
proc_0_continue_16:
	; BC_CONST [b2]
	mov r0, #0x00d20000			; r0=rConstants[50] (210.0000)
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #60*4]			; r0=rConstants[60]=0x82082080 (33288.1270)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [aa]
	mov r0, #0x00a50000			; r0=rConstants[42] (165.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_17
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
proc_0_continue_17:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01640000			; r0=rConstants[57] (356.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_18
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
proc_0_continue_18:
	; BC_CONST [ae]
	mov r0, #0x00b90000			; r0=rConstants[46] (185.0000)
	; BC_CONST [8d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[13] (6.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [9d]
	mov r0, #0x00280000			; r0=rConstants[29] (40.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #63*4]			; r0=rConstants[63]=0x82089260 (33288.5718)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_19
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
proc_0_continue_19:
	; BC_CONST [9d]
	mov r0, #0x00280000			; r0=rConstants[29] (40.0000)
	; BC_CONST [c2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #66*4]			; r0=rConstants[66]=0x8802f140 (34818.9424)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a50000			; r0=rConstants[42] (165.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_20
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
proc_0_continue_20:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ae]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00b90000			; r0=rConstants[46] (185.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_21
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
proc_0_continue_21:
	; BC_CONST [b5]
	mov r0, #0x01130000			; r0=rConstants[53] (275.0000)
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_22
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
proc_0_continue_22:
	; BC_PROC [07]
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_23
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
proc_0_continue_23:
	; BC_PROC [07]
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_24
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
proc_0_continue_24:
	; BC_PROC [07]
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_25
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
proc_0_continue_25:
	; BC_PROC [07]
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_26
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
proc_0_continue_26:
	; BC_PROC [07]
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_27
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
proc_0_continue_27:
	; BC_PROC [07]
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_28
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
proc_0_continue_28:
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_CONST [a2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00420000			; r0=rConstants[34] (66.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_29
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
proc_0_continue_29:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01640000			; r0=rConstants[57] (356.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_30
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
proc_0_continue_30:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [88]
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_31
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
proc_0_continue_31:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ae]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00b90000			; r0=rConstants[46] (185.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_32
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
proc_0_continue_32:
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_33
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
proc_0_continue_33:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_34
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
proc_0_continue_34:
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_35
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
proc_0_continue_35:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_36
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
proc_0_continue_36:
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_37
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
proc_0_continue_37:
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	mov r0, #0x00b00000			; r0=rConstants[45] (176.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_38
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
proc_0_continue_38:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_39
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
proc_0_continue_39:
	; BC_CONST [96]
	mov r0, #0x00100000			; r0=rConstants[22] (16.0000)
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01640000			; r0=rConstants[57] (356.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00070000			; r0=rConstants[14] (7.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_40
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
proc_0_continue_40:
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b8]
	mov r0, #0x01600000			; r0=rConstants[56] (352.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_41
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
proc_0_continue_41:
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b8]
	mov r0, #0x01600000			; r0=rConstants[56] (352.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_42
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
proc_0_continue_42:
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00d20000			; r0=rConstants[50] (210.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00c80000			; r0=rConstants[49] (200.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b8]
	mov r0, #0x01600000			; r0=rConstants[56] (352.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_43
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
proc_0_continue_43:
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00d20000			; r0=rConstants[50] (210.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00c80000			; r0=rConstants[49] (200.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_44
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
proc_0_continue_44:
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_45
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
proc_0_continue_45:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x004d0000			; r0=rConstants[36] (77.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_46
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
proc_0_continue_46:
	; BC_PROC [07]
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b8]
	mov r0, #0x01600000			; r0=rConstants[56] (352.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_47
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
proc_0_continue_47:
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00d20000			; r0=rConstants[50] (210.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00c80000			; r0=rConstants[49] (200.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b8]
	mov r0, #0x01600000			; r0=rConstants[56] (352.0000)
	; BC_WAIT [0a]
	adr r1, proc_0_continue_48
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
proc_0_continue_48:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ae]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00b90000			; r0=rConstants[46] (185.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00090000			; r0=rConstants[16] (9.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
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
proc_0_end:

proc_1_start:
	; BC_CONST [9a]
	mov r0, #0x001e0000			; r0=rConstants[26] (30.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_49
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
proc_1_continue_49:
	; BC_CONST [9f]
	mov r0, #0x00320000			; r0=rConstants[31] (50.0000)
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a0]
	mov r0, #0x003c0000			; r0=rConstants[32] (60.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_50
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
proc_1_continue_50:
	; BC_CONST [ab]
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01130000			; r0=rConstants[53] (275.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a7]
	mov r0, #0x00640000			; r0=rConstants[39] (100.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_51
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
proc_1_continue_51:
	; BC_CONST [b3]
	mov r0, #0x00d60000			; r0=rConstants[51] (214.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01130000			; r0=rConstants[53] (275.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a0]
	mov r0, #0x003c0000			; r0=rConstants[32] (60.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00420000			; r0=rConstants[34] (66.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_52
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
proc_1_continue_52:
	; BC_CONST [b3]
	mov r0, #0x00d60000			; r0=rConstants[51] (214.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01130000			; r0=rConstants[53] (275.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a0]
	mov r0, #0x003c0000			; r0=rConstants[32] (60.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_53
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
proc_1_continue_53:
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_54
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
proc_1_continue_54:
	; BC_CONST [9f]
	mov r0, #0x00320000			; r0=rConstants[31] (50.0000)
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [9f]
	mov r0, #0x00320000			; r0=rConstants[31] (50.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_55
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
proc_1_continue_55:
	; BC_CONST [ab]
	mov r0, #0x00a70000			; r0=rConstants[43] (167.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01130000			; r0=rConstants[53] (275.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a7]
	mov r0, #0x00640000			; r0=rConstants[39] (100.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_CONST [a0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x003c0000			; r0=rConstants[32] (60.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_56
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
proc_1_continue_56:
	; BC_CONST [b3]
	mov r0, #0x00d60000			; r0=rConstants[51] (214.0000)
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00d20000			; r0=rConstants[50] (210.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [9c]
	mov r0, #0x00230000			; r0=rConstants[28] (35.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00640000			; r0=rConstants[39] (100.0000)
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00420000			; r0=rConstants[34] (66.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_57
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
proc_1_continue_57:
	; BC_CONST [b3]
	mov r0, #0x00d60000			; r0=rConstants[51] (214.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01130000			; r0=rConstants[53] (275.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a1]
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
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
	; BC_CONST [9f]
	mov r0, #0x00320000			; r0=rConstants[31] (50.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a1]
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00040000			; r0=rConstants[10] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_2_continue_58
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
proc_2_continue_58:
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00040000			; r0=rConstants[10] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_2_continue_59
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
proc_2_continue_59:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_CONST [9f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[31] (50.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [8a]
	mov r0, #0x00040000			; r0=rConstants[10] (4.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00040000			; r0=rConstants[10] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_2_target_60
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_2_continue_61
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
proc_2_continue_61:
	; BC_RAND [03]
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SEED [0c]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_PROC [07]
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00040000			; r0=rConstants[10] (4.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00040000			; r0=rConstants[10] (4.0000)
	; BC_WLOCAL [42]
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WLOCAL [41]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_2_target_60:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_2_end:

proc_3_start:
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [98]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_3_continue_62
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
proc_3_continue_62:
	; BC_CONST [b4]
	mov r0, #0x01090000			; r0=rConstants[52] (265.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8e]
	mov r0, #0x00070000			; r0=rConstants[14] (7.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_3_continue_63
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
proc_3_continue_63:
	; BC_CONST [b3]
	mov r0, #0x00d60000			; r0=rConstants[51] (214.0000)
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [b1]
	mov r0, #0x00c80000			; r0=rConstants[49] (200.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00640000			; r0=rConstants[39] (100.0000)
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00420000			; r0=rConstants[34] (66.0000)
	; BC_WAIT [0a]
	adr r1, proc_3_continue_64
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
proc_3_continue_64:
	; BC_CONST [96]
	mov r0, #0x00100000			; r0=rConstants[22] (16.0000)
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00070000			; r0=rConstants[14] (7.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_3_continue_65
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
proc_3_continue_65:
	; BC_CONST [b4]
	mov r0, #0x01090000			; r0=rConstants[52] (265.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8e]
	mov r0, #0x00070000			; r0=rConstants[14] (7.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00c80000			; r0=rConstants[49] (200.0000)
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_3_continue_66
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
proc_3_continue_66:
	; BC_CONST [b2]
	mov r0, #0x00d20000			; r0=rConstants[50] (210.0000)
	; BC_CONST [b4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01090000			; r0=rConstants[52] (265.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [af]
	mov r0, #0x00be0000			; r0=rConstants[47] (190.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00640000			; r0=rConstants[39] (100.0000)
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00420000			; r0=rConstants[34] (66.0000)
	; BC_WAIT [0a]
	adr r1, proc_3_continue_67
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
proc_3_continue_67:
	; BC_CONST [96]
	mov r0, #0x00100000			; r0=rConstants[22] (16.0000)
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01640000			; r0=rConstants[57] (356.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00070000			; r0=rConstants[14] (7.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_3_continue_68
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
proc_3_continue_68:
	; BC_CONST [b4]
	mov r0, #0x01090000			; r0=rConstants[52] (265.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8e]
	mov r0, #0x00070000			; r0=rConstants[14] (7.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_3_continue_69
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
proc_3_continue_69:
	; BC_CONST [b3]
	mov r0, #0x00d60000			; r0=rConstants[51] (214.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [af]
	mov r0, #0x00be0000			; r0=rConstants[47] (190.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_CONST [a0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x003c0000			; r0=rConstants[32] (60.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00420000			; r0=rConstants[34] (66.0000)
	; BC_WAIT [0a]
	adr r1, proc_3_continue_70
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
proc_3_continue_70:
	; BC_CONST [b2]
	mov r0, #0x00d20000			; r0=rConstants[50] (210.0000)
	; BC_CONST [b6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01360000			; r0=rConstants[54] (310.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [af]
	mov r0, #0x00be0000			; r0=rConstants[47] (190.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00640000			; r0=rConstants[39] (100.0000)
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x001e0000			; r0=rConstants[26] (30.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_3_target_71
	; BC_CONST [a5]
	mov r0, #0x00580000			; r0=rConstants[37] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_3_continue_72
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
proc_3_continue_72:
	; BC_CONST [96]
	mov r0, #0x00100000			; r0=rConstants[22] (16.0000)
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01640000			; r0=rConstants[57] (356.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[23] (20.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[41] (128.0000)
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00070000			; r0=rConstants[14] (7.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_3_target_71:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_3_end:

proc_4_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_4_target_73
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_6_start		; r0=r_Procedures[6]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_4_target_74
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_4_continue_75
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
proc_4_continue_75:
	; BC_PROC [07]
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_ELSE [01]
	b proc_4_target_76
proc_4_target_74:
	; BC_CONST [8c]
	mov r0, #0x00058000			; r0=rConstants[12] (5.5000)
	; BC_WAIT [0a]
	adr r1, proc_4_continue_77
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
proc_4_continue_77:
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_4_continue_78
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
proc_4_continue_78:
	; BC_PROC [07]
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [42]
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_4_target_76:
	; BC_DONE [00]
proc_4_target_73:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_4_end:

proc_5_start:
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_5_target_79
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [8d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[13] (6.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_5_target_80
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_5_continue_81
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
proc_5_continue_81:
	; BC_PROC [07]
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_ELSE [01]
	b proc_5_target_82
proc_5_target_80:
	; BC_CONST [8c]
	mov r0, #0x00058000			; r0=rConstants[12] (5.5000)
	; BC_WAIT [0a]
	adr r1, proc_5_continue_83
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
proc_5_continue_83:
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_5_continue_84
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
proc_5_continue_84:
	; BC_PROC [07]
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [44]
	str r0, [r5, #-5*4]			; StateStack[-5]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_5_target_82:
	; BC_DONE [00]
proc_5_target_79:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_5_end:

proc_6_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00080000			; r0=rConstants[15] (8.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	mov r0, #0x00060000			; r0=rConstants[13] (6.0000)
	; BC_WAIT [0a]
	adr r1, proc_6_continue_85
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
proc_6_continue_85:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00080000			; r0=rConstants[15] (8.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_20_start		; r0=r_Procedures[20]
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
proc_6_end:

proc_7_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_7_target_86
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [88]
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [42]
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
	b proc_7_target_87
proc_7_target_86:
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_7_continue_88
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
proc_7_continue_88:
	; BC_CONST [88]
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [91]
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [94]
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_WAIT [0a]
	adr r1, proc_7_continue_89
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
proc_7_continue_89:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_7_target_90
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_7_continue_91
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
proc_7_continue_91:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [9e]
	mov r0, #0x002a0000			; r0=rConstants[30] (42.0000)
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
	; BC_DONE [00]
proc_7_target_90:
	; BC_DONE [00]
proc_7_target_87:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_7_end:

proc_8_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_8_target_92
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	; BC_CONST [88]
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_8_continue_93
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
proc_8_continue_93:
	; BC_PROC [07]
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00002000			; r0=rConstants[2] (0.1250)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_8_target_92:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_8_end:

proc_9_start:
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_9_continue_94
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
proc_9_continue_94:
	; BC_CONST [91]
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_9_continue_95
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
proc_9_continue_95:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_9_continue_96
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
proc_9_continue_96:
	; BC_CONST [b4]
	mov r0, #0x01090000			; r0=rConstants[52] (265.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00c80000			; r0=rConstants[49] (200.0000)
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_9_continue_97
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
proc_9_continue_97:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00c80000			; r0=rConstants[49] (200.0000)
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_9_end:

proc_10_start:
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_98
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
proc_10_continue_98:
	; BC_CONST [b4]
	mov r0, #0x01090000			; r0=rConstants[52] (265.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_99
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
proc_10_continue_99:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_100
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
proc_10_continue_100:
	; BC_CONST [91]
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[55] (330.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00c80000			; r0=rConstants[49] (200.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_101
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
proc_10_continue_101:
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00780000			; r0=rConstants[40] (120.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00c80000			; r0=rConstants[49] (200.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000e0000			; r0=rConstants[20] (14.0000)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[19] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_10_end:

proc_11_start:
	; BC_RLOCAL [67]
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_11_target_102
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_12_start		; r0=r_Procedures[12]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [65]
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9a]
	mov r0, #0x001e0000			; r0=rConstants[26] (30.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [84]
	mov r0, #0x00008000			; r0=rConstants[4] (0.5000)
	; BC_WAIT [0a]
	adr r1, proc_11_continue_103
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
proc_11_continue_103:
	; BC_PROC [07]
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [47]
	str r0, [r5, #-8*4]			; StateStack[-8]=r0
	; BC_WLOCAL [43]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
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
proc_11_target_102:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_11_end:

proc_12_start:
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_12_target_104
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9a]
	mov r0, #0x001e0000			; r0=rConstants[26] (30.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [84]
	mov r0, #0x00008000			; r0=rConstants[4] (0.5000)
	; BC_WAIT [0a]
	adr r1, proc_12_continue_105
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
proc_12_continue_105:
	; BC_PROC [07]
	adr r0, proc_12_start		; r0=r_Procedures[12]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [44]
	str r0, [r5, #-5*4]			; StateStack[-5]=r0
	; BC_WLOCAL [43]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
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
proc_12_target_104:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_12_end:

proc_13_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_13_target_106
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
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
	; BC_CONST [88]
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_WAIT [0a]
	adr r1, proc_13_continue_107
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
proc_13_continue_107:
	; BC_PROC [07]
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_13_target_106:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_13_end:

proc_14_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [17]
	beq proc_14_target_108
	; BC_CONST [bb]
	mov r0, #0x80000000			; r0=rConstants[59] (32768.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WHEN [17]
	beq proc_14_target_109
	; BC_CONST [a7]
	mov r0, #0x00640000			; r0=rConstants[39] (100.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00460000			; r0=rConstants[35] (70.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [96]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00100000			; r0=rConstants[22] (16.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [96]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00100000			; r0=rConstants[22] (16.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [98]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_14_target_110
	; BC_PROC [07]
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_ELSE [01]
	b proc_14_target_111
proc_14_target_110:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_14_target_112
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_ELSE [01]
	b proc_14_target_113
proc_14_target_112:
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [96]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00100000			; r0=rConstants[22] (16.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00018000			; r0=rConstants[7] (1.5000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_DONE [00]
proc_14_target_113:
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00001000			; r0=rConstants[1] (0.0625)
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x7c000000			; r0=rConstants[58] (31744.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_14_target_114
	; BC_CONST [bb]
	mov r0, #0x80000000			; r0=rConstants[59] (32768.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [17]
	beq proc_14_target_115
	; BC_RLOCAL [67]
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_14_target_115:
	; BC_DONE [00]
proc_14_target_114:
	; BC_CONST [8c]
	mov r0, #0x00058000			; r0=rConstants[12] (5.5000)
	; BC_WAIT [0a]
	adr r1, proc_14_continue_116
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
proc_14_continue_116:
	; BC_PROC [07]
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_14_target_111:
	; BC_ELSE [01]
	b proc_14_target_117
proc_14_target_109:
	; BC_CONST [8c]
	mov r0, #0x00058000			; r0=rConstants[12] (5.5000)
	; BC_WAIT [0a]
	adr r1, proc_14_continue_118
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
proc_14_continue_118:
	; BC_PROC [07]
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_14_target_117:
	; BC_DONE [00]
proc_14_target_108:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_14_end:

proc_15_start:
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_15_continue_119
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
proc_15_continue_119:
	; BC_CONST [96]
	mov r0, #0x00100000			; r0=rConstants[22] (16.0000)
	; BC_CONST [96]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00100000			; r0=rConstants[22] (16.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [98]
	mov r0, #0x00160000			; r0=rConstants[24] (22.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00002000			; r0=rConstants[2] (0.1250)
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
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[17] (10.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_SINE [0b]
	mov r1, #0xfffc
	and r0, r0, r1
	ldr r0, [r7, r0]			; r7=r_Sinus
	mov r0, r0, asl #2
	; BC_SINE [0b]
	mov r1, #0xfffc
	and r0, r0, r1
	ldr r0, [r7, r0]			; r7=r_Sinus
	mov r0, r0, asl #2
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_16_start		; r0=r_Procedures[16]
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
proc_15_end:

proc_16_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_16_target_120
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_16_continue_121
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
proc_16_continue_121:
	; BC_PROC [07]
	adr r0, proc_16_start		; r0=r_Procedures[16]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [42]
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_16_target_120:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_16_end:

proc_17_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_17_target_122
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1d]
	blt proc_17_target_123
	; BC_CONST [88]
	mov r0, #0x00020000			; r0=rConstants[8] (2.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8b]
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
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
	; BC_DONE [00]
proc_17_target_123:
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_17_continue_124
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
proc_17_continue_124:
	; BC_PROC [07]
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00001000			; r0=rConstants[1] (0.0625)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_17_target_122:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_17_end:

proc_18_start:
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_18_target_125
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000b0000			; r0=rConstants[18] (11.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[21] (15.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[9] (3.0000)
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	bic r1, r0, #0xff000000
	bic r1, r1, #0x00ff0000
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [68]
	ldr r0, [r5, #-9*4]			; r0=StateStack[-9]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	mov r0, r8, asr #16			; X
	mov r1, r9, asr #16			; Y
	mov r2, r10, asr #16		; RADIUS
	mov r9, r11, lsr #16		; TINT
	ldr r10, [r6, #-8]			; (plot_square_instruction)
	orr r10, r10, r2			; mov r1, #st_size
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl link_circle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [83]
	mov r0, #0x00004000			; r0=rConstants[3] (0.2500)
	; BC_WAIT [0a]
	adr r1, proc_18_continue_126
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
proc_18_continue_126:
	; BC_PROC [07]
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_CONST [83]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00004000			; r0=rConstants[3] (0.2500)
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_18_target_125:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_18_end:

proc_19_start:
	; BC_RLOCAL [65]
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_19_target_127
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_19_continue_128
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
proc_19_continue_128:
	; BC_PROC [07]
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [45]
	str r0, [r5, #-6*4]			; StateStack[-6]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_19_target_127:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_19_end:

proc_20_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_20_target_129
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	mov r0, r8, asr #16			; X
	mov r1, r9, asr #16			; Y
	mov r2, r10, asr #16		; RADIUS
	mov r9, r11, lsr #16		; TINT
	ldr r10, [r6, #-8]			; (plot_square_instruction)
	orr r10, r10, r2			; mov r1, #st_size
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl link_circle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_20_continue_130
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
proc_20_continue_130:
	; BC_PROC [07]
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [42]
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_20_target_129:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_20_end:

proc_21_start:
	; BC_RLOCAL [66]
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_21_target_131
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_CONST [9f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[31] (50.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [65]
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_WAIT [0a]
	adr r1, proc_21_continue_132
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
proc_21_continue_132:
	; BC_PROC [07]
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [46]
	str r0, [r5, #-7*4]			; StateStack[-7]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_21_target_131:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_21_end:

proc_22_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1d]
	blt proc_22_target_133
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [99]
	mov r0, #0x00180000			; r0=rConstants[25] (24.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	mov r0, r8, asr #16			; X
	mov r1, r9, asr #16			; Y
	mov r2, r10, asr #16		; RADIUS
	mov r9, r11, lsr #16		; TINT
	ldr r10, [r6, #-8]			; (plot_square_instruction)
	orr r10, r10, r2			; mov r1, #st_size
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl link_circle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_22_continue_134
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
proc_22_continue_134:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
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
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [42]
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
proc_22_target_133:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_22_end:

proc_23_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	; BC_CONST [9b]
	mov r0, #0x00200000			; r0=rConstants[27] (32.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_23_end:

proc_24_start:
	; BC_CONST [85]
	mov r0, #0x00010000			; r0=rConstants[5] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_24_target_135
	; BC_CONST [86]
	mov r0, #0x00016a00			; r0=rConstants[6] (1.4141)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_PROC [07]
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r2, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r2
	; BC_DONE [00]
proc_24_target_135:
	; BC_END [02]
	ldr r2, [r6, #-4]			; (r_FreeState)
	str r2, [r5]				; first word of state block points to prev free state.
	str r5, [r6, #-4]			; (r_FreeState) this state becomes the next free state.
	mov pc, lr					; Return.
proc_24_end:

proc_25_start:
	; BC_CONST [9c]
	mov r0, #0x00230000			; r0=rConstants[28] (35.0000)
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00230000			; r0=rConstants[28] (35.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00230000			; r0=rConstants[28] (35.0000)
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[33] (64.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00040000			; r0=rConstants[10] (4.0000)
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[11] (5.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
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
proc_25_end:


; ============================================================================
; Constants.
; ============================================================================

r_Constants:
.long 0x00000000				; [0] = 0.0000
.long 0x00001000				; [1] = 0.0625
.long 0x00002000				; [2] = 0.1250
.long 0x00004000				; [3] = 0.2500
.long 0x00008000				; [4] = 0.5000
.long 0x00010000				; [5] = 1.0000
.long 0x00016a00				; [6] = 1.4141
.long 0x00018000				; [7] = 1.5000
.long 0x00020000				; [8] = 2.0000
.long 0x00030000				; [9] = 3.0000
.long 0x00040000				; [10] = 4.0000
.long 0x00050000				; [11] = 5.0000
.long 0x00058000				; [12] = 5.5000
.long 0x00060000				; [13] = 6.0000
.long 0x00070000				; [14] = 7.0000
.long 0x00080000				; [15] = 8.0000
.long 0x00090000				; [16] = 9.0000
.long 0x000a0000				; [17] = 10.0000
.long 0x000b0000				; [18] = 11.0000
.long 0x000d0000				; [19] = 13.0000
.long 0x000e0000				; [20] = 14.0000
.long 0x000f0000				; [21] = 15.0000
.long 0x00100000				; [22] = 16.0000
.long 0x00140000				; [23] = 20.0000
.long 0x00160000				; [24] = 22.0000
.long 0x00180000				; [25] = 24.0000
.long 0x001e0000				; [26] = 30.0000
.long 0x00200000				; [27] = 32.0000
.long 0x00230000				; [28] = 35.0000
.long 0x00280000				; [29] = 40.0000
.long 0x002a0000				; [30] = 42.0000
.long 0x00320000				; [31] = 50.0000
.long 0x003c0000				; [32] = 60.0000
.long 0x00400000				; [33] = 64.0000
.long 0x00420000				; [34] = 66.0000
.long 0x00460000				; [35] = 70.0000
.long 0x004d0000				; [36] = 77.0000
.long 0x00580000				; [37] = 88.0000
.long 0x00630000				; [38] = 99.0000
.long 0x00640000				; [39] = 100.0000
.long 0x00780000				; [40] = 120.0000
.long 0x00800000				; [41] = 128.0000
.long 0x00a50000				; [42] = 165.0000
.long 0x00a70000				; [43] = 167.0000
.long 0x00a80000				; [44] = 168.0000
.long 0x00b00000				; [45] = 176.0000
.long 0x00b90000				; [46] = 185.0000
.long 0x00be0000				; [47] = 190.0000
.long 0x00c00000				; [48] = 192.0000
.long 0x00c80000				; [49] = 200.0000
.long 0x00d20000				; [50] = 210.0000
.long 0x00d60000				; [51] = 214.0000
.long 0x01090000				; [52] = 265.0000
.long 0x01130000				; [53] = 275.0000
.long 0x01360000				; [54] = 310.0000
.long 0x014a0000				; [55] = 330.0000
.long 0x01600000				; [56] = 352.0000
.long 0x01640000				; [57] = 356.0000
.long 0x7c000000				; [58] = 31744.0000
.long 0x80000000				; [59] = 32768.0000
.long 0x82082080				; [60] = 33288.1270
.long 0x82088208				; [61] = 33288.5079
.long 0x82089240				; [62] = 33288.5713
.long 0x82089260				; [63] = 33288.5718
.long 0x82089410				; [64] = 33288.5784
.long 0x8208b508				; [65] = 33288.7072
.long 0x8802f140				; [66] = 34818.9424
.long 0x002c0000				; [67] = 44.0000
.long 0x00120000				; [68] = 18.0000
.long 0x00210000				; [69] = 33.0000
.long 0x00370000				; [70] = 55.0000
.long 0x005f0000				; [71] = 95.0000
.long 0x00750000				; [72] = 117.0000

; ============================================================================
; Color Script.
; ============================================================================

r_ColorScript:
.long -1, 0x00334488, 0x013355cc, 0x022288ff, 0x03444433			; delta_frames=1 [0]
.long -308, 0x02ccccff			; delta_frames=308 [308]
.long -2, 0x022288ff			; delta_frames=2 [310]
.long -6, 0x02ccccff			; delta_frames=6 [316]
.long -2, 0x022288ff			; delta_frames=2 [318]
.long -6, 0x02ccccff			; delta_frames=6 [324]
.long -2, 0x022288ff			; delta_frames=2 [326]
.long -6, 0x02ccccff			; delta_frames=6 [332]
.long -2, 0x022288ff			; delta_frames=2 [334]
.long -359, 0x00550000			; delta_frames=359 [693]
.long -11, 0x01ff5555, 0x02ffaaaa			; delta_frames=11 [704]
.long -693, 0x00220022, 0x01660055, 0x02eeaacc			; delta_frames=693 [1397]
.long -704, 0x00000033, 0x013355cc, 0x022288ff			; delta_frames=704 [2101]
.long -33, 0x0388ccff			; delta_frames=33 [2134]
.long -66, 0x00000000			; delta_frames=66 [2200]
.long -11, 0x00000033			; delta_frames=11 [2211]
.long -77, 0x00000000			; delta_frames=77 [2288]
.long -11, 0x00000033			; delta_frames=11 [2299]
.long -77, 0x00000000			; delta_frames=77 [2376]
.long -11, 0x00000033			; delta_frames=11 [2387]
.long -55, 0x00333366			; delta_frames=55 [2442]
.long -5, 0x00000033			; delta_frames=5 [2447]
.long -6, 0x00333366			; delta_frames=6 [2453]
.long -5, 0x00000033			; delta_frames=5 [2458]
.long -6, 0x00000000			; delta_frames=6 [2464]
.long -11, 0x00330000, 0x01ff5555, 0x02ffaaaa, 0x03ffffaa			; delta_frames=11 [2475]
.long -77, 0x00000000			; delta_frames=77 [2552]
.long -11, 0x00330000			; delta_frames=11 [2563]
.long -77, 0x00000000			; delta_frames=77 [2640]
.long -11, 0x00330000			; delta_frames=11 [2651]
.long -77, 0x03444433			; delta_frames=77 [2728]
.long -55, 0x013355cc, 0x022288ff			; delta_frames=55 [2783]
.long -22, 0x00330033, 0x03662266			; delta_frames=22 [2805]
.long -33, 0x01ff5555, 0x02ffaaaa			; delta_frames=33 [2838]
.long -704, 0x013355cc, 0x022288ff			; delta_frames=704 [3542]
.long -609, 0x00330000			; delta_frames=609 [4151]
.long -117, 0x0388ccff			; delta_frames=117 [4268]
.long -286, 0x00663333			; delta_frames=286 [4554]
.long -5, 0x00330000			; delta_frames=5 [4559]
.long -6, 0x00663333			; delta_frames=6 [4565]
.long -5, 0x00330000, 0x01cc88cc, 0x02ccff22			; delta_frames=5 [4570]
.long -336, 0x00663333			; delta_frames=336 [4906]
.long -5, 0x00330000			; delta_frames=5 [4911]
.long -6, 0x00663333			; delta_frames=6 [4917]
.long -5, 0x00330000, 0x013355cc, 0x022288ff			; delta_frames=5 [4922]
.long -336, 0x00663333			; delta_frames=336 [5258]
.long -5, 0x00330000			; delta_frames=5 [5263]
.long -6, 0x00663333			; delta_frames=6 [5269]
.long -5, 0x00330000, 0x01cc88cc, 0x02ccff22			; delta_frames=5 [5274]
.long -248, 0x01ff5555			; delta_frames=248 [5522]
.long -88, 0x00663333			; delta_frames=88 [5610]
.long -5, 0x00330000			; delta_frames=5 [5615]
.long -6, 0x00663333			; delta_frames=6 [5621]
.long -5, 0x00330000, 0x013355cc, 0x022288ff			; delta_frames=5 [5626]
.long -710, 0x00ffffff, 0x03000000			; delta_frames=710 [6336]
.long -15, 0x00000000			; delta_frames=15 [6351]
.long 0x80000000	; END_SCRIPT.
