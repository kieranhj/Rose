; ============================================================================
; rose2arc.py
; input = examples/everyway/bytecodes.bin.
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
	; BC_CONST [d6]
	ldr r0, [r4, #86*4]			; r0=rConstants[86]
	; BC_CONST [c4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_PROC [07]
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_PROC [07]
	adr r0, proc_54_start		; r0=r_Procedures[54]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_PROC [07]
	adr r0, proc_74_start		; r0=r_Procedures[74]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_PROC [07]
	adr r0, proc_88_start		; r0=r_Procedures[88]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_PROC [07]
	adr r0, proc_101_start		; r0=r_Procedures[101]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_PROC [07]
	adr r0, proc_146_start		; r0=r_Procedures[146]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_PROC [07]
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_WAIT [0a]
	adr r1, proc_0_continue_8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_8:
	; BC_PROC [07]
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_9
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_9:
	; BC_PROC [07]
	adr r0, proc_191_start		; r0=r_Procedures[191]
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
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [d7]
	ldr r0, [r4, #87*4]			; r0=rConstants[87]
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_10
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_10:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_11
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_11:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_12
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_12:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_1_end:

proc_2_start:
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [aa]
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_137_start		; r0=r_Procedures[137]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_13
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_13:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_137_start		; r0=r_Procedures[137]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
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
proc_2_end:

proc_3_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_3_target_14
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_3_continue_15
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_3_continue_15:
	; BC_PROC [07]
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
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
	; BC_ELSE [01]
	b proc_3_target_16
proc_3_target_14:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_3_target_16:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_3_end:

proc_4_start:
	; BC_CONST [a9]
	ldr r0, [r4, #41*4]			; r0=rConstants[41]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [d6]
	ldr r0, [r4, #86*4]			; r0=rConstants[86]
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_186_start		; r0=r_Procedures[186]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_17
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_17:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_4_continue_18
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_18:
	; BC_CONST [cd]
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
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
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_4_continue_19
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_19:
	; BC_CONST [e0]
	ldr r0, [r4, #96*4]			; r0=rConstants[96]
	; BC_CONST [e7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #103*4]			; r0=rConstants[103]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_20
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_20:
	; BC_CONST [d6]
	ldr r0, [r4, #86*4]			; r0=rConstants[86]
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_186_start		; r0=r_Procedures[186]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_WAIT [0a]
	adr r1, proc_4_continue_21
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_21:
	; BC_CONST [cd]
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_CONST [e7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #103*4]			; r0=rConstants[103]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_4_continue_22
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_22:
	; BC_CONST [e0]
	ldr r0, [r4, #96*4]			; r0=rConstants[96]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [b5]
	ldr r0, [r4, #53*4]			; r0=rConstants[53]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_4_end:

proc_5_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_6_start		; r0=r_Procedures[6]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WAIT [0a]
	adr r1, proc_5_continue_23
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_23:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_6_start		; r0=r_Procedures[6]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_5_end:

proc_6_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_6_target_24
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_6_continue_25
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_6_continue_25:
	; BC_RLOCAL [66]
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
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_6_start		; r0=r_Procedures[6]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_6_target_24:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_6_end:

proc_7_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [e6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #102*4]			; r0=rConstants[102]
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
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [e6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #102*4]			; r0=rConstants[102]
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
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_7_end:

proc_8_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_8_target_26
	; BC_CONST [a3]
	ldr r0, [r4, #35*4]			; r0=rConstants[35]
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
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_8_continue_27
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_8_continue_27:
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
	; BC_PROC [07]
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_8_target_26:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_8_end:

proc_9_start:
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [aa]
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_9_continue_28
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_9_continue_28:
	; BC_CONST [e3]
	ldr r0, [r4, #99*4]			; r0=rConstants[99]
	; BC_CONST [e0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #96*4]			; r0=rConstants[96]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_9_continue_29
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_9_continue_29:
	; BC_CONST [c6]
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_CONST [e0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #96*4]			; r0=rConstants[96]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_9_end:

proc_10_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_10_target_30
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
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
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_10_continue_31
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_31:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_10_continue_32
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_32:
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_10_target_30:
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
	beq proc_11_target_33
	; BC_CONST [bb]
	ldr r0, [r4, #59*4]			; r0=rConstants[59]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_12_start		; r0=r_Procedures[12]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_11_continue_34
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_34:
	; BC_PROC [07]
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_11_target_33:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_11_end:

proc_12_start:
	; BC_CONST [d0]
	ldr r0, [r4, #80*4]			; r0=rConstants[80]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_35
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_35:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_36
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_36:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_37
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_37:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [d0]
	ldr r0, [r4, #80*4]			; r0=rConstants[80]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_38
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_38:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_39
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_39:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_40
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_40:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_41
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_41:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_12_end:

proc_13_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_13_target_42
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_13_continue_43
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_13_continue_43:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c7]
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_13_target_42:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_13_end:

proc_14_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_14_target_44
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_14_target_44:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_14_end:

proc_15_start:
	; BC_CONST [d7]
	ldr r0, [r4, #87*4]			; r0=rConstants[87]
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [ae]
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_CONST [ca]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #74*4]			; r0=rConstants[74]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_16_start		; r0=r_Procedures[16]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_15_continue_45
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_45:
	; BC_CONST [ae]
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_CONST [ca]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #74*4]			; r0=rConstants[74]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_16_start		; r0=r_Procedures[16]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_15_continue_46
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_46:
	; BC_CONST [ae]
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_CONST [ca]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #74*4]			; r0=rConstants[74]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_16_start		; r0=r_Procedures[16]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_15_continue_47
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_47:
	; BC_CONST [ae]
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_CONST [ca]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #74*4]			; r0=rConstants[74]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WAIT [0a]
	adr r1, proc_15_continue_48
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_48:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_15_end:

proc_16_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_16_continue_49
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_49:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_50
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_50:
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_16_continue_51
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_51:
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_52
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_52:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_53
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_53:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_54
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_54:
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_55
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_55:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_56
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_56:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_57
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_57:
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_16_continue_58
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_58:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_59
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_59:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_60
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_60:
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_61
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_61:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_62
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_62:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_16_end:

proc_17_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_63
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_63:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_64
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_64:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_65
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_65:
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_17_continue_66
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_66:
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_67
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_67:
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_17_continue_68
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_68:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_69
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_69:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_70
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_70:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_71
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_71:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_72
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_72:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_73
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_73:
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_17_continue_74
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_74:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_75
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_75:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_76
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_76:
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_77
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_77:
	; BC_PROC [07]
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_17_end:

proc_18_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_18_target_78
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_18_target_79
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [85]
	ldr r0, [r4, #5*4]			; r0=rConstants[5]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_18_continue_80
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_18_continue_80:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_18_target_79:
	; BC_DONE [00]
proc_18_target_78:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_18_end:

proc_19_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_19_target_81
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_19_target_82
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [85]
	ldr r0, [r4, #5*4]			; r0=rConstants[5]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_19_continue_83
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_19_continue_83:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_19_target_82:
	; BC_DONE [00]
proc_19_target_81:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_19_end:

proc_20_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_20_target_84
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_20_target_85
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [85]
	ldr r0, [r4, #5*4]			; r0=rConstants[5]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_20_continue_86
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_86:
	; BC_PROC [07]
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_20_target_85:
	; BC_DONE [00]
proc_20_target_84:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_20_end:

proc_21_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c6]
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [d4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #84*4]			; r0=rConstants[84]
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
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [d3]
	ldr r0, [r4, #83*4]			; r0=rConstants[83]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [e5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #101*4]			; r0=rConstants[101]
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
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_21_continue_87
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_87:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_21_end:

proc_22_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c6]
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [d4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #84*4]			; r0=rConstants[84]
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
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [d3]
	ldr r0, [r4, #83*4]			; r0=rConstants[83]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [e5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #101*4]			; r0=rConstants[101]
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
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_88
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_88:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_22_end:

proc_23_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_23_target_89
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_90
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_90:
	; BC_CONST [bf]
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_23_target_89:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_23_target_91
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_92
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_92:
	; BC_CONST [bf]
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_23_target_91:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_23_target_93
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_94
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_94:
	; BC_CONST [bf]
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_23_target_93:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_23_target_95
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_23_target_95:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_23_end:

proc_24_start:
	; BC_PROC [07]
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_24_end:

proc_25_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_38_start		; r0=r_Procedures[38]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_25_continue_96
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_96:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_39_start		; r0=r_Procedures[39]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_25_continue_97
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_97:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_35_start		; r0=r_Procedures[35]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_25_continue_98
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_98:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_30_start		; r0=r_Procedures[30]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_25_continue_99
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_99:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_25_continue_100
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_100:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_34_start		; r0=r_Procedures[34]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_25_continue_101
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_101:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_25_continue_102
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_102:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_25_continue_103
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_103:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_25_end:

proc_26_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_26_continue_104
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_26_continue_104:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_26_end:

proc_27_start:
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_27_continue_105
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_105:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b6]
	ldr r0, [r4, #54*4]			; r0=rConstants[54]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_27_continue_106
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_106:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b4]
	ldr r0, [r4, #52*4]			; r0=rConstants[52]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_27_continue_107
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_107:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_27_continue_108
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_108:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ae]
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_27_continue_109
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_109:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ab]
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_27_continue_110
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_110:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_27_end:

proc_28_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_28_target_111
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_28_continue_112
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_28_continue_112:
	; BC_PROC [07]
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
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
proc_28_target_111:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_28_end:

proc_29_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_29_continue_113
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_29_continue_113:
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_29_end:

proc_30_start:
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_30_continue_114
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_30_continue_114:
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_31_start		; r0=r_Procedures[31]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
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
proc_30_end:

proc_31_start:
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_31_continue_115
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_31_continue_115:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_31_continue_116
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_31_continue_116:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_31_continue_117
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_31_continue_117:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_31_continue_118
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_31_continue_118:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_31_continue_119
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_31_continue_119:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_31_continue_120
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_31_continue_120:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_31_continue_121
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_31_continue_121:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_31_continue_122
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_31_continue_122:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_31_end:

proc_32_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_32_continue_123
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_32_continue_123:
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_32_end:

proc_33_start:
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_33_continue_124
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_33_continue_124:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_33_continue_125
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_33_continue_125:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [a6]
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_33_continue_126
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_33_continue_126:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_33_continue_127
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_33_continue_127:
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_33_end:

proc_34_start:
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_34_continue_128
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_34_continue_128:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [e1]
	ldr r0, [r4, #97*4]			; r0=rConstants[97]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_40_start		; r0=r_Procedures[40]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_40_start		; r0=r_Procedures[40]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_34_end:

proc_35_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_35_continue_129
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_35_continue_129:
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_36_start		; r0=r_Procedures[36]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_36_start		; r0=r_Procedures[36]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_35_end:

proc_36_start:
	; BC_PROC [07]
	adr r0, proc_37_start		; r0=r_Procedures[37]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_37_start		; r0=r_Procedures[37]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_36_end:

proc_37_start:
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_37_continue_130
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_37_continue_130:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_37_continue_131
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_37_continue_131:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_37_continue_132
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_37_continue_132:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_37_continue_133
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_37_continue_133:
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_37_end:

proc_38_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_38_continue_134
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_38_continue_134:
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_38_end:

proc_39_start:
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_39_continue_135
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_39_continue_135:
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_40_start		; r0=r_Procedures[40]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_40_start		; r0=r_Procedures[40]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_39_end:

proc_40_start:
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_136
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_136:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_137
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_137:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_138
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_138:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_139
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_139:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_140
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_140:
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
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_141
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_141:
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
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_142
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_142:
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_143
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_143:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_40_end:

proc_41_start:
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_41_continue_144
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_41_continue_144:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_41_continue_145
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_41_continue_145:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_41_continue_146
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_41_continue_146:
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_41_continue_147
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_41_continue_147:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_41_end:

proc_42_start:
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WAIT [0a]
	adr r1, proc_42_continue_148
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_42_continue_148:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_42_end:

proc_43_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_43_target_149
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_43_continue_150
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_43_continue_150:
	; BC_PROC [07]
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
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
	; BC_ELSE [01]
	b proc_43_target_151
proc_43_target_149:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_43_target_151:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_43_end:

proc_44_start:
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_44_end:

proc_45_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_45_target_152
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_45_continue_153
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_45_continue_153:
	; BC_PROC [07]
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
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
	; BC_ELSE [01]
	b proc_45_target_154
proc_45_target_152:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_45_target_154:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_45_end:

proc_46_start:
	; BC_PROC [07]
	adr r0, proc_47_start		; r0=r_Procedures[47]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_46_continue_155
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_155:
	; BC_PROC [07]
	adr r0, proc_48_start		; r0=r_Procedures[48]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_46_continue_156
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_156:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_46_continue_157
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_157:
	; BC_PROC [07]
	adr r0, proc_50_start		; r0=r_Procedures[50]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_46_continue_158
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_158:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_46_end:

proc_47_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_WAIT [0a]
	adr r1, proc_47_continue_159
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_47_continue_159:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_47_continue_160
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_47_continue_160:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_47_continue_161
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_47_continue_161:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_WAIT [0a]
	adr r1, proc_47_continue_162
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_47_continue_162:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
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
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_WAIT [0a]
	adr r1, proc_48_continue_163
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_48_continue_163:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_48_continue_164
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_48_continue_164:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_48_continue_165
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_48_continue_165:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_WAIT [0a]
	adr r1, proc_48_continue_166
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_48_continue_166:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_48_end:

proc_49_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_167
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_167:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_168
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_168:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_169
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_169:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_170
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_170:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_49_end:

proc_50_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_50_continue_171
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_50_continue_171:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_WAIT [0a]
	adr r1, proc_50_continue_172
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_50_continue_172:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_50_continue_173
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_50_continue_173:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_50_end:

proc_51_start:
	; BC_CONST [c8]
	ldr r0, [r4, #72*4]			; r0=rConstants[72]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_52_start		; r0=r_Procedures[52]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_52_start		; r0=r_Procedures[52]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_52_start		; r0=r_Procedures[52]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_52_start		; r0=r_Procedures[52]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_52_start		; r0=r_Procedures[52]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cb]
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_52_start		; r0=r_Procedures[52]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_51_end:

proc_52_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_52_target_174
	; BC_CONST [ce]
	ldr r0, [r4, #78*4]			; r0=rConstants[78]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_53_start		; r0=r_Procedures[53]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	adr r0, proc_52_start		; r0=r_Procedures[52]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_52_target_174:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_52_end:

proc_53_start:
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_53_target_175
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_53_target_176
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_53_target_176:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_53_continue_177
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_53_continue_177:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_53_target_178
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_53_start		; r0=r_Procedures[53]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
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
	; BC_ELSE [01]
	b proc_53_target_179
proc_53_target_178:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_53_start		; r0=r_Procedures[53]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
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
	; BC_DONE [00]
proc_53_target_179:
	; BC_DONE [00]
proc_53_target_175:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_53_end:

proc_54_start:
	; BC_PROC [07]
	adr r0, proc_70_start		; r0=r_Procedures[70]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_55_start		; r0=r_Procedures[55]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_59_start		; r0=r_Procedures[59]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_54_continue_180
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_54_continue_180:
	; BC_PROC [07]
	adr r0, proc_56_start		; r0=r_Procedures[56]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_60_start		; r0=r_Procedures[60]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_54_end:

proc_55_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_58_start		; r0=r_Procedures[58]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_58_start		; r0=r_Procedures[58]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_55_end:

proc_56_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_56_end:

proc_57_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_57_target_181
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_57_target_182
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_65_start		; r0=r_Procedures[65]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_57_continue_183
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_57_continue_183:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_65_start		; r0=r_Procedures[65]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_57_continue_184
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_57_continue_184:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_WAIT [0a]
	adr r1, proc_57_continue_185
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_57_continue_185:
	; BC_ELSE [01]
	b proc_57_target_186
proc_57_target_182:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_65_start		; r0=r_Procedures[65]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_57_continue_187
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_57_continue_187:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_57_target_186:
	; BC_PROC [07]
	adr r0, proc_57_start		; r0=r_Procedures[57]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_57_target_181:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_57_end:

proc_58_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_58_target_188
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_58_target_189
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_65_start		; r0=r_Procedures[65]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_58_continue_190
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_58_continue_190:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_65_start		; r0=r_Procedures[65]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_58_continue_191
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_58_continue_191:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_WAIT [0a]
	adr r1, proc_58_continue_192
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_58_continue_192:
	; BC_ELSE [01]
	b proc_58_target_193
proc_58_target_189:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_65_start		; r0=r_Procedures[65]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_58_continue_194
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_58_continue_194:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_58_target_193:
	; BC_PROC [07]
	adr r0, proc_58_start		; r0=r_Procedures[58]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_58_target_188:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_58_end:

proc_59_start:
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_62_start		; r0=r_Procedures[62]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_62_start		; r0=r_Procedures[62]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_59_end:

proc_60_start:
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_61_start		; r0=r_Procedures[61]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_61_start		; r0=r_Procedures[61]
	; BC_FORK [21]
	mov r1, #1
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
	beq proc_61_target_195
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_61_continue_196
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_61_continue_196:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_61_target_197
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_ELSE [01]
	b proc_61_target_198
proc_61_target_197:
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_61_target_198:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_61_continue_199
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_61_continue_199:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_61_start		; r0=r_Procedures[61]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_61_target_195:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_61_end:

proc_62_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_62_target_200
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_62_continue_201
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_62_continue_201:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_62_target_202
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_ELSE [01]
	b proc_62_target_203
proc_62_target_202:
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_62_target_203:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
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
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_62_continue_204
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_62_continue_204:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_62_start		; r0=r_Procedures[62]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_62_target_200:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_62_end:

proc_63_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_63_target_205
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_63_continue_206
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_63_continue_206:
	; BC_PROC [07]
	adr r0, proc_63_start		; r0=r_Procedures[63]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_63_target_205:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_63_end:

proc_64_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_64_target_207
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_64_continue_208
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_64_continue_208:
	; BC_PROC [07]
	adr r0, proc_64_start		; r0=r_Procedures[64]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_64_target_207:
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
	beq proc_65_target_209
	; BC_PROC [07]
	adr r0, proc_67_start		; r0=r_Procedures[67]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_65_continue_210
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_65_continue_210:
	; BC_PROC [07]
	adr r0, proc_66_start		; r0=r_Procedures[66]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_65_start		; r0=r_Procedures[65]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_65_target_209:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_65_end:

proc_66_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_66_end:

proc_67_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [a6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
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
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_68_start		; r0=r_Procedures[68]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_69_start		; r0=r_Procedures[69]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_69_start		; r0=r_Procedures[69]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_67_end:

proc_68_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_68_target_211
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a6]
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_68_start		; r0=r_Procedures[68]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_68_target_211:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_68_end:

proc_69_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_69_target_212
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a6]
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [a6]
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_69_start		; r0=r_Procedures[69]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_69_target_212:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_69_end:

proc_70_start:
	; BC_CONST [d8]
	ldr r0, [r4, #88*4]			; r0=rConstants[88]
	; BC_CONST [df]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #95*4]			; r0=rConstants[95]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_71_start		; r0=r_Procedures[71]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_71_start		; r0=r_Procedures[71]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_71_start		; r0=r_Procedures[71]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_71_start		; r0=r_Procedures[71]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_70_continue_213
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_70_continue_213:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_72_start		; r0=r_Procedures[72]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_72_start		; r0=r_Procedures[72]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_72_start		; r0=r_Procedures[72]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_72_start		; r0=r_Procedures[72]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
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
	beq proc_71_target_214
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_73_start		; r0=r_Procedures[73]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_71_continue_215
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_71_continue_215:
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_71_start		; r0=r_Procedures[71]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_71_target_214:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_71_end:

proc_72_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_72_target_216
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_73_start		; r0=r_Procedures[73]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_72_continue_217
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_72_continue_217:
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
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
	adr r0, proc_72_start		; r0=r_Procedures[72]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_72_target_216:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_72_end:

proc_73_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_73_target_218
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
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
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_73_start		; r0=r_Procedures[73]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_73_target_218:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_73_end:

proc_74_start:
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_82_start		; r0=r_Procedures[82]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_74_continue_219
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_74_continue_219:
	; BC_CONST [d0]
	ldr r0, [r4, #80*4]			; r0=rConstants[80]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_82_start		; r0=r_Procedures[82]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_74_continue_220
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_74_continue_220:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
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
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_83_start		; r0=r_Procedures[83]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_74_continue_221
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_74_continue_221:
	; BC_CONST [d0]
	ldr r0, [r4, #80*4]			; r0=rConstants[80]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_83_start		; r0=r_Procedures[83]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_74_continue_222
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_74_continue_222:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_80_start		; r0=r_Procedures[80]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_74_continue_223
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_74_continue_223:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #60*4]			; r0=rConstants[60]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_75_start		; r0=r_Procedures[75]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [bc]
	ldr r0, [r4, #60*4]			; r0=rConstants[60]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_75_start		; r0=r_Procedures[75]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_74_end:

proc_75_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_76_start		; r0=r_Procedures[76]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_75_continue_224
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_224:
	; BC_CONST [bc]
	ldr r0, [r4, #60*4]			; r0=rConstants[60]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_76_start		; r0=r_Procedures[76]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_75_continue_225
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_225:
	; BC_CONST [bc]
	ldr r0, [r4, #60*4]			; r0=rConstants[60]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_76_start		; r0=r_Procedures[76]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_75_continue_226
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_75_continue_226:
	; BC_CONST [bc]
	ldr r0, [r4, #60*4]			; r0=rConstants[60]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_76_start		; r0=r_Procedures[76]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_75_end:

proc_76_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_77_start		; r0=r_Procedures[77]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_76_end:

proc_77_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_77_target_227
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_77_target_228
	; BC_CONST [ae]
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_78_start		; r0=r_Procedures[78]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_ELSE [01]
	b proc_77_target_229
proc_77_target_228:
	; BC_CONST [ae]
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_79_start		; r0=r_Procedures[79]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_77_target_229:
	; BC_CONST [bc]
	ldr r0, [r4, #60*4]			; r0=rConstants[60]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_77_start		; r0=r_Procedures[77]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_77_target_227:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_77_end:

proc_78_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_78_target_230
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_78_continue_231
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_78_continue_231:
	; BC_PROC [07]
	adr r0, proc_78_start		; r0=r_Procedures[78]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_78_target_232
proc_78_target_230:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_78_target_232:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_78_end:

proc_79_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_79_target_233
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_79_continue_234
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_79_continue_234:
	; BC_PROC [07]
	adr r0, proc_79_start		; r0=r_Procedures[79]
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
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
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_79_target_235
proc_79_target_233:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_79_target_235:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_79_end:

proc_80_start:
	; BC_CONST [cc]
	ldr r0, [r4, #76*4]			; r0=rConstants[76]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [cc]
	ldr r0, [r4, #76*4]			; r0=rConstants[76]
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_81_start		; r0=r_Procedures[81]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_WAIT [0a]
	adr r1, proc_80_continue_236
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_80_continue_236:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [d2]
	ldr r0, [r4, #82*4]			; r0=rConstants[82]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [e8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #104*4]			; r0=rConstants[104]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_81_start		; r0=r_Procedures[81]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ab]
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_WAIT [0a]
	adr r1, proc_80_continue_237
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_80_continue_237:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [e2]
	ldr r0, [r4, #98*4]			; r0=rConstants[98]
	; BC_CONST [ec]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #108*4]			; r0=rConstants[108]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_81_start		; r0=r_Procedures[81]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ab]
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_WAIT [0a]
	adr r1, proc_80_continue_238
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_80_continue_238:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [e9]
	ldr r0, [r4, #105*4]			; r0=rConstants[105]
	; BC_CONST [cc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #76*4]			; r0=rConstants[76]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_81_start		; r0=r_Procedures[81]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_80_end:

proc_81_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_81_target_239
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_81_continue_240
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_81_continue_240:
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_81_start		; r0=r_Procedures[81]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_81_target_239:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_81_end:

proc_82_start:
	; BC_CONST [d9]
	ldr r0, [r4, #89*4]			; r0=rConstants[89]
	; BC_CONST [dd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #93*4]			; r0=rConstants[93]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_84_start		; r0=r_Procedures[84]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_84_start		; r0=r_Procedures[84]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_84_start		; r0=r_Procedures[84]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_84_start		; r0=r_Procedures[84]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_82_end:

proc_83_start:
	; BC_CONST [d9]
	ldr r0, [r4, #89*4]			; r0=rConstants[89]
	; BC_CONST [dd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #93*4]			; r0=rConstants[93]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_83_end:

proc_84_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_84_target_241
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_85_start		; r0=r_Procedures[85]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_84_continue_242
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_84_continue_242:
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
	; BC_PROC [07]
	adr r0, proc_84_start		; r0=r_Procedures[84]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_84_target_241:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_84_end:

proc_85_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_85_target_243
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_85_start		; r0=r_Procedures[85]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_85_target_243:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_85_end:

proc_86_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_86_target_244
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_87_start		; r0=r_Procedures[87]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_86_continue_245
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_86_continue_245:
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
	; BC_PROC [07]
	adr r0, proc_86_start		; r0=r_Procedures[86]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_86_target_244:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_86_end:

proc_87_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_87_target_246
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_87_start		; r0=r_Procedures[87]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_87_target_246:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_87_end:

proc_88_start:
	; BC_PROC [07]
	adr r0, proc_89_start		; r0=r_Procedures[89]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_88_continue_247
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_88_continue_247:
	; BC_PROC [07]
	adr r0, proc_95_start		; r0=r_Procedures[95]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_88_continue_248
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_88_continue_248:
	; BC_PROC [07]
	adr r0, proc_93_start		; r0=r_Procedures[93]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_88_end:

proc_89_start:
	; BC_CONST [d9]
	ldr r0, [r4, #89*4]			; r0=rConstants[89]
	; BC_CONST [db]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #91*4]			; r0=rConstants[91]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_90_start		; r0=r_Procedures[90]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_89_continue_249
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_89_continue_249:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_90_start		; r0=r_Procedures[90]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_89_continue_250
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_89_continue_250:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_90_start		; r0=r_Procedures[90]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_89_continue_251
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_89_continue_251:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_90_start		; r0=r_Procedures[90]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_89_continue_252
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_89_continue_252:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_90_start		; r0=r_Procedures[90]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_89_continue_253
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_89_continue_253:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_90_start		; r0=r_Procedures[90]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_89_continue_254
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_89_continue_254:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_90_start		; r0=r_Procedures[90]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_89_end:

proc_90_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_90_target_255
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_91_start		; r0=r_Procedures[91]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_WAIT [0a]
	adr r1, proc_90_continue_256
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_90_continue_256:
	; BC_PROC [07]
	adr r0, proc_90_start		; r0=r_Procedures[90]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
	b proc_90_target_257
proc_90_target_255:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_91_start		; r0=r_Procedures[91]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_DONE [00]
proc_90_target_257:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_90_end:

proc_91_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_91_target_258
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_92_start		; r0=r_Procedures[92]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_91_continue_259
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_91_continue_259:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_91_start		; r0=r_Procedures[91]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_91_target_258:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_91_end:

proc_92_start:
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_92_target_260
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_92_continue_261
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_92_continue_261:
	; BC_PROC [07]
	adr r0, proc_92_start		; r0=r_Procedures[92]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_92_target_260:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_92_end:

proc_93_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_94_start		; r0=r_Procedures[94]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_93_continue_262
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_93_continue_262:
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_94_start		; r0=r_Procedures[94]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_93_continue_263
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_93_continue_263:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_94_start		; r0=r_Procedures[94]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_WAIT [0a]
	adr r1, proc_93_continue_264
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_93_continue_264:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_94_start		; r0=r_Procedures[94]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_93_end:

proc_94_start:
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_94_continue_265
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_94_continue_265:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_94_end:

proc_95_start:
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_95_continue_266
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_95_continue_266:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_WAIT [0a]
	adr r1, proc_95_continue_267
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_95_continue_267:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
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
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_WAIT [0a]
	adr r1, proc_95_continue_268
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_95_continue_268:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_WAIT [0a]
	adr r1, proc_95_continue_269
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_95_continue_269:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_95_end:

proc_96_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_96_target_270
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_97_start		; r0=r_Procedures[97]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_WAIT [0a]
	adr r1, proc_96_continue_271
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_96_continue_271:
	; BC_PROC [07]
	adr r0, proc_96_start		; r0=r_Procedures[96]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_96_target_270:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_96_end:

proc_97_start:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_WSTATE [50]
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
	beq proc_98_target_272
	; BC_PROC [07]
	adr r0, proc_99_start		; r0=r_Procedures[99]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_98_continue_273
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_98_continue_273:
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_98_start		; r0=r_Procedures[98]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_98_target_272:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_98_end:

proc_99_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_100_start		; r0=r_Procedures[100]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_99_continue_274
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_99_continue_274:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
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
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [a6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
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
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1e]
	bgt proc_100_target_275
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
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
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_100_target_276
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_ELSE [01]
	b proc_100_target_277
proc_100_target_276:
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_100_target_277:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_100_continue_278
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_100_continue_278:
	; BC_PROC [07]
	adr r0, proc_100_start		; r0=r_Procedures[100]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_100_target_275:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_100_end:

proc_101_start:
	; BC_CONST [d9]
	ldr r0, [r4, #89*4]			; r0=rConstants[89]
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_118_start		; r0=r_Procedures[118]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_135_start		; r0=r_Procedures[135]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_101_continue_279
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_101_continue_279:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_101_continue_280
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_101_continue_280:
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_101_continue_281
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_101_continue_281:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_101_continue_282
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_101_continue_282:
	; BC_PROC [07]
	adr r0, proc_102_start		; r0=r_Procedures[102]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c3]
	ldr r0, [r4, #67*4]			; r0=rConstants[67]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_118_start		; r0=r_Procedures[118]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_135_start		; r0=r_Procedures[135]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_108_start		; r0=r_Procedures[108]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_101_continue_283
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_101_continue_283:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_108_start		; r0=r_Procedures[108]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_101_continue_284
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_101_continue_284:
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_108_start		; r0=r_Procedures[108]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_101_continue_285
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_101_continue_285:
	; BC_CONST [c3]
	ldr r0, [r4, #67*4]			; r0=rConstants[67]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_118_start		; r0=r_Procedures[118]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_101_continue_286
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_101_continue_286:
	; BC_CONST [c3]
	ldr r0, [r4, #67*4]			; r0=rConstants[67]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_117_start		; r0=r_Procedures[117]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_101_end:

proc_102_start:
	; BC_CONST [d9]
	ldr r0, [r4, #89*4]			; r0=rConstants[89]
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [d0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #80*4]			; r0=rConstants[80]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_103_start		; r0=r_Procedures[103]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_102_continue_287
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_102_continue_287:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_CONST [d0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #80*4]			; r0=rConstants[80]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_103_start		; r0=r_Procedures[103]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_102_continue_288
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_102_continue_288:
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [d0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #80*4]			; r0=rConstants[80]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_103_start		; r0=r_Procedures[103]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_102_continue_289
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_102_continue_289:
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [d0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #80*4]			; r0=rConstants[80]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_103_start		; r0=r_Procedures[103]
	; BC_FORK [23]
	mov r1, #3
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
	beq proc_103_target_290
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_104_start		; r0=r_Procedures[104]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_103_continue_291
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_103_continue_291:
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
	; BC_PROC [07]
	adr r0, proc_103_start		; r0=r_Procedures[103]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_103_target_290:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_103_end:

proc_104_start:
	; BC_CONST [dc]
	ldr r0, [r4, #92*4]			; r0=rConstants[92]
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
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_105_start		; r0=r_Procedures[105]
	; BC_FORK [22]
	mov r1, #2
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
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_106_start		; r0=r_Procedures[106]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b4]
	ldr r0, [r4, #52*4]			; r0=rConstants[52]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_105_continue_293
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_105_continue_293:
	; BC_PROC [07]
	adr r0, proc_105_start		; r0=r_Procedures[105]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1d]
	blt proc_106_target_294
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_WAIT [0a]
	adr r1, proc_106_continue_295
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_106_continue_295:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_107_start		; r0=r_Procedures[107]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_106_start		; r0=r_Procedures[106]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_106_target_294:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_106_end:

proc_107_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_107_end:

proc_108_start:
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_108_continue_296
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_108_continue_296:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_114_start		; r0=r_Procedures[114]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	adr r0, proc_114_start		; r0=r_Procedures[114]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_108_continue_297
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_108_continue_297:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_111_start		; r0=r_Procedures[111]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_111_start		; r0=r_Procedures[111]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_108_end:

proc_109_start:
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_109_continue_298
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_109_continue_298:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_114_start		; r0=r_Procedures[114]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	adr r0, proc_114_start		; r0=r_Procedures[114]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_109_continue_299
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_109_continue_299:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_110_start		; r0=r_Procedures[110]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_110_start		; r0=r_Procedures[110]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_109_end:

proc_110_start:
	; BC_CONST [d1]
	ldr r0, [r4, #81*4]			; r0=rConstants[81]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
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
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_112_start		; r0=r_Procedures[112]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_110_continue_300
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_110_continue_300:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_113_start		; r0=r_Procedures[113]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_110_end:

proc_111_start:
	; BC_CONST [d1]
	ldr r0, [r4, #81*4]			; r0=rConstants[81]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_112_start		; r0=r_Procedures[112]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_111_continue_301
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_111_continue_301:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_113_start		; r0=r_Procedures[113]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_111_end:

proc_112_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_112_target_302
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ba]
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_CONST [d1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #81*4]			; r0=rConstants[81]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ba]
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_CONST [d1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #81*4]			; r0=rConstants[81]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_112_continue_303
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_112_continue_303:
	; BC_PROC [07]
	adr r0, proc_112_start		; r0=r_Procedures[112]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_112_target_302:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_112_end:

proc_113_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_113_target_304
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [d1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #81*4]			; r0=rConstants[81]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [d1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #81*4]			; r0=rConstants[81]
	; BC_DIV [09]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement divs.w overflow behaviour!
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl divide					; r0=r0/r1
	ldr lr, [sp], #4			; Pop lr off program stack.
	mov r0, r0, asl #8
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_113_continue_305
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_113_continue_305:
	; BC_PROC [07]
	adr r0, proc_113_start		; r0=r_Procedures[113]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_113_target_304:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_113_end:

proc_114_start:
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_115_start		; r0=r_Procedures[115]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_114_continue_306
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_114_continue_306:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_115_start		; r0=r_Procedures[115]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_114_end:

proc_115_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_115_target_307
	; BC_PROC [07]
	adr r0, proc_116_start		; r0=r_Procedures[116]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
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
	; BC_PROC [07]
	adr r0, proc_116_start		; r0=r_Procedures[116]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
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
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_115_continue_308
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_115_continue_308:
	; BC_PROC [07]
	adr r0, proc_115_start		; r0=r_Procedures[115]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_115_target_307:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_115_end:

proc_116_start:
	; BC_CONST [d1]
	ldr r0, [r4, #81*4]			; r0=rConstants[81]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_116_end:

proc_117_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_122_start		; r0=r_Procedures[122]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_117_continue_309
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_117_continue_309:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_117_continue_310
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_117_continue_310:
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_117_continue_311
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_117_continue_311:
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c2]
	ldr r0, [r4, #66*4]			; r0=rConstants[66]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_123_start		; r0=r_Procedures[123]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_117_continue_312
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_117_continue_312:
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [bf]
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_125_start		; r0=r_Procedures[125]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_117_continue_313
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_117_continue_313:
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_123_start		; r0=r_Procedures[123]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_117_continue_314
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_117_continue_314:
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b5]
	ldr r0, [r4, #53*4]			; r0=rConstants[53]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_129_start		; r0=r_Procedures[129]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_117_continue_315
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_117_continue_315:
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_123_start		; r0=r_Procedures[123]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_117_continue_316
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_117_continue_316:
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_120_start		; r0=r_Procedures[120]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_117_continue_317
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_117_continue_317:
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_CONST [c4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_119_start		; r0=r_Procedures[119]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_WAIT [0a]
	adr r1, proc_117_continue_318
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_117_continue_318:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_117_end:

proc_118_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_118_target_319
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_119_start		; r0=r_Procedures[119]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_WAIT [0a]
	adr r1, proc_118_continue_320
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_118_continue_320:
	; BC_CONST [ab]
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_119_start		; r0=r_Procedures[119]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_WAIT [0a]
	adr r1, proc_118_continue_321
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_118_continue_321:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_119_start		; r0=r_Procedures[119]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_118_continue_322
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_118_continue_322:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
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
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_119_start		; r0=r_Procedures[119]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_118_continue_323
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_118_continue_323:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_119_start		; r0=r_Procedures[119]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_118_target_324
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_118_continue_325
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_118_continue_325:
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_119_start		; r0=r_Procedures[119]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_WAIT [0a]
	adr r1, proc_118_continue_326
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_118_continue_326:
	; BC_CONST [ab]
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_119_start		; r0=r_Procedures[119]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_WAIT [0a]
	adr r1, proc_118_continue_327
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_118_continue_327:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_119_start		; r0=r_Procedures[119]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_118_continue_328
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_118_continue_328:
	; BC_DONE [00]
proc_118_target_324:
	; BC_PROC [07]
	adr r0, proc_118_start		; r0=r_Procedures[118]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_118_target_319:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_118_end:

proc_119_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1d]
	blt proc_119_target_329
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_121_start		; r0=r_Procedures[121]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_119_continue_330
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_119_continue_330:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_119_target_331
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_119_target_331:
	; BC_PROC [07]
	adr r0, proc_119_start		; r0=r_Procedures[119]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
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
proc_119_target_329:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_119_end:

proc_120_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1d]
	blt proc_120_target_332
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_121_start		; r0=r_Procedures[121]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_120_continue_333
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_120_continue_333:
	; BC_PROC [07]
	adr r0, proc_120_start		; r0=r_Procedures[120]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
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
proc_120_target_332:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_120_end:

proc_121_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_121_target_334
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_122_start		; r0=r_Procedures[122]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_121_target_334:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_121_target_335
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_123_start		; r0=r_Procedures[123]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_121_target_335:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_121_target_336
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_124_start		; r0=r_Procedures[124]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_121_target_336:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_121_target_337
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_125_start		; r0=r_Procedures[125]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_121_target_337:
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_121_target_338
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_126_start		; r0=r_Procedures[126]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_121_target_338:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_121_target_339
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_127_start		; r0=r_Procedures[127]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_121_target_339:
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_121_target_340
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_128_start		; r0=r_Procedures[128]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_121_target_340:
	; BC_CONST [a4]
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_121_target_341
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_129_start		; r0=r_Procedures[129]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_121_target_341:
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_121_target_342
	; BC_PROC [07]
	adr r0, proc_130_start		; r0=r_Procedures[130]
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_121_target_342:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_121_end:

proc_122_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_131_start		; r0=r_Procedures[131]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_131_start		; r0=r_Procedures[131]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_131_start		; r0=r_Procedures[131]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_122_end:

proc_123_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_132_start		; r0=r_Procedures[132]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_132_start		; r0=r_Procedures[132]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_132_start		; r0=r_Procedures[132]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_123_end:

proc_124_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_133_start		; r0=r_Procedures[133]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_133_start		; r0=r_Procedures[133]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_133_start		; r0=r_Procedures[133]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_124_end:

proc_125_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_134_start		; r0=r_Procedures[134]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_134_start		; r0=r_Procedures[134]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_134_start		; r0=r_Procedures[134]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_125_end:

proc_126_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_131_start		; r0=r_Procedures[131]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_132_start		; r0=r_Procedures[132]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_133_start		; r0=r_Procedures[133]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_126_end:

proc_127_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_134_start		; r0=r_Procedures[134]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_133_start		; r0=r_Procedures[133]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_132_start		; r0=r_Procedures[132]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_127_end:

proc_128_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_131_start		; r0=r_Procedures[131]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_131_start		; r0=r_Procedures[131]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_134_start		; r0=r_Procedures[134]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_128_end:

proc_129_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_133_start		; r0=r_Procedures[133]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_133_start		; r0=r_Procedures[133]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_132_start		; r0=r_Procedures[132]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_129_end:

proc_130_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_131_start		; r0=r_Procedures[131]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_133_start		; r0=r_Procedures[133]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_132_start		; r0=r_Procedures[132]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_130_end:

proc_131_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
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
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_131_end:

proc_132_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_132_end:

proc_133_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_133_end:

proc_134_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
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
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_134_end:

proc_135_start:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_135_continue_343
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_135_continue_343:
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_140_start		; r0=r_Procedures[140]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_135_continue_344
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_135_continue_344:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_136_start		; r0=r_Procedures[136]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_135_continue_345
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_135_continue_345:
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_140_start		; r0=r_Procedures[140]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_135_continue_346
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_135_continue_346:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_136_start		; r0=r_Procedures[136]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_135_continue_347
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_135_continue_347:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_140_start		; r0=r_Procedures[140]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_135_continue_348
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_135_continue_348:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_136_start		; r0=r_Procedures[136]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a4]
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_135_continue_349
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_135_continue_349:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_135_target_350
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_142_start		; r0=r_Procedures[142]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_135_continue_351
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_135_continue_351:
	; BC_CONST [e1]
	ldr r0, [r4, #97*4]			; r0=rConstants[97]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_136_start		; r0=r_Procedures[136]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_136_start		; r0=r_Procedures[136]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_CONST [9f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_CONST [8c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_141_start		; r0=r_Procedures[141]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_135_continue_352
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_135_continue_352:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_136_start		; r0=r_Procedures[136]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_136_start		; r0=r_Procedures[136]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_CONST [9f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_CONST [8c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_141_start		; r0=r_Procedures[141]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_135_continue_353
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_135_continue_353:
	; BC_DONE [00]
proc_135_target_350:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_135_end:

proc_136_start:
	; BC_CONST [c5]
	ldr r0, [r4, #69*4]			; r0=rConstants[69]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [aa]
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_137_start		; r0=r_Procedures[137]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WAIT [0a]
	adr r1, proc_136_continue_354
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_136_continue_354:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_137_start		; r0=r_Procedures[137]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
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
proc_136_end:

proc_137_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_137_target_355
	; BC_PROC [07]
	adr r0, proc_138_start		; r0=r_Procedures[138]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
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
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_137_continue_356
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_137_continue_356:
	; BC_PROC [07]
	adr r0, proc_137_start		; r0=r_Procedures[137]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_137_target_355:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_137_end:

proc_138_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [ae]
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_139_start		; r0=r_Procedures[139]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_139_start		; r0=r_Procedures[139]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_138_end:

proc_139_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_139_target_357
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_139_start		; r0=r_Procedures[139]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_139_target_357:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_139_end:

proc_140_start:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [bd]
	ldr r0, [r4, #61*4]			; r0=rConstants[61]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_142_start		; r0=r_Procedures[142]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_140_continue_358
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_140_continue_358:
	; BC_CONST [af]
	ldr r0, [r4, #47*4]			; r0=rConstants[47]
	; BC_CONST [9f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_CONST [8d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_141_start		; r0=r_Procedures[141]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_140_end:

proc_141_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_141_target_359
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_144_start		; r0=r_Procedures[144]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_141_continue_360
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_141_continue_360:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_143_start		; r0=r_Procedures[143]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_141_start		; r0=r_Procedures[141]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
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
proc_141_target_359:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_141_end:

proc_142_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_142_target_361
	; BC_CONST [9f]
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_143_start		; r0=r_Procedures[143]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9f]
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_144_start		; r0=r_Procedures[144]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
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
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_142_continue_362
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_142_continue_362:
	; BC_PROC [07]
	adr r0, proc_142_start		; r0=r_Procedures[142]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_142_target_361:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_142_end:

proc_143_start:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
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
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [c5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #69*4]			; r0=rConstants[69]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_143_target_363
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
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
	b proc_143_target_364
proc_143_target_363:
	; BC_CONST [c5]
	ldr r0, [r4, #69*4]			; r0=rConstants[69]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DONE [00]
proc_143_target_364:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_143_end:

proc_144_start:
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
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
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
	adr r0, proc_145_start		; r0=r_Procedures[145]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_145_start		; r0=r_Procedures[145]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_145_start		; r0=r_Procedures[145]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_145_start		; r0=r_Procedures[145]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_144_end:

proc_145_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_145_target_365
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
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
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_145_start		; r0=r_Procedures[145]
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_145_target_365:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_145_end:

proc_146_start:
	; BC_CONST [d6]
	ldr r0, [r4, #86*4]			; r0=rConstants[86]
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_186_start		; r0=r_Procedures[186]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_146_continue_366
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_146_continue_366:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [da]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #90*4]			; r0=rConstants[90]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_CONST [da]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #90*4]			; r0=rConstants[90]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_161_start		; r0=r_Procedures[161]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_146_continue_367
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_146_continue_367:
	; BC_PROC [07]
	adr r0, proc_147_start		; r0=r_Procedures[147]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_146_continue_368
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_146_continue_368:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [da]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #90*4]			; r0=rConstants[90]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [de]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #94*4]			; r0=rConstants[94]
	; BC_CONST [da]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #90*4]			; r0=rConstants[90]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_161_start		; r0=r_Procedures[161]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_146_continue_369
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_146_continue_369:
	; BC_PROC [07]
	adr r0, proc_148_start		; r0=r_Procedures[148]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_146_continue_370
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_146_continue_370:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_146_end:

proc_147_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [cd]
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_152_start		; r0=r_Procedures[152]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_147_continue_371
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_147_continue_371:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_149_start		; r0=r_Procedures[149]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_147_continue_372
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_147_continue_372:
	; BC_CONST [df]
	ldr r0, [r4, #95*4]			; r0=rConstants[95]
	; BC_CONST [eb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #107*4]			; r0=rConstants[107]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_152_start		; r0=r_Procedures[152]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_147_continue_373
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_147_continue_373:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_149_start		; r0=r_Procedures[149]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_147_continue_374
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_147_continue_374:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [d9]
	ldr r0, [r4, #89*4]			; r0=rConstants[89]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_152_start		; r0=r_Procedures[152]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_147_continue_375
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_147_continue_375:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_150_start		; r0=r_Procedures[150]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_147_continue_376
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_147_continue_376:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_CONST [c0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
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
proc_147_end:

proc_148_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_CONST [d3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #83*4]			; r0=rConstants[83]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_152_start		; r0=r_Procedures[152]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_148_continue_377
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_148_continue_377:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_149_start		; r0=r_Procedures[149]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_148_continue_378
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_148_continue_378:
	; BC_CONST [e4]
	ldr r0, [r4, #100*4]			; r0=rConstants[100]
	; BC_CONST [ea]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #106*4]			; r0=rConstants[106]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [e1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #97*4]			; r0=rConstants[97]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_152_start		; r0=r_Procedures[152]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_148_continue_379
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_148_continue_379:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_149_start		; r0=r_Procedures[149]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_148_continue_380
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_148_continue_380:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [d9]
	ldr r0, [r4, #89*4]			; r0=rConstants[89]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_152_start		; r0=r_Procedures[152]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_148_continue_381
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_148_continue_381:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [9e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_151_start		; r0=r_Procedures[151]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_148_continue_382
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_148_continue_382:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_CONST [c0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
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
proc_148_end:

proc_149_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_149_continue_383
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_149_continue_383:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_149_continue_384
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_149_continue_384:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_149_continue_385
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_149_continue_385:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_149_continue_386
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_149_continue_386:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WAIT [0a]
	adr r1, proc_149_continue_387
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_149_continue_387:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_CONST [c0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_149_end:

proc_150_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_150_continue_388
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_150_continue_388:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_150_continue_389
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_150_continue_389:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_150_continue_390
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_150_continue_390:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_150_continue_391
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_150_continue_391:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_150_continue_392
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_150_continue_392:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_150_continue_393
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_150_continue_393:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_150_continue_394
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_150_continue_394:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WAIT [0a]
	adr r1, proc_150_continue_395
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_150_continue_395:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
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
	; BC_WAIT [0a]
	adr r1, proc_150_continue_396
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_150_continue_396:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
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
	; BC_WAIT [0a]
	adr r1, proc_150_continue_397
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_150_continue_397:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WLOCAL [42]
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
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
proc_150_end:

proc_151_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_151_continue_398
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_151_continue_398:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_151_continue_399
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_151_continue_399:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_151_continue_400
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_151_continue_400:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_151_continue_401
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_151_continue_401:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_151_continue_402
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_151_continue_402:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WAIT [0a]
	adr r1, proc_151_continue_403
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_151_continue_403:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_151_continue_404
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_151_continue_404:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WAIT [0a]
	adr r1, proc_151_continue_405
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_151_continue_405:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
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
	; BC_WAIT [0a]
	adr r1, proc_151_continue_406
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_151_continue_406:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
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
	; BC_WAIT [0a]
	adr r1, proc_151_continue_407
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_151_continue_407:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_156_start		; r0=r_Procedures[156]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WLOCAL [42]
	str r0, [r5, #-3*4]			; StateStack[-3]=r0
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
proc_151_end:

proc_152_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_152_target_408
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a4]
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_154_start		; r0=r_Procedures[154]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_152_continue_409
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_152_continue_409:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
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
	; BC_PROC [07]
	adr r0, proc_155_start		; r0=r_Procedures[155]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_152_start		; r0=r_Procedures[152]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
proc_152_target_408:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_152_end:

proc_153_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_153_target_410
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [a4]
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_154_start		; r0=r_Procedures[154]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_153_continue_411
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_153_continue_411:
	; BC_PROC [07]
	adr r0, proc_153_start		; r0=r_Procedures[153]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_153_target_410:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_153_end:

proc_154_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_154_target_412
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_154_start		; r0=r_Procedures[154]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_154_target_412:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_154_end:

proc_155_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b4]
	ldr r0, [r4, #52*4]			; r0=rConstants[52]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_155_end:

proc_156_start:
	; BC_RSTATE [71]
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_198_start		; r0=r_Procedures[198]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_156_continue_413
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_156_continue_413:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_199_start		; r0=r_Procedures[199]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_156_continue_414
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_156_continue_414:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_198_start		; r0=r_Procedures[198]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_156_continue_415
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_156_continue_415:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_200_start		; r0=r_Procedures[200]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_156_continue_416
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_156_continue_416:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_201_start		; r0=r_Procedures[201]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_156_continue_417
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_156_continue_417:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_202_start		; r0=r_Procedures[202]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_156_continue_418
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_156_continue_418:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_203_start		; r0=r_Procedures[203]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_156_continue_419
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_156_continue_419:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_201_start		; r0=r_Procedures[201]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_156_continue_420
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_156_continue_420:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_156_end:

proc_157_start:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_158_start		; r0=r_Procedures[158]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_157_end:

proc_158_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_158_target_421
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_158_target_422
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_ELSE [01]
	b proc_158_target_423
proc_158_target_422:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_DONE [00]
proc_158_target_423:
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WHEN [17]
	beq proc_158_target_424
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_158_target_424:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_158_start		; r0=r_Procedures[158]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
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
proc_158_target_421:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_158_end:

proc_159_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_159_target_425
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_159_target_426
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_ELSE [01]
	b proc_159_target_427
proc_159_target_426:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_DONE [00]
proc_159_target_427:
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WHEN [17]
	beq proc_159_target_428
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_159_target_428:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_159_start		; r0=r_Procedures[159]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
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
proc_159_target_425:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_159_end:

proc_160_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1e]
	bgt proc_160_target_429
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_160_continue_430
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_160_continue_430:
	; BC_PROC [07]
	adr r0, proc_160_start		; r0=r_Procedures[160]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_160_target_429:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_160_end:

proc_161_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_161_target_431
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [83]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #3*4]			; r0=rConstants[3]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_171_start		; r0=r_Procedures[171]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_162_start		; r0=r_Procedures[162]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_161_continue_432
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_161_continue_432:
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_174_start		; r0=r_Procedures[174]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_161_continue_433
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_161_continue_433:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
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
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [a0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #32*4]			; r0=rConstants[32]
	; BC_CONST [83]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #3*4]			; r0=rConstants[3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_171_start		; r0=r_Procedures[171]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_161_continue_434
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_161_continue_434:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_161_start		; r0=r_Procedures[161]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_161_target_431:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_161_end:

proc_162_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_167_start		; r0=r_Procedures[167]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_162_continue_435
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_162_continue_435:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_167_start		; r0=r_Procedures[167]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_162_continue_436
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_162_continue_436:
	; BC_PROC [07]
	adr r0, proc_163_start		; r0=r_Procedures[163]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_162_continue_437
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_162_continue_437:
	; BC_PROC [07]
	adr r0, proc_163_start		; r0=r_Procedures[163]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_162_continue_438
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_162_continue_438:
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_162_continue_439
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_162_continue_439:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_168_start		; r0=r_Procedures[168]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_162_target_440
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_166_start		; r0=r_Procedures[166]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_162_target_440:
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WAIT [0a]
	adr r1, proc_162_continue_441
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_162_continue_441:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_168_start		; r0=r_Procedures[168]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_162_target_442
	; BC_PROC [07]
	adr r0, proc_166_start		; r0=r_Procedures[166]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
proc_162_target_442:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_162_end:

proc_163_start:
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_164_start		; r0=r_Procedures[164]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_164_start		; r0=r_Procedures[164]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_164_start		; r0=r_Procedures[164]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_164_start		; r0=r_Procedures[164]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
proc_163_end:

proc_164_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_164_target_443
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_165_start		; r0=r_Procedures[165]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
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
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_165_start		; r0=r_Procedures[165]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [92]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
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
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_164_continue_444
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_164_continue_444:
	; BC_PROC [07]
	adr r0, proc_164_start		; r0=r_Procedures[164]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_164_target_443:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_164_end:

proc_165_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_165_end:

proc_166_start:
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #5*4]			; r0=rConstants[5]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_170_start		; r0=r_Procedures[170]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_166_end:

proc_167_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_170_start		; r0=r_Procedures[170]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_170_start		; r0=r_Procedures[170]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_170_start		; r0=r_Procedures[170]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_170_start		; r0=r_Procedures[170]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
proc_167_end:

proc_168_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_169_start		; r0=r_Procedures[169]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_169_start		; r0=r_Procedures[169]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_169_start		; r0=r_Procedures[169]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_169_start		; r0=r_Procedures[169]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
proc_168_end:

proc_169_start:
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_169_target_445
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_169_continue_446
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_169_continue_446:
	; BC_PROC [07]
	adr r0, proc_170_start		; r0=r_Procedures[170]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_169_target_445:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_169_end:

proc_170_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_170_target_447
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_170_continue_448
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_170_continue_448:
	; BC_PROC [07]
	adr r0, proc_170_start		; r0=r_Procedures[170]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_170_target_447:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_170_end:

proc_171_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_171_target_449
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_177_start		; r0=r_Procedures[177]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_171_continue_450
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_171_continue_450:
	; BC_PROC [07]
	adr r0, proc_172_start		; r0=r_Procedures[172]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_171_start		; r0=r_Procedures[171]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
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
proc_171_target_449:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_171_end:

proc_172_start:
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PROC [07]
	adr r0, proc_173_start		; r0=r_Procedures[173]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_173_start		; r0=r_Procedures[173]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_173_start		; r0=r_Procedures[173]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_173_start		; r0=r_Procedures[173]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_172_end:

proc_173_start:
	; BC_CONST [bf]
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_173_end:

proc_174_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_174_target_451
	; BC_CONST [9f]
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_177_start		; r0=r_Procedures[177]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
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
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_174_continue_452
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_174_continue_452:
	; BC_CONST [9f]
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_176_start		; r0=r_Procedures[176]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_174_start		; r0=r_Procedures[174]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_174_target_451:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_174_end:

proc_175_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_175_target_453
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_177_start		; r0=r_Procedures[177]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
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
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_175_continue_454
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_175_continue_454:
	; BC_PROC [07]
	adr r0, proc_175_start		; r0=r_Procedures[175]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_175_target_453:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_175_end:

proc_176_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [cc]
	ldr r0, [r4, #76*4]			; r0=rConstants[76]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_176_end:

proc_177_start:
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
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_179_start		; r0=r_Procedures[179]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_179_start		; r0=r_Procedures[179]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_179_start		; r0=r_Procedures[179]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_179_start		; r0=r_Procedures[179]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_177_end:

proc_178_start:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_178_target_455
	; BC_CONST [96]
	ldr r0, [r4, #22*4]			; r0=rConstants[22]
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
	; BC_CONST [88]
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
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
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_178_target_456
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_178_target_456:
	; BC_PROC [07]
	adr r0, proc_178_start		; r0=r_Procedures[178]
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
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_178_target_455:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_178_end:

proc_179_start:
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_179_target_457
	; BC_CONST [96]
	ldr r0, [r4, #22*4]			; r0=rConstants[22]
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
	; BC_CONST [88]
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
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
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_179_target_458
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_179_target_458:
	; BC_PROC [07]
	adr r0, proc_178_start		; r0=r_Procedures[178]
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
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_179_target_457:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_179_end:

proc_180_start:
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_183_start		; r0=r_Procedures[183]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_180_continue_459
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_180_continue_459:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_181_start		; r0=r_Procedures[181]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_180_continue_460
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_180_continue_460:
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
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
	adr r0, proc_183_start		; r0=r_Procedures[183]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_180_continue_461
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_180_continue_461:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_181_start		; r0=r_Procedures[181]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_180_continue_462
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_180_continue_462:
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
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
	adr r0, proc_183_start		; r0=r_Procedures[183]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_180_continue_463
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_180_continue_463:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_181_start		; r0=r_Procedures[181]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_180_continue_464
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_180_continue_464:
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
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
	adr r0, proc_183_start		; r0=r_Procedures[183]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_180_continue_465
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_180_continue_465:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_181_start		; r0=r_Procedures[181]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_180_continue_466
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_180_continue_466:
	; BC_CONST [b9]
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
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
proc_180_end:

proc_181_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_181_target_467
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_183_start		; r0=r_Procedures[183]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_181_continue_468
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_181_continue_468:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_182_start		; r0=r_Procedures[182]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_181_start		; r0=r_Procedures[181]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_181_target_467:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_181_end:

proc_182_start:
	; BC_CONST [b5]
	ldr r0, [r4, #53*4]			; r0=rConstants[53]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_183_start		; r0=r_Procedures[183]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_182_end:

proc_183_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_184_start		; r0=r_Procedures[184]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_184_start		; r0=r_Procedures[184]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	adr r0, proc_184_start		; r0=r_Procedures[184]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_183_end:

proc_184_start:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_185_start		; r0=r_Procedures[185]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_184_end:

proc_185_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_185_target_469
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_185_start		; r0=r_Procedures[185]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_185_target_469:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_185_end:

proc_186_start:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_186_continue_470
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_186_continue_470:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_187_start		; r0=r_Procedures[187]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_WAIT [0a]
	adr r1, proc_186_continue_471
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_186_continue_471:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_187_start		; r0=r_Procedures[187]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_WAIT [0a]
	adr r1, proc_186_continue_472
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_186_continue_472:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_187_start		; r0=r_Procedures[187]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_WAIT [0a]
	adr r1, proc_186_continue_473
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_186_continue_473:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_187_start		; r0=r_Procedures[187]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_WAIT [0a]
	adr r1, proc_186_continue_474
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_186_continue_474:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_187_start		; r0=r_Procedures[187]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_WAIT [0a]
	adr r1, proc_186_continue_475
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_186_continue_475:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_187_start		; r0=r_Procedures[187]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_WAIT [0a]
	adr r1, proc_186_continue_476
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_186_continue_476:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_187_start		; r0=r_Procedures[187]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_WAIT [0a]
	adr r1, proc_186_continue_477
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_186_continue_477:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_187_start		; r0=r_Procedures[187]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_WAIT [0a]
	adr r1, proc_186_continue_478
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_186_continue_478:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [bf]
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_187_start		; r0=r_Procedures[187]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_186_end:

proc_187_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_188_start		; r0=r_Procedures[188]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_WAIT [0a]
	adr r1, proc_187_continue_479
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_187_continue_479:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_188_start		; r0=r_Procedures[188]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_187_end:

proc_188_start:
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
	; BC_CONST [84]
	ldr r0, [r4, #4*4]			; r0=rConstants[4]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [bb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #59*4]			; r0=rConstants[59]
	; BC_CONST [86]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #6*4]			; r0=rConstants[6]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_190_start		; r0=r_Procedures[190]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
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
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
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
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [84]
	ldr r0, [r4, #4*4]			; r0=rConstants[4]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [bb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #59*4]			; r0=rConstants[59]
	; BC_CONST [86]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #6*4]			; r0=rConstants[6]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_190_start		; r0=r_Procedures[190]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_188_end:

proc_189_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_189_target_480
	; BC_CONST [84]
	ldr r0, [r4, #4*4]			; r0=rConstants[4]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_190_start		; r0=r_Procedures[190]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_189_target_481
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_ELSE [01]
	b proc_189_target_482
proc_189_target_481:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_DONE [00]
proc_189_target_482:
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WHEN [17]
	beq proc_189_target_483
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_189_continue_484
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_189_continue_484:
	; BC_ELSE [01]
	b proc_189_target_485
proc_189_target_483:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WAIT [0a]
	adr r1, proc_189_continue_486
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_189_continue_486:
	; BC_DONE [00]
proc_189_target_485:
	; BC_PROC [07]
	adr r0, proc_189_start		; r0=r_Procedures[189]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
proc_189_target_480:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_189_end:

proc_190_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_190_target_487
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WAIT [0a]
	adr r1, proc_190_continue_488
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_190_continue_488:
	; BC_PROC [07]
	adr r0, proc_190_start		; r0=r_Procedures[190]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_190_target_487:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_190_end:

proc_191_start:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_192_start		; r0=r_Procedures[192]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_191_continue_489
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_191_continue_489:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_192_start		; r0=r_Procedures[192]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_191_continue_490
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_191_continue_490:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_192_start		; r0=r_Procedures[192]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [98]
	ldr r0, [r4, #24*4]			; r0=rConstants[24]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asl #8
	mov r0, r0, asr #16			; Implement muls.w (signed)
	mov r1, r1, asl #8
	mov r1, r1, asr #16			; Implement muls.w (signed)
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_191_continue_491
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_191_continue_491:
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_192_start		; r0=r_Procedures[192]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_191_continue_492
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_191_continue_492:
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_192_start		; r0=r_Procedures[192]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WAIT [0a]
	adr r1, proc_191_continue_493
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_191_continue_493:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_192_start		; r0=r_Procedures[192]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_191_end:

proc_192_start:
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_CONST [a2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #34*4]			; r0=rConstants[34]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [a4]
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
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
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_195_start		; r0=r_Procedures[195]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_192_continue_494
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_192_continue_494:
	; BC_CONST [a4]
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_196_start		; r0=r_Procedures[196]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_192_continue_495
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_192_continue_495:
	; BC_CONST [97]
	ldr r0, [r4, #23*4]			; r0=rConstants[23]
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
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
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_193_start		; r0=r_Procedures[193]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_192_continue_496
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_192_continue_496:
	; BC_CONST [9b]
	ldr r0, [r4, #27*4]			; r0=rConstants[27]
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_197_start		; r0=r_Procedures[197]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WAIT [0a]
	adr r1, proc_192_continue_497
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_192_continue_497:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
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
	; BC_PROC [07]
	adr r0, proc_194_start		; r0=r_Procedures[194]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_192_end:

proc_193_start:
	; BC_RSTATE [71]
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_204_start		; r0=r_Procedures[204]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_193_continue_498
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_193_continue_498:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_205_start		; r0=r_Procedures[205]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_193_continue_499
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_193_continue_499:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_206_start		; r0=r_Procedures[206]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_193_continue_500
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_193_continue_500:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_206_start		; r0=r_Procedures[206]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_193_continue_501
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_193_continue_501:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_207_start		; r0=r_Procedures[207]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_193_continue_502
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_193_continue_502:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_203_start		; r0=r_Procedures[203]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_193_continue_503
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_193_continue_503:
	; BC_PROC [07]
	adr r0, proc_208_start		; r0=r_Procedures[208]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
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
proc_193_end:

proc_194_start:
	; BC_RSTATE [71]
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_209_start		; r0=r_Procedures[209]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_194_continue_504
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_194_continue_504:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_210_start		; r0=r_Procedures[210]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_194_continue_505
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_194_continue_505:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_211_start		; r0=r_Procedures[211]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_194_continue_506
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_194_continue_506:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_198_start		; r0=r_Procedures[198]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_194_continue_507
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_194_continue_507:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_209_start		; r0=r_Procedures[209]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_194_continue_508
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_194_continue_508:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_198_start		; r0=r_Procedures[198]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_194_continue_509
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_194_continue_509:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_200_start		; r0=r_Procedures[200]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_194_continue_510
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_194_continue_510:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_200_start		; r0=r_Procedures[200]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_194_continue_511
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_194_continue_511:
	; BC_PROC [07]
	adr r0, proc_201_start		; r0=r_Procedures[201]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
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
proc_194_end:

proc_195_start:
	; BC_RSTATE [71]
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_199_start		; r0=r_Procedures[199]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_195_continue_512
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_195_continue_512:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_212_start		; r0=r_Procedures[212]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
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
	; BC_WAIT [0a]
	adr r1, proc_195_continue_513
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_195_continue_513:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_213_start		; r0=r_Procedures[213]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_195_continue_514
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_195_continue_514:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_211_start		; r0=r_Procedures[211]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_195_continue_515
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_195_continue_515:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_203_start		; r0=r_Procedures[203]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_195_continue_516
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_195_continue_516:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_210_start		; r0=r_Procedures[210]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_195_continue_517
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_195_continue_517:
	; BC_PROC [07]
	adr r0, proc_213_start		; r0=r_Procedures[213]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
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
proc_195_end:

proc_196_start:
	; BC_RSTATE [71]
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_207_start		; r0=r_Procedures[207]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_196_continue_518
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_196_continue_518:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_211_start		; r0=r_Procedures[211]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_196_continue_519
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_196_continue_519:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_213_start		; r0=r_Procedures[213]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_196_continue_520
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_196_continue_520:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_212_start		; r0=r_Procedures[212]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
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
	; BC_WAIT [0a]
	adr r1, proc_196_continue_521
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_196_continue_521:
	; BC_PROC [07]
	adr r0, proc_214_start		; r0=r_Procedures[214]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
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
proc_196_end:

proc_197_start:
	; BC_RSTATE [71]
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
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
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_198_start		; r0=r_Procedures[198]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
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
	; BC_WAIT [0a]
	adr r1, proc_197_continue_522
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_197_continue_522:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_208_start		; r0=r_Procedures[208]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_197_continue_523
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_197_continue_523:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_215_start		; r0=r_Procedures[215]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_197_continue_524
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_197_continue_524:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_212_start		; r0=r_Procedures[212]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
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
	; BC_WAIT [0a]
	adr r1, proc_197_continue_525
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_197_continue_525:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_208_start		; r0=r_Procedures[208]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
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
	; BC_WAIT [0a]
	adr r1, proc_197_continue_526
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_197_continue_526:
	; BC_PROC [07]
	adr r0, proc_198_start		; r0=r_Procedures[198]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
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
proc_197_end:

proc_198_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_198_continue_527
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_198_continue_527:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_198_continue_528
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_198_continue_528:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_198_continue_529
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_198_continue_529:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_198_end:

proc_199_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #52*4]			; r0=rConstants[52]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_199_continue_530
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_199_continue_530:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #52*4]			; r0=rConstants[52]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_199_continue_531
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_199_continue_531:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_199_continue_532
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_199_continue_532:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [b4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #52*4]			; r0=rConstants[52]
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
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_199_continue_533
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_199_continue_533:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #52*4]			; r0=rConstants[52]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_199_end:

proc_200_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_200_continue_534
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_200_continue_534:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ae]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_200_continue_535
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_200_continue_535:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ae]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_200_continue_536
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_200_continue_536:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #41*4]			; r0=rConstants[41]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_200_end:

proc_201_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_201_continue_537
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_201_continue_537:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_201_continue_538
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_201_continue_538:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_201_continue_539
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_201_continue_539:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_201_continue_540
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_201_continue_540:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_201_end:

proc_202_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_202_continue_541
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_202_continue_541:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_202_continue_542
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_202_continue_542:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_202_continue_543
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_202_continue_543:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_202_continue_544
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_202_continue_544:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_202_end:

proc_203_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_203_continue_545
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_203_continue_545:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ae]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_203_continue_546
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_203_continue_546:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ae]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_203_continue_547
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_203_continue_547:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_203_end:

proc_204_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_204_continue_548
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_204_continue_548:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_204_continue_549
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_204_continue_549:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_204_continue_550
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_204_continue_550:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_204_continue_551
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_204_continue_551:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_204_end:

proc_205_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_205_continue_552
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_205_continue_552:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_205_continue_553
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_205_continue_553:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_205_continue_554
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_205_continue_554:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_205_continue_555
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_205_continue_555:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_205_end:

proc_206_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_206_continue_556
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_206_continue_556:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_206_continue_557
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_206_continue_557:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_206_continue_558
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_206_continue_558:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_206_end:

proc_207_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_207_continue_559
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_207_continue_559:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_207_continue_560
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_207_continue_560:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_207_continue_561
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_207_continue_561:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_207_continue_562
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_207_continue_562:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_207_end:

proc_208_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_208_continue_563
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_208_continue_563:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_208_continue_564
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_208_continue_564:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [9c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_208_continue_565
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_208_continue_565:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_208_continue_566
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_208_continue_566:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_208_end:

proc_209_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_209_continue_567
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_209_continue_567:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_209_continue_568
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_209_continue_568:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_209_continue_569
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_209_continue_569:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_209_end:

proc_210_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_210_continue_570
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_210_continue_570:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_210_continue_571
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_210_continue_571:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_210_continue_572
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_210_continue_572:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_210_end:

proc_211_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_211_continue_573
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_211_continue_573:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_211_continue_574
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_211_continue_574:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_211_continue_575
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_211_continue_575:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_211_continue_576
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_211_continue_576:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_211_end:

proc_212_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_212_continue_577
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_212_continue_577:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_212_continue_578
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_212_continue_578:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_212_end:

proc_213_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_213_continue_579
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_213_continue_579:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_213_continue_580
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_213_continue_580:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_213_continue_581
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_213_continue_581:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_213_continue_582
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_213_continue_582:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_213_end:

proc_214_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_214_continue_583
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_214_continue_583:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_214_continue_584
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_214_continue_584:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_214_continue_585
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_214_continue_585:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_214_end:

proc_215_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_215_continue_586
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_215_continue_586:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_215_continue_587
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_215_continue_587:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_215_continue_588
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_215_continue_588:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WAIT [0a]
	adr r1, proc_215_continue_589
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_215_continue_589:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_CONST [a1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_157_start		; r0=r_Procedures[157]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_215_end:


; ============================================================================
; Constants.
; ============================================================================

r_Constants:
.long 0x00000000				; [0] = 0.0
.long 0x00001999				; [1] = 0.0999908447265625
.long 0x00002666				; [2] = 0.149993896484375
.long 0x00002ccc				; [3] = 0.17498779296875
.long 0x00003333				; [4] = 0.1999969482421875
.long 0x00004000				; [5] = 0.25
.long 0x000075c2				; [6] = 0.459991455078125
.long 0x00008000				; [7] = 0.5
.long 0x00009999				; [8] = 0.5999908447265625
.long 0x0000c000				; [9] = 0.75
.long 0x0000cccc				; [10] = 0.79998779296875
.long 0x0000e147				; [11] = 0.8799896240234375
.long 0x0000e666				; [12] = 0.899993896484375
.long 0x0000f0a3				; [13] = 0.9399871826171875
.long 0x0000f74b				; [14] = 0.9659881591796875
.long 0x00010000				; [15] = 1.0
.long 0x00010dd2				; [16] = 1.053985595703125
.long 0x00016a00				; [17] = 1.4140625
.long 0x0001745d				; [18] = 1.4545440673828125
.long 0x00018000				; [19] = 1.5
.long 0x0001e666				; [20] = 1.899993896484375
.long 0x00020000				; [21] = 2.0
.long 0x00023333				; [22] = 2.1999969482421875
.long 0x00024ccc				; [23] = 2.29998779296875
.long 0x0002e666				; [24] = 2.899993896484375
.long 0x00030000				; [25] = 3.0
.long 0x00031999				; [26] = 3.0999908447265625
.long 0x00034ccc				; [27] = 3.29998779296875
.long 0x00040000				; [28] = 4.0
.long 0x00046666				; [29] = 4.399993896484375
.long 0x00050000				; [30] = 5.0
.long 0x00058000				; [31] = 5.5
.long 0x00059999				; [32] = 5.5999908447265625
.long 0x00060000				; [33] = 6.0
.long 0x00061999				; [34] = 6.0999908447265625
.long 0x00064ccc				; [35] = 6.29998779296875
.long 0x00070000				; [36] = 7.0
.long 0x00080000				; [37] = 8.0
.long 0x00090000				; [38] = 9.0
.long 0x000a0000				; [39] = 10.0
.long 0x000b0000				; [40] = 11.0
.long 0x000d0000				; [41] = 13.0
.long 0x000e0000				; [42] = 14.0
.long 0x000f0000				; [43] = 15.0
.long 0x00100000				; [44] = 16.0
.long 0x00110000				; [45] = 17.0
.long 0x00120000				; [46] = 18.0
.long 0x00130000				; [47] = 19.0
.long 0x00140000				; [48] = 20.0
.long 0x00150000				; [49] = 21.0
.long 0x00160000				; [50] = 22.0
.long 0x00170000				; [51] = 23.0
.long 0x00180000				; [52] = 24.0
.long 0x00190000				; [53] = 25.0
.long 0x001b0000				; [54] = 27.0
.long 0x001e0000				; [55] = 30.0
.long 0x001f0000				; [56] = 31.0
.long 0x00200000				; [57] = 32.0
.long 0x00210000				; [58] = 33.0
.long 0x00230000				; [59] = 35.0
.long 0x00240000				; [60] = 36.0
.long 0x00250000				; [61] = 37.0
.long 0x00270000				; [62] = 39.0
.long 0x00280000				; [63] = 40.0
.long 0x002b0000				; [64] = 43.0
.long 0x002c0000				; [65] = 44.0
.long 0x002d0000				; [66] = 45.0
.long 0x00300000				; [67] = 48.0
.long 0x00320000				; [68] = 50.0
.long 0x00350000				; [69] = 53.0
.long 0x00370000				; [70] = 55.0
.long 0x00380000				; [71] = 56.0
.long 0x003c0000				; [72] = 60.0
.long 0x00400000				; [73] = 64.0
.long 0x00410000				; [74] = 65.0
.long 0x00420000				; [75] = 66.0
.long 0x00460000				; [76] = 70.0
.long 0x00500000				; [77] = 80.0
.long 0x00570000				; [78] = 87.0
.long 0x00580000				; [79] = 88.0
.long 0x00600000				; [80] = 96.0
.long 0x00640000				; [81] = 100.0
.long 0x006e0000				; [82] = 110.0
.long 0x00780000				; [83] = 120.0
.long 0x007d0000				; [84] = 125.0
.long 0x00800000				; [85] = 128.0
.long 0x00820000				; [86] = 130.0
.long 0x00870000				; [87] = 135.0
.long 0x008b0000				; [88] = 139.0
.long 0x008c0000				; [89] = 140.0
.long 0x00910000				; [90] = 145.0
.long 0x00a40000				; [91] = 164.0
.long 0x00aa0000				; [92] = 170.0
.long 0x00af0000				; [93] = 175.0
.long 0x00b00000				; [94] = 176.0
.long 0x00b40000				; [95] = 180.0
.long 0x00be0000				; [96] = 190.0
.long 0x00c00000				; [97] = 192.0
.long 0x00d20000				; [98] = 210.0
.long 0x00e10000				; [99] = 225.0
.long 0x00f00000				; [100] = 240.0
.long 0x00fc0000				; [101] = 252.0
.long 0x01000000				; [102] = 256.0
.long 0x01180000				; [103] = 280.0
.long 0x01190000				; [104] = 281.0
.long 0x01360000				; [105] = 310.0
.long 0x01400000				; [106] = 320.0
.long 0x01580000				; [107] = 344.0
.long 0x01860000				; [108] = 390.0

; ============================================================================
; Color Script.
; ============================================================================

r_ColorScript:
.long -1, 0x00ffffff, 0x01000000, 0x02000000, 0x03000000			; delta_frames=1 [0]
.long -352, 0x00000000, 0x01ffffff			; delta_frames=352 [352]
.long -352, 0x00440000, 0x01ffffff, 0x02000000, 0x03990099			; delta_frames=352 [704]
.long -704, 0x00660066, 0x0100ffff, 0x02ffff00, 0x03ff00ff			; delta_frames=704 [1408]
.long -688, 0x00660066, 0x0100ffff			; delta_frames=688 [2096]
.long -1, 0x00771177, 0x0111ffff			; delta_frames=1 [2097]
.long -1, 0x00772277, 0x0122ffff			; delta_frames=1 [2098]
.long -1, 0x00883388, 0x0133ffff			; delta_frames=1 [2099]
.long -1, 0x00884488, 0x0133eeee			; delta_frames=1 [2100]
.long -1, 0x00995599, 0x0144eeee			; delta_frames=1 [2101]
.long -1, 0x00aa66aa, 0x0155eeee			; delta_frames=1 [2102]
.long -1, 0x00aa77aa, 0x0166eeee			; delta_frames=1 [2103]
.long -1, 0x00bb88bb, 0x0177eeee			; delta_frames=1 [2104]
.long -1, 0x00bb99bb, 0x0188eeee			; delta_frames=1 [2105]
.long -1, 0x00ccaacc, 0x0199eeee			; delta_frames=1 [2106]
.long -1, 0x00ddbbdd, 0x01aaeeee			; delta_frames=1 [2107]
.long -1, 0x00ddccdd, 0x01aadddd			; delta_frames=1 [2108]
.long -1, 0x00eeddee, 0x01bbdddd			; delta_frames=1 [2109]
.long -1, 0x00eeeeee, 0x01ccdddd			; delta_frames=1 [2110]
.long -1, 0x00ffffff, 0x01dddddd			; delta_frames=1 [2111]
.long -1, 0x00ffffff, 0x01cccccc, 0x02888888, 0x0300ffff			; delta_frames=1 [2112]
.long -22, 0x0300ffff			; delta_frames=22 [2134]
.long -2, 0x0311ffff			; delta_frames=2 [2136]
.long -2, 0x0311eeee			; delta_frames=2 [2138]
.long -2, 0x0322eeee			; delta_frames=2 [2140]
.long -2, 0x0322dddd			; delta_frames=2 [2142]
.long -2, 0x0333dddd			; delta_frames=2 [2144]
.long -2, 0x0333cccc			; delta_frames=2 [2146]
.long -2, 0x0344cccc			; delta_frames=2 [2148]
.long -1, 0x0344bbbb			; delta_frames=1 [2149]
.long -1, 0x0355bbbb			; delta_frames=1 [2150]
.long -1, 0x0355aaaa			; delta_frames=1 [2151]
.long -1, 0x0366aaaa			; delta_frames=1 [2152]
.long -1, 0x03669999			; delta_frames=1 [2153]
.long -1, 0x03779999			; delta_frames=1 [2154]
.long -1, 0x03778888			; delta_frames=1 [2155]
.long -1, 0x03888888			; delta_frames=1 [2156]
.long -22, 0x0300ffff			; delta_frames=22 [2178]
.long -2, 0x0311ffff			; delta_frames=2 [2180]
.long -2, 0x0311eeee			; delta_frames=2 [2182]
.long -2, 0x0322eeee			; delta_frames=2 [2184]
.long -2, 0x0322dddd			; delta_frames=2 [2186]
.long -2, 0x0333dddd			; delta_frames=2 [2188]
.long -2, 0x0333cccc			; delta_frames=2 [2190]
.long -2, 0x0344cccc			; delta_frames=2 [2192]
.long -1, 0x0344bbbb			; delta_frames=1 [2193]
.long -1, 0x0355bbbb			; delta_frames=1 [2194]
.long -1, 0x0355aaaa			; delta_frames=1 [2195]
.long -1, 0x0366aaaa			; delta_frames=1 [2196]
.long -1, 0x03669999			; delta_frames=1 [2197]
.long -1, 0x03779999			; delta_frames=1 [2198]
.long -1, 0x03778888			; delta_frames=1 [2199]
.long -1, 0x03888888			; delta_frames=1 [2200]
.long -22, 0x0300ffff			; delta_frames=22 [2222]
.long -2, 0x0311ffff			; delta_frames=2 [2224]
.long -2, 0x0311eeee			; delta_frames=2 [2226]
.long -2, 0x0322eeee			; delta_frames=2 [2228]
.long -2, 0x0322dddd			; delta_frames=2 [2230]
.long -2, 0x0333dddd			; delta_frames=2 [2232]
.long -2, 0x0333cccc			; delta_frames=2 [2234]
.long -2, 0x0344cccc			; delta_frames=2 [2236]
.long -1, 0x0344bbbb			; delta_frames=1 [2237]
.long -1, 0x0355bbbb			; delta_frames=1 [2238]
.long -1, 0x0355aaaa			; delta_frames=1 [2239]
.long -1, 0x0366aaaa			; delta_frames=1 [2240]
.long -1, 0x03669999			; delta_frames=1 [2241]
.long -1, 0x03779999			; delta_frames=1 [2242]
.long -1, 0x03778888			; delta_frames=1 [2243]
.long -1, 0x03888888			; delta_frames=1 [2244]
.long -22, 0x0300ffff			; delta_frames=22 [2266]
.long -2, 0x0311ffff			; delta_frames=2 [2268]
.long -2, 0x0311eeee			; delta_frames=2 [2270]
.long -2, 0x0322eeee			; delta_frames=2 [2272]
.long -2, 0x0322dddd			; delta_frames=2 [2274]
.long -2, 0x0333dddd			; delta_frames=2 [2276]
.long -2, 0x0333cccc			; delta_frames=2 [2278]
.long -2, 0x0344cccc			; delta_frames=2 [2280]
.long -1, 0x0344bbbb			; delta_frames=1 [2281]
.long -1, 0x0355bbbb			; delta_frames=1 [2282]
.long -1, 0x0355aaaa			; delta_frames=1 [2283]
.long -1, 0x0366aaaa			; delta_frames=1 [2284]
.long -1, 0x03669999			; delta_frames=1 [2285]
.long -1, 0x03779999			; delta_frames=1 [2286]
.long -1, 0x03778888			; delta_frames=1 [2287]
.long -1, 0x03888888			; delta_frames=1 [2288]
.long -22, 0x0300ffff			; delta_frames=22 [2310]
.long -2, 0x0311ffff			; delta_frames=2 [2312]
.long -2, 0x0311eeee			; delta_frames=2 [2314]
.long -2, 0x0322eeee			; delta_frames=2 [2316]
.long -2, 0x0322dddd			; delta_frames=2 [2318]
.long -2, 0x0333dddd			; delta_frames=2 [2320]
.long -2, 0x0333cccc			; delta_frames=2 [2322]
.long -2, 0x0344cccc			; delta_frames=2 [2324]
.long -1, 0x0344bbbb			; delta_frames=1 [2325]
.long -1, 0x0355bbbb			; delta_frames=1 [2326]
.long -1, 0x0355aaaa			; delta_frames=1 [2327]
.long -1, 0x0366aaaa			; delta_frames=1 [2328]
.long -1, 0x03669999			; delta_frames=1 [2329]
.long -1, 0x03779999			; delta_frames=1 [2330]
.long -1, 0x03778888			; delta_frames=1 [2331]
.long -1, 0x03888888			; delta_frames=1 [2332]
.long -22, 0x0300ffff			; delta_frames=22 [2354]
.long -2, 0x0311ffff			; delta_frames=2 [2356]
.long -2, 0x0311eeee			; delta_frames=2 [2358]
.long -2, 0x0322eeee			; delta_frames=2 [2360]
.long -2, 0x0322dddd			; delta_frames=2 [2362]
.long -2, 0x0333dddd			; delta_frames=2 [2364]
.long -2, 0x0333cccc			; delta_frames=2 [2366]
.long -2, 0x0344cccc			; delta_frames=2 [2368]
.long -1, 0x0344bbbb			; delta_frames=1 [2369]
.long -1, 0x0355bbbb			; delta_frames=1 [2370]
.long -1, 0x0355aaaa			; delta_frames=1 [2371]
.long -1, 0x0366aaaa			; delta_frames=1 [2372]
.long -1, 0x03669999			; delta_frames=1 [2373]
.long -1, 0x03779999			; delta_frames=1 [2374]
.long -1, 0x03778888			; delta_frames=1 [2375]
.long -1, 0x03888888			; delta_frames=1 [2376]
.long -22, 0x0300ffff			; delta_frames=22 [2398]
.long -2, 0x0311ffff			; delta_frames=2 [2400]
.long -2, 0x0311eeee			; delta_frames=2 [2402]
.long -2, 0x0322eeee			; delta_frames=2 [2404]
.long -2, 0x0322dddd			; delta_frames=2 [2406]
.long -2, 0x0333dddd			; delta_frames=2 [2408]
.long -2, 0x0333cccc			; delta_frames=2 [2410]
.long -2, 0x0344cccc			; delta_frames=2 [2412]
.long -1, 0x0344bbbb			; delta_frames=1 [2413]
.long -1, 0x0355bbbb			; delta_frames=1 [2414]
.long -1, 0x0355aaaa			; delta_frames=1 [2415]
.long -1, 0x0366aaaa			; delta_frames=1 [2416]
.long -1, 0x03669999			; delta_frames=1 [2417]
.long -1, 0x03779999			; delta_frames=1 [2418]
.long -1, 0x03778888			; delta_frames=1 [2419]
.long -1, 0x03888888			; delta_frames=1 [2420]
.long -22, 0x0300ffff			; delta_frames=22 [2442]
.long -2, 0x0311ffff			; delta_frames=2 [2444]
.long -2, 0x0311eeee			; delta_frames=2 [2446]
.long -2, 0x0322eeee			; delta_frames=2 [2448]
.long -2, 0x0322dddd			; delta_frames=2 [2450]
.long -2, 0x0333dddd			; delta_frames=2 [2452]
.long -2, 0x0333cccc			; delta_frames=2 [2454]
.long -2, 0x0344cccc			; delta_frames=2 [2456]
.long -1, 0x0344bbbb			; delta_frames=1 [2457]
.long -1, 0x0355bbbb			; delta_frames=1 [2458]
.long -1, 0x0355aaaa			; delta_frames=1 [2459]
.long -1, 0x0366aaaa			; delta_frames=1 [2460]
.long -1, 0x03669999			; delta_frames=1 [2461]
.long -1, 0x03779999			; delta_frames=1 [2462]
.long -1, 0x03778888			; delta_frames=1 [2463]
.long -1, 0x03888888, 0x02cccccc, 0x01888888			; delta_frames=1 [2464]
.long -22, 0x0300ffff			; delta_frames=22 [2486]
.long -2, 0x0311ffff			; delta_frames=2 [2488]
.long -2, 0x0322ffff			; delta_frames=2 [2490]
.long -2, 0x0322eeee			; delta_frames=2 [2492]
.long -2, 0x0333eeee			; delta_frames=2 [2494]
.long -2, 0x0344eeee			; delta_frames=2 [2496]
.long -2, 0x0355eeee			; delta_frames=2 [2498]
.long -2, 0x0366eeee			; delta_frames=2 [2500]
.long -1, 0x0366dddd			; delta_frames=1 [2501]
.long -1, 0x0377dddd			; delta_frames=1 [2502]
.long -1, 0x0388dddd			; delta_frames=1 [2503]
.long -1, 0x0399dddd			; delta_frames=1 [2504]
.long -1, 0x03aadddd			; delta_frames=1 [2505]
.long -1, 0x03aacccc			; delta_frames=1 [2506]
.long -1, 0x03bbcccc			; delta_frames=1 [2507]
.long -1, 0x03cccccc			; delta_frames=1 [2508]
.long -22, 0x0300ffff			; delta_frames=22 [2530]
.long -2, 0x0311ffff			; delta_frames=2 [2532]
.long -2, 0x0322ffff			; delta_frames=2 [2534]
.long -2, 0x0322eeee			; delta_frames=2 [2536]
.long -2, 0x0333eeee			; delta_frames=2 [2538]
.long -2, 0x0344eeee			; delta_frames=2 [2540]
.long -2, 0x0355eeee			; delta_frames=2 [2542]
.long -2, 0x0366eeee			; delta_frames=2 [2544]
.long -1, 0x0366dddd			; delta_frames=1 [2545]
.long -1, 0x0377dddd			; delta_frames=1 [2546]
.long -1, 0x0388dddd			; delta_frames=1 [2547]
.long -1, 0x0399dddd			; delta_frames=1 [2548]
.long -1, 0x03aadddd			; delta_frames=1 [2549]
.long -1, 0x03aacccc			; delta_frames=1 [2550]
.long -1, 0x03bbcccc			; delta_frames=1 [2551]
.long -1, 0x03cccccc			; delta_frames=1 [2552]
.long -22, 0x0300ffff			; delta_frames=22 [2574]
.long -2, 0x0311ffff			; delta_frames=2 [2576]
.long -2, 0x0322ffff			; delta_frames=2 [2578]
.long -2, 0x0322eeee			; delta_frames=2 [2580]
.long -2, 0x0333eeee			; delta_frames=2 [2582]
.long -2, 0x0344eeee			; delta_frames=2 [2584]
.long -2, 0x0355eeee			; delta_frames=2 [2586]
.long -2, 0x0366eeee			; delta_frames=2 [2588]
.long -1, 0x0366dddd			; delta_frames=1 [2589]
.long -1, 0x0377dddd			; delta_frames=1 [2590]
.long -1, 0x0388dddd			; delta_frames=1 [2591]
.long -1, 0x0399dddd			; delta_frames=1 [2592]
.long -1, 0x03aadddd			; delta_frames=1 [2593]
.long -1, 0x03aacccc			; delta_frames=1 [2594]
.long -1, 0x03bbcccc			; delta_frames=1 [2595]
.long -1, 0x03cccccc			; delta_frames=1 [2596]
.long -22, 0x0300ffff			; delta_frames=22 [2618]
.long -2, 0x0311ffff			; delta_frames=2 [2620]
.long -2, 0x0322ffff			; delta_frames=2 [2622]
.long -2, 0x0322eeee			; delta_frames=2 [2624]
.long -2, 0x0333eeee			; delta_frames=2 [2626]
.long -2, 0x0344eeee			; delta_frames=2 [2628]
.long -2, 0x0355eeee			; delta_frames=2 [2630]
.long -2, 0x0366eeee			; delta_frames=2 [2632]
.long -1, 0x0366dddd			; delta_frames=1 [2633]
.long -1, 0x0377dddd			; delta_frames=1 [2634]
.long -1, 0x0388dddd			; delta_frames=1 [2635]
.long -1, 0x0399dddd			; delta_frames=1 [2636]
.long -1, 0x03aadddd			; delta_frames=1 [2637]
.long -1, 0x03aacccc			; delta_frames=1 [2638]
.long -1, 0x03bbcccc			; delta_frames=1 [2639]
.long -1, 0x03cccccc			; delta_frames=1 [2640]
.long -22, 0x0300ffff			; delta_frames=22 [2662]
.long -2, 0x0311ffff			; delta_frames=2 [2664]
.long -2, 0x0322ffff			; delta_frames=2 [2666]
.long -2, 0x0322eeee			; delta_frames=2 [2668]
.long -2, 0x0333eeee			; delta_frames=2 [2670]
.long -2, 0x0344eeee			; delta_frames=2 [2672]
.long -2, 0x0355eeee			; delta_frames=2 [2674]
.long -2, 0x0366eeee			; delta_frames=2 [2676]
.long -1, 0x0366dddd			; delta_frames=1 [2677]
.long -1, 0x0377dddd			; delta_frames=1 [2678]
.long -1, 0x0388dddd			; delta_frames=1 [2679]
.long -1, 0x0399dddd			; delta_frames=1 [2680]
.long -1, 0x03aadddd			; delta_frames=1 [2681]
.long -1, 0x03aacccc			; delta_frames=1 [2682]
.long -1, 0x03bbcccc			; delta_frames=1 [2683]
.long -1, 0x03cccccc			; delta_frames=1 [2684]
.long -22, 0x0300ffff			; delta_frames=22 [2706]
.long -2, 0x0311ffff			; delta_frames=2 [2708]
.long -2, 0x0322ffff			; delta_frames=2 [2710]
.long -2, 0x0322eeee			; delta_frames=2 [2712]
.long -2, 0x0333eeee			; delta_frames=2 [2714]
.long -2, 0x0344eeee			; delta_frames=2 [2716]
.long -2, 0x0355eeee			; delta_frames=2 [2718]
.long -2, 0x0366eeee			; delta_frames=2 [2720]
.long -1, 0x0366dddd			; delta_frames=1 [2721]
.long -1, 0x0377dddd			; delta_frames=1 [2722]
.long -1, 0x0388dddd			; delta_frames=1 [2723]
.long -1, 0x0399dddd			; delta_frames=1 [2724]
.long -1, 0x03aadddd			; delta_frames=1 [2725]
.long -1, 0x03aacccc			; delta_frames=1 [2726]
.long -1, 0x03bbcccc			; delta_frames=1 [2727]
.long -1, 0x03cccccc			; delta_frames=1 [2728]
.long -22, 0x0300ffff			; delta_frames=22 [2750]
.long -2, 0x0311ffff			; delta_frames=2 [2752]
.long -2, 0x0322ffff			; delta_frames=2 [2754]
.long -2, 0x0322eeee			; delta_frames=2 [2756]
.long -2, 0x0333eeee			; delta_frames=2 [2758]
.long -2, 0x0344eeee			; delta_frames=2 [2760]
.long -2, 0x0355eeee			; delta_frames=2 [2762]
.long -2, 0x0366eeee			; delta_frames=2 [2764]
.long -1, 0x0366dddd			; delta_frames=1 [2765]
.long -1, 0x0377dddd			; delta_frames=1 [2766]
.long -1, 0x0388dddd			; delta_frames=1 [2767]
.long -1, 0x0399dddd			; delta_frames=1 [2768]
.long -1, 0x03aadddd			; delta_frames=1 [2769]
.long -1, 0x03aacccc			; delta_frames=1 [2770]
.long -1, 0x03bbcccc			; delta_frames=1 [2771]
.long -1, 0x03cccccc			; delta_frames=1 [2772]
.long -22, 0x0300ffff			; delta_frames=22 [2794]
.long -2, 0x0311ffff			; delta_frames=2 [2796]
.long -2, 0x0322ffff			; delta_frames=2 [2798]
.long -2, 0x0322eeee			; delta_frames=2 [2800]
.long -2, 0x0333eeee			; delta_frames=2 [2802]
.long -2, 0x0344eeee			; delta_frames=2 [2804]
.long -2, 0x0355eeee			; delta_frames=2 [2806]
.long -2, 0x0366eeee			; delta_frames=2 [2808]
.long -1, 0x0366dddd			; delta_frames=1 [2809]
.long -1, 0x0377dddd			; delta_frames=1 [2810]
.long -1, 0x0388dddd			; delta_frames=1 [2811]
.long -1, 0x0399dddd			; delta_frames=1 [2812]
.long -1, 0x03aadddd			; delta_frames=1 [2813]
.long -1, 0x03aacccc			; delta_frames=1 [2814]
.long -1, 0x03bbcccc			; delta_frames=1 [2815]
.long -1, 0x03cccccc, 0x00ffffff, 0x03888888, 0x02cccccc, 0x01eeeeee			; delta_frames=1 [2816]
.long -352, 0x00ffffff, 0x01888888, 0x02cccccc, 0x03eeeeee, 0x0300ffff			; delta_frames=352 [3168]
.long -319, 0x00000000, 0x0100ffff, 0x0200ffff, 0x0300ffff			; delta_frames=319 [3487]
.long -33, 0x00000000, 0x013300ff, 0x02aa3300, 0x03ffffff			; delta_frames=33 [3520]
.long -264, 0x01888888			; delta_frames=264 [3784]
.long -88, 0x0266cc00			; delta_frames=88 [3872]
.long -88, 0x03ff33ff			; delta_frames=88 [3960]
.long -264, 0x010000ff, 0x0200ff00, 0x03ff0000, 0x00444444			; delta_frames=264 [4224]
.long -2, 0x00333333			; delta_frames=2 [4226]
.long -2, 0x00222222			; delta_frames=2 [4228]
.long -2, 0x00111111			; delta_frames=2 [4230]
.long -2, 0x00000000			; delta_frames=2 [4232]
.long -2, 0x00000000, 0x010000ff, 0x0200ff00, 0x03ff0000			; delta_frames=2 [4234]
.long -694, 0x00000000, 0x013300ff, 0x02aa3300, 0x03ffffff, 0x00440000			; delta_frames=694 [4928]
.long -2, 0x00330000			; delta_frames=2 [4930]
.long -2, 0x00220000			; delta_frames=2 [4932]
.long -2, 0x00110000			; delta_frames=2 [4934]
.long -2, 0x00000000			; delta_frames=2 [4936]
.long -9, 0x00440000			; delta_frames=9 [4945]
.long -2, 0x00330000			; delta_frames=2 [4947]
.long -2, 0x00220000			; delta_frames=2 [4949]
.long -2, 0x00110000			; delta_frames=2 [4951]
.long -2, 0x00000000			; delta_frames=2 [4953]
.long -8, 0x00440000			; delta_frames=8 [4961]
.long -2, 0x00330000			; delta_frames=2 [4963]
.long -2, 0x00220000			; delta_frames=2 [4965]
.long -2, 0x00110000			; delta_frames=2 [4967]
.long -2, 0x00000000			; delta_frames=2 [4969]
.long -3, 0x00440000			; delta_frames=3 [4972]
.long -2, 0x00330000			; delta_frames=2 [4974]
.long -2, 0x00220000			; delta_frames=2 [4976]
.long -2, 0x00110000			; delta_frames=2 [4978]
.long -2, 0x00000000			; delta_frames=2 [4980]
.long -25, 0x00440000			; delta_frames=25 [5005]
.long -2, 0x00330000			; delta_frames=2 [5007]
.long -2, 0x00220000			; delta_frames=2 [5009]
.long -2, 0x00110000			; delta_frames=2 [5011]
.long -2, 0x00000000			; delta_frames=2 [5013]
.long -3, 0x01888888, 0x00440000			; delta_frames=3 [5016]
.long -2, 0x00330000			; delta_frames=2 [5018]
.long -2, 0x00220000			; delta_frames=2 [5020]
.long -2, 0x00110000			; delta_frames=2 [5022]
.long -2, 0x00000000			; delta_frames=2 [5024]
.long -9, 0x00440000			; delta_frames=9 [5033]
.long -2, 0x00330000			; delta_frames=2 [5035]
.long -2, 0x00220000			; delta_frames=2 [5037]
.long -2, 0x00110000			; delta_frames=2 [5039]
.long -2, 0x00000000			; delta_frames=2 [5041]
.long -8, 0x00440000			; delta_frames=8 [5049]
.long -2, 0x00330000			; delta_frames=2 [5051]
.long -2, 0x00220000			; delta_frames=2 [5053]
.long -2, 0x00110000			; delta_frames=2 [5055]
.long -2, 0x00000000			; delta_frames=2 [5057]
.long -3, 0x00440000			; delta_frames=3 [5060]
.long -2, 0x00330000			; delta_frames=2 [5062]
.long -2, 0x00220000			; delta_frames=2 [5064]
.long -2, 0x00110000			; delta_frames=2 [5066]
.long -2, 0x00000000			; delta_frames=2 [5068]
.long -14, 0x00444444			; delta_frames=14 [5082]
.long -2, 0x00333333			; delta_frames=2 [5084]
.long -2, 0x00222222			; delta_frames=2 [5086]
.long -2, 0x00111111			; delta_frames=2 [5088]
.long -2, 0x00000000			; delta_frames=2 [5090]
.long -14, 0x0266cc00, 0x00440000			; delta_frames=14 [5104]
.long -2, 0x00330000			; delta_frames=2 [5106]
.long -2, 0x00220000			; delta_frames=2 [5108]
.long -2, 0x00110000			; delta_frames=2 [5110]
.long -2, 0x00000000			; delta_frames=2 [5112]
.long -9, 0x00440000			; delta_frames=9 [5121]
.long -2, 0x00330000			; delta_frames=2 [5123]
.long -2, 0x00220000			; delta_frames=2 [5125]
.long -2, 0x00110000			; delta_frames=2 [5127]
.long -2, 0x00000000			; delta_frames=2 [5129]
.long -8, 0x00440000			; delta_frames=8 [5137]
.long -2, 0x00330000			; delta_frames=2 [5139]
.long -2, 0x00220000			; delta_frames=2 [5141]
.long -2, 0x00110000			; delta_frames=2 [5143]
.long -2, 0x00000000			; delta_frames=2 [5145]
.long -3, 0x00440000			; delta_frames=3 [5148]
.long -2, 0x00330000			; delta_frames=2 [5150]
.long -2, 0x00220000			; delta_frames=2 [5152]
.long -2, 0x00110000			; delta_frames=2 [5154]
.long -2, 0x00000000			; delta_frames=2 [5156]
.long -25, 0x00440000			; delta_frames=25 [5181]
.long -2, 0x00330000			; delta_frames=2 [5183]
.long -2, 0x00220000			; delta_frames=2 [5185]
.long -2, 0x00110000			; delta_frames=2 [5187]
.long -2, 0x00000000			; delta_frames=2 [5189]
.long -3, 0x03ff33ff, 0x00440000			; delta_frames=3 [5192]
.long -2, 0x00330000			; delta_frames=2 [5194]
.long -2, 0x00220000			; delta_frames=2 [5196]
.long -2, 0x00110000			; delta_frames=2 [5198]
.long -2, 0x00000000			; delta_frames=2 [5200]
.long -9, 0x00440000			; delta_frames=9 [5209]
.long -2, 0x00330000			; delta_frames=2 [5211]
.long -2, 0x00220000			; delta_frames=2 [5213]
.long -2, 0x00110000			; delta_frames=2 [5215]
.long -2, 0x00000000			; delta_frames=2 [5217]
.long -8, 0x00440000			; delta_frames=8 [5225]
.long -2, 0x00330000			; delta_frames=2 [5227]
.long -2, 0x00220000			; delta_frames=2 [5229]
.long -2, 0x00110000			; delta_frames=2 [5231]
.long -2, 0x00000000			; delta_frames=2 [5233]
.long -3, 0x00440000			; delta_frames=3 [5236]
.long -2, 0x00330000			; delta_frames=2 [5238]
.long -2, 0x00220000			; delta_frames=2 [5240]
.long -2, 0x00110000			; delta_frames=2 [5242]
.long -2, 0x00000000			; delta_frames=2 [5244]
.long -14, 0x00444444			; delta_frames=14 [5258]
.long -2, 0x00333333			; delta_frames=2 [5260]
.long -2, 0x00222222			; delta_frames=2 [5262]
.long -2, 0x00111111			; delta_frames=2 [5264]
.long -2, 0x00000000			; delta_frames=2 [5266]
.long -14, 0x02aa3300, 0x00440000			; delta_frames=14 [5280]
.long -2, 0x00330000			; delta_frames=2 [5282]
.long -2, 0x00220000			; delta_frames=2 [5284]
.long -2, 0x00110000			; delta_frames=2 [5286]
.long -2, 0x00000000			; delta_frames=2 [5288]
.long -9, 0x00440000			; delta_frames=9 [5297]
.long -2, 0x00330000			; delta_frames=2 [5299]
.long -2, 0x00220000			; delta_frames=2 [5301]
.long -2, 0x00110000			; delta_frames=2 [5303]
.long -2, 0x00000000			; delta_frames=2 [5305]
.long -8, 0x00440000			; delta_frames=8 [5313]
.long -2, 0x00330000			; delta_frames=2 [5315]
.long -2, 0x00220000			; delta_frames=2 [5317]
.long -2, 0x00110000			; delta_frames=2 [5319]
.long -2, 0x00000000			; delta_frames=2 [5321]
.long -3, 0x00440000			; delta_frames=3 [5324]
.long -2, 0x00330000			; delta_frames=2 [5326]
.long -2, 0x00220000			; delta_frames=2 [5328]
.long -2, 0x00110000			; delta_frames=2 [5330]
.long -2, 0x00000000			; delta_frames=2 [5332]
.long -25, 0x00440000			; delta_frames=25 [5357]
.long -2, 0x00330000			; delta_frames=2 [5359]
.long -2, 0x00220000			; delta_frames=2 [5361]
.long -2, 0x00110000			; delta_frames=2 [5363]
.long -2, 0x00000000			; delta_frames=2 [5365]
.long -3, 0x013300ff, 0x00440000			; delta_frames=3 [5368]
.long -2, 0x00330000			; delta_frames=2 [5370]
.long -2, 0x00220000			; delta_frames=2 [5372]
.long -2, 0x00110000			; delta_frames=2 [5374]
.long -2, 0x00000000			; delta_frames=2 [5376]
.long -9, 0x00440000			; delta_frames=9 [5385]
.long -2, 0x00330000			; delta_frames=2 [5387]
.long -2, 0x00220000			; delta_frames=2 [5389]
.long -2, 0x00110000			; delta_frames=2 [5391]
.long -2, 0x00000000			; delta_frames=2 [5393]
.long -8, 0x00440000			; delta_frames=8 [5401]
.long -2, 0x00330000			; delta_frames=2 [5403]
.long -2, 0x00220000			; delta_frames=2 [5405]
.long -2, 0x00110000			; delta_frames=2 [5407]
.long -2, 0x00000000			; delta_frames=2 [5409]
.long -3, 0x00440000			; delta_frames=3 [5412]
.long -2, 0x00330000			; delta_frames=2 [5414]
.long -2, 0x00220000			; delta_frames=2 [5416]
.long -2, 0x00110000			; delta_frames=2 [5418]
.long -2, 0x00000000			; delta_frames=2 [5420]
.long -14, 0x00444444			; delta_frames=14 [5434]
.long -2, 0x00333333			; delta_frames=2 [5436]
.long -2, 0x00222222			; delta_frames=2 [5438]
.long -2, 0x00111111			; delta_frames=2 [5440]
.long -2, 0x00000000			; delta_frames=2 [5442]
.long -14, 0x0266cc00, 0x00440000			; delta_frames=14 [5456]
.long -2, 0x00330000			; delta_frames=2 [5458]
.long -2, 0x00220000			; delta_frames=2 [5460]
.long -2, 0x00110000			; delta_frames=2 [5462]
.long -2, 0x00000000			; delta_frames=2 [5464]
.long -9, 0x00440000			; delta_frames=9 [5473]
.long -2, 0x00330000			; delta_frames=2 [5475]
.long -2, 0x00220000			; delta_frames=2 [5477]
.long -2, 0x00110000			; delta_frames=2 [5479]
.long -2, 0x00000000			; delta_frames=2 [5481]
.long -8, 0x00440000			; delta_frames=8 [5489]
.long -2, 0x00330000			; delta_frames=2 [5491]
.long -2, 0x00220000			; delta_frames=2 [5493]
.long -2, 0x00110000			; delta_frames=2 [5495]
.long -2, 0x00000000			; delta_frames=2 [5497]
.long -3, 0x00440000			; delta_frames=3 [5500]
.long -2, 0x00330000			; delta_frames=2 [5502]
.long -2, 0x00220000			; delta_frames=2 [5504]
.long -2, 0x00110000			; delta_frames=2 [5506]
.long -2, 0x00000000			; delta_frames=2 [5508]
.long -25, 0x00440000			; delta_frames=25 [5533]
.long -2, 0x00330000			; delta_frames=2 [5535]
.long -2, 0x00220000			; delta_frames=2 [5537]
.long -2, 0x00110000			; delta_frames=2 [5539]
.long -2, 0x00000000			; delta_frames=2 [5541]
.long -3, 0x03ffffff, 0x00440000			; delta_frames=3 [5544]
.long -2, 0x00330000			; delta_frames=2 [5546]
.long -2, 0x00220000			; delta_frames=2 [5548]
.long -2, 0x00110000			; delta_frames=2 [5550]
.long -2, 0x00000000			; delta_frames=2 [5552]
.long -9, 0x00440000			; delta_frames=9 [5561]
.long -2, 0x00330000			; delta_frames=2 [5563]
.long -2, 0x00220000			; delta_frames=2 [5565]
.long -2, 0x00110000			; delta_frames=2 [5567]
.long -2, 0x00000000			; delta_frames=2 [5569]
.long -8, 0x00440000			; delta_frames=8 [5577]
.long -2, 0x00330000			; delta_frames=2 [5579]
.long -2, 0x00220000			; delta_frames=2 [5581]
.long -2, 0x00110000			; delta_frames=2 [5583]
.long -2, 0x00000000			; delta_frames=2 [5585]
.long -3, 0x00440000			; delta_frames=3 [5588]
.long -2, 0x00330000			; delta_frames=2 [5590]
.long -2, 0x00220000			; delta_frames=2 [5592]
.long -2, 0x00110000			; delta_frames=2 [5594]
.long -2, 0x00000000			; delta_frames=2 [5596]
.long -14, 0x00444444			; delta_frames=14 [5610]
.long -2, 0x00333333			; delta_frames=2 [5612]
.long -2, 0x00222222			; delta_frames=2 [5614]
.long -2, 0x00111111			; delta_frames=2 [5616]
.long -2, 0x00000000			; delta_frames=2 [5618]
.long -3, 0x00444444			; delta_frames=3 [5621]
.long -2, 0x00333333			; delta_frames=2 [5623]
.long -2, 0x00222222			; delta_frames=2 [5625]
.long -2, 0x00111111			; delta_frames=2 [5627]
.long -2, 0x00000000			; delta_frames=2 [5629]
.long -3, 0x00000000, 0x013300ff, 0x02aa3300, 0x03ffffff, 0x00440000			; delta_frames=3 [5632]
.long -2, 0x00330000			; delta_frames=2 [5634]
.long -2, 0x00220000			; delta_frames=2 [5636]
.long -2, 0x00110000			; delta_frames=2 [5638]
.long -2, 0x00000000			; delta_frames=2 [5640]
.long -9, 0x00440000			; delta_frames=9 [5649]
.long -2, 0x00330000			; delta_frames=2 [5651]
.long -2, 0x00220000			; delta_frames=2 [5653]
.long -2, 0x00110000			; delta_frames=2 [5655]
.long -2, 0x00000000			; delta_frames=2 [5657]
.long -8, 0x00440000			; delta_frames=8 [5665]
.long -2, 0x00330000			; delta_frames=2 [5667]
.long -2, 0x00220000			; delta_frames=2 [5669]
.long -2, 0x00110000			; delta_frames=2 [5671]
.long -2, 0x00000000			; delta_frames=2 [5673]
.long -3, 0x00440000			; delta_frames=3 [5676]
.long -2, 0x00330000			; delta_frames=2 [5678]
.long -2, 0x00220000			; delta_frames=2 [5680]
.long -2, 0x00110000			; delta_frames=2 [5682]
.long -2, 0x00000000			; delta_frames=2 [5684]
.long -25, 0x00440000			; delta_frames=25 [5709]
.long -2, 0x00330000			; delta_frames=2 [5711]
.long -2, 0x00220000			; delta_frames=2 [5713]
.long -2, 0x00110000			; delta_frames=2 [5715]
.long -2, 0x00000000			; delta_frames=2 [5717]
.long -3, 0x01888888, 0x00440000			; delta_frames=3 [5720]
.long -2, 0x00330000			; delta_frames=2 [5722]
.long -2, 0x00220000			; delta_frames=2 [5724]
.long -2, 0x00110000			; delta_frames=2 [5726]
.long -2, 0x00000000			; delta_frames=2 [5728]
.long -9, 0x00440000			; delta_frames=9 [5737]
.long -2, 0x00330000			; delta_frames=2 [5739]
.long -2, 0x00220000			; delta_frames=2 [5741]
.long -2, 0x00110000			; delta_frames=2 [5743]
.long -2, 0x00000000			; delta_frames=2 [5745]
.long -8, 0x00440000			; delta_frames=8 [5753]
.long -2, 0x00330000			; delta_frames=2 [5755]
.long -2, 0x00220000			; delta_frames=2 [5757]
.long -2, 0x00110000			; delta_frames=2 [5759]
.long -2, 0x00000000			; delta_frames=2 [5761]
.long -3, 0x00440000			; delta_frames=3 [5764]
.long -2, 0x00330000			; delta_frames=2 [5766]
.long -2, 0x00220000			; delta_frames=2 [5768]
.long -2, 0x00110000			; delta_frames=2 [5770]
.long -2, 0x00000000			; delta_frames=2 [5772]
.long -14, 0x00444444			; delta_frames=14 [5786]
.long -2, 0x00333333			; delta_frames=2 [5788]
.long -2, 0x00222222			; delta_frames=2 [5790]
.long -2, 0x00111111			; delta_frames=2 [5792]
.long -2, 0x00000000			; delta_frames=2 [5794]
.long -14, 0x0266cc00, 0x00440000			; delta_frames=14 [5808]
.long -2, 0x00330000			; delta_frames=2 [5810]
.long -2, 0x00220000			; delta_frames=2 [5812]
.long -2, 0x00110000			; delta_frames=2 [5814]
.long -2, 0x00000000			; delta_frames=2 [5816]
.long -9, 0x00440000			; delta_frames=9 [5825]
.long -2, 0x00330000			; delta_frames=2 [5827]
.long -2, 0x00220000			; delta_frames=2 [5829]
.long -2, 0x00110000			; delta_frames=2 [5831]
.long -2, 0x00000000			; delta_frames=2 [5833]
.long -8, 0x00440000			; delta_frames=8 [5841]
.long -2, 0x00330000			; delta_frames=2 [5843]
.long -2, 0x00220000			; delta_frames=2 [5845]
.long -2, 0x00110000			; delta_frames=2 [5847]
.long -2, 0x00000000			; delta_frames=2 [5849]
.long -3, 0x00440000			; delta_frames=3 [5852]
.long -2, 0x00330000			; delta_frames=2 [5854]
.long -2, 0x00220000			; delta_frames=2 [5856]
.long -2, 0x00110000			; delta_frames=2 [5858]
.long -2, 0x00000000			; delta_frames=2 [5860]
.long -25, 0x00440000			; delta_frames=25 [5885]
.long -2, 0x00330000			; delta_frames=2 [5887]
.long -2, 0x00220000			; delta_frames=2 [5889]
.long -2, 0x00110000			; delta_frames=2 [5891]
.long -2, 0x00000000			; delta_frames=2 [5893]
.long -3, 0x03ff33ff, 0x00440000			; delta_frames=3 [5896]
.long -2, 0x00330000			; delta_frames=2 [5898]
.long -2, 0x00220000			; delta_frames=2 [5900]
.long -2, 0x00110000			; delta_frames=2 [5902]
.long -2, 0x00000000			; delta_frames=2 [5904]
.long -9, 0x00440000			; delta_frames=9 [5913]
.long -2, 0x00330000			; delta_frames=2 [5915]
.long -2, 0x00220000			; delta_frames=2 [5917]
.long -2, 0x00110000			; delta_frames=2 [5919]
.long -2, 0x00000000			; delta_frames=2 [5921]
.long -8, 0x00440000			; delta_frames=8 [5929]
.long -2, 0x00330000			; delta_frames=2 [5931]
.long -2, 0x00220000			; delta_frames=2 [5933]
.long -2, 0x00110000			; delta_frames=2 [5935]
.long -2, 0x00000000			; delta_frames=2 [5937]
.long -3, 0x00440000			; delta_frames=3 [5940]
.long -2, 0x00330000			; delta_frames=2 [5942]
.long -2, 0x00220000			; delta_frames=2 [5944]
.long -2, 0x00110000			; delta_frames=2 [5946]
.long -2, 0x00000000			; delta_frames=2 [5948]
.long -14, 0x00444444			; delta_frames=14 [5962]
.long -2, 0x00333333			; delta_frames=2 [5964]
.long -2, 0x00222222			; delta_frames=2 [5966]
.long -2, 0x00111111			; delta_frames=2 [5968]
.long -2, 0x00000000			; delta_frames=2 [5970]
.long -14, 0x02aa3300, 0x00440000			; delta_frames=14 [5984]
.long -2, 0x00330000			; delta_frames=2 [5986]
.long -2, 0x00220000			; delta_frames=2 [5988]
.long -2, 0x00110000			; delta_frames=2 [5990]
.long -2, 0x00000000			; delta_frames=2 [5992]
.long -9, 0x00440000			; delta_frames=9 [6001]
.long -2, 0x00330000			; delta_frames=2 [6003]
.long -2, 0x00220000			; delta_frames=2 [6005]
.long -2, 0x00110000			; delta_frames=2 [6007]
.long -2, 0x00000000			; delta_frames=2 [6009]
.long -8, 0x00440000			; delta_frames=8 [6017]
.long -2, 0x00330000			; delta_frames=2 [6019]
.long -2, 0x00220000			; delta_frames=2 [6021]
.long -2, 0x00110000			; delta_frames=2 [6023]
.long -2, 0x00000000			; delta_frames=2 [6025]
.long -3, 0x00440000			; delta_frames=3 [6028]
.long -2, 0x00330000			; delta_frames=2 [6030]
.long -2, 0x00220000			; delta_frames=2 [6032]
.long -2, 0x00110000			; delta_frames=2 [6034]
.long -2, 0x00000000			; delta_frames=2 [6036]
.long -25, 0x00440000			; delta_frames=25 [6061]
.long -2, 0x00330000			; delta_frames=2 [6063]
.long -2, 0x00220000			; delta_frames=2 [6065]
.long -2, 0x00110000			; delta_frames=2 [6067]
.long -2, 0x00000000			; delta_frames=2 [6069]
.long -3, 0x013300ff, 0x00440000			; delta_frames=3 [6072]
.long -2, 0x00330000			; delta_frames=2 [6074]
.long -2, 0x00220000			; delta_frames=2 [6076]
.long -2, 0x00110000			; delta_frames=2 [6078]
.long -2, 0x00000000			; delta_frames=2 [6080]
.long -9, 0x00440000			; delta_frames=9 [6089]
.long -2, 0x00330000			; delta_frames=2 [6091]
.long -2, 0x00220000			; delta_frames=2 [6093]
.long -2, 0x00110000			; delta_frames=2 [6095]
.long -2, 0x00000000			; delta_frames=2 [6097]
.long -8, 0x00440000			; delta_frames=8 [6105]
.long -2, 0x00330000			; delta_frames=2 [6107]
.long -2, 0x00220000			; delta_frames=2 [6109]
.long -2, 0x00110000			; delta_frames=2 [6111]
.long -2, 0x00000000			; delta_frames=2 [6113]
.long -3, 0x00440000			; delta_frames=3 [6116]
.long -2, 0x00330000			; delta_frames=2 [6118]
.long -2, 0x00220000			; delta_frames=2 [6120]
.long -2, 0x00110000			; delta_frames=2 [6122]
.long -2, 0x00000000			; delta_frames=2 [6124]
.long -14, 0x00444444			; delta_frames=14 [6138]
.long -2, 0x00333333			; delta_frames=2 [6140]
.long -2, 0x00222222			; delta_frames=2 [6142]
.long -2, 0x00111111			; delta_frames=2 [6144]
.long -2, 0x00000000			; delta_frames=2 [6146]
.long -14, 0x0266cc00, 0x00440000			; delta_frames=14 [6160]
.long -2, 0x00330000			; delta_frames=2 [6162]
.long -2, 0x00220000			; delta_frames=2 [6164]
.long -2, 0x00110000			; delta_frames=2 [6166]
.long -2, 0x00000000			; delta_frames=2 [6168]
.long -9, 0x00440000			; delta_frames=9 [6177]
.long -2, 0x00330000			; delta_frames=2 [6179]
.long -2, 0x00220000			; delta_frames=2 [6181]
.long -2, 0x00110000			; delta_frames=2 [6183]
.long -2, 0x00000000			; delta_frames=2 [6185]
.long -8, 0x00440000			; delta_frames=8 [6193]
.long -2, 0x00330000			; delta_frames=2 [6195]
.long -2, 0x00220000			; delta_frames=2 [6197]
.long -2, 0x00110000			; delta_frames=2 [6199]
.long -2, 0x00000000			; delta_frames=2 [6201]
.long -3, 0x00440000			; delta_frames=3 [6204]
.long -2, 0x00330000			; delta_frames=2 [6206]
.long -2, 0x00220000			; delta_frames=2 [6208]
.long -2, 0x00110000			; delta_frames=2 [6210]
.long -2, 0x00000000			; delta_frames=2 [6212]
.long -25, 0x00440000			; delta_frames=25 [6237]
.long -2, 0x00330000			; delta_frames=2 [6239]
.long -2, 0x00220000			; delta_frames=2 [6241]
.long -2, 0x00110000			; delta_frames=2 [6243]
.long -2, 0x00000000			; delta_frames=2 [6245]
.long -3, 0x03ffffff			; delta_frames=3 [6248]
.long -72, 0x00000000, 0x013300ff, 0x0266cc00, 0x03ffffff			; delta_frames=72 [6320]
.long -1, 0x00111111, 0x014411ff, 0x0277cc11, 0x03ffffff			; delta_frames=1 [6321]
.long -1, 0x00222222, 0x015522ff, 0x0277cc22, 0x03ffffff			; delta_frames=1 [6322]
.long -1, 0x00333333, 0x015533ff, 0x0288dd33, 0x03ffffff			; delta_frames=1 [6323]
.long -1, 0x00444444, 0x016644ff, 0x0288dd44, 0x03ffffff			; delta_frames=1 [6324]
.long -1, 0x00555555, 0x017755ff, 0x0299dd55, 0x03ffffff			; delta_frames=1 [6325]
.long -1, 0x00666666, 0x018866ff, 0x02aadd66, 0x03ffffff			; delta_frames=1 [6326]
.long -1, 0x00777777, 0x019977ff, 0x02aadd77, 0x03ffffff			; delta_frames=1 [6327]
.long -1, 0x00888888, 0x019988ff, 0x02bbee88, 0x03ffffff			; delta_frames=1 [6328]
.long -1, 0x00999999, 0x01aa99ff, 0x02bbee99, 0x03ffffff			; delta_frames=1 [6329]
.long -1, 0x00aaaaaa, 0x01bbaaff, 0x02cceeaa, 0x03ffffff			; delta_frames=1 [6330]
.long -1, 0x00bbbbbb, 0x01ccbbff, 0x02ddeebb, 0x03ffffff			; delta_frames=1 [6331]
.long -1, 0x00cccccc, 0x01ddccff, 0x02ddeecc, 0x03ffffff			; delta_frames=1 [6332]
.long -1, 0x00dddddd, 0x01ddddff, 0x02eeffdd, 0x03ffffff			; delta_frames=1 [6333]
.long -1, 0x00eeeeee, 0x01eeeeff, 0x02eeffee, 0x03ffffff			; delta_frames=1 [6334]
.long -1, 0x00ffffff, 0x01ffffff, 0x02ffffff, 0x03ffffff			; delta_frames=1 [6335]
.long -1, 0x00ffffff, 0x01ccaa00, 0x02aacc44, 0x0366ffff			; delta_frames=1 [6336]
.long -22, 0x0100ffff			; delta_frames=22 [6358]
.long -17, 0x023388ff			; delta_frames=17 [6375]
.long -16, 0x0133ffff			; delta_frames=16 [6391]
.long -17, 0x023399ff			; delta_frames=17 [6408]
.long -16, 0x0100ffff			; delta_frames=16 [6424]
.long -88, 0x02770000, 0x03ff0000, 0x01cc00cc			; delta_frames=88 [6512]
.long -72, 0x01cc00cc			; delta_frames=72 [6584]
.long -1, 0x01cc11bb			; delta_frames=1 [6585]
.long -1, 0x01cc11aa			; delta_frames=1 [6586]
.long -1, 0x01cc22aa			; delta_frames=1 [6587]
.long -1, 0x01bb3399			; delta_frames=1 [6588]
.long -1, 0x01bb3388			; delta_frames=1 [6589]
.long -1, 0x01bb4477			; delta_frames=1 [6590]
.long -1, 0x01bb5566			; delta_frames=1 [6591]
.long -1, 0x01bb5566			; delta_frames=1 [6592]
.long -1, 0x01bb6655			; delta_frames=1 [6593]
.long -1, 0x01bb7744			; delta_frames=1 [6594]
.long -1, 0x01bb7733			; delta_frames=1 [6595]
.long -1, 0x01aa8822			; delta_frames=1 [6596]
.long -1, 0x01aa9922			; delta_frames=1 [6597]
.long -1, 0x01aa9911			; delta_frames=1 [6598]
.long -1, 0x01aaaa00			; delta_frames=1 [6599]
.long -1, 0x02cc00cc, 0x03990099, 0x01aaaa00			; delta_frames=1 [6600]
.long -72, 0x01aaaa00			; delta_frames=72 [6672]
.long -1, 0x01aa9911			; delta_frames=1 [6673]
.long -1, 0x01aa9911			; delta_frames=1 [6674]
.long -1, 0x01aa8822			; delta_frames=1 [6675]
.long -1, 0x01aa7722			; delta_frames=1 [6676]
.long -1, 0x01aa7733			; delta_frames=1 [6677]
.long -1, 0x01aa6644			; delta_frames=1 [6678]
.long -1, 0x01aa5544			; delta_frames=1 [6679]
.long -1, 0x01995555			; delta_frames=1 [6680]
.long -1, 0x01994455			; delta_frames=1 [6681]
.long -1, 0x01993366			; delta_frames=1 [6682]
.long -1, 0x01993377			; delta_frames=1 [6683]
.long -1, 0x01992277			; delta_frames=1 [6684]
.long -1, 0x01991188			; delta_frames=1 [6685]
.long -1, 0x01991188			; delta_frames=1 [6686]
.long -1, 0x01990099			; delta_frames=1 [6687]
.long -1, 0x02cccc00, 0x03aaaa00, 0x01990099			; delta_frames=1 [6688]
.long -72, 0x01990099			; delta_frames=72 [6760]
.long -1, 0x01991199			; delta_frames=1 [6761]
.long -1, 0x01991199			; delta_frames=1 [6762]
.long -1, 0x01992299			; delta_frames=1 [6763]
.long -1, 0x01992299			; delta_frames=1 [6764]
.long -1, 0x01993399			; delta_frames=1 [6765]
.long -1, 0x01993399			; delta_frames=1 [6766]
.long -1, 0x01994499			; delta_frames=1 [6767]
.long -1, 0x01884488			; delta_frames=1 [6768]
.long -1, 0x01885588			; delta_frames=1 [6769]
.long -1, 0x01885588			; delta_frames=1 [6770]
.long -1, 0x01886688			; delta_frames=1 [6771]
.long -1, 0x01886688			; delta_frames=1 [6772]
.long -1, 0x01887788			; delta_frames=1 [6773]
.long -1, 0x01887788			; delta_frames=1 [6774]
.long -1, 0x01888888			; delta_frames=1 [6775]
.long -1, 0x02ff00ff, 0x03990099, 0x01888888			; delta_frames=1 [6776]
.long -88, 0x01888888, 0x02bbbbbb, 0x03dddddd			; delta_frames=88 [6864]
.long -176, 0x02bbbb00, 0x0300ffff, 0x01aa3300			; delta_frames=176 [7040]
.long -88, 0x02cc00cc, 0x03ccaa00, 0x01aa3300			; delta_frames=88 [7128]
.long -72, 0x01aa3300			; delta_frames=72 [7200]
.long -1, 0x01aa3311			; delta_frames=1 [7201]
.long -1, 0x01993322			; delta_frames=1 [7202]
.long -1, 0x01992233			; delta_frames=1 [7203]
.long -1, 0x01882244			; delta_frames=1 [7204]
.long -1, 0x01882255			; delta_frames=1 [7205]
.long -1, 0x01772266			; delta_frames=1 [7206]
.long -1, 0x01772277			; delta_frames=1 [7207]
.long -1, 0x01661188			; delta_frames=1 [7208]
.long -1, 0x01661199			; delta_frames=1 [7209]
.long -1, 0x015511aa			; delta_frames=1 [7210]
.long -1, 0x015511bb			; delta_frames=1 [7211]
.long -1, 0x014411cc			; delta_frames=1 [7212]
.long -1, 0x014400dd			; delta_frames=1 [7213]
.long -1, 0x013300ee			; delta_frames=1 [7214]
.long -1, 0x013300ff			; delta_frames=1 [7215]
.long -1, 0x02cccc00, 0x03ff0000, 0x013300ff			; delta_frames=1 [7216]
.long -72, 0x013300ff			; delta_frames=72 [7288]
.long -1, 0x013311ff			; delta_frames=1 [7289]
.long -1, 0x013311ff			; delta_frames=1 [7290]
.long -1, 0x013322ff			; delta_frames=1 [7291]
.long -1, 0x013322ff			; delta_frames=1 [7292]
.long -1, 0x013333ff			; delta_frames=1 [7293]
.long -1, 0x013344ff			; delta_frames=1 [7294]
.long -1, 0x013344ff			; delta_frames=1 [7295]
.long -1, 0x013355ff			; delta_frames=1 [7296]
.long -1, 0x013355ff			; delta_frames=1 [7297]
.long -1, 0x013366ff			; delta_frames=1 [7298]
.long -1, 0x013377ff			; delta_frames=1 [7299]
.long -1, 0x013377ff			; delta_frames=1 [7300]
.long -1, 0x013388ff			; delta_frames=1 [7301]
.long -1, 0x013388ff			; delta_frames=1 [7302]
.long -1, 0x013399ff			; delta_frames=1 [7303]
.long -1, 0x023300ff, 0x03ccaa00, 0x013399ff			; delta_frames=1 [7304]
.long -72, 0x013399ff			; delta_frames=72 [7376]
.long -1, 0x013399ff			; delta_frames=1 [7377]
.long -1, 0x014488ff			; delta_frames=1 [7378]
.long -1, 0x014488ee			; delta_frames=1 [7379]
.long -1, 0x015588ee			; delta_frames=1 [7380]
.long -1, 0x015577ee			; delta_frames=1 [7381]
.long -1, 0x016677ee			; delta_frames=1 [7382]
.long -1, 0x016677ee			; delta_frames=1 [7383]
.long -1, 0x017766dd			; delta_frames=1 [7384]
.long -1, 0x017766dd			; delta_frames=1 [7385]
.long -1, 0x018866dd			; delta_frames=1 [7386]
.long -1, 0x018855dd			; delta_frames=1 [7387]
.long -1, 0x019955dd			; delta_frames=1 [7388]
.long -1, 0x019955cc			; delta_frames=1 [7389]
.long -1, 0x01aa44cc			; delta_frames=1 [7390]
.long -1, 0x01aa44cc			; delta_frames=1 [7391]
.long -1, 0x02aacc44, 0x03aa0000, 0x01aa44cc			; delta_frames=1 [7392]
.long -72, 0x01aa44cc			; delta_frames=72 [7464]
.long -1, 0x01aa44bb			; delta_frames=1 [7465]
.long -1, 0x01aa44aa			; delta_frames=1 [7466]
.long -1, 0x01aa44aa			; delta_frames=1 [7467]
.long -1, 0x01aa4499			; delta_frames=1 [7468]
.long -1, 0x01aa4488			; delta_frames=1 [7469]
.long -1, 0x01aa4477			; delta_frames=1 [7470]
.long -1, 0x01aa4466			; delta_frames=1 [7471]
.long -1, 0x01aa3366			; delta_frames=1 [7472]
.long -1, 0x01aa3355			; delta_frames=1 [7473]
.long -1, 0x01aa3344			; delta_frames=1 [7474]
.long -1, 0x01aa3333			; delta_frames=1 [7475]
.long -1, 0x01aa3322			; delta_frames=1 [7476]
.long -1, 0x01aa3322			; delta_frames=1 [7477]
.long -1, 0x01aa3311			; delta_frames=1 [7478]
.long -1, 0x01aa3300			; delta_frames=1 [7479]
.long -1, 0x02990099, 0x03ccaa00, 0x01aa3300			; delta_frames=1 [7480]
.long -72, 0x01aa3300			; delta_frames=72 [7552]
.long -1, 0x01aa3311			; delta_frames=1 [7553]
.long -1, 0x01aa4411			; delta_frames=1 [7554]
.long -1, 0x01aa4422			; delta_frames=1 [7555]
.long -1, 0x01994422			; delta_frames=1 [7556]
.long -1, 0x01995533			; delta_frames=1 [7557]
.long -1, 0x01995533			; delta_frames=1 [7558]
.long -1, 0x01995544			; delta_frames=1 [7559]
.long -1, 0x01996644			; delta_frames=1 [7560]
.long -1, 0x01996655			; delta_frames=1 [7561]
.long -1, 0x01996655			; delta_frames=1 [7562]
.long -1, 0x01997766			; delta_frames=1 [7563]
.long -1, 0x01887766			; delta_frames=1 [7564]
.long -1, 0x01887777			; delta_frames=1 [7565]
.long -1, 0x01888877			; delta_frames=1 [7566]
.long -1, 0x01888888			; delta_frames=1 [7567]
.long -1, 0x01888888, 0x02bbbbbb, 0x03dddddd			; delta_frames=1 [7568]
.long -176, 0x00ffffff, 0x02ccaa00, 0x01aacc44, 0x0300ffff			; delta_frames=176 [7744]
.long -704, 0x00ffffff, 0x01ccaa00, 0x02aacc44, 0x0366ffff			; delta_frames=704 [8448]
.long -396, 0x00ffffff			; delta_frames=396 [8844]
.long -3, 0x00eeeeee			; delta_frames=3 [8847]
.long -3, 0x00dddddd			; delta_frames=3 [8850]
.long -3, 0x00cccccc			; delta_frames=3 [8853]
.long -3, 0x00bbbbbb			; delta_frames=3 [8856]
.long -3, 0x00aaaaaa			; delta_frames=3 [8859]
.long -3, 0x00999999			; delta_frames=3 [8862]
.long -3, 0x00888888			; delta_frames=3 [8865]
.long -3, 0x00777777			; delta_frames=3 [8868]
.long -3, 0x00666666			; delta_frames=3 [8871]
.long -3, 0x00555555			; delta_frames=3 [8874]
.long -3, 0x00444444			; delta_frames=3 [8877]
.long -3, 0x00333333			; delta_frames=3 [8880]
.long -3, 0x00222222			; delta_frames=3 [8883]
.long -3, 0x00111111			; delta_frames=3 [8886]
.long -3, 0x00000000			; delta_frames=3 [8889]
.long 0x80000000	; END_SCRIPT.
