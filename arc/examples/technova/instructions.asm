; ============================================================================
; rose2arc.py
; input = examples/technova/bytecodes.bin.
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
	; BC_CONST [cd]
	mov r0, #0x00a00000			; r0=rConstants[77] (160.0000)
	; BC_WSTATE [5b]
	str r0, [r5, #ST_WIRE3*4]		; State[ST_WIRE3]=r0
	; BC_CONST [c8]
	mov r0, #0x005a0000			; r0=rConstants[72] (90.0000)
	; BC_WSTATE [5a]
	str r0, [r5, #ST_WIRE2*4]		; State[ST_WIRE2]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RSTATE [7a]
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_RSTATE [7b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE3*4]		; r0=State[ST_WIRE3]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_60_start		; r0=r_Procedures[60]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_0:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_1:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_2:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_76_start		; r0=r_Procedures[76]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_3:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_PROC [07]
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_4:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_5:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_PROC [07]
	adr r0, proc_64_start		; r0=r_Procedures[64]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_68_start		; r0=r_Procedures[68]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_6:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_7:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_8:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_9
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_9:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_PROC [07]
	adr r0, proc_36_start		; r0=r_Procedures[36]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_10
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_10:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_11
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_11:
	; BC_PROC [07]
	adr r0, proc_69_start		; r0=r_Procedures[69]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_102_start		; r0=r_Procedures[102]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_PROC [07]
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_12
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_12:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_13
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_13:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_75_start		; r0=r_Procedures[75]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_14
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_14:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_15
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_15:
	; BC_PROC [07]
	adr r0, proc_40_start		; r0=r_Procedures[40]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_16
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_16:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_17
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_17:
	; BC_PROC [07]
	adr r0, proc_47_start		; r0=r_Procedures[47]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_0_end:

proc_1_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RSTATE [7a]
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_RSTATE [7b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE3*4]		; r0=State[ST_WIRE3]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [e1]
	ldr r0, [r4, #97*4]			; r0=rConstants[97]=0x05390000 (1337.0000)
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
	; BC_CONST [ad]
	mov r0, #0x000b0000			; r0=rConstants[45] (11.0000)
	; BC_WSTATE [59]
	str r0, [r5, #ST_WIRE1*4]		; State[ST_WIRE1]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c7]
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_18
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_18:
	; BC_CONST [df]
	mov r0, #0x045c0000			; r0=rConstants[95] (1116.0000)
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
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c7]
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_19
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_19:
	; BC_CONST [db]
	mov r0, #0x029a0000			; r0=rConstants[91] (666.0000)
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
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c7]
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_20
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_20:
	; BC_CONST [d7]
	mov r0, #0x01d90000			; r0=rConstants[87] (473.0000)
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
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c7]
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_21
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_21:
	; BC_CONST [da]
	ldr r0, [r4, #90*4]			; r0=rConstants[90]=0x022b0000 (555.0000)
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
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c7]
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_22
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_22:
	; BC_CONST [d8]
	mov r0, #0x01da0000			; r0=rConstants[88] (474.0000)
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
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c7]
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_23
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_23:
	; BC_CONST [e8]
	ldr r0, [r4, #104*4]			; r0=rConstants[104]=0x09130000 (2323.0000)
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
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c7]
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_1_continue_24
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_24:
	; BC_CONST [da]
	ldr r0, [r4, #90*4]			; r0=rConstants[90]=0x022b0000 (555.0000)
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
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_1_end:

proc_2_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_2_target_25
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_2_target_26
	; BC_PROC [07]
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [af]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[47] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_WSTATE [59]
	str r0, [r5, #ST_WIRE1*4]		; State[ST_WIRE1]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_2_continue_27
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_27:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_ELSE [01]
	b proc_2_target_28
proc_2_target_26:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_2_target_28:
	; BC_DONE [00]
proc_2_target_25:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_2_target_29
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_2_target_30
	; BC_PROC [07]
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [af]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[47] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x007f0000			; r0=rConstants[73] (127.0000)
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
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
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_2_continue_31
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_31:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_ELSE [01]
	b proc_2_target_32
proc_2_target_30:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_2_target_32:
	; BC_DONE [00]
proc_2_target_29:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_2_target_33
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_2_target_34
	; BC_PROC [07]
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [af]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000d0000			; r0=rConstants[47] (13.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
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
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [59]
	str r0, [r5, #ST_WIRE1*4]		; State[ST_WIRE1]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_2_continue_35
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_35:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_ELSE [01]
	b proc_2_target_36
proc_2_target_34:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_2_target_36:
	; BC_DONE [00]
proc_2_target_33:
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_2_target_37
	; BC_CONST [ab]
	mov r0, #0x00090000			; r0=rConstants[43] (9.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_2_target_38
	; BC_PROC [07]
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_2_continue_39
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_39:
	; BC_PROC [07]
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_2_target_40
proc_2_target_38:
	; BC_PROC [07]
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [42]
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_2_target_40:
	; BC_DONE [00]
proc_2_target_37:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_2_end:

proc_3_start:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c4]
	mov r0, #0x00460000			; r0=rConstants[68] (70.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RSTATE [7a]
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_RSTATE [7b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE3*4]		; r0=State[ST_WIRE3]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_3_end:

proc_4_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_4_target_41
	; BC_RSTATE [79]
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
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
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
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
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_CONST [b3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [d2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00ff0000			; r0=rConstants[82] (255.0000)
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_4_continue_42
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_42:
	; BC_PROC [07]
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_4_target_41:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_4_end:

proc_5_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
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
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
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
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_5_end:

proc_6_start:
	; BC_CONST [cc]
	mov r0, #0x00960000			; r0=rConstants[76] (150.0000)
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	mov r0, #0x00110000			; r0=rConstants[50] (17.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_6_continue_43
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_6_continue_43:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	mov r0, #0x00110000			; r0=rConstants[50] (17.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_6_end:

proc_7_start:
	; BC_CONST [ac]
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_CONST [d6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x014a0000			; r0=rConstants[86] (330.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	mov r0, #0x00110000			; r0=rConstants[50] (17.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_7_continue_44
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_7_continue_44:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	mov r0, #0x00110000			; r0=rConstants[50] (17.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_7_end:

proc_8_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_8_target_45
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [b2]
	mov r0, #0x00110000			; r0=rConstants[50] (17.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_8_continue_46
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_8_continue_46:
	; BC_PROC [07]
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_8_target_45:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_8_end:

proc_9_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_9_target_47
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [95]
	mov r0, #0x00008000			; r0=rConstants[21] (0.5000)
	; BC_WAIT [0a]
	adr r1, proc_9_continue_48
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_9_continue_48:
	; BC_PROC [07]
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_9_target_47:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_9_end:

proc_10_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_10_target_49
	; BC_CONST [e1]
	ldr r0, [r4, #97*4]			; r0=rConstants[97]=0x05390000 (1337.0000)
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
	adr r0, proc_6_start		; r0=r_Procedures[6]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_50
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_50:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_51
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_51:
	; BC_PROC [07]
	adr r0, proc_12_start		; r0=r_Procedures[12]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_52
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_52:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_53
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_53:
	; BC_PROC [07]
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_54
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_54:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_55
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_55:
	; BC_PROC [07]
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_56
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_56:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_10_continue_57
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_57:
	; BC_PROC [07]
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_10_target_49:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_10_end:

proc_11_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_11_target_58
	; BC_CONST [e1]
	ldr r0, [r4, #97*4]			; r0=rConstants[97]=0x05390000 (1337.0000)
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
	adr r0, proc_12_start		; r0=r_Procedures[12]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_11_continue_59
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_59:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_11_continue_60
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_60:
	; BC_PROC [07]
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_11_continue_61
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_61:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_11_continue_62
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_62:
	; BC_PROC [07]
	adr r0, proc_12_start		; r0=r_Procedures[12]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_11_continue_63
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_63:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_11_continue_64
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_64:
	; BC_PROC [07]
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_11_continue_65
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_65:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_11_continue_66
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_66:
	; BC_PROC [07]
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_11_target_58:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_11_end:

proc_12_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b2]
	mov r0, #0x00110000			; r0=rConstants[50] (17.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_12_continue_67
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_67:
	; BC_CONST [bc]
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_12_end:

proc_13_start:
	; BC_CONST [cf]
	mov r0, #0x00b40000			; r0=rConstants[79] (180.0000)
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_CONST [d5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01400000			; r0=rConstants[85] (320.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b2]
	mov r0, #0x00110000			; r0=rConstants[50] (17.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_13_continue_68
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_13_continue_68:
	; BC_CONST [bc]
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_13_end:

proc_14_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_14_target_69
	; BC_CONST [fe]
	ldr r0, [r4, #177*4]			; r0=rConstants[177]=0xffff0000 (65535.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
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
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_CONST [a2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
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
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
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
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_14_target_70
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_14_target_70:
	; BC_CONST [ac]
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
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
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [ad]
	mov r0, #0x000b0000			; r0=rConstants[45] (11.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a0]
	ldr r0, [r4, #32*4]			; r0=rConstants[32]=0x00013333 (1.2000)
	; BC_WAIT [0a]
	adr r1, proc_14_continue_71
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_14_continue_71:
	; BC_PROC [07]
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_14_target_69:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_14_end:

proc_15_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_15_target_72
	; BC_CONST [fe]
	ldr r0, [r4, #177*4]			; r0=rConstants[177]=0xffff0000 (65535.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
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
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_CONST [a2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
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
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
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
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
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
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [ad]
	mov r0, #0x000b0000			; r0=rConstants[45] (11.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a0]
	ldr r0, [r4, #32*4]			; r0=rConstants[32]=0x00013333 (1.2000)
	; BC_WAIT [0a]
	adr r1, proc_15_continue_73
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_73:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_15_target_72:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_15_end:

proc_16_start:
	; BC_CONST [bc]
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_CONST [d4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01180000			; r0=rConstants[84] (280.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b0]
	mov r0, #0x000f0000			; r0=rConstants[48] (15.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_16_end:

proc_17_start:
	; BC_CONST [97]
	ldr r0, [r4, #23*4]			; r0=rConstants[23]=0x00009999 (0.6000)
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
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]=0x00004ccc (0.3000)
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
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_17_target_74
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_17_target_74:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_17_target_75
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_17_target_75:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_17_target_76
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_17_target_76:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_17_end:

proc_18_start:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_18_end:

proc_19_start:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_19_end:

proc_20_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_20_target_77
	; BC_CONST [bf]
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [d3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x010e0000			; r0=rConstants[83] (270.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_20_continue_78
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_78:
	; BC_CONST [cb]
	mov r0, #0x00820000			; r0=rConstants[75] (130.0000)
	; BC_CONST [d3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x010e0000			; r0=rConstants[83] (270.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_20_continue_79
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_79:
	; BC_CONST [cb]
	mov r0, #0x00820000			; r0=rConstants[75] (130.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_20_continue_80
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_80:
	; BC_CONST [bf]
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_20_target_81
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_20_continue_82
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_82:
	; BC_ELSE [01]
	b proc_20_target_83
proc_20_target_81:
	; BC_RSTATE [7a]
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_RSTATE [7b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE3*4]		; r0=State[ST_WIRE3]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WAIT [0a]
	adr r1, proc_20_continue_84
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_84:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_20_continue_85
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_85:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_20_continue_86
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_86:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_20_continue_87
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_87:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_20_continue_88
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_88:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_20_target_83:
	; BC_PROC [07]
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_20_target_77:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_20_end:

proc_21_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_21_target_89
	; BC_CONST [bf]
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [d3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x010e0000			; r0=rConstants[83] (270.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_90
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_90:
	; BC_CONST [cb]
	mov r0, #0x00820000			; r0=rConstants[75] (130.0000)
	; BC_CONST [d3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x010e0000			; r0=rConstants[83] (270.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_91
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_91:
	; BC_CONST [cb]
	mov r0, #0x00820000			; r0=rConstants[75] (130.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_92
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_92:
	; BC_CONST [bf]
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_93
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_93:
	; BC_PROC [07]
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_21_target_89:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_21_end:

proc_22_start:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WAIT [0a]
	adr r1, proc_22_continue_94
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_94:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_22_continue_95
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_95:
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WAIT [0a]
	adr r1, proc_22_continue_96
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_96:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_22_continue_97
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_97:
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WAIT [0a]
	adr r1, proc_22_continue_98
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_98:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_22_continue_99
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_99:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WAIT [0a]
	adr r1, proc_22_continue_100
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_100:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_22_continue_101
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_101:
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_22_end:

proc_23_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_23_target_102
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_23_continue_103
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_103:
	; BC_PROC [07]
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]=0x0000e666 (0.9000)
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
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_23_target_102:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_23_end:

proc_24_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_24_target_104
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_24_continue_105
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_105:
	; BC_PROC [07]
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]=0x0000e666 (0.9000)
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
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_24_target_104:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_24_end:

proc_25_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [98]
	ldr r0, [r4, #24*4]			; r0=rConstants[24]=0x0000a8f5 (0.6600)
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
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]=0x0000547a (0.3300)
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
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_25_end:

proc_26_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [98]
	ldr r0, [r4, #24*4]			; r0=rConstants[24]=0x0000a8f5 (0.6600)
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
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]=0x0000547a (0.3300)
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
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_26_end:

proc_27_start:
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00190000			; r0=rConstants[56] (25.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00004000			; r0=rConstants[16] (0.2500)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_106
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_106:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00190000			; r0=rConstants[56] (25.0000)
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000083			; r0=rConstants[2] (0.0020)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_107
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_107:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00190000			; r0=rConstants[56] (25.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00004000			; r0=rConstants[16] (0.2500)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_108
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_108:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000312			; r0=rConstants[8] (0.0120)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_109
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_109:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00180000			; r0=rConstants[55] (24.0000)
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]=0x00003333 (0.2000)
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]=0x0000b333 (0.7000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000041			; r0=rConstants[1] (0.0010)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_30_start		; r0=r_Procedures[30]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_110
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_110:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00180000			; r0=rConstants[55] (24.0000)
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000083			; r0=rConstants[2] (0.0020)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_111
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_111:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00004000			; r0=rConstants[16] (0.2500)
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]=0x00001999 (0.1000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #9*4]			; r0=rConstants[9]=0x00000353 (0.0130)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_112
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_112:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00190000			; r0=rConstants[56] (25.0000)
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000083			; r0=rConstants[2] (0.0020)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_113
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_113:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00190000			; r0=rConstants[56] (25.0000)
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00008000			; r0=rConstants[21] (0.5000)
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]=0x00001999 (0.1000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_30_start		; r0=r_Procedures[30]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_114
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_114:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00170000			; r0=rConstants[54] (23.0000)
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000083			; r0=rConstants[2] (0.0020)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_115
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_115:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00190000			; r0=rConstants[56] (25.0000)
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00004000			; r0=rConstants[16] (0.2500)
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]=0x00001999 (0.1000)
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]=0x0000028f (0.0100)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_116
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_116:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00190000			; r0=rConstants[56] (25.0000)
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000041			; r0=rConstants[1] (0.0010)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [84]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000001ca			; r0=rConstants[4] (0.0070)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_117
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_117:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00190000			; r0=rConstants[56] (25.0000)
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]=0x00001999 (0.1000)
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]=0x00001999 (0.1000)
	; BC_CONST [83]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000189			; r0=rConstants[3] (0.0060)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x0000020c			; r0=rConstants[5] (0.0080)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_118
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_118:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00170000			; r0=rConstants[54] (23.0000)
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]=0x00000395 (0.0140)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [84]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000001ca			; r0=rConstants[4] (0.0070)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_119
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_119:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00170000			; r0=rConstants[54] (23.0000)
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]=0x00003333 (0.2000)
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]=0x00003333 (0.2000)
	; BC_CONST [84]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000001ca			; r0=rConstants[4] (0.0070)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000083			; r0=rConstants[2] (0.0020)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_30_start		; r0=r_Procedures[30]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_120
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_120:
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00190000			; r0=rConstants[56] (25.0000)
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_CONST [84]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000001ca			; r0=rConstants[4] (0.0070)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [84]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000001ca			; r0=rConstants[4] (0.0070)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_27_continue_121
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_121:
	; BC_PROC [07]
	adr r0, proc_31_start		; r0=r_Procedures[31]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_27_end:

proc_28_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_28_target_122
	; BC_PROC [07]
	adr r0, proc_31_start		; r0=r_Procedures[31]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_28_continue_123
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_28_continue_123:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1d]
	blt proc_28_target_124
	; BC_PROC [07]
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WLOCAL [42]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_28_target_125
proc_28_target_124:
	; BC_PROC [07]
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]=0x0000e666 (0.9000)
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
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WLOCAL [42]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_28_target_125:
	; BC_DONE [00]
proc_28_target_122:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_28_end:

proc_29_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_29_target_126
	; BC_PROC [07]
	adr r0, proc_31_start		; r0=r_Procedures[31]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_29_continue_127
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_29_continue_127:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1d]
	blt proc_29_target_128
	; BC_PROC [07]
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WLOCAL [42]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_29_target_129
proc_29_target_128:
	; BC_PROC [07]
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]=0x0000e666 (0.9000)
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
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WLOCAL [42]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_29_target_129:
	; BC_DONE [00]
proc_29_target_126:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_29_end:

proc_30_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_30_target_130
	; BC_PROC [07]
	adr r0, proc_31_start		; r0=r_Procedures[31]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [26]
	mov r1, #6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_30_continue_131
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_30_continue_131:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1d]
	blt proc_30_target_132
	; BC_PROC [07]
	adr r0, proc_30_start		; r0=r_Procedures[30]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WLOCAL [42]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_30_target_133
proc_30_target_132:
	; BC_PROC [07]
	adr r0, proc_30_start		; r0=r_Procedures[30]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]=0x0000e666 (0.9000)
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
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]=0x0000ffff (1.0000)
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WLOCAL [42]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_30_target_133:
	; BC_DONE [00]
proc_30_target_130:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_30_end:

proc_31_start:
	; BC_RSTATE [7a]
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_RSTATE [7b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE3*4]		; r0=State[ST_WIRE3]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c4]
	mov r0, #0x00460000			; r0=rConstants[68] (70.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_31_end:

proc_32_start:
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_SINE [0b]
	mov r1, #0xfffc
	and r0, r0, r1
	ldr r0, [r7, r0]			; r7=r_Sinus
	mov r0, r0, asl #2
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00004000			; r0=rConstants[16] (0.2500)
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_SINE [0b]
	mov r1, #0xfffc
	and r0, r0, r1
	ldr r0, [r7, r0]			; r7=r_Sinus
	mov r0, r0, asl #2
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
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
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
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
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
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
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
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
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_RLOCAL [68]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-9*4]			; r0=StateStack[-9]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_WLOCAL [42]
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WLOCAL [41]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
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
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_32_end:

proc_33_start:
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_SINE [0b]
	mov r1, #0xfffc
	and r0, r0, r1
	ldr r0, [r7, r0]			; r7=r_Sinus
	mov r0, r0, asl #2
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00004000			; r0=rConstants[16] (0.2500)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_SINE [0b]
	mov r1, #0xfffc
	and r0, r0, r1
	ldr r0, [r7, r0]			; r7=r_Sinus
	mov r0, r0, asl #2
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
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
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
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
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
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
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
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
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_34_start		; r0=r_Procedures[34]
	; BC_RLOCAL [68]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-9*4]			; r0=StateStack[-9]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_WLOCAL [42]
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
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
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_33_end:

proc_34_start:
	; BC_CONST [c8]
	mov r0, #0x005a0000			; r0=rConstants[72] (90.0000)
	; BC_CONST [c8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x005a0000			; r0=rConstants[72] (90.0000)
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
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
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_35_start		; r0=r_Procedures[35]
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_34_end:

proc_35_start:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [a2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_35_target_134
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_ELSE [01]
	b proc_35_target_135
proc_35_target_134:
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DONE [00]
proc_35_target_135:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RSTATE [7a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [7b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE3*4]		; r0=State[ST_WIRE3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_35_end:

proc_36_start:
	; BC_PROC [07]
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	mov r0, #0x000f0000			; r0=rConstants[48] (15.0000)
	; BC_WSTATE [59]
	str r0, [r5, #ST_WIRE1*4]		; State[ST_WIRE1]=r0
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_CONST [ca]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [ad]
	mov r0, #0x000b0000			; r0=rConstants[45] (11.0000)
	; BC_WAIT [0a]
	adr r1, proc_36_continue_136
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_36_continue_136:
	; BC_CONST [ba]
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_37_start		; r0=r_Procedures[37]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_36_end:

proc_37_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_37_target_137
	; BC_PROC [07]
	adr r0, proc_38_start		; r0=r_Procedures[38]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ba]
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_38_start		; r0=r_Procedures[38]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ba]
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_38_start		; r0=r_Procedures[38]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ba]
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
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
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_37_continue_138
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_37_continue_138:
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_37_start		; r0=r_Procedures[37]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_37_target_137:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_37_end:

proc_38_start:
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_39_start		; r0=r_Procedures[39]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_38_continue_139
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_38_continue_139:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_39_start		; r0=r_Procedures[39]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WAIT [0a]
	adr r1, proc_38_continue_140
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_38_continue_140:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_39_start		; r0=r_Procedures[39]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WAIT [0a]
	adr r1, proc_38_continue_141
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_38_continue_141:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_39_start		; r0=r_Procedures[39]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_38_end:

proc_39_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1e]
	bgt proc_39_target_142
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_39_target_143
	; BC_RSTATE [79]
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_ELSE [01]
	b proc_39_target_144
proc_39_target_143:
	; BC_RSTATE [79]
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DONE [00]
proc_39_target_144:
	; BC_DRAW [04]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a0]
	ldr r0, [r4, #32*4]			; r0=rConstants[32]=0x00013333 (1.2000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]=0x00004ccc (0.3000)
	; BC_WAIT [0a]
	adr r1, proc_39_continue_145
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_39_continue_145:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_39_target_146
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_ELSE [01]
	b proc_39_target_147
proc_39_target_146:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_DONE [00]
proc_39_target_147:
	; BC_PROC [07]
	adr r0, proc_39_start		; r0=r_Procedures[39]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_39_target_142:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_39_end:

proc_40_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [5a]
	str r0, [r5, #ST_WIRE2*4]		; State[ST_WIRE2]=r0
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WSTATE [59]
	str r0, [r5, #ST_WIRE1*4]		; State[ST_WIRE1]=r0
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_40_continue_148
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_148:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_40_continue_149
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_149:
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [5a]
	str r0, [r5, #ST_WIRE2*4]		; State[ST_WIRE2]=r0
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WSTATE [59]
	str r0, [r5, #ST_WIRE1*4]		; State[ST_WIRE1]=r0
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [ba]
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [ab]
	mov r0, #0x00090000			; r0=rConstants[43] (9.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_40_end:

proc_41_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_41_target_150
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	mov r0, #0x002c0000			; r0=rConstants[62] (44.0000)
	; BC_WAIT [0a]
	adr r1, proc_41_continue_151
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_41_continue_151:
	; BC_PROC [07]
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_41_target_150:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_41_end:

proc_42_start:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [bc]
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_42_end:

proc_43_start:
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [ba]
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WAIT [0a]
	adr r1, proc_43_continue_152
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_43_continue_152:
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WAIT [0a]
	adr r1, proc_43_continue_153
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_43_continue_153:
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WAIT [0a]
	adr r1, proc_43_continue_154
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_43_continue_154:
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WAIT [0a]
	adr r1, proc_43_continue_155
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_43_continue_155:
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WAIT [0a]
	adr r1, proc_43_continue_156
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_43_continue_156:
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [65]
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WAIT [0a]
	adr r1, proc_43_continue_157
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_43_continue_157:
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [66]
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WAIT [0a]
	adr r1, proc_43_continue_158
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_43_continue_158:
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_43_end:

proc_44_start:
	; BC_CONST [b1]
	mov r0, #0x00100000			; r0=rConstants[49] (16.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_44_target_159
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [c3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_DONE [00]
proc_44_target_159:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_44_target_160
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WHEN [17]
	beq proc_44_target_161
	; BC_PROC [07]
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_44_target_161:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [90]
	mov r0, #0x00004000			; r0=rConstants[16] (0.2500)
	; BC_WAIT [0a]
	adr r1, proc_44_continue_162
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_44_continue_162:
	; BC_PROC [07]
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [33]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, lsr #16			; swap.w r1
	and r1, r1, #63				; only bottom 6 bits are valid.
	movs r0, r0, ror r1			; r0=r0 ror r1
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_44_target_160:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_44_end:

proc_45_start:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RSTATE [79]
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_WAIT [0a]
	adr r1, proc_45_continue_163
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_45_continue_163:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [7a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_45_target_164
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_45_continue_165
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_45_continue_165:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_45_continue_166
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_45_continue_166:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_45_target_164:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_45_end:

proc_46_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_46_target_167
	; BC_CONST [dc]
	ldr r0, [r4, #92*4]			; r0=rConstants[92]=0x03800fe0 (896.0620)
	; BC_CONST [f8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #120*4]			; r0=rConstants[120]=0x1ff00fe0 (8176.0620)
	; BC_CONST [e4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x07c00000			; r0=rConstants[100] (1984.0000)
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000380			; r0=rConstants[10] (0.0137)
	; BC_CONST [fd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #125*4]			; r0=rConstants[125]=0x2388638c (9096.3889)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #170*4]			; r0=rConstants[170]=0xf01ef83e (61470.9697)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #173*4]			; r0=rConstants[173]=0xfc7e7c7c (64638.4863)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #128*4]			; r0=rConstants[128]=0x38381010 (14392.0627)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_46_target_167:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_46_target_168
	; BC_CONST [ed]
	ldr r0, [r4, #109*4]			; r0=rConstants[109]=0x0ff01008 (4080.0626)
	; BC_CONST [fb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #123*4]			; r0=rConstants[123]=0x20044002 (8196.2500)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #139*4]			; r0=rConstants[139]=0x80018001 (32769.5000)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #161*4]			; r0=rConstants[161]=0x9ff99ff9 (40953.6249)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #160*4]			; r0=rConstants[160]=0x9ff98001 (40953.5000)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #138*4]			; r0=rConstants[138]=0x80014002 (32769.2500)
	; BC_CONST [fa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #122*4]			; r0=rConstants[122]=0x20041008 (8196.0626)
	; BC_CONST [ec]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x0ff00000			; r0=rConstants[108] (4080.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_46_target_168:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_46_target_169
	; BC_CONST [ee]
	ldr r0, [r4, #110*4]			; r0=rConstants[110]=0x0ff01f08 (4080.1212)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #131*4]			; r0=rConstants[131]=0x3f047f02 (16132.4961)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #174*4]			; r0=rConstants[174]=0xff01ff01 (65281.9961)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #175*4]			; r0=rConstants[175]=0xff01ffff (65282.0000)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #144*4]			; r0=rConstants[144]=0x80ff80ff (33023.5039)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #143*4]			; r0=rConstants[143]=0x80ff40fe (33023.2539)
	; BC_CONST [fc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #124*4]			; r0=rConstants[124]=0x20fc10f8 (8444.0663)
	; BC_CONST [ec]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x0ff00000			; r0=rConstants[108] (4080.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_46_target_169:
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_46_target_170
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [e9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #105*4]			; r0=rConstants[105]=0x0c3003c0 (3120.0146)
	; BC_CONST [f9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #121*4]			; r0=rConstants[121]=0x1ff83ffc (8184.2499)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #129*4]			; r0=rConstants[129]=0x399c3ffc (14748.2499)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #132*4]			; r0=rConstants[132]=0x3ffc0c30 (16380.0476)
	; BC_CONST [ea]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #106*4]			; r0=rConstants[106]=0x0c301bd8 (3120.1088)
	; BC_CONST [f6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #118*4]			; r0=rConstants[118]=0x19986006 (6552.3751)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #136*4]			; r0=rConstants[136]=0x60060000 (24582.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_46_target_170:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_46_target_171
	; BC_CONST [8c]
	mov r0, #0x000006c0			; r0=rConstants[12] (0.0264)
	; BC_CONST [e7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #103*4]			; r0=rConstants[103]=0x08201010 (2080.0627)
	; BC_CONST [ef]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #111*4]			; r0=rConstants[111]=0x10101bb0 (4112.1082)
	; BC_CONST [f3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #115*4]			; r0=rConstants[115]=0x18300c60 (6192.0483)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #130*4]			; r0=rConstants[130]=0x3ef87c7c (16120.4863)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #167*4]			; r0=rConstants[167]=0xc2c69392 (49862.5764)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #155*4]			; r0=rConstants[155]=0x8ba28382 (35746.5137)
	; BC_CONST [e2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #98*4]			; r0=rConstants[98]=0x06c03c78 (1728.2362)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_46_target_171:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_46_target_172
	; BC_CONST [dd]
	ldr r0, [r4, #93*4]			; r0=rConstants[93]=0x0380c383 (896.7637)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #146*4]			; r0=rConstants[146]=0x81c181c1 (33217.5069)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #142*4]			; r0=rConstants[142]=0x80e18061 (32993.5015)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #157*4]			; r0=rConstants[157]=0x8ff18ff1 (36849.5623)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #156*4]			; r0=rConstants[156]=0x8e018701 (36353.5274)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #154*4]			; r0=rConstants[154]=0x838181c1 (33665.5069)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #141*4]			; r0=rConstants[141]=0x80c18061 (32961.5015)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #165*4]			; r0=rConstants[165]=0xc0230010 (49187.0002)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_46_target_172:
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_46_target_173
	; BC_CONST [de]
	ldr r0, [r4, #94*4]			; r0=rConstants[94]=0x038702bd (903.0107)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #168*4]			; r0=rConstants[168]=0xe3a7b920 (58279.7231)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #169*4]			; r0=rConstants[169]=0xeffc0044 (61436.0010)
	; BC_CONST [e6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #102*4]			; r0=rConstants[102]=0x07cee44a (1998.8918)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #163*4]			; r0=rConstants[163]=0xbceee4a0 (48366.8931)
	; BC_CONST [e0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #96*4]			; r0=rConstants[96]=0x04e00400 (1248.0156)
	; BC_CONST [e3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #99*4]			; r0=rConstants[99]=0x0787e2fd (1927.8867)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #164*4]			; r0=rConstants[164]=0xbe07e000 (48647.8750)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_46_target_173:
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_46_target_174
	; BC_CONST [8a]
	mov r0, #0x00000380			; r0=rConstants[10] (0.0137)
	; BC_CONST [e5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #101*4]			; r0=rConstants[101]=0x07c006c0 (1984.0264)
	; BC_CONST [eb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #107*4]			; r0=rConstants[107]=0x0c600d60 (3168.0522)
	; BC_CONST [f5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #117*4]			; r0=rConstants[117]=0x19301930 (6448.0984)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #127*4]			; r0=rConstants[127]=0x31183118 (12568.1918)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #137*4]			; r0=rConstants[137]=0x610c600c (24844.3752)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #166*4]			; r0=rConstants[166]=0xc106c006 (49414.7501)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #176*4]			; r0=rConstants[176]=0xfffe7ffc (65534.4999)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_46_target_174:
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_46_target_175
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]=0x00007cfe (0.4883)
	; BC_CONST [86]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000210			; r0=rConstants[6] (0.0081)
	; BC_CONST [f7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #119*4]			; r0=rConstants[119]=0x1e100210 (7696.0081)
	; BC_CONST [d9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #89*4]			; r0=rConstants[89]=0x02107c10 (528.4846)
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #19*4]			; r0=rConstants[19]=0x00007c82 (0.4864)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #140*4]			; r0=rConstants[140]=0x8086828a (32902.5099)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #153*4]			; r0=rConstants[153]=0x829282a2 (33426.5103)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #152*4]			; r0=rConstants[152]=0x82827c82 (33410.4864)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_46_target_175:
	; BC_CONST [ab]
	mov r0, #0x00090000			; r0=rConstants[43] (9.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_46_target_176
	; BC_CONST [96]
	ldr r0, [r4, #22*4]			; r0=rConstants[22]=0x0000827c (0.5097)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #147*4]			; r0=rConstants[147]=0x82008202 (33280.5078)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #172*4]			; r0=rConstants[172]=0xfa028202 (64002.5078)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #148*4]			; r0=rConstants[148]=0x8202827c (33282.5097)
	; BC_CONST [8d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #13*4]			; r0=rConstants[13]=0x00001082 (0.0645)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #126*4]			; r0=rConstants[126]=0x28822844 (10370.1573)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #134*4]			; r0=rConstants[134]=0x44444428 (17476.2662)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #150*4]			; r0=rConstants[150]=0x82288210 (33320.5081)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_46_target_176:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_46_end:

proc_47_start:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [5a]
	str r0, [r5, #ST_WIRE2*4]		; State[ST_WIRE2]=r0
	; BC_PROC [07]
	adr r0, proc_53_start		; r0=r_Procedures[53]
	; BC_WSTATE [59]
	str r0, [r5, #ST_WIRE1*4]		; State[ST_WIRE1]=r0
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [bb]
	mov r0, #0x00230000			; r0=rConstants[59] (35.0000)
	; BC_CONST [c6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00560000			; r0=rConstants[70] (86.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_47_continue_177
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_47_continue_177:
	; BC_CONST [fe]
	ldr r0, [r4, #151*4]			; r0=rConstants[151]=0x823f3f20 (33343.2466)
	; BC_CONST [f4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #116*4]			; r0=rConstants[116]=0x185e1e86 (6238.1192)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #158*4]			; r0=rConstants[158]=0x927f0104 (37503.0040)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #158*4]			; r0=rConstants[158]=0x927f0104 (37503.0040)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #133*4]			; r0=rConstants[133]=0x40bf3f08 (16575.2462)
	; BC_CONST [f2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #114*4]			; r0=rConstants[114]=0x14bc3c49 (5308.2355)
	; BC_CONST [f0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #112*4]			; r0=rConstants[112]=0x107e3c08 (4222.2345)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_50_start		; r0=r_Procedures[50]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_47_continue_178
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_47_continue_178:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #159*4]			; r0=rConstants[159]=0x9a6e19a6 (39534.1002)
	; BC_CONST [f1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #113*4]			; r0=rConstants[113]=0x147f1c49 (5247.1105)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #171*4]			; r0=rConstants[171]=0xf8602087 (63584.1271)
	; BC_CONST [f0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #112*4]			; r0=rConstants[112]=0x107e3c08 (4222.2345)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #149*4]			; r0=rConstants[149]=0x82071fa2 (33287.1236)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_50_start		; r0=r_Procedures[50]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_47_continue_179
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_47_continue_179:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [c0]
	mov r0, #0x00370000			; r0=rConstants[64] (55.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c2]
	mov r0, #0x003d0000			; r0=rConstants[66] (61.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_48_start		; r0=r_Procedures[48]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_47_continue_180
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_47_continue_180:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WAIT [0a]
	adr r1, proc_47_continue_181
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_47_continue_181:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c2]
	mov r0, #0x003d0000			; r0=rConstants[66] (61.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_48_start		; r0=r_Procedures[48]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_47_end:

proc_48_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_48_target_182
	; BC_CONST [9b]
	ldr r0, [r4, #27*4]			; r0=rConstants[27]=0x0000cccc (0.8000)
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
	; BC_CONST [a2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
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
	; BC_WAIT [0a]
	adr r1, proc_48_continue_183
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_48_continue_183:
	; BC_PROC [07]
	adr r0, proc_48_start		; r0=r_Procedures[48]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_48_target_182:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_48_end:

proc_49_start:
	; BC_CONST [d1]
	mov r0, #0x00e10000			; r0=rConstants[81] (225.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_184
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_185
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_185:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_49_target_184:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_49_end:

proc_50_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_52_start		; r0=r_Procedures[52]
	; BC_FORK [2b]
	mov r1, #11
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_50_continue_186
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_50_continue_186:
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_CONST [ce]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00aa0000			; r0=rConstants[78] (170.0000)
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_50_end:

proc_51_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_51_target_187
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [bf]
	mov r0, #0x00320000			; r0=rConstants[63] (50.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c5]
	mov r0, #0x00500000			; r0=rConstants[69] (80.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c5]
	mov r0, #0x00500000			; r0=rConstants[69] (80.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c5]
	mov r0, #0x00500000			; r0=rConstants[69] (80.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [c5]
	mov r0, #0x00500000			; r0=rConstants[69] (80.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_51_continue_188
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_51_continue_188:
	; BC_PROC [07]
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_51_target_187:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_51_end:

proc_52_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_RLOCAL [6a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-11*4]			; r0=StateStack[-11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_52_continue_189
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_52_continue_189:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_RLOCAL [6a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-11*4]			; r0=StateStack[-11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_52_continue_190
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_52_continue_190:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_RLOCAL [6a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-11*4]			; r0=StateStack[-11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_52_continue_191
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_52_continue_191:
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_RLOCAL [6a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-11*4]			; r0=StateStack[-11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_52_continue_192
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_52_continue_192:
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_RLOCAL [6a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-11*4]			; r0=StateStack[-11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_52_continue_193
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_52_continue_193:
	; BC_RLOCAL [65]
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_RLOCAL [6a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-11*4]			; r0=StateStack[-11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_52_continue_194
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_52_continue_194:
	; BC_RLOCAL [66]
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_RLOCAL [6a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-11*4]			; r0=StateStack[-11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_52_continue_195
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_52_continue_195:
	; BC_RLOCAL [67]
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_RLOCAL [6a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-11*4]			; r0=StateStack[-11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_52_continue_196
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_52_continue_196:
	; BC_RLOCAL [68]
	ldr r0, [r5, #-9*4]			; r0=StateStack[-9]
	; BC_RSTATE [79]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_RLOCAL [69]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-10*4]			; r0=StateStack[-10]
	; BC_RLOCAL [6a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-11*4]			; r0=StateStack[-11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_52_end:

proc_53_start:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WAIT [0a]
	adr r1, proc_53_continue_197
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_53_continue_197:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WAIT [0a]
	adr r1, proc_53_continue_198
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_53_continue_198:
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_53_continue_199
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_53_continue_199:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_58_start		; r0=r_Procedures[58]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_53_end:

proc_54_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_54_target_200
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_56_start		; r0=r_Procedures[56]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [7a]
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WAIT [0a]
	adr r1, proc_54_continue_201
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_54_continue_201:
	; BC_PROC [07]
	adr r0, proc_54_start		; r0=r_Procedures[54]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [33]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, lsr #16			; swap.w r1
	and r1, r1, #63				; only bottom 6 bits are valid.
	movs r0, r0, ror r1			; r0=r0 ror r1
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_54_target_200:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_54_end:

proc_55_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_55_target_202
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WHEN [17]
	beq proc_55_target_203
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_55_target_203:
	; BC_RSTATE [7a]
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WAIT [0a]
	adr r1, proc_55_continue_204
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_55_continue_204:
	; BC_PROC [07]
	adr r0, proc_55_start		; r0=r_Procedures[55]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [33]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, lsr #16			; swap.w r1
	and r1, r1, #63				; only bottom 6 bits are valid.
	movs r0, r0, ror r1			; r0=r0 ror r1
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_55_target_202:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_55_end:

proc_56_start:
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_55_start		; r0=r_Procedures[55]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_56_end:

proc_57_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_54_start		; r0=r_Procedures[54]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_57_end:

proc_58_start:
	; BC_CONST [d0]
	mov r0, #0x00c00000			; r0=rConstants[80] (192.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [97]
	ldr r0, [r4, #23*4]			; r0=rConstants[23]=0x00009999 (0.6000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_59_start		; r0=r_Procedures[59]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_58_end:

proc_59_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_59_target_205
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x003c0000			; r0=rConstants[65] (60.0000)
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_59_continue_206
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_59_continue_206:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_59_start		; r0=r_Procedures[59]
	; BC_CONST [9f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #31*4]			; r0=rConstants[31]=0x0001170a (1.0900)
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
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_59_target_205:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_59_end:

proc_60_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [bc]
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [fe]
	ldr r0, [r4, #162*4]			; r0=rConstants[162]=0xbade1234 (47838.0711)
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
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #135*4]			; r0=rConstants[135]=0x4a3762e5 (18999.3863)
	; BC_CONST [fe]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #145*4]			; r0=rConstants[145]=0x819fd0cb (33183.8156)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_61_start		; r0=r_Procedures[61]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_60_end:

proc_61_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_61_target_207
	; BC_CONST [97]
	ldr r0, [r4, #23*4]			; r0=rConstants[23]=0x00009999 (0.6000)
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
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]=0x00003333 (0.2000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_62_start		; r0=r_Procedures[62]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ae]
	mov r0, #0x000c0000			; r0=rConstants[46] (12.0000)
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x000f0000			; r0=rConstants[48] (15.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
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
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [ac]
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_WAIT [0a]
	adr r1, proc_61_continue_208
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_61_continue_208:
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_61_target_209
	; BC_PROC [07]
	adr r0, proc_61_start		; r0=r_Procedures[61]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_CONST [a6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [33]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, lsr #16			; swap.w r1
	and r1, r1, #63				; only bottom 6 bits are valid.
	movs r0, r0, ror r1			; r0=r0 ror r1
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
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
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_61_target_210
proc_61_target_209:
	; BC_PROC [07]
	adr r0, proc_61_start		; r0=r_Procedures[61]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [a6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [33]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, lsr #16			; swap.w r1
	and r1, r1, #63				; only bottom 6 bits are valid.
	movs r0, r0, ror r1			; r0=r0 ror r1
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WLOCAL [41]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WLOCAL [40]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_61_target_210:
	; BC_DONE [00]
proc_61_target_207:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_61_end:

proc_62_start:
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_WAIT [0a]
	adr r1, proc_62_continue_211
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_62_continue_211:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_WAIT [0a]
	adr r1, proc_62_continue_212
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_62_continue_212:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_WAIT [0a]
	adr r1, proc_62_continue_213
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_62_continue_213:
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_62_end:

proc_63_start:
	; BC_CONST [d5]
	mov r0, #0x01400000			; r0=rConstants[85] (320.0000)
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_63_target_214
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WAIT [0a]
	adr r1, proc_63_continue_215
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_63_continue_215:
	; BC_PROC [07]
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_63_target_214:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_63_end:

proc_64_start:
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [ac]
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b1]
	mov r0, #0x00100000			; r0=rConstants[49] (16.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_65_start		; r0=r_Procedures[65]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_64_end:

proc_65_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_65_target_216
	; BC_CONST [ac]
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_66_start		; r0=r_Procedures[66]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WAIT [0a]
	adr r1, proc_65_continue_217
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_65_continue_217:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_66_start		; r0=r_Procedures[66]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_65_continue_218
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_65_continue_218:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_66_start		; r0=r_Procedures[66]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WAIT [0a]
	adr r1, proc_65_continue_219
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_65_continue_219:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_66_start		; r0=r_Procedures[66]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_65_continue_220
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_65_continue_220:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_66_start		; r0=r_Procedures[66]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WAIT [0a]
	adr r1, proc_65_continue_221
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_65_continue_221:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_66_start		; r0=r_Procedures[66]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_65_continue_222
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_65_continue_222:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_66_start		; r0=r_Procedures[66]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WAIT [0a]
	adr r1, proc_65_continue_223
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_65_continue_223:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_66_start		; r0=r_Procedures[66]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_65_continue_224
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_65_continue_224:
	; BC_PROC [07]
	adr r0, proc_65_start		; r0=r_Procedures[65]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_65_target_216:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_65_end:

proc_66_start:
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
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
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
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
	; BC_CONST [a2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
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
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
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
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a3]
	mov r0, #0x00028000			; r0=rConstants[35] (2.5000)
	; BC_WAIT [0a]
	adr r1, proc_66_continue_225
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_66_continue_225:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_66_end:

proc_67_start:
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
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
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_67_continue_226
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_67_continue_226:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_67_continue_227
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_67_continue_227:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_67_continue_228
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_67_continue_228:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_67_end:

proc_68_start:
	; BC_CONST [95]
	mov r0, #0x00008000			; r0=rConstants[21] (0.5000)
	; BC_WSTATE [5c]
	str r0, [r5, #ST_WIRE4*4]		; State[ST_WIRE4]=r0
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_68_continue_229
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_68_continue_229:
	; BC_CONST [c8]
	mov r0, #0x005a0000			; r0=rConstants[72] (90.0000)
	; BC_CONST [d4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01180000			; r0=rConstants[84] (280.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d0]
	mov r0, #0x00c00000			; r0=rConstants[80] (192.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [b1]
	mov r0, #0x00100000			; r0=rConstants[49] (16.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_71_start		; r0=r_Procedures[71]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_68_end:

proc_69_start:
	; BC_CONST [9a]
	mov r0, #0x0000c000			; r0=rConstants[26] (0.7500)
	; BC_WSTATE [5c]
	str r0, [r5, #ST_WIRE4*4]		; State[ST_WIRE4]=r0
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_69_continue_230
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_69_continue_230:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_69_continue_231
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_69_continue_231:
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_69_continue_232
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_69_continue_232:
	; BC_CONST [c8]
	mov r0, #0x005a0000			; r0=rConstants[72] (90.0000)
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d0]
	mov r0, #0x00c00000			; r0=rConstants[80] (192.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_70_start		; r0=r_Procedures[70]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c8]
	mov r0, #0x005a0000			; r0=rConstants[72] (90.0000)
	; BC_CONST [d4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01180000			; r0=rConstants[84] (280.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c7]
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_WAIT [0a]
	adr r1, proc_69_continue_233
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_69_continue_233:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_70_start		; r0=r_Procedures[70]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_69_end:

proc_70_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_70_target_234
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
	; BC_WSTATE [5b]
	str r0, [r5, #ST_WIRE3*4]		; State[ST_WIRE3]=r0
	; BC_CONST [bc]
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_RSTATE [7b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE3*4]		; r0=State[ST_WIRE3]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [5a]
	str r0, [r5, #ST_WIRE2*4]		; State[ST_WIRE2]=r0
	; BC_PROC [07]
	adr r0, proc_72_start		; r0=r_Procedures[72]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_72_start		; r0=r_Procedures[72]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_70_continue_235
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_70_continue_235:
	; BC_PROC [07]
	adr r0, proc_70_start		; r0=r_Procedures[70]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_70_target_234:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_70_end:

proc_71_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_71_target_236
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
	; BC_WSTATE [5b]
	str r0, [r5, #ST_WIRE3*4]		; State[ST_WIRE3]=r0
	; BC_CONST [bc]
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_RSTATE [7b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE3*4]		; r0=State[ST_WIRE3]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00280000			; r0=rConstants[60] (40.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [5a]
	str r0, [r5, #ST_WIRE2*4]		; State[ST_WIRE2]=r0
	; BC_PROC [07]
	adr r0, proc_72_start		; r0=r_Procedures[72]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_72_start		; r0=r_Procedures[72]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_71_continue_237
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_71_continue_237:
	; BC_PROC [07]
	adr r0, proc_71_start		; r0=r_Procedures[71]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_71_target_236:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_71_end:

proc_72_start:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [59]
	str r0, [r5, #ST_WIRE1*4]		; State[ST_WIRE1]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_73_start		; r0=r_Procedures[73]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WAIT [0a]
	adr r1, proc_72_continue_238
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_72_continue_238:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [59]
	str r0, [r5, #ST_WIRE1*4]		; State[ST_WIRE1]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_73_start		; r0=r_Procedures[73]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_72_end:

proc_73_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_73_target_239
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_74_start		; r0=r_Procedures[74]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]=0x00036666 (3.4000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [7c]
	ldr r0, [r5, #ST_WIRE4*4]		; r0=State[ST_WIRE4]
	; BC_WAIT [0a]
	adr r1, proc_73_continue_240
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_73_continue_240:
	; BC_PROC [07]
	adr r0, proc_73_start		; r0=r_Procedures[73]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_73_target_239:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_73_end:

proc_74_start:
	; BC_RSTATE [71]
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [7a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_RSTATE [7b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE3*4]		; r0=State[ST_WIRE3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00008000			; r0=rConstants[21] (0.5000)
	; BC_RSTATE [7a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE2*4]		; r0=State[ST_WIRE2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_RSTATE [7b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE3*4]		; r0=State[ST_WIRE3]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [b6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00170000			; r0=rConstants[54] (23.0000)
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
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
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_RSTATE [79]
	ldr r0, [r5, #ST_WIRE1*4]		; r0=State[ST_WIRE1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [b6]
	mov r0, #0x00170000			; r0=rConstants[54] (23.0000)
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r2, r5, #4
	ldmia r2, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_74_end:

proc_75_start:
	; BC_PROC [07]
	adr r0, proc_78_start		; r0=r_Procedures[78]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_75_continue_241
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_241:
	; BC_PROC [07]
	adr r0, proc_77_start		; r0=r_Procedures[77]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_75_continue_242
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_242:
	; BC_PROC [07]
	adr r0, proc_78_start		; r0=r_Procedures[78]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_75_continue_243
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_243:
	; BC_PROC [07]
	adr r0, proc_77_start		; r0=r_Procedures[77]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_75_continue_244
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_244:
	; BC_PROC [07]
	adr r0, proc_78_start		; r0=r_Procedures[78]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_75_continue_245
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_245:
	; BC_PROC [07]
	adr r0, proc_77_start		; r0=r_Procedures[77]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_75_continue_246
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_246:
	; BC_PROC [07]
	adr r0, proc_78_start		; r0=r_Procedures[78]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_75_continue_247
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_247:
	; BC_PROC [07]
	adr r0, proc_77_start		; r0=r_Procedures[77]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_75_continue_248
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_248:
	; BC_PROC [07]
	adr r0, proc_99_start		; r0=r_Procedures[99]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_75_continue_249
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_249:
	; BC_PROC [07]
	adr r0, proc_93_start		; r0=r_Procedures[93]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_75_continue_250
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_250:
	; BC_CONST [ba]
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_85_start		; r0=r_Procedures[85]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_75_end:

proc_76_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_76_target_251
	; BC_PROC [07]
	adr r0, proc_77_start		; r0=r_Procedures[77]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_76_continue_252
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_76_continue_252:
	; BC_PROC [07]
	adr r0, proc_78_start		; r0=r_Procedures[78]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00580000			; r0=rConstants[71] (88.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_76_continue_253
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_76_continue_253:
	; BC_PROC [07]
	adr r0, proc_76_start		; r0=r_Procedures[76]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_76_target_251:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_76_end:

proc_77_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_99_start		; r0=r_Procedures[99]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_77_continue_254
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_77_continue_254:
	; BC_PROC [07]
	adr r0, proc_93_start		; r0=r_Procedures[93]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_77_continue_255
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_77_continue_255:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_89_start		; r0=r_Procedures[89]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_77_continue_256
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_77_continue_256:
	; BC_PROC [07]
	adr r0, proc_85_start		; r0=r_Procedures[85]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_77_end:

proc_78_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_99_start		; r0=r_Procedures[99]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_78_continue_257
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_78_continue_257:
	; BC_PROC [07]
	adr r0, proc_92_start		; r0=r_Procedures[92]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_83_start		; r0=r_Procedures[83]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_78_continue_258
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_78_continue_258:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_79_start		; r0=r_Procedures[79]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_78_continue_259
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_78_continue_259:
	; BC_CONST [ba]
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_85_start		; r0=r_Procedures[85]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_78_end:

proc_79_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_79_target_260
	; BC_CONST [c1]
	mov r0, #0x003c0000			; r0=rConstants[65] (60.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_80_start		; r0=r_Procedures[80]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_79_continue_261
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_79_continue_261:
	; BC_CONST [b4]
	mov r0, #0x00150000			; r0=rConstants[52] (21.0000)
	; BC_CONST [c3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_79_start		; r0=r_Procedures[79]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_79_target_262
proc_79_target_260:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c1]
	mov r0, #0x003c0000			; r0=rConstants[65] (60.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_80_start		; r0=r_Procedures[80]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_79_target_262:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_79_end:

proc_80_start:
	; BC_PROC [07]
	adr r0, proc_81_start		; r0=r_Procedures[81]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_81_start		; r0=r_Procedures[81]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_81_start		; r0=r_Procedures[81]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_81_start		; r0=r_Procedures[81]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_80_end:

proc_81_start:
	; BC_CONST [b9]
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_82_start		; r0=r_Procedures[82]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_81_end:

proc_82_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_82_target_263
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_82_continue_264
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_82_continue_264:
	; BC_PROC [07]
	adr r0, proc_82_start		; r0=r_Procedures[82]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_82_target_263:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_82_end:

proc_83_start:
	; BC_PROC [07]
	adr r0, proc_84_start		; r0=r_Procedures[84]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_84_start		; r0=r_Procedures[84]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_84_start		; r0=r_Procedures[84]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_84_start		; r0=r_Procedures[84]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_83_end:

proc_84_start:
	; BC_CONST [b9]
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_82_start		; r0=r_Procedures[82]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_84_end:

proc_85_start:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_85_continue_265
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_85_continue_265:
	; BC_PROC [07]
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_85_continue_266
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_85_continue_266:
	; BC_PROC [07]
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_85_continue_267
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_85_continue_267:
	; BC_PROC [07]
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_85_end:

proc_86_start:
	; BC_PROC [07]
	adr r0, proc_87_start		; r0=r_Procedures[87]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_87_start		; r0=r_Procedures[87]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_87_start		; r0=r_Procedures[87]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_87_start		; r0=r_Procedures[87]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_86_end:

proc_87_start:
	; BC_CONST [ba]
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [bd]
	mov r0, #0x002b0000			; r0=rConstants[61] (43.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_88_start		; r0=r_Procedures[88]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_87_end:

proc_88_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_88_target_268
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_88_continue_269
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_88_continue_269:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_88_start		; r0=r_Procedures[88]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_88_target_268:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_88_end:

proc_89_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_89_target_270
	; BC_CONST [c1]
	mov r0, #0x003c0000			; r0=rConstants[65] (60.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_89_target_271
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_ELSE [01]
	b proc_89_target_272
proc_89_target_271:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [a2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DONE [00]
proc_89_target_272:
	; BC_PROC [07]
	adr r0, proc_90_start		; r0=r_Procedures[90]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b4]
	mov r0, #0x00150000			; r0=rConstants[52] (21.0000)
	; BC_CONST [c3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_89_continue_273
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_89_continue_273:
	; BC_PROC [07]
	adr r0, proc_89_start		; r0=r_Procedures[89]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_89_target_270:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_89_end:

proc_90_start:
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_91_start		; r0=r_Procedures[91]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_91_start		; r0=r_Procedures[91]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_91_start		; r0=r_Procedures[91]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_91_start		; r0=r_Procedures[91]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_90_end:

proc_91_start:
	; BC_CONST [ba]
	mov r0, #0x00200000			; r0=rConstants[58] (32.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [bd]
	mov r0, #0x002b0000			; r0=rConstants[61] (43.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_91_end:

proc_92_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_94_start		; r0=r_Procedures[94]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_94_start		; r0=r_Procedures[94]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WAIT [0a]
	adr r1, proc_92_continue_274
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_92_continue_274:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_94_start		; r0=r_Procedures[94]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_94_start		; r0=r_Procedures[94]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WAIT [0a]
	adr r1, proc_92_continue_275
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_92_continue_275:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_94_start		; r0=r_Procedures[94]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_94_start		; r0=r_Procedures[94]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_92_end:

proc_93_start:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_95_start		; r0=r_Procedures[95]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_95_start		; r0=r_Procedures[95]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WAIT [0a]
	adr r1, proc_93_continue_276
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_93_continue_276:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_95_start		; r0=r_Procedures[95]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_95_start		; r0=r_Procedures[95]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WAIT [0a]
	adr r1, proc_93_continue_277
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_93_continue_277:
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_95_start		; r0=r_Procedures[95]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_95_start		; r0=r_Procedures[95]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_93_end:

proc_94_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_94_end:

proc_95_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_97_start		; r0=r_Procedures[97]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	adr r0, proc_97_start		; r0=r_Procedures[97]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	adr r0, proc_97_start		; r0=r_Procedures[97]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	adr r0, proc_97_start		; r0=r_Procedures[97]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_95_end:

proc_96_start:
	; BC_CONST [b9]
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b9]
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_98_start		; r0=r_Procedures[98]
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_96_end:

proc_97_start:
	; BC_CONST [b9]
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_98_start		; r0=r_Procedures[98]
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_97_end:

proc_98_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_98_target_278
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	mov r0, #0x00008000			; r0=rConstants[21] (0.5000)
	; BC_WAIT [0a]
	adr r1, proc_98_continue_279
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_98_continue_279:
	; BC_PROC [07]
	adr r0, proc_98_start		; r0=r_Procedures[98]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_98_target_278:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_98_end:

proc_99_start:
	; BC_CONST [a7]
	mov r0, #0x00050000			; r0=rConstants[39] (5.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_100_start		; r0=r_Procedures[100]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_99_continue_280
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_99_continue_280:
	; BC_CONST [a8]
	mov r0, #0x00060000			; r0=rConstants[40] (6.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_100_start		; r0=r_Procedures[100]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WAIT [0a]
	adr r1, proc_99_continue_281
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_99_continue_281:
	; BC_CONST [a9]
	mov r0, #0x00070000			; r0=rConstants[41] (7.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_100_start		; r0=r_Procedures[100]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_99_end:

proc_100_start:
	; BC_CONST [b9]
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_100_target_282
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_101_start		; r0=r_Procedures[101]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WAIT [0a]
	adr r1, proc_100_continue_283
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_100_continue_283:
	; BC_PROC [07]
	adr r0, proc_100_start		; r0=r_Procedures[100]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #33*4]			; r0=rConstants[33]=0x00014ccc (1.3000)
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
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_100_target_284
proc_100_target_282:
	; BC_PROC [07]
	adr r0, proc_101_start		; r0=r_Procedures[101]
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x001e0000			; r0=rConstants[57] (30.0000)
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_100_target_284:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_100_end:

proc_101_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_101_end:

proc_102_start:
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b5]
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_WAIT [0a]
	adr r1, proc_102_continue_285
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_102_continue_285:
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00b40000			; r0=rConstants[79] (180.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [d5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01400000			; r0=rConstants[85] (320.0000)
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [ac]
	mov r0, #0x000a0000			; r0=rConstants[44] (10.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_103_start		; r0=r_Procedures[103]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_102_end:

proc_103_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_103_target_286
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00b40000			; r0=rConstants[79] (180.0000)
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_CONST [d5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x01400000			; r0=rConstants[85] (320.0000)
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_104_start		; r0=r_Procedures[104]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_103_continue_287
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_103_continue_287:
	; BC_CONST [b3]
	mov r0, #0x00140000			; r0=rConstants[51] (20.0000)
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_104_start		; r0=r_Procedures[104]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00160000			; r0=rConstants[53] (22.0000)
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_103_continue_288
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_103_continue_288:
	; BC_PROC [07]
	adr r0, proc_103_start		; r0=r_Procedures[103]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_103_target_286:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_103_end:

proc_104_start:
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b4]
	mov r0, #0x00150000			; r0=rConstants[52] (21.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_105_start		; r0=r_Procedures[105]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WAIT [0a]
	adr r1, proc_104_continue_289
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_104_continue_289:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b4]
	mov r0, #0x00150000			; r0=rConstants[52] (21.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_105_start		; r0=r_Procedures[105]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WAIT [0a]
	adr r1, proc_104_continue_290
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_104_continue_290:
	; BC_CONST [9e]
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b4]
	mov r0, #0x00150000			; r0=rConstants[52] (21.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_105_start		; r0=r_Procedures[105]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	mov r0, #0x00040000			; r0=rConstants[38] (4.0000)
	; BC_WAIT [0a]
	adr r1, proc_104_continue_291
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_104_continue_291:
	; BC_CONST [80]
	mov r0, #0x00000000			; r0=rConstants[0] (0.0000)
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b4]
	mov r0, #0x00150000			; r0=rConstants[52] (21.0000)
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_105_start		; r0=r_Procedures[105]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_104_end:

proc_105_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_105_target_292
	; BC_PROC [07]
	adr r0, proc_106_start		; r0=r_Procedures[106]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9a]
	mov r0, #0x0000c000			; r0=rConstants[26] (0.7500)
	; BC_WAIT [0a]
	adr r1, proc_105_continue_293
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_105_continue_293:
	; BC_CONST [a2]
	mov r0, #0x00020000			; r0=rConstants[34] (2.0000)
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
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
	; BC_PROC [07]
	adr r0, proc_105_start		; r0=r_Procedures[105]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	mov r0, #0x00010000			; r0=rConstants[30] (1.0000)
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_105_target_292:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_105_end:

proc_106_start:
	; BC_CONST [a4]
	mov r0, #0x00030000			; r0=rConstants[36] (3.0000)
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ca]
	mov r0, #0x00800000			; r0=rConstants[74] (128.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	mov r0, #0x00400000			; r0=rConstants[67] (64.0000)
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [aa]
	mov r0, #0x00080000			; r0=rConstants[42] (8.0000)
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PLOT [06]
	add r2, r5, #4
	ldmia r2, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_106_end:


; ============================================================================
; Constants.
; ============================================================================

r_Constants:
.long 0x00000000				; [0] = 0.0000
.long 0x00000041				; [1] = 0.0010
.long 0x00000083				; [2] = 0.0020
.long 0x00000189				; [3] = 0.0060
.long 0x000001ca				; [4] = 0.0070
.long 0x0000020c				; [5] = 0.0080
.long 0x00000210				; [6] = 0.0081
.long 0x0000028f				; [7] = 0.0100
.long 0x00000312				; [8] = 0.0120
.long 0x00000353				; [9] = 0.0130
.long 0x00000380				; [10] = 0.0137
.long 0x00000395				; [11] = 0.0140
.long 0x000006c0				; [12] = 0.0264
.long 0x00001082				; [13] = 0.0645
.long 0x00001999				; [14] = 0.1000
.long 0x00003333				; [15] = 0.2000
.long 0x00004000				; [16] = 0.2500
.long 0x00004ccc				; [17] = 0.3000
.long 0x0000547a				; [18] = 0.3300
.long 0x00007c82				; [19] = 0.4864
.long 0x00007cfe				; [20] = 0.4883
.long 0x00008000				; [21] = 0.5000
.long 0x0000827c				; [22] = 0.5097
.long 0x00009999				; [23] = 0.6000
.long 0x0000a8f5				; [24] = 0.6600
.long 0x0000b333				; [25] = 0.7000
.long 0x0000c000				; [26] = 0.7500
.long 0x0000cccc				; [27] = 0.8000
.long 0x0000e666				; [28] = 0.9000
.long 0x0000ffff				; [29] = 1.0000
.long 0x00010000				; [30] = 1.0000
.long 0x0001170a				; [31] = 1.0900
.long 0x00013333				; [32] = 1.2000
.long 0x00014ccc				; [33] = 1.3000
.long 0x00020000				; [34] = 2.0000
.long 0x00028000				; [35] = 2.5000
.long 0x00030000				; [36] = 3.0000
.long 0x00036666				; [37] = 3.4000
.long 0x00040000				; [38] = 4.0000
.long 0x00050000				; [39] = 5.0000
.long 0x00060000				; [40] = 6.0000
.long 0x00070000				; [41] = 7.0000
.long 0x00080000				; [42] = 8.0000
.long 0x00090000				; [43] = 9.0000
.long 0x000a0000				; [44] = 10.0000
.long 0x000b0000				; [45] = 11.0000
.long 0x000c0000				; [46] = 12.0000
.long 0x000d0000				; [47] = 13.0000
.long 0x000f0000				; [48] = 15.0000
.long 0x00100000				; [49] = 16.0000
.long 0x00110000				; [50] = 17.0000
.long 0x00140000				; [51] = 20.0000
.long 0x00150000				; [52] = 21.0000
.long 0x00160000				; [53] = 22.0000
.long 0x00170000				; [54] = 23.0000
.long 0x00180000				; [55] = 24.0000
.long 0x00190000				; [56] = 25.0000
.long 0x001e0000				; [57] = 30.0000
.long 0x00200000				; [58] = 32.0000
.long 0x00230000				; [59] = 35.0000
.long 0x00280000				; [60] = 40.0000
.long 0x002b0000				; [61] = 43.0000
.long 0x002c0000				; [62] = 44.0000
.long 0x00320000				; [63] = 50.0000
.long 0x00370000				; [64] = 55.0000
.long 0x003c0000				; [65] = 60.0000
.long 0x003d0000				; [66] = 61.0000
.long 0x00400000				; [67] = 64.0000
.long 0x00460000				; [68] = 70.0000
.long 0x00500000				; [69] = 80.0000
.long 0x00560000				; [70] = 86.0000
.long 0x00580000				; [71] = 88.0000
.long 0x005a0000				; [72] = 90.0000
.long 0x007f0000				; [73] = 127.0000
.long 0x00800000				; [74] = 128.0000
.long 0x00820000				; [75] = 130.0000
.long 0x00960000				; [76] = 150.0000
.long 0x00a00000				; [77] = 160.0000
.long 0x00aa0000				; [78] = 170.0000
.long 0x00b40000				; [79] = 180.0000
.long 0x00c00000				; [80] = 192.0000
.long 0x00e10000				; [81] = 225.0000
.long 0x00ff0000				; [82] = 255.0000
.long 0x010e0000				; [83] = 270.0000
.long 0x01180000				; [84] = 280.0000
.long 0x01400000				; [85] = 320.0000
.long 0x014a0000				; [86] = 330.0000
.long 0x01d90000				; [87] = 473.0000
.long 0x01da0000				; [88] = 474.0000
.long 0x02107c10				; [89] = 528.4846
.long 0x022b0000				; [90] = 555.0000
.long 0x029a0000				; [91] = 666.0000
.long 0x03800fe0				; [92] = 896.0620
.long 0x0380c383				; [93] = 896.7637
.long 0x038702bd				; [94] = 903.0107
.long 0x045c0000				; [95] = 1116.0000
.long 0x04e00400				; [96] = 1248.0156
.long 0x05390000				; [97] = 1337.0000
.long 0x06c03c78				; [98] = 1728.2362
.long 0x0787e2fd				; [99] = 1927.8867
.long 0x07c00000				; [100] = 1984.0000
.long 0x07c006c0				; [101] = 1984.0264
.long 0x07cee44a				; [102] = 1998.8918
.long 0x08201010				; [103] = 2080.0627
.long 0x09130000				; [104] = 2323.0000
.long 0x0c3003c0				; [105] = 3120.0146
.long 0x0c301bd8				; [106] = 3120.1088
.long 0x0c600d60				; [107] = 3168.0522
.long 0x0ff00000				; [108] = 4080.0000
.long 0x0ff01008				; [109] = 4080.0626
.long 0x0ff01f08				; [110] = 4080.1212
.long 0x10101bb0				; [111] = 4112.1082
.long 0x107e3c08				; [112] = 4222.2345
.long 0x147f1c49				; [113] = 5247.1105
.long 0x14bc3c49				; [114] = 5308.2355
.long 0x18300c60				; [115] = 6192.0483
.long 0x185e1e86				; [116] = 6238.1192
.long 0x19301930				; [117] = 6448.0984
.long 0x19986006				; [118] = 6552.3751
.long 0x1e100210				; [119] = 7696.0081
.long 0x1ff00fe0				; [120] = 8176.0620
.long 0x1ff83ffc				; [121] = 8184.2499
.long 0x20041008				; [122] = 8196.0626
.long 0x20044002				; [123] = 8196.2500
.long 0x20fc10f8				; [124] = 8444.0663
.long 0x2388638c				; [125] = 9096.3889
.long 0x28822844				; [126] = 10370.1573
.long 0x31183118				; [127] = 12568.1918
.long 0x38381010				; [128] = 14392.0627
.long 0x399c3ffc				; [129] = 14748.2499
.long 0x3ef87c7c				; [130] = 16120.4863
.long 0x3f047f02				; [131] = 16132.4961
.long 0x3ffc0c30				; [132] = 16380.0476
.long 0x40bf3f08				; [133] = 16575.2462
.long 0x44444428				; [134] = 17476.2662
.long 0x4a3762e5				; [135] = 18999.3863
.long 0x60060000				; [136] = 24582.0000
.long 0x610c600c				; [137] = 24844.3752
.long 0x80014002				; [138] = 32769.2500
.long 0x80018001				; [139] = 32769.5000
.long 0x8086828a				; [140] = 32902.5099
.long 0x80c18061				; [141] = 32961.5015
.long 0x80e18061				; [142] = 32993.5015
.long 0x80ff40fe				; [143] = 33023.2539
.long 0x80ff80ff				; [144] = 33023.5039
.long 0x819fd0cb				; [145] = 33183.8156
.long 0x81c181c1				; [146] = 33217.5069
.long 0x82008202				; [147] = 33280.5078
.long 0x8202827c				; [148] = 33282.5097
.long 0x82071fa2				; [149] = 33287.1236
.long 0x82288210				; [150] = 33320.5081
.long 0x823f3f20				; [151] = 33343.2466
.long 0x82827c82				; [152] = 33410.4864
.long 0x829282a2				; [153] = 33426.5103
.long 0x838181c1				; [154] = 33665.5069
.long 0x8ba28382				; [155] = 35746.5137
.long 0x8e018701				; [156] = 36353.5274
.long 0x8ff18ff1				; [157] = 36849.5623
.long 0x927f0104				; [158] = 37503.0040
.long 0x9a6e19a6				; [159] = 39534.1002
.long 0x9ff98001				; [160] = 40953.5000
.long 0x9ff99ff9				; [161] = 40953.6249
.long 0xbade1234				; [162] = 47838.0711
.long 0xbceee4a0				; [163] = 48366.8931
.long 0xbe07e000				; [164] = 48647.8750
.long 0xc0230010				; [165] = 49187.0002
.long 0xc106c006				; [166] = 49414.7501
.long 0xc2c69392				; [167] = 49862.5764
.long 0xe3a7b920				; [168] = 58279.7231
.long 0xeffc0044				; [169] = 61436.0010
.long 0xf01ef83e				; [170] = 61470.9697
.long 0xf8602087				; [171] = 63584.1271
.long 0xfa028202				; [172] = 64002.5078
.long 0xfc7e7c7c				; [173] = 64638.4863
.long 0xff01ff01				; [174] = 65281.9961
.long 0xff01ffff				; [175] = 65282.0000
.long 0xfffe7ffc				; [176] = 65534.4999
.long 0xffff0000				; [177] = 65535.0000

; ============================================================================
; Color Script.
; ============================================================================

r_ColorScript:
.long -1, 0x00000000, 0x01000000, 0x02000000, 0x03000000, 0x04000000, 0x05000000, 0x06000000, 0x07000000			; delta_frames=1 [0]
.long -30, 0x03000011, 0x07000011			; delta_frames=30 [30]
.long -6, 0x02000011, 0x06000011			; delta_frames=6 [36]
.long -8, 0x01000011, 0x05000011			; delta_frames=8 [44]
.long -44, 0x03111122, 0x07111122			; delta_frames=44 [88]
.long -18, 0x02000022, 0x06000022			; delta_frames=18 [106]
.long -26, 0x01000022, 0x05000022			; delta_frames=26 [132]
.long -15, 0x03111133, 0x07111133			; delta_frames=15 [147]
.long -29, 0x02111133, 0x06111133			; delta_frames=29 [176]
.long -30, 0x03111144, 0x07111144			; delta_frames=30 [206]
.long -14, 0x01000033, 0x05000033			; delta_frames=14 [220]
.long -27, 0x02111144, 0x06111144			; delta_frames=27 [247]
.long -17, 0x03222255, 0x07222255			; delta_frames=17 [264]
.long -44, 0x01000044, 0x05000044			; delta_frames=44 [308]
.long -9, 0x02111155, 0x06111155			; delta_frames=9 [317]
.long -6, 0x03222266, 0x07222266			; delta_frames=6 [323]
.long -1085, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x07000044, 0x06111155, 0x05220033			; delta_frames=1085 [1408]
.long -176, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x07000044, 0x06111155, 0x05330044			; delta_frames=176 [1584]
.long -176, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x07000088, 0x062222aa, 0x05330066			; delta_frames=176 [1760]
.long -176, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x07110077, 0x06224477, 0x05777777			; delta_frames=176 [1936]
.long -134, 0x05666666, 0x06224466, 0x07110066			; delta_frames=134 [2070]
.long -1, 0x06223366			; delta_frames=1 [2071]
.long -2, 0x05555555, 0x06223355, 0x07110055			; delta_frames=2 [2073]
.long -1, 0x06113355			; delta_frames=1 [2074]
.long -2, 0x05444444, 0x06113344, 0x07110044			; delta_frames=2 [2076]
.long -1, 0x06112244			; delta_frames=1 [2077]
.long -3, 0x05333333, 0x06112233, 0x07000033			; delta_frames=3 [2080]
.long -2, 0x06111133			; delta_frames=2 [2082]
.long -1, 0x05222222, 0x06111122, 0x07000022			; delta_frames=1 [2083]
.long -2, 0x06001122			; delta_frames=2 [2085]
.long -1, 0x05111111, 0x06001111, 0x07000011			; delta_frames=1 [2086]
.long -2, 0x06000011			; delta_frames=2 [2088]
.long -1, 0x05000000, 0x06000000, 0x07000000			; delta_frames=1 [2089]
.long -23, 0x00000000, 0x01000044, 0x02111155, 0x03ffffff, 0x04000000, 0x05000044, 0x06111155, 0x07443322			; delta_frames=23 [2112]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2134]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2135]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2136]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2137]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2138]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2139]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2140]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2141]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2142]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2143]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2144]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2145]
.long -1, 0x07998888			; delta_frames=1 [2146]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2147]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2148]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2149]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2150]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2151]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2152]
.long -1, 0x03ddddee			; delta_frames=1 [2153]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2154]
.long -1, 0x03eeeeff			; delta_frames=1 [2155]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2156]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2178]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2179]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2180]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2181]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2182]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2183]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2184]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2185]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2186]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2187]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2188]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2189]
.long -1, 0x07998888			; delta_frames=1 [2190]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2191]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2192]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2193]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2194]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2195]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2196]
.long -1, 0x03ddddee			; delta_frames=1 [2197]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2198]
.long -1, 0x03eeeeff			; delta_frames=1 [2199]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2200]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2222]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2223]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2224]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2225]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2226]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2227]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2228]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2229]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2230]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2231]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2232]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2233]
.long -1, 0x07998888			; delta_frames=1 [2234]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2235]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2236]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2237]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2238]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2239]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2240]
.long -1, 0x03ddddee			; delta_frames=1 [2241]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2242]
.long -1, 0x03eeeeff			; delta_frames=1 [2243]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2244]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2266]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2267]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2268]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2269]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2270]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2271]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2272]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2273]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2274]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2275]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2276]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2277]
.long -1, 0x07998888			; delta_frames=1 [2278]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2279]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2280]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2281]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2282]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2283]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2284]
.long -1, 0x03ddddee			; delta_frames=1 [2285]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2286]
.long -1, 0x03eeeeff			; delta_frames=1 [2287]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2288]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2310]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2311]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2312]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2313]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2314]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2315]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2316]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2317]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2318]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2319]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2320]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2321]
.long -1, 0x07998888			; delta_frames=1 [2322]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2323]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2324]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2325]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2326]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2327]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2328]
.long -1, 0x03ddddee			; delta_frames=1 [2329]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2330]
.long -1, 0x03eeeeff			; delta_frames=1 [2331]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2332]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2354]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2355]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2356]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2357]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2358]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2359]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2360]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2361]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2362]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2363]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2364]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2365]
.long -1, 0x07998888			; delta_frames=1 [2366]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2367]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2368]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2369]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2370]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2371]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2372]
.long -1, 0x03ddddee			; delta_frames=1 [2373]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2374]
.long -1, 0x03eeeeff			; delta_frames=1 [2375]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2376]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2398]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2399]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2400]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2401]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2402]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2403]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2404]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2405]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2406]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2407]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2408]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2409]
.long -1, 0x07998888			; delta_frames=1 [2410]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2411]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2412]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2413]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2414]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2415]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2416]
.long -1, 0x03ddddee			; delta_frames=1 [2417]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2418]
.long -1, 0x03eeeeff			; delta_frames=1 [2419]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2420]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2442]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2443]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2444]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2445]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2446]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2447]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2448]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2449]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2450]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2451]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2452]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2453]
.long -1, 0x07998888			; delta_frames=1 [2454]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2455]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2456]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2457]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2458]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2459]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2460]
.long -1, 0x03ddddee			; delta_frames=1 [2461]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2462]
.long -1, 0x03eeeeff			; delta_frames=1 [2463]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2464]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2486]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2487]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2488]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2489]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2490]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2491]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2492]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2493]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2494]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2495]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2496]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2497]
.long -1, 0x07998888			; delta_frames=1 [2498]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2499]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2500]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2501]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2502]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2503]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2504]
.long -1, 0x03ddddee			; delta_frames=1 [2505]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2506]
.long -1, 0x03eeeeff			; delta_frames=1 [2507]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2508]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2530]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2531]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2532]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2533]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2534]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2535]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2536]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2537]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2538]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2539]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2540]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2541]
.long -1, 0x07998888			; delta_frames=1 [2542]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2543]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2544]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2545]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2546]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2547]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2548]
.long -1, 0x03ddddee			; delta_frames=1 [2549]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2550]
.long -1, 0x03eeeeff			; delta_frames=1 [2551]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2552]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2574]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2575]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2576]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2577]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2578]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2579]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2580]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2581]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2582]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2583]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2584]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2585]
.long -1, 0x07998888			; delta_frames=1 [2586]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2587]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2588]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2589]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2590]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2591]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2592]
.long -1, 0x03ddddee			; delta_frames=1 [2593]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2594]
.long -1, 0x03eeeeff			; delta_frames=1 [2595]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2596]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2618]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2619]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2620]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2621]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2622]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2623]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2624]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2625]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2626]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2627]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2628]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2629]
.long -1, 0x07998888			; delta_frames=1 [2630]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2631]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2632]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2633]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2634]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2635]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2636]
.long -1, 0x03ddddee			; delta_frames=1 [2637]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2638]
.long -1, 0x03eeeeff			; delta_frames=1 [2639]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2640]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2662]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2663]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2664]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2665]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2666]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2667]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2668]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2669]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2670]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2671]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2672]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2673]
.long -1, 0x07998888			; delta_frames=1 [2674]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2675]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2676]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2677]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2678]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2679]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2680]
.long -1, 0x03ddddee			; delta_frames=1 [2681]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2682]
.long -1, 0x03eeeeff			; delta_frames=1 [2683]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2684]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2706]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2707]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2708]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2709]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2710]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2711]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2712]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2713]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2714]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2715]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2716]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2717]
.long -1, 0x07998888			; delta_frames=1 [2718]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2719]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2720]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2721]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2722]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2723]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2724]
.long -1, 0x03ddddee			; delta_frames=1 [2725]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2726]
.long -1, 0x03eeeeff			; delta_frames=1 [2727]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2728]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2750]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2751]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2752]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2753]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2754]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2755]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2756]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2757]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2758]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2759]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2760]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2761]
.long -1, 0x07998888			; delta_frames=1 [2762]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2763]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2764]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2765]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2766]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2767]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2768]
.long -1, 0x03ddddee			; delta_frames=1 [2769]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2770]
.long -1, 0x03eeeeff			; delta_frames=1 [2771]
.long -1, 0x03ffffff, 0x07443322			; delta_frames=1 [2772]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000044, 0x06111155, 0x07ffffff			; delta_frames=22 [2794]
.long -1, 0x03333366, 0x07ffeeee			; delta_frames=1 [2795]
.long -1, 0x03333377, 0x07eeeeee			; delta_frames=1 [2796]
.long -1, 0x03444477, 0x07eedddd			; delta_frames=1 [2797]
.long -1, 0x03444488, 0x07dddddd			; delta_frames=1 [2798]
.long -1, 0x03555588, 0x07ddcccc			; delta_frames=1 [2799]
.long -1, 0x03666688, 0x07ccccbb			; delta_frames=1 [2800]
.long -1, 0x03666699, 0x07ccbbbb			; delta_frames=1 [2801]
.long -1, 0x03777799, 0x07bbbbaa			; delta_frames=1 [2802]
.long -1, 0x037777aa, 0x07bbaaaa			; delta_frames=1 [2803]
.long -1, 0x038888aa, 0x07aaaa99			; delta_frames=1 [2804]
.long -1, 0x039999bb, 0x07aa9999			; delta_frames=1 [2805]
.long -1, 0x07998888			; delta_frames=1 [2806]
.long -1, 0x03aaaabb, 0x07998877			; delta_frames=1 [2807]
.long -1, 0x03aaaacc, 0x07887777			; delta_frames=1 [2808]
.long -1, 0x03bbbbcc, 0x07887766			; delta_frames=1 [2809]
.long -1, 0x03bbbbdd, 0x07776666			; delta_frames=1 [2810]
.long -1, 0x03ccccdd, 0x07776655			; delta_frames=1 [2811]
.long -1, 0x03dddddd, 0x07665544			; delta_frames=1 [2812]
.long -1, 0x03ddddee			; delta_frames=1 [2813]
.long -1, 0x03eeeeee, 0x07554433			; delta_frames=1 [2814]
.long -1, 0x03eeeeff			; delta_frames=1 [2815]
.long -1, 0x03ffffff, 0x07443322, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05333333, 0x06443322, 0x07554433			; delta_frames=1 [2816]
.long -385, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05cccccc, 0x06cccccc, 0x07cccccc			; delta_frames=385 [3201]
.long -2, 0x05bbbbbb, 0x06bbbbbb, 0x07bbbbbb			; delta_frames=2 [3203]
.long -2, 0x05aaaaaa, 0x06bbaaaa, 0x07bbbbaa			; delta_frames=2 [3205]
.long -1, 0x06aaaaaa, 0x07aaaaaa			; delta_frames=1 [3206]
.long -1, 0x06aaaa99			; delta_frames=1 [3207]
.long -1, 0x05999999, 0x06999999, 0x07aa9999			; delta_frames=1 [3208]
.long -1, 0x06999988, 0x07999999			; delta_frames=1 [3209]
.long -1, 0x05888888, 0x06998888, 0x07999988			; delta_frames=1 [3210]
.long -1, 0x06888877, 0x07998888			; delta_frames=1 [3211]
.long -2, 0x05777777, 0x06887777, 0x07888877			; delta_frames=2 [3213]
.long -1, 0x06777766, 0x07887777			; delta_frames=1 [3214]
.long -1, 0x05666666, 0x06776666, 0x07887766			; delta_frames=1 [3215]
.long -1, 0x06776655, 0x07777766			; delta_frames=1 [3216]
.long -1, 0x05555555, 0x06665555, 0x07776655			; delta_frames=1 [3217]
.long -1, 0x06665544			; delta_frames=1 [3218]
.long -1, 0x06555544, 0x07665555			; delta_frames=1 [3219]
.long -1, 0x05444444, 0x06554433, 0x07665544			; delta_frames=1 [3220]
.long -2, 0x05333333, 0x06443322, 0x07554433			; delta_frames=2 [3222]
.long -67, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05cccccc, 0x06cccccc, 0x07cccccc			; delta_frames=67 [3289]
.long -2, 0x05bbbbbb, 0x06bbbbbb, 0x07bbbbbb			; delta_frames=2 [3291]
.long -2, 0x05aaaaaa, 0x06bbaaaa, 0x07bbbbaa			; delta_frames=2 [3293]
.long -1, 0x06aaaaaa, 0x07aaaaaa			; delta_frames=1 [3294]
.long -1, 0x06aaaa99			; delta_frames=1 [3295]
.long -1, 0x05999999, 0x06999999, 0x07aa9999			; delta_frames=1 [3296]
.long -1, 0x06999988, 0x07999999			; delta_frames=1 [3297]
.long -1, 0x05888888, 0x06998888, 0x07999988			; delta_frames=1 [3298]
.long -1, 0x06888877, 0x07998888			; delta_frames=1 [3299]
.long -2, 0x05777777, 0x06887777, 0x07888877			; delta_frames=2 [3301]
.long -1, 0x06777766, 0x07887777			; delta_frames=1 [3302]
.long -1, 0x05666666, 0x06776666, 0x07887766			; delta_frames=1 [3303]
.long -1, 0x06776655, 0x07777766			; delta_frames=1 [3304]
.long -1, 0x05555555, 0x06665555, 0x07776655			; delta_frames=1 [3305]
.long -1, 0x06665544			; delta_frames=1 [3306]
.long -1, 0x06555544, 0x07665555			; delta_frames=1 [3307]
.long -1, 0x05444444, 0x06554433, 0x07665544			; delta_frames=1 [3308]
.long -2, 0x05333333, 0x06443322, 0x07554433			; delta_frames=2 [3310]
.long -67, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05cccccc, 0x06cccccc, 0x07cccccc			; delta_frames=67 [3377]
.long -2, 0x05bbbbbb, 0x06bbbbbb, 0x07bbbbbb			; delta_frames=2 [3379]
.long -2, 0x05aaaaaa, 0x06bbaaaa, 0x07bbbbaa			; delta_frames=2 [3381]
.long -1, 0x06aaaaaa, 0x07aaaaaa			; delta_frames=1 [3382]
.long -1, 0x06aaaa99			; delta_frames=1 [3383]
.long -1, 0x05999999, 0x06999999, 0x07aa9999			; delta_frames=1 [3384]
.long -1, 0x06999988, 0x07999999			; delta_frames=1 [3385]
.long -1, 0x05888888, 0x06998888, 0x07999988			; delta_frames=1 [3386]
.long -1, 0x06888877, 0x07998888			; delta_frames=1 [3387]
.long -2, 0x05777777, 0x06887777, 0x07888877			; delta_frames=2 [3389]
.long -1, 0x06777766, 0x07887777			; delta_frames=1 [3390]
.long -1, 0x05666666, 0x06776666, 0x07887766			; delta_frames=1 [3391]
.long -1, 0x06776655, 0x07777766			; delta_frames=1 [3392]
.long -1, 0x05555555, 0x06665555, 0x07776655			; delta_frames=1 [3393]
.long -1, 0x06665544			; delta_frames=1 [3394]
.long -1, 0x06555544, 0x07665555			; delta_frames=1 [3395]
.long -1, 0x05444444, 0x06554433, 0x07665544			; delta_frames=1 [3396]
.long -2, 0x05333333, 0x06443322, 0x07554433			; delta_frames=2 [3398]
.long -67, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05cccccc, 0x06cccccc, 0x07cccccc			; delta_frames=67 [3465]
.long -2, 0x05bbbbbb, 0x06bbbbbb, 0x07bbbbbb			; delta_frames=2 [3467]
.long -2, 0x05aaaaaa, 0x06bbaaaa, 0x07bbbbaa			; delta_frames=2 [3469]
.long -1, 0x06aaaaaa, 0x07aaaaaa			; delta_frames=1 [3470]
.long -1, 0x06aaaa99			; delta_frames=1 [3471]
.long -1, 0x05999999, 0x06999999, 0x07aa9999			; delta_frames=1 [3472]
.long -1, 0x06999988, 0x07999999			; delta_frames=1 [3473]
.long -1, 0x05888888, 0x06998888, 0x07999988			; delta_frames=1 [3474]
.long -1, 0x06888877, 0x07998888			; delta_frames=1 [3475]
.long -2, 0x05777777, 0x06887777, 0x07888877			; delta_frames=2 [3477]
.long -1, 0x06777766, 0x07887777			; delta_frames=1 [3478]
.long -1, 0x05666666, 0x06776666, 0x07887766			; delta_frames=1 [3479]
.long -1, 0x06776655, 0x07777766			; delta_frames=1 [3480]
.long -1, 0x05555555, 0x06665555, 0x07776655			; delta_frames=1 [3481]
.long -1, 0x06665544			; delta_frames=1 [3482]
.long -1, 0x06555544, 0x07665555			; delta_frames=1 [3483]
.long -1, 0x05444444, 0x06554433, 0x07665544			; delta_frames=1 [3484]
.long -2, 0x05333333, 0x06443322, 0x07554433			; delta_frames=2 [3486]
.long -34, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000055, 0x060022aa, 0x07555555			; delta_frames=34 [3520]
.long -352, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05000055, 0x060022aa, 0x07555555			; delta_frames=352 [3872]
.long -363, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x050022ff, 0x060088ff, 0x07aaffff, 0x01000044, 0x02111155, 0x03222266			; delta_frames=363 [4235]
.long -11, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=11 [4246]
.long -1, 0x0266ccff, 0x03eeeeff			; delta_frames=1 [4247]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4248]
.long -1, 0x013344ee, 0x0255bbee, 0x03ddddee			; delta_frames=1 [4249]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4250]
.long -1, 0x0255aadd, 0x03ccccdd			; delta_frames=1 [4251]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4252]
.long -1, 0x012233cc, 0x024499cc, 0x03bbbbcc			; delta_frames=1 [4253]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4254]
.long -1, 0x024488bb, 0x03aaaabb			; delta_frames=1 [4255]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4256]
.long -1, 0x024477aa			; delta_frames=1 [4257]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4258]
.long -1, 0x02336699, 0x037777aa			; delta_frames=1 [4259]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4260]
.long -1, 0x02335588, 0x03666699			; delta_frames=1 [4261]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4262]
.long -1, 0x02224477, 0x03555588			; delta_frames=1 [4263]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4264]
.long -1, 0x01001166, 0x02223366, 0x03444477			; delta_frames=1 [4265]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4266]
.long -1, 0x02112255, 0x03333366			; delta_frames=1 [4267]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4268]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4290]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4291]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4292]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4293]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4294]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4295]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4296]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4297]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4298]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4299]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4300]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4301]
.long -11, 0x01000044, 0x02111155, 0x03222266			; delta_frames=11 [4312]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4334]
.long -1, 0x0266ccff, 0x03eeeeff			; delta_frames=1 [4335]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4336]
.long -1, 0x013344ee, 0x0255bbee, 0x03ddddee			; delta_frames=1 [4337]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4338]
.long -1, 0x0255aadd, 0x03ccccdd			; delta_frames=1 [4339]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4340]
.long -1, 0x012233cc, 0x024499cc, 0x03bbbbcc			; delta_frames=1 [4341]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4342]
.long -1, 0x024488bb, 0x03aaaabb			; delta_frames=1 [4343]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4344]
.long -1, 0x024477aa			; delta_frames=1 [4345]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4346]
.long -1, 0x02336699, 0x037777aa			; delta_frames=1 [4347]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4348]
.long -1, 0x02335588, 0x03666699			; delta_frames=1 [4349]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4350]
.long -1, 0x02224477, 0x03555588			; delta_frames=1 [4351]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4352]
.long -1, 0x01001166, 0x02223366, 0x03444477			; delta_frames=1 [4353]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4354]
.long -1, 0x02112255, 0x03333366			; delta_frames=1 [4355]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4356]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4378]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4379]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4380]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4381]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4382]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4383]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4384]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4385]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4386]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4387]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4388]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4389]
.long -11, 0x01000044, 0x02111155, 0x03222266			; delta_frames=11 [4400]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4422]
.long -1, 0x0266ccff, 0x03eeeeff			; delta_frames=1 [4423]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4424]
.long -1, 0x013344ee, 0x0255bbee, 0x03ddddee			; delta_frames=1 [4425]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4426]
.long -1, 0x0255aadd, 0x03ccccdd			; delta_frames=1 [4427]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4428]
.long -1, 0x012233cc, 0x024499cc, 0x03bbbbcc			; delta_frames=1 [4429]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4430]
.long -1, 0x024488bb, 0x03aaaabb			; delta_frames=1 [4431]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4432]
.long -1, 0x024477aa			; delta_frames=1 [4433]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4434]
.long -1, 0x02336699, 0x037777aa			; delta_frames=1 [4435]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4436]
.long -1, 0x02335588, 0x03666699			; delta_frames=1 [4437]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4438]
.long -1, 0x02224477, 0x03555588			; delta_frames=1 [4439]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4440]
.long -1, 0x01001166, 0x02223366, 0x03444477			; delta_frames=1 [4441]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4442]
.long -1, 0x02112255, 0x03333366			; delta_frames=1 [4443]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4444]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4466]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4467]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4468]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4469]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4470]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4471]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4472]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4473]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4474]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4475]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4476]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4477]
.long -11, 0x01000044, 0x02111155, 0x03222266			; delta_frames=11 [4488]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4510]
.long -1, 0x0266ccff, 0x03eeeeff			; delta_frames=1 [4511]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4512]
.long -1, 0x013344ee, 0x0255bbee, 0x03ddddee			; delta_frames=1 [4513]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4514]
.long -1, 0x0255aadd, 0x03ccccdd			; delta_frames=1 [4515]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4516]
.long -1, 0x012233cc, 0x024499cc, 0x03bbbbcc			; delta_frames=1 [4517]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4518]
.long -1, 0x024488bb, 0x03aaaabb			; delta_frames=1 [4519]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4520]
.long -1, 0x024477aa			; delta_frames=1 [4521]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4522]
.long -1, 0x02336699, 0x037777aa			; delta_frames=1 [4523]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4524]
.long -1, 0x02335588, 0x03666699			; delta_frames=1 [4525]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4526]
.long -1, 0x02224477, 0x03555588			; delta_frames=1 [4527]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4528]
.long -1, 0x01001166, 0x02223366, 0x03444477			; delta_frames=1 [4529]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4530]
.long -1, 0x02112255, 0x03333366			; delta_frames=1 [4531]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4532]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4554]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4555]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4556]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4557]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4558]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4559]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4560]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4561]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4562]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4563]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4564]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4565]
.long -11, 0x01000044, 0x02111155, 0x03222266			; delta_frames=11 [4576]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4598]
.long -1, 0x0266ccff, 0x03eeeeff			; delta_frames=1 [4599]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4600]
.long -1, 0x013344ee, 0x0255bbee, 0x03ddddee			; delta_frames=1 [4601]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4602]
.long -1, 0x0255aadd, 0x03ccccdd			; delta_frames=1 [4603]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4604]
.long -1, 0x012233cc, 0x024499cc, 0x03bbbbcc			; delta_frames=1 [4605]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4606]
.long -1, 0x024488bb, 0x03aaaabb			; delta_frames=1 [4607]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4608]
.long -1, 0x024477aa			; delta_frames=1 [4609]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4610]
.long -1, 0x02336699, 0x037777aa			; delta_frames=1 [4611]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4612]
.long -1, 0x02335588, 0x03666699			; delta_frames=1 [4613]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4614]
.long -1, 0x02224477, 0x03555588			; delta_frames=1 [4615]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4616]
.long -1, 0x01001166, 0x02223366, 0x03444477			; delta_frames=1 [4617]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4618]
.long -1, 0x02112255, 0x03333366			; delta_frames=1 [4619]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4620]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4642]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4643]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4644]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4645]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4646]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4647]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4648]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4649]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4650]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4651]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4652]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4653]
.long -11, 0x01000044, 0x02111155, 0x03222266			; delta_frames=11 [4664]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4686]
.long -1, 0x0266ccff, 0x03eeeeff			; delta_frames=1 [4687]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4688]
.long -1, 0x013344ee, 0x0255bbee, 0x03ddddee			; delta_frames=1 [4689]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4690]
.long -1, 0x0255aadd, 0x03ccccdd			; delta_frames=1 [4691]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4692]
.long -1, 0x012233cc, 0x024499cc, 0x03bbbbcc			; delta_frames=1 [4693]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4694]
.long -1, 0x024488bb, 0x03aaaabb			; delta_frames=1 [4695]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4696]
.long -1, 0x024477aa			; delta_frames=1 [4697]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4698]
.long -1, 0x02336699, 0x037777aa			; delta_frames=1 [4699]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4700]
.long -1, 0x02335588, 0x03666699			; delta_frames=1 [4701]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4702]
.long -1, 0x02224477, 0x03555588			; delta_frames=1 [4703]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4704]
.long -1, 0x01001166, 0x02223366, 0x03444477			; delta_frames=1 [4705]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4706]
.long -1, 0x02112255, 0x03333366			; delta_frames=1 [4707]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4708]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4730]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4731]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4732]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4733]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4734]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4735]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4736]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4737]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4738]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4739]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4740]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4741]
.long -11, 0x01000044, 0x02111155, 0x03222266			; delta_frames=11 [4752]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4774]
.long -1, 0x0266ccff, 0x03eeeeff			; delta_frames=1 [4775]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4776]
.long -1, 0x013344ee, 0x0255bbee, 0x03ddddee			; delta_frames=1 [4777]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4778]
.long -1, 0x0255aadd, 0x03ccccdd			; delta_frames=1 [4779]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4780]
.long -1, 0x012233cc, 0x024499cc, 0x03bbbbcc			; delta_frames=1 [4781]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4782]
.long -1, 0x024488bb, 0x03aaaabb			; delta_frames=1 [4783]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4784]
.long -1, 0x024477aa			; delta_frames=1 [4785]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4786]
.long -1, 0x02336699, 0x037777aa			; delta_frames=1 [4787]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4788]
.long -1, 0x02335588, 0x03666699			; delta_frames=1 [4789]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4790]
.long -1, 0x02224477, 0x03555588			; delta_frames=1 [4791]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4792]
.long -1, 0x01001166, 0x02223366, 0x03444477			; delta_frames=1 [4793]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4794]
.long -1, 0x02112255, 0x03333366			; delta_frames=1 [4795]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4796]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4818]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4819]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4820]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4821]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4822]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4823]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4824]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4825]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4826]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4827]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4828]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4829]
.long -11, 0x01000044, 0x02111155, 0x03222266			; delta_frames=11 [4840]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4862]
.long -1, 0x0266ccff, 0x03eeeeff			; delta_frames=1 [4863]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4864]
.long -1, 0x013344ee, 0x0255bbee, 0x03ddddee			; delta_frames=1 [4865]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4866]
.long -1, 0x0255aadd, 0x03ccccdd			; delta_frames=1 [4867]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4868]
.long -1, 0x012233cc, 0x024499cc, 0x03bbbbcc			; delta_frames=1 [4869]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4870]
.long -1, 0x024488bb, 0x03aaaabb			; delta_frames=1 [4871]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4872]
.long -1, 0x024477aa			; delta_frames=1 [4873]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4874]
.long -1, 0x02336699, 0x037777aa			; delta_frames=1 [4875]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4876]
.long -1, 0x02335588, 0x03666699			; delta_frames=1 [4877]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4878]
.long -1, 0x02224477, 0x03555588			; delta_frames=1 [4879]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4880]
.long -1, 0x01001166, 0x02223366, 0x03444477			; delta_frames=1 [4881]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4882]
.long -1, 0x02112255, 0x03333366			; delta_frames=1 [4883]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4884]
.long -22, 0x013355ff, 0x0266ddff, 0x03ffffff			; delta_frames=22 [4906]
.long -1, 0x013355ee, 0x0266ccee, 0x03eeeeee			; delta_frames=1 [4907]
.long -1, 0x012244dd, 0x0255bbdd, 0x03dddddd			; delta_frames=1 [4908]
.long -1, 0x012244cc, 0x0255aacc, 0x03bbbbdd			; delta_frames=1 [4909]
.long -1, 0x012233bb, 0x024499bb, 0x03aaaacc			; delta_frames=1 [4910]
.long -1, 0x012233aa, 0x024488aa, 0x039999bb			; delta_frames=1 [4911]
.long -1, 0x01112299, 0x023366aa, 0x038888aa			; delta_frames=1 [4912]
.long -1, 0x01112288, 0x02335599, 0x03777799			; delta_frames=1 [4913]
.long -1, 0x01111177, 0x02224488, 0x03666688			; delta_frames=1 [4914]
.long -1, 0x01111166, 0x02223377, 0x03444488			; delta_frames=1 [4915]
.long -1, 0x01000055, 0x02112266, 0x03333377			; delta_frames=1 [4916]
.long -1, 0x01000044, 0x02111155, 0x03222266			; delta_frames=1 [4917]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05224400, 0x06226644, 0x07cccc88			; delta_frames=22 [4939]
.long -693, 0x00000000, 0x01000044, 0x02111155, 0x03222266, 0x04000000, 0x05002222, 0x06111155, 0x07226644			; delta_frames=693 [5632]
.long -704, 0x05224400, 0x06226644, 0x07cccc88			; delta_frames=704 [6336]
.long -22, 0x00000000, 0x01000044, 0x02111155, 0x03222266			; delta_frames=22 [6358]
.long 0x80000000	; END_SCRIPT.
