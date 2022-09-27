; ============================================================================
; rose2arc.py
; input = arc/revision/bytecodes.bin.
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
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ba]
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [ad]
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_CONST [9f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [af]
	ldr r0, [r4, #47*4]			; r0=rConstants[47]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [aa]
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [c0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_PROC [07]
	adr r0, proc_39_start		; r0=r_Procedures[39]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [98]
	ldr r0, [r4, #24*4]			; r0=rConstants[24]
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_0:
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_6_start		; r0=r_Procedures[6]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [96]
	ldr r0, [r4, #22*4]			; r0=rConstants[22]
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_1:
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [aa]
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [c0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_2:
	; BC_PROC [07]
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_0_continue_3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_3:
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_2_start		; r0=r_Procedures[2]
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
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_4:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_5:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_6:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_7:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_8:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_9
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_9:
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_10
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_10:
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_11
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_11:
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_12
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_12:
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_13
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_13:
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_14
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_14:
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_15
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_15:
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_16
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_16:
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_17
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_17:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_1_end:

proc_2_start:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_18
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_18:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_19
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_19:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_20
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_20:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_21
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_21:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_22
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_22:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_23
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_23:
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_24
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_24:
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_25
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_25:
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_26
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_26:
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_27
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_27:
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_28
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_28:
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_29
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_29:
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_30
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_30:
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_CONST [b2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
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
proc_2_end:

proc_3_start:
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_3_target_31
	; BC_CONST [a4]
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_3_target_31:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_3_target_32
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
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
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_3_continue_33
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_3_continue_33:
	; BC_PROC [07]
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [84]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #4*4]			; r0=rConstants[4]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	b proc_3_target_34
proc_3_target_32:
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
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
	; BC_DONE [00]
proc_3_target_34:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_3_end:

proc_4_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_4_target_35
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_36
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_36:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_37
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_37:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_38
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_38:
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_39
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_39:
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_40
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_40:
	; BC_PROC [07]
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_41
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_41:
	; BC_PROC [07]
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_42
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_42:
	; BC_PROC [07]
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_43
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_43:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_44
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_44:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_45
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_45:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_4_continue_46
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_4_continue_46:
	; BC_PROC [07]
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_4_target_35:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_4_end:

proc_5_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_5_target_47
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_5_continue_48
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_48:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_5_continue_49
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_49:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_5_continue_50
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_50:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_5_continue_51
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_51:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_5_continue_52
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_52:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_5_continue_53
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_53:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_5_continue_54
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_54:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_5_continue_55
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_55:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_5_continue_56
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_56:
	; BC_PROC [07]
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_5_target_47:
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
	beq proc_6_target_57
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a3]
	ldr r0, [r4, #35*4]			; r0=rConstants[35]
	; BC_WAIT [0a]
	adr r1, proc_6_continue_58
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_6_continue_58:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a3]
	ldr r0, [r4, #35*4]			; r0=rConstants[35]
	; BC_WAIT [0a]
	adr r1, proc_6_continue_59
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_6_continue_59:
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a3]
	ldr r0, [r4, #35*4]			; r0=rConstants[35]
	; BC_WAIT [0a]
	adr r1, proc_6_continue_60
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_6_continue_60:
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_6_target_61
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_ELSE [01]
	b proc_6_target_62
proc_6_target_61:
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PROC [07]
	adr r0, proc_9_start		; r0=r_Procedures[9]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_6_target_62:
	; BC_CONST [a3]
	ldr r0, [r4, #35*4]			; r0=rConstants[35]
	; BC_WAIT [0a]
	adr r1, proc_6_continue_63
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_6_continue_63:
	; BC_PROC [07]
	adr r0, proc_6_start		; r0=r_Procedures[6]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_6_target_57:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_6_end:

proc_7_start:
	; BC_CONST [9f]
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_WAIT [0a]
	adr r1, proc_7_continue_64
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_7_continue_64:
	; BC_CONST [9b]
	ldr r0, [r4, #27*4]			; r0=rConstants[27]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_WAIT [0a]
	adr r1, proc_7_continue_65
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_7_continue_65:
	; BC_CONST [9b]
	ldr r0, [r4, #27*4]			; r0=rConstants[27]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_WAIT [0a]
	adr r1, proc_7_continue_66
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_7_continue_66:
	; BC_CONST [9b]
	ldr r0, [r4, #27*4]			; r0=rConstants[27]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_WAIT [0a]
	adr r1, proc_7_continue_67
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_7_continue_67:
	; BC_CONST [9b]
	ldr r0, [r4, #27*4]			; r0=rConstants[27]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_WAIT [0a]
	adr r1, proc_7_continue_68
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_7_continue_68:
	; BC_CONST [9b]
	ldr r0, [r4, #27*4]			; r0=rConstants[27]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_7_end:

proc_8_start:
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
proc_8_end:

proc_9_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_12_start		; r0=r_Procedures[12]
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
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_10_end:

proc_11_start:
	; BC_CONST [96]
	ldr r0, [r4, #22*4]			; r0=rConstants[22]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1e]
	bgt proc_11_target_69
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_11_continue_70
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_70:
	; BC_PROC [07]
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_11_target_69:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_11_end:

proc_12_start:
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1e]
	bgt proc_12_target_71
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_72
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_72:
	; BC_PROC [07]
	adr r0, proc_12_start		; r0=r_Procedures[12]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_12_target_71:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_12_end:

proc_13_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_13_target_73
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9b]
	ldr r0, [r4, #27*4]			; r0=rConstants[27]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_13_continue_74
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_13_continue_74:
	; BC_PROC [07]
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_13_target_73:
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
	beq proc_14_target_75
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_14_continue_76
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_14_continue_76:
	; BC_PROC [07]
	adr r0, proc_14_start		; r0=r_Procedures[14]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_14_target_75:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_14_end:

proc_15_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_CONST [9f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [c6]
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_CONST [c3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #67*4]			; r0=rConstants[67]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_15_continue_77
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_77:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [95]
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_WAIT [0a]
	adr r1, proc_15_continue_78
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_78:
	; BC_CONST [ad]
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [c2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #66*4]			; r0=rConstants[66]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_15_continue_79
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_79:
	; BC_PROC [07]
	adr r0, proc_37_start		; r0=r_Procedures[37]
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
proc_15_end:

proc_16_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [c2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #66*4]			; r0=rConstants[66]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_80
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_80:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [c2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #66*4]			; r0=rConstants[66]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_81
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_81:
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [c2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #66*4]			; r0=rConstants[66]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_82
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_82:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
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
	; BC_CONST [9f]
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_16_end:

proc_17_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_17_target_83
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_17_target_83:
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_84
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_84:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_17_target_85
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_17_target_85:
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_86
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_86:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_17_target_87
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_17_target_87:
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_88
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_88:
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_17_target_89
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_17_target_89:
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_17_continue_90
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_90:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_17_end:

proc_18_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_18_continue_91
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_18_continue_91:
	; BC_CONST [c2]
	ldr r0, [r4, #66*4]			; r0=rConstants[66]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_18_continue_92
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_18_continue_92:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_18_continue_93
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_18_continue_93:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_18_continue_94
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_18_continue_94:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_18_end:

proc_19_start:
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [c6]
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_19_continue_95
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_19_continue_95:
	; BC_CONST [c2]
	ldr r0, [r4, #66*4]			; r0=rConstants[66]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_19_continue_96
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_19_continue_96:
	; BC_CONST [c3]
	ldr r0, [r4, #67*4]			; r0=rConstants[67]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_19_continue_97
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_19_continue_97:
	; BC_CONST [c3]
	ldr r0, [r4, #67*4]			; r0=rConstants[67]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_19_end:

proc_20_start:
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [c2]
	ldr r0, [r4, #66*4]			; r0=rConstants[66]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_WAIT [0a]
	adr r1, proc_20_continue_98
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_98:
	; BC_CONST [c5]
	ldr r0, [r4, #69*4]			; r0=rConstants[69]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_33_start		; r0=r_Procedures[33]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_20_end:

proc_21_start:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_99
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_99:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_100
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_100:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_101
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_101:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_102
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_102:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_103
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_103:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_104
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_104:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_105
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_105:
	; BC_PROC [07]
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_106
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_106:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_107
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_107:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_108
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_108:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_109
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_109:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_110
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_110:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_111
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_111:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_112
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_112:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_113
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_113:
	; BC_PROC [07]
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_21_continue_114
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_114:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_21_end:

proc_22_start:
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_115
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_115:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_116
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_116:
	; BC_CONST [c8]
	ldr r0, [r4, #72*4]			; r0=rConstants[72]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_117
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_117:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_118
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_118:
	; BC_CONST [c7]
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_119
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_119:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_120
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_120:
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_121
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_121:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_122
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_122:
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_123
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_123:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_22_continue_124
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_22_continue_124:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_22_end:

proc_23_start:
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_125
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_125:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_126
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_126:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_127
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_127:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_128
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_128:
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_129
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_129:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_130
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_130:
	; BC_CONST [c7]
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_131
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_131:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_132
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_132:
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_133
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_133:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_134
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_134:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_23_end:

proc_24_start:
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_24_continue_135
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_135:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_24_continue_136
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_136:
	; BC_CONST [c8]
	ldr r0, [r4, #72*4]			; r0=rConstants[72]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_24_continue_137
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_137:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_24_continue_138
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_138:
	; BC_CONST [c7]
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [99]
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_WAIT [0a]
	adr r1, proc_24_continue_139
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_139:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_24_continue_140
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_140:
	; BC_CONST [c8]
	ldr r0, [r4, #72*4]			; r0=rConstants[72]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [96]
	ldr r0, [r4, #22*4]			; r0=rConstants[22]
	; BC_WAIT [0a]
	adr r1, proc_24_continue_141
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_141:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_24_continue_142
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_142:
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [94]
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_WAIT [0a]
	adr r1, proc_24_continue_143
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_143:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_24_continue_144
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_24_continue_144:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_24_end:

proc_25_start:
	; BC_CONST [a1]
	ldr r0, [r4, #33*4]			; r0=rConstants[33]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [c9]
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_145
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_145:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_146
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_146:
	; BC_CONST [c8]
	ldr r0, [r4, #72*4]			; r0=rConstants[72]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_147
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_147:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_148
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_148:
	; BC_CONST [c7]
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_149
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_149:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_150
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_150:
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_29_start		; r0=r_Procedures[29]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_151
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_151:
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
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
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [78]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_152
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_152:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_25_end:

proc_26_start:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_26_end:

proc_27_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_27_target_153
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
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_27_continue_154
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_154:
	; BC_PROC [07]
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_27_target_153:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_27_end:

proc_28_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
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
	adr r0, proc_30_start		; r0=r_Procedures[30]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_28_end:

proc_29_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_28_start		; r0=r_Procedures[28]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_29_end:

proc_30_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_30_target_155
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
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
	adr r0, proc_31_start		; r0=r_Procedures[31]
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
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WAIT [0a]
	adr r1, proc_30_continue_156
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_30_continue_156:
	; BC_PROC [07]
	adr r0, proc_30_start		; r0=r_Procedures[30]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [33]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, lsr #16			; swap.w r1
	and r1, r1, #63				; only bottom 6 bits are valid.
	movs r0, r0, ror r1			; r0=r0 ror r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_30_target_155:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_30_end:

proc_31_start:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_32_start		; r0=r_Procedures[32]
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_32_target_157
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WHEN [17]
	beq proc_32_target_158
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_32_target_158:
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	; BC_WAIT [0a]
	adr r1, proc_32_continue_159
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_32_continue_159:
	; BC_PROC [07]
	adr r0, proc_32_start		; r0=r_Procedures[32]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_32_target_157:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_32_end:

proc_33_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_34_start		; r0=r_Procedures[34]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_33_end:

proc_34_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_34_target_160
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_35_start		; r0=r_Procedures[35]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [81]
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_WAIT [0a]
	adr r1, proc_34_continue_161
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_34_continue_161:
	; BC_PROC [07]
	adr r0, proc_34_start		; r0=r_Procedures[34]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [33]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r1, r1, lsr #16			; swap.w r1
	and r1, r1, #63				; only bottom 6 bits are valid.
	movs r0, r0, ror r1			; r0=r0 ror r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_34_target_160:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_34_end:

proc_35_start:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
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
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_36_target_162
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_OP [3c]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	ands r0, r0, r1				; r0=r0 ands r1
	; BC_WHEN [17]
	beq proc_36_target_163
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_36_target_163:
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_36_start		; r0=r_Procedures[36]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_36_target_162:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_36_end:

proc_37_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [aa]
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_38_start		; r0=r_Procedures[38]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
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
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [aa]
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_38_start		; r0=r_Procedures[38]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_37_end:

proc_38_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	; BC_WHEN [17]
	movs r0, r0					; update Status flags
	beq proc_38_target_164
	; BC_PLOT [06]
	add r6, r5, #4
	ldmia r6, {r8-r11}		; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutSquare
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_38_start		; r0=r_Procedures[38]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
proc_38_target_164:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_38_end:

proc_39_start:
	; BC_CONST [81]
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_WSTATE [58]
	str r0, [r5, #ST_WIRE0*4]		; State[ST_WIRE0]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
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
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [93]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_165
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_165:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_166
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_166:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [8c]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_167
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_167:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_168
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_168:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_169
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_169:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_47_start		; r0=r_Procedures[47]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_170
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_170:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [86]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #6*4]			; r0=rConstants[6]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_48_start		; r0=r_Procedures[48]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_171
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_171:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #5*4]			; r0=rConstants[5]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_172
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_172:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [83]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #3*4]			; r0=rConstants[3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_50_start		; r0=r_Procedures[50]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_173
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_173:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	subs r0, r0, r1				; r0=r0 subs r1
	; BC_WSTATE [52]
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_CONST [82]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_WAIT [0a]
	adr r1, proc_40_continue_174
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_40_continue_174:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_40_end:

proc_41_start:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	adds r0, r0, r1				; r0=r0 adds r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
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
proc_41_end:

proc_42_start:
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_42_target_175
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_42_continue_176
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_42_continue_176:
	; BC_PROC [07]
	adr r0, proc_42_start		; r0=r_Procedures[42]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_42_target_175:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_42_end:

proc_43_start:
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_43_target_177
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_43_continue_178
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_43_continue_178:
	; BC_PROC [07]
	adr r0, proc_43_start		; r0=r_Procedures[43]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_43_target_177:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_43_end:

proc_44_start:
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_44_target_179
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_44_continue_180
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_44_continue_180:
	; BC_PROC [07]
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_44_target_181
proc_44_target_179:
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_44_target_182
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_44_continue_183
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_44_continue_183:
	; BC_PROC [07]
	adr r0, proc_44_start		; r0=r_Procedures[44]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_44_target_182:
	; BC_DONE [00]
proc_44_target_181:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_44_end:

proc_45_start:
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_45_target_184
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_45_continue_185
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_45_continue_185:
	; BC_PROC [07]
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_45_target_186
proc_45_target_184:
	; BC_CONST [a0]
	ldr r0, [r4, #32*4]			; r0=rConstants[32]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_45_target_187
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_45_continue_188
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_45_continue_188:
	; BC_PROC [07]
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_45_target_189
proc_45_target_187:
	; BC_CONST [ab]
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_45_target_190
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_45_continue_191
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_45_continue_191:
	; BC_PROC [07]
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_45_target_192
proc_45_target_190:
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_45_target_193
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_45_continue_194
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_45_continue_194:
	; BC_PROC [07]
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_45_target_195
proc_45_target_193:
	; BC_CONST [ba]
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_45_target_196
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_45_continue_197
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_45_continue_197:
	; BC_PROC [07]
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_45_target_198
proc_45_target_196:
	; BC_CONST [bc]
	ldr r0, [r4, #60*4]			; r0=rConstants[60]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_45_target_199
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_45_continue_200
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_45_continue_200:
	; BC_PROC [07]
	adr r0, proc_45_start		; r0=r_Procedures[45]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_45_target_199:
	; BC_DONE [00]
proc_45_target_198:
	; BC_DONE [00]
proc_45_target_195:
	; BC_DONE [00]
proc_45_target_192:
	; BC_DONE [00]
proc_45_target_189:
	; BC_DONE [00]
proc_45_target_186:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_45_end:

proc_46_start:
	; BC_CONST [a2]
	ldr r0, [r4, #34*4]			; r0=rConstants[34]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_46_target_201
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_46_continue_202
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_202:
	; BC_PROC [07]
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_46_target_203
proc_46_target_201:
	; BC_CONST [a5]
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_46_target_204
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_46_continue_205
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_205:
	; BC_PROC [07]
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_46_target_206
proc_46_target_204:
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_46_target_207
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_46_continue_208
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_208:
	; BC_PROC [07]
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_46_target_209
proc_46_target_207:
	; BC_CONST [b8]
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_46_target_210
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_46_continue_211
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_211:
	; BC_PROC [07]
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_46_target_212
proc_46_target_210:
	; BC_CONST [bd]
	ldr r0, [r4, #61*4]			; r0=rConstants[61]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_46_target_213
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_46_continue_214
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_214:
	; BC_PROC [07]
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_46_target_215
proc_46_target_213:
	; BC_CONST [bf]
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_46_target_216
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_46_continue_217
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_217:
	; BC_PROC [07]
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_46_target_218
proc_46_target_216:
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_46_target_219
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_46_continue_220
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_46_continue_220:
	; BC_PROC [07]
	adr r0, proc_46_start		; r0=r_Procedures[46]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_46_target_219:
	; BC_DONE [00]
proc_46_target_218:
	; BC_DONE [00]
proc_46_target_215:
	; BC_DONE [00]
proc_46_target_212:
	; BC_DONE [00]
proc_46_target_209:
	; BC_DONE [00]
proc_46_target_206:
	; BC_DONE [00]
proc_46_target_203:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_46_end:

proc_47_start:
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_47_target_221
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_47_continue_222
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_47_continue_222:
	; BC_PROC [07]
	adr r0, proc_47_start		; r0=r_Procedures[47]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_47_target_221:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_47_end:

proc_48_start:
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_48_target_223
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_48_continue_224
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_48_continue_224:
	; BC_PROC [07]
	adr r0, proc_48_start		; r0=r_Procedures[48]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_48_target_223:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_48_end:

proc_49_start:
	; BC_CONST [97]
	ldr r0, [r4, #23*4]			; r0=rConstants[23]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_225
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_226
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_226:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_227
proc_49_target_225:
	; BC_CONST [9d]
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_228
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_229
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_229:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_230
proc_49_target_228:
	; BC_CONST [a7]
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_231
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_232
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_232:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_233
proc_49_target_231:
	; BC_CONST [a9]
	ldr r0, [r4, #41*4]			; r0=rConstants[41]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_234
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_235
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_235:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_236
proc_49_target_234:
	; BC_CONST [ac]
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_237
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_238
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_238:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_239
proc_49_target_237:
	; BC_CONST [ae]
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_240
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_241
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_241:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_242
proc_49_target_240:
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_243
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_244
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_244:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_245
proc_49_target_243:
	; BC_CONST [b3]
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_246
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_247
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_247:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_248
proc_49_target_246:
	; BC_CONST [b5]
	ldr r0, [r4, #53*4]			; r0=rConstants[53]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_249
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_250
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_250:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_251
proc_49_target_249:
	; BC_CONST [bb]
	ldr r0, [r4, #59*4]			; r0=rConstants[59]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_252
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_253
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_253:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_254
proc_49_target_252:
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_255
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_256
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_256:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_49_target_257
proc_49_target_255:
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_49_target_258
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_49_continue_259
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_49_continue_259:
	; BC_PROC [07]
	adr r0, proc_49_start		; r0=r_Procedures[49]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_49_target_258:
	; BC_DONE [00]
proc_49_target_257:
	; BC_DONE [00]
proc_49_target_254:
	; BC_DONE [00]
proc_49_target_251:
	; BC_DONE [00]
proc_49_target_248:
	; BC_DONE [00]
proc_49_target_245:
	; BC_DONE [00]
proc_49_target_242:
	; BC_DONE [00]
proc_49_target_239:
	; BC_DONE [00]
proc_49_target_236:
	; BC_DONE [00]
proc_49_target_233:
	; BC_DONE [00]
proc_49_target_230:
	; BC_DONE [00]
proc_49_target_227:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_49_end:

proc_50_start:
	; BC_CONST [c1]
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_50_target_260
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_50_continue_261
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_50_continue_261:
	; BC_PROC [07]
	adr r0, proc_50_start		; r0=r_Procedures[50]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_50_target_260:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_50_end:

proc_51_start:
	; BC_CONST [9a]
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_51_target_262
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_51_continue_263
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_51_continue_263:
	; BC_PROC [07]
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_51_target_264
proc_51_target_262:
	; BC_CONST [a6]
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_51_target_265
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_51_continue_266
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_51_continue_266:
	; BC_PROC [07]
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_51_target_267
proc_51_target_265:
	; BC_CONST [b4]
	ldr r0, [r4, #52*4]			; r0=rConstants[52]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_51_target_268
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_51_continue_269
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_51_continue_269:
	; BC_PROC [07]
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_ELSE [01]
	b proc_51_target_270
proc_51_target_268:
	; BC_CONST [b6]
	ldr r0, [r4, #54*4]			; r0=rConstants[54]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_51_target_271
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_41_start		; r0=r_Procedures[41]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
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
	; BC_RSTATE [78]
	ldr r0, [r5, #ST_WIRE0*4]		; r0=State[ST_WIRE0]
	; BC_WAIT [0a]
	adr r1, proc_51_continue_272
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_51_continue_272:
	; BC_PROC [07]
	adr r0, proc_51_start		; r0=r_Procedures[51]
	; BC_WSTATE [50]
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_51_target_271:
	; BC_DONE [00]
proc_51_target_270:
	; BC_DONE [00]
proc_51_target_267:
	; BC_DONE [00]
proc_51_target_264:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_51_end:


; ============================================================================
; Constants.
; ============================================================================

r_Constants:
.long 0x00000000				; [0] = 0.0
.long 0x00008000				; [1] = 0.5
.long 0x0000b0a3				; [2] = 0.6899871826171875
.long 0x0000c51e				; [3] = 0.769989013671875
.long 0x0000cccc				; [4] = 0.79998779296875
.long 0x0000deb8				; [5] = 0.8699951171875
.long 0x0000fd70				; [6] = 0.989990234375
.long 0x00010000				; [7] = 1.0
.long 0x000128f5				; [8] = 1.1599884033203125
.long 0x00016666				; [9] = 1.399993896484375
.long 0x0001c7ae				; [10] = 1.779998779296875
.long 0x00020000				; [11] = 2.0
.long 0x00028000				; [12] = 2.5
.long 0x00030000				; [13] = 3.0
.long 0x00040000				; [14] = 4.0
.long 0x00050000				; [15] = 5.0
.long 0x00060000				; [16] = 6.0
.long 0x00070000				; [17] = 7.0
.long 0x00080000				; [18] = 8.0
.long 0x000a0000				; [19] = 10.0
.long 0x000b0000				; [20] = 11.0
.long 0x000c0000				; [21] = 12.0
.long 0x000f0000				; [22] = 15.0
.long 0x00100000				; [23] = 16.0
.long 0x00110000				; [24] = 17.0
.long 0x00130000				; [25] = 19.0
.long 0x00140000				; [26] = 20.0
.long 0x00150000				; [27] = 21.0
.long 0x00170000				; [28] = 23.0
.long 0x00180000				; [29] = 24.0
.long 0x00190000				; [30] = 25.0
.long 0x001e0000				; [31] = 30.0
.long 0x00200000				; [32] = 32.0
.long 0x00210000				; [33] = 33.0
.long 0x00230000				; [34] = 35.0
.long 0x00300000				; [35] = 48.0
.long 0x00320000				; [36] = 50.0
.long 0x00340000				; [37] = 52.0
.long 0x003c0000				; [38] = 60.0
.long 0x00400000				; [39] = 64.0
.long 0x00460000				; [40] = 70.0
.long 0x004e0000				; [41] = 78.0
.long 0x00500000				; [42] = 80.0
.long 0x00520000				; [43] = 82.0
.long 0x00580000				; [44] = 88.0
.long 0x005a0000				; [45] = 90.0
.long 0x00600000				; [46] = 96.0
.long 0x006e0000				; [47] = 110.0
.long 0x00700000				; [48] = 112.0
.long 0x007d0000				; [49] = 125.0
.long 0x00800000				; [50] = 128.0
.long 0x00860000				; [51] = 134.0
.long 0x009a0000				; [52] = 154.0
.long 0x009c0000				; [53] = 156.0
.long 0x00a20000				; [54] = 162.0
.long 0x00b00000				; [55] = 176.0
.long 0x00b60000				; [56] = 182.0
.long 0x00be0000				; [57] = 190.0
.long 0x00c00000				; [58] = 192.0
.long 0x00c80000				; [59] = 200.0
.long 0x00cc0000				; [60] = 204.0
.long 0x00e00000				; [61] = 224.0
.long 0x00f00000				; [62] = 240.0
.long 0x00f40000				; [63] = 244.0
.long 0x00fa0000				; [64] = 250.0
.long 0x01000000				; [65] = 256.0
.long 0x081f1f82				; [66] = 2079.123077392578
.long 0x14bc3c49				; [67] = 5308.235488891602
.long 0x820f08f0				; [68] = 33295.034912109375
.long 0x823f3f20				; [69] = 33343.24658203125
.long 0x881f1f81				; [70] = 34847.12306213379
.long 0x98611bb6				; [71] = 39009.10824584961
.long 0x9a7226a6				; [72] = 39538.150970458984
.long 0xf8800083				; [73] = 63616.00199890137

; ============================================================================
; Color Script.
; ============================================================================

r_ColorScript:
.long -1, 0x00221111, 0x01ffffff, 0x02ffffff, 0x03000000, 0x04000000, 0x05221111, 0x06221111, 0x07555500			; delta_frames=1 [0]
.long 0x80000000	; END_SCRIPT.
