; ============================================================================
; rose2arc.py
; input = arc/chiperia/bytecodes.bin.
; ============================================================================

.equ ST_PROC, 0
.equ ST_X, 1
.equ ST_Y, 2
.equ ST_SIZE, 3
.equ ST_TINT, 4
.equ ST_RAND, 5
.equ ST_DIR, 6
.equ ST_TIME, 7

; ============================================================================
; r3 = p_StateStack.
; r4 = r_Constants.
; r5 = p_State.
; r6 = <temp>           ; r_StateSpace.
; r7 = r_Sinus.
; ============================================================================

proc_0_start:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_6_start		; r0=r_Procedures[6]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_0:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_1:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_2:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_12_start		; r0=r_Procedures[12]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_6_start		; r0=r_Procedures[6]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_3:
	; BC_PROC [07]
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_4:
	; BC_PROC [07]
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_5:
	; BC_PROC [07]
	adr r0, proc_21_start		; r0=r_Procedures[21]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_12_start		; r0=r_Procedures[12]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_6:
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_7:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_6_start		; r0=r_Procedures[6]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_7_start		; r0=r_Procedures[7]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_8:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_8_start		; r0=r_Procedures[8]
	; BC_FORK [21]
	mov r1, #1
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
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_9
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_9:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_10_start		; r0=r_Procedures[10]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_11_start		; r0=r_Procedures[11]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_10
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_10:
	; BC_PROC [07]
	adr r0, proc_22_start		; r0=r_Procedures[22]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_12_start		; r0=r_Procedures[12]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_13_start		; r0=r_Procedures[13]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_11
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_11:
	; BC_PROC [07]
	adr r0, proc_25_start		; r0=r_Procedures[25]
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [e0]
	ldr r0, [r4, #96*4]			; r0=rConstants[96]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_12
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_12:
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [c6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_13
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_13:
	; BC_CONST [88]
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_14
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_14:
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_3_start		; r0=r_Procedures[3]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_0_continue_15
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_0_continue_15:
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_4_start		; r0=r_Procedures[4]
	; BC_FORK [21]
	mov r1, #1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_0_end:

proc_1_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [d1]
	ldr r0, [r4, #81*4]			; r0=rConstants[81]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c2]
	ldr r0, [r4, #66*4]			; r0=rConstants[66]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_1_end:

proc_2_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c0]
	ldr r0, [r4, #64*4]			; r0=rConstants[64]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_2_end:

proc_3_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [d8]
	ldr r0, [r4, #88*4]			; r0=rConstants[88]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [bb]
	ldr r0, [r4, #59*4]			; r0=rConstants[59]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_3_end:

proc_4_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [da]
	ldr r0, [r4, #90*4]			; r0=rConstants[90]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b7]
	ldr r0, [r4, #55*4]			; r0=rConstants[55]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_FORK [24]
	mov r1, #4
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_4_end:

proc_5_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_5_target_16
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WAIT [0a]
	adr r1, proc_5_continue_17
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_5_continue_17:
	; BC_PROC [07]
	adr r0, proc_5_start		; r0=r_Procedures[5]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_5_target_16:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_5_end:

proc_6_start:
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_CONST [a6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #38*4]			; r0=rConstants[38]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_6_continue_18
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_6_continue_18:
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [ab]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #43*4]			; r0=rConstants[43]
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #23*4]			; r0=rConstants[23]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_6_continue_19
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_6_continue_19:
	; BC_CONST [b2]
	ldr r0, [r4, #50*4]			; r0=rConstants[50]
	; BC_CONST [cc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #76*4]			; r0=rConstants[76]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_6_continue_20
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_6_continue_20:
	; BC_CONST [d5]
	ldr r0, [r4, #85*4]			; r0=rConstants[85]
	; BC_CONST [d2]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #82*4]			; r0=rConstants[82]
	; BC_CONST [ca]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #74*4]			; r0=rConstants[74]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_6_end:

proc_7_start:
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_7_continue_21
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_7_continue_21:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [cd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #77*4]			; r0=rConstants[77]
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_7_continue_22
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_7_continue_22:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [bd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #61*4]			; r0=rConstants[61]
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_7_continue_23
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_7_continue_23:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [af]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #47*4]			; r0=rConstants[47]
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_7_end:

proc_8_start:
	; BC_CONST [ba]
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_8_continue_24
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_8_continue_24:
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_CONST [a5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #37*4]			; r0=rConstants[37]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_8_continue_25
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_8_continue_25:
	; BC_CONST [ba]
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_CONST [d3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #83*4]			; r0=rConstants[83]
	; BC_CONST [ce]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #78*4]			; r0=rConstants[78]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_8_continue_26
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_8_continue_26:
	; BC_CONST [cf]
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_CONST [d3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #83*4]			; r0=rConstants[83]
	; BC_CONST [bc]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #60*4]			; r0=rConstants[60]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_8_end:

proc_9_start:
	; BC_CONST [88]
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_WAIT [0a]
	adr r1, proc_9_continue_27
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_9_continue_27:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_9_continue_28
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_9_continue_28:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [cf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #79*4]			; r0=rConstants[79]
	; BC_CONST [ad]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_CONST [90]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [bf]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #63*4]			; r0=rConstants[63]
	; BC_CONST [ba]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_9_end:

proc_10_start:
	; BC_CONST [c6]
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_CONST [a4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #36*4]			; r0=rConstants[36]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_10_continue_29
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_29:
	; BC_CONST [c6]
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_CONST [b4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #52*4]			; r0=rConstants[52]
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #53*4]			; r0=rConstants[53]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_10_continue_30
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_30:
	; BC_CONST [c6]
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_CONST [c3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #67*4]			; r0=rConstants[67]
	; BC_CONST [d9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #89*4]			; r0=rConstants[89]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_10_continue_31
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_10_continue_31:
	; BC_CONST [c6]
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_CONST [d4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #84*4]			; r0=rConstants[84]
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_10_end:

proc_11_start:
	; BC_CONST [8a]
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_WAIT [0a]
	adr r1, proc_11_continue_32
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_32:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [c6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_CONST [ac]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #44*4]			; r0=rConstants[44]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_11_continue_33
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_33:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [c6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_CONST [b8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #56*4]			; r0=rConstants[56]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_11_continue_34
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_11_continue_34:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [c6]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #70*4]			; r0=rConstants[70]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_11_end:

proc_12_start:
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [a3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #35*4]			; r0=rConstants[35]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_35
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_35:
	; BC_CONST [d0]
	ldr r0, [r4, #80*4]			; r0=rConstants[80]
	; BC_CONST [b3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_36
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_36:
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [c3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #67*4]			; r0=rConstants[67]
	; BC_CONST [b9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #57*4]			; r0=rConstants[57]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_12_continue_37
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_12_continue_37:
	; BC_CONST [be]
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [d4]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #84*4]			; r0=rConstants[84]
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
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
	; BC_CONST [88]
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_WAIT [0a]
	adr r1, proc_13_continue_38
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_13_continue_38:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_CONST [b3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_CONST [cb]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #75*4]			; r0=rConstants[75]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_13_continue_39
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_13_continue_39:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [aa]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #42*4]			; r0=rConstants[42]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_CONST [8d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_WAIT [0a]
	adr r1, proc_13_continue_40
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_13_continue_40:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [c1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #65*4]			; r0=rConstants[65]
	; BC_CONST [b3]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #51*4]			; r0=rConstants[51]
	; BC_CONST [a7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #39*4]			; r0=rConstants[39]
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [92]
	ldr r0, [r4, #18*4]			; r0=rConstants[18]
	; BC_WAIT [0a]
	adr r1, proc_13_continue_41
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_13_continue_41:
	; BC_PROC [07]
	adr r0, proc_15_start		; r0=r_Procedures[15]
	; BC_CONST [be]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #62*4]			; r0=rConstants[62]
	; BC_CONST [c9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #73*4]			; r0=rConstants[73]
	; BC_CONST [a8]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [8a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_13_end:

proc_14_start:
	; BC_CONST [93]
	ldr r0, [r4, #19*4]			; r0=rConstants[19]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [88]
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_WAIT [0a]
	adr r1, proc_14_continue_42
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_14_continue_42:
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a2]
	ldr r0, [r4, #34*4]			; r0=rConstants[34]
	; BC_WAIT [0a]
	adr r1, proc_14_continue_43
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_14_continue_43:
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
proc_14_end:

proc_15_start:
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [88]
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_WAIT [0a]
	adr r1, proc_15_continue_44
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_44:
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
	; BC_WAIT [0a]
	adr r1, proc_15_continue_45
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_45:
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
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
	adr r1, proc_15_continue_46
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_15_continue_46:
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
proc_15_end:

proc_16_start:
	; BC_CONST [88]
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [97]
	ldr r0, [r4, #23*4]			; r0=rConstants[23]
	; BC_WAIT [0a]
	adr r1, proc_16_continue_47
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_16_continue_47:
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
proc_16_end:

proc_17_start:
	; BC_RLOCAL [67]
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	movs r0, r0					; update Status flags
	; BC_WHEN [17]
	beq proc_17_target_48
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	movs r0, r0					; update Status flags
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [66]
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	movs r0, r0					; update Status flags
	; BC_WAIT [0a]
	adr r1, proc_17_continue_49
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_17_continue_49:
	; BC_PROC [07]
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_WLOCAL [47]
	str r0, [r5, #-8*4]			; StateStack[-8]=r0
	; BC_WLOCAL [44]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-5*4]			; StateStack[-5]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_17_target_48:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_17_end:

proc_18_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	movs r0, r0					; update Status flags
	; BC_WLOCAL [43]
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
proc_18_end:

proc_19_start:
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_WHEN [17]
	beq proc_19_target_50
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_FORK [20]
	mov r1, #0
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_WAIT [0a]
	adr r1, proc_19_continue_51
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_19_continue_51:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_19_start		; r0=r_Procedures[19]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_19_target_50:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_19_end:

proc_20_start:
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_CONST [8b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_CONST [a9]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #41*4]			; r0=rConstants[41]
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [b0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_WAIT [0a]
	adr r1, proc_20_continue_52
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_52:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [66]
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [96]
	ldr r0, [r4, #22*4]			; r0=rConstants[22]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [65]
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b6]
	ldr r0, [r4, #54*4]			; r0=rConstants[54]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_16_start		; r0=r_Procedures[16]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	movs r0, r0					; update Status flags
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	movs r0, r0					; update Status flags
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	movs r0, r0					; update Status flags
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_FORK [27]
	mov r1, #7
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_20_continue_53
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_53:
	; BC_PROC [07]
	adr r0, proc_16_start		; r0=r_Procedures[16]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_CONST [95]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #21*4]			; r0=rConstants[21]
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_RLOCAL [66]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	movs r0, r0					; update Status flags
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_17_start		; r0=r_Procedures[17]
	; BC_FORK [28]
	mov r1, #8
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [64]
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	movs r0, r0					; update Status flags
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_20_continue_54
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_20_continue_54:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_RLOCAL [66]
	ldr r0, [r5, #-7*4]			; r0=StateStack[-7]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [96]
	ldr r0, [r4, #22*4]			; r0=rConstants[22]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_PROC [07]
	adr r0, proc_18_start		; r0=r_Procedures[18]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_16_start		; r0=r_Procedures[16]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	movs r0, r0					; update Status flags
	; BC_RSTATE [72]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	movs r0, r0					; update Status flags
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [65]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-6*4]			; r0=StateStack[-6]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [67]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-8*4]			; r0=StateStack[-8]
	movs r0, r0					; update Status flags
	; BC_WLOCAL [46]
	str r0, [r5, #-7*4]			; StateStack[-7]=r0
	; BC_WLOCAL [45]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #-6*4]			; StateStack[-6]=r0
	; BC_WLOCAL [44]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
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
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_20_end:

proc_21_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_CONST [83]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #3*4]			; r0=rConstants[3]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_20_start		; r0=r_Procedures[20]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [b0]
	ldr r0, [r4, #48*4]			; r0=rConstants[48]
	; BC_WAIT [0a]
	adr r1, proc_21_continue_55
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_21_continue_55:
	; BC_PROC [07]
	adr r0, proc_14_start		; r0=r_Procedures[14]
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
proc_21_end:

proc_22_start:
	; BC_PROC [07]
	adr r0, proc_14_start		; r0=r_Procedures[14]
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
proc_22_end:

proc_23_start:
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_WHEN [17]
	beq proc_23_target_56
	; BC_CONST [a8]
	ldr r0, [r4, #40*4]			; r0=rConstants[40]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_RLOCAL [64]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-5*4]			; r0=StateStack[-5]
	movs r0, r0					; update Status flags
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_23_continue_57
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_23_continue_57:
	; BC_PROC [07]
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_WLOCAL [43]
	str r0, [r5, #-4*4]			; StateStack[-4]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_23_target_56:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_23_end:

proc_24_start:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_WHEN [17]
	beq proc_24_target_58
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_PROC [07]
	adr r0, proc_24_start		; r0=r_Procedures[24]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_WLOCAL [41]
	str r0, [r5, #-2*4]			; StateStack[-2]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_24_target_58:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_24_end:

proc_25_start:
	; BC_CONST [dc]
	ldr r0, [r4, #92*4]			; r0=rConstants[92]
	; BC_CONST [db]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #91*4]			; r0=rConstants[91]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [ce]
	ldr r0, [r4, #78*4]			; r0=rConstants[78]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [88]
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_SEED [0c]
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [ca]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #74*4]			; r0=rConstants[74]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c7]
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_59
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_59:
	; BC_CONST [df]
	ldr r0, [r4, #95*4]			; r0=rConstants[95]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [9b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #27*4]			; r0=rConstants[27]
	; BC_CONST [a0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #32*4]			; r0=rConstants[32]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_60
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_60:
	; BC_CONST [ce]
	ldr r0, [r4, #78*4]			; r0=rConstants[78]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [c8]
	ldr r0, [r4, #72*4]			; r0=rConstants[72]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8a]
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_SEED [0c]
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [ca]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #74*4]			; r0=rConstants[74]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_61
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_61:
	; BC_CONST [a3]
	ldr r0, [r4, #35*4]			; r0=rConstants[35]
	; BC_CONST [af]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #47*4]			; r0=rConstants[47]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [d7]
	ldr r0, [r4, #87*4]			; r0=rConstants[87]
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [9b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #27*4]			; r0=rConstants[27]
	; BC_CONST [9d]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #29*4]			; r0=rConstants[29]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [98]
	ldr r0, [r4, #24*4]			; r0=rConstants[24]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_62
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_62:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_CONST [b5]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #53*4]			; r0=rConstants[53]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [9e]
	ldr r0, [r4, #30*4]			; r0=rConstants[30]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_SEED [0c]
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [c7]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #71*4]			; r0=rConstants[71]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [c5]
	ldr r0, [r4, #69*4]			; r0=rConstants[69]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_63
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_63:
	; BC_CONST [df]
	ldr r0, [r4, #95*4]			; r0=rConstants[95]
	; BC_CONST [dd]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #93*4]			; r0=rConstants[93]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [ba]
	ldr r0, [r4, #58*4]			; r0=rConstants[58]
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [9a]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #26*4]			; r0=rConstants[26]
	; BC_CONST [9f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #31*4]			; r0=rConstants[31]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_64
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_64:
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
	; BC_CONST [b5]
	ldr r0, [r4, #53*4]			; r0=rConstants[53]
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8e]
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_SEED [0c]
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_CONST [99]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #25*4]			; r0=rConstants[25]
	; BC_CONST [ae]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #46*4]			; r0=rConstants[46]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [ad]
	ldr r0, [r4, #45*4]			; r0=rConstants[45]
	; BC_WAIT [0a]
	adr r1, proc_25_continue_65
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_25_continue_65:
	; BC_CONST [df]
	ldr r0, [r4, #95*4]			; r0=rConstants[95]
	; BC_CONST [b1]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8f]
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [c4]
	ldr r0, [r4, #68*4]			; r0=rConstants[68]
	; BC_CONST [94]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #20*4]			; r0=rConstants[20]
	; BC_CONST [91]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_CONST [9b]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #27*4]			; r0=rConstants[27]
	; BC_CONST [a0]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #32*4]			; r0=rConstants[32]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_23_start		; r0=r_Procedures[23]
	; BC_FORK [25]
	mov r1, #5
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_25_end:

proc_26_start:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WHEN [17]
	beq proc_26_target_66
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [85]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #5*4]			; r0=rConstants[5]
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #23*4]			; r0=rConstants[23]
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [86]
	ldr r0, [r4, #6*4]			; r0=rConstants[6]
	; BC_WAIT [0a]
	adr r1, proc_26_continue_67
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_26_continue_67:
	; BC_PROC [07]
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
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
proc_26_target_66:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_26_end:

proc_27_start:
	; BC_RLOCAL [62]
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_WHEN [17]
	beq proc_27_target_68
	; BC_CONST [91]
	ldr r0, [r4, #17*4]			; r0=rConstants[17]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [16]
	bne proc_27_target_69
	; BC_CONST [b1]
	ldr r0, [r4, #49*4]			; r0=rConstants[49]
	; BC_CONST [84]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #4*4]			; r0=rConstants[4]
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_CONST [89]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #23*4]			; r0=rConstants[23]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_FORK [23]
	mov r1, #3
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_RLOCAL [63]
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_DONE [00]
proc_27_target_69:
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_WHEN [17]
	beq proc_27_target_70
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [9c]
	ldr r0, [r4, #28*4]			; r0=rConstants[28]
	; BC_CONST [84]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #4*4]			; r0=rConstants[4]
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_RAND*4]
	mov r1, r0
	mov r2, r0, lsl #16
	orr r0, r2, r0, lsr #16
	mov r2, #0x9d3d
	mul r1, r2, r1
	add r0, r0, r1
	str r0, [r5, #ST_RAND*4]
	mov r0, r0, lsr #16
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, asr #8
	mov r1, r1, asr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_RSTATE [76]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_DIR*4]		; r0=State[ST_DIR]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [87]
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_WAIT [0a]
	adr r1, proc_27_continue_71
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_27_continue_71:
	; BC_PROC [07]
	adr r0, proc_27_start		; r0=r_Procedures[27]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_RLOCAL [62]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-3*4]			; r0=StateStack[-3]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
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
	b proc_27_target_72
proc_27_target_70:
	; BC_PROC [07]
	adr r0, proc_26_start		; r0=r_Procedures[26]
	; BC_CONST [97]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #23*4]			; r0=rConstants[23]
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
proc_27_target_72:
	; BC_DONE [00]
proc_27_target_68:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_27_end:


; ============================================================================
; Constants.
; ============================================================================

r_Constants:
.long 0x00000000				; [0] = 0.0
.long 0x00000f5c				; [1] = 0.05999755859375
.long 0x0000170a				; [2] = 0.089996337890625
.long 0x00004ccc				; [3] = 0.29998779296875
.long 0x00006666				; [4] = 0.399993896484375
.long 0x000070a3				; [5] = 0.4399871826171875
.long 0x00008000				; [6] = 0.5
.long 0x00010000				; [7] = 1.0
.long 0x00020000				; [8] = 2.0
.long 0x00030000				; [9] = 3.0
.long 0x00040000				; [10] = 4.0
.long 0x00050000				; [11] = 5.0
.long 0x00060000				; [12] = 6.0
.long 0x00070000				; [13] = 7.0
.long 0x00090000				; [14] = 9.0
.long 0x000a0000				; [15] = 10.0
.long 0x000b0000				; [16] = 11.0
.long 0x000c0000				; [17] = 12.0
.long 0x000e0000				; [18] = 14.0
.long 0x000f0000				; [19] = 15.0
.long 0x00110000				; [20] = 17.0
.long 0x00120000				; [21] = 18.0
.long 0x00130000				; [22] = 19.0
.long 0x00140000				; [23] = 20.0
.long 0x00160000				; [24] = 22.0
.long 0x00180000				; [25] = 24.0
.long 0x00190000				; [26] = 25.0
.long 0x001a0000				; [27] = 26.0
.long 0x001e0000				; [28] = 30.0
.long 0x00200000				; [29] = 32.0
.long 0x00230000				; [30] = 35.0
.long 0x00240000				; [31] = 36.0
.long 0x00250000				; [32] = 37.0
.long 0x00270000				; [33] = 39.0
.long 0x002a0000				; [34] = 42.0
.long 0x00310000				; [35] = 49.0
.long 0x00350000				; [36] = 53.0
.long 0x00390000				; [37] = 57.0
.long 0x003a0000				; [38] = 58.0
.long 0x003c0000				; [39] = 60.0
.long 0x00400000				; [40] = 64.0
.long 0x00460000				; [41] = 70.0
.long 0x00490000				; [42] = 73.0
.long 0x004b0000				; [43] = 75.0
.long 0x004c0000				; [44] = 76.0
.long 0x00500000				; [45] = 80.0
.long 0x00580000				; [46] = 88.0
.long 0x005a0000				; [47] = 90.0
.long 0x00600000				; [48] = 96.0
.long 0x00640000				; [49] = 100.0
.long 0x00690000				; [50] = 105.0
.long 0x006d0000				; [51] = 109.0
.long 0x006f0000				; [52] = 111.0
.long 0x00780000				; [53] = 120.0
.long 0x00800000				; [54] = 128.0
.long 0x00850000				; [55] = 133.0
.long 0x00860000				; [56] = 134.0
.long 0x00880000				; [57] = 136.0
.long 0x008c0000				; [58] = 140.0
.long 0x008f0000				; [59] = 143.0
.long 0x00910000				; [60] = 145.0
.long 0x00940000				; [61] = 148.0
.long 0x00960000				; [62] = 150.0
.long 0x00980000				; [63] = 152.0
.long 0x00990000				; [64] = 153.0
.long 0x00a00000				; [65] = 160.0
.long 0x00a30000				; [66] = 163.0
.long 0x00a90000				; [67] = 169.0
.long 0x00aa0000				; [68] = 170.0
.long 0x00af0000				; [69] = 175.0
.long 0x00b00000				; [70] = 176.0
.long 0x00b40000				; [71] = 180.0
.long 0x00be0000				; [72] = 190.0
.long 0x00c00000				; [73] = 192.0
.long 0x00c80000				; [74] = 200.0
.long 0x00cb0000				; [75] = 203.0
.long 0x00cd0000				; [76] = 205.0
.long 0x00ce0000				; [77] = 206.0
.long 0x00d20000				; [78] = 210.0
.long 0x00d40000				; [79] = 212.0
.long 0x00d90000				; [80] = 217.0
.long 0x00dd0000				; [81] = 221.0
.long 0x00de0000				; [82] = 222.0
.long 0x00df0000				; [83] = 223.0
.long 0x00e30000				; [84] = 227.0
.long 0x00e70000				; [85] = 231.0
.long 0x00ee0000				; [86] = 238.0
.long 0x00f00000				; [87] = 240.0
.long 0x00f10000				; [88] = 241.0
.long 0x00fa0000				; [89] = 250.0
.long 0x00fb0000				; [90] = 251.0
.long 0x010e0000				; [91] = 270.0
.long 0x01220000				; [92] = 290.0
.long 0x012c0000				; [93] = 300.0
.long 0x01620000				; [94] = 354.0
.long 0x01ae0000				; [95] = 430.0
.long 0x02a00000				; [96] = 672.0
.long 0x00540000				; [97] = 84.0
.long 0x00320000				; [98] = 50.0
.long 0x001c0000				; [99] = 28.0

; ============================================================================
; Color Script.
; ============================================================================

r_ColorScript:
.long -1, 0x00554444, 0x02ffffff, 0x01ff77dd			; delta_frames=1 [0]
.long -96, 0x01ff8866			; delta_frames=96 [96]
.long -96, 0x0155ee55			; delta_frames=96 [192]
.long -96, 0x0144ddff			; delta_frames=96 [288]
.long -84, 0x03bb4499			; delta_frames=84 [372]
.long -12, 0x01ff77dd			; delta_frames=12 [384]
.long -84, 0x03cc4444			; delta_frames=84 [468]
.long -12, 0x01ff8866			; delta_frames=12 [480]
.long -84, 0x03339933			; delta_frames=84 [564]
.long -12, 0x0155ee55			; delta_frames=12 [576]
.long -84, 0x030088bb			; delta_frames=84 [660]
.long -12, 0x0144ddff			; delta_frames=12 [672]
.long -96, 0x01ff77dd, 0x03bb4499			; delta_frames=96 [768]
.long -96, 0x01ff8866, 0x03cc4444			; delta_frames=96 [864]
.long -96, 0x0155ee55, 0x03339933			; delta_frames=96 [960]
.long -96, 0x0144ddff, 0x030088bb			; delta_frames=96 [1056]
.long -84, 0x00665533			; delta_frames=84 [1140]
.long -3, 0x00776622			; delta_frames=3 [1143]
.long -3, 0x00887711			; delta_frames=3 [1146]
.long -3, 0x00998800			; delta_frames=3 [1149]
.long -3, 0x01000000			; delta_frames=3 [1152]
.long -210, 0x000088bb			; delta_frames=210 [1362]
.long -150, 0x00222288			; delta_frames=150 [1512]
.long -200, 0x03882244			; delta_frames=200 [1712]
.long -35, 0x00882244			; delta_frames=35 [1747]
.long -50, 0x00554444			; delta_frames=50 [1797]
.long -28, 0x01ffffff			; delta_frames=28 [1825]
.long -6, 0x01ff77dd			; delta_frames=6 [1831]
.long -6, 0x01bb4499, 0x02ffffff			; delta_frames=6 [1837]
.long -6, 0x02ff8866			; delta_frames=6 [1843]
.long -6, 0x01554444, 0x02cc4444, 0x03ffffff			; delta_frames=6 [1849]
.long -6, 0x0355ee55			; delta_frames=6 [1855]
.long -6, 0x02554444, 0x03339933, 0x01ffffff			; delta_frames=6 [1861]
.long -6, 0x0144ddff			; delta_frames=6 [1867]
.long -6, 0x03554444, 0x010088bb			; delta_frames=6 [1873]
.long -12, 0x01554444			; delta_frames=12 [1885]
.long -12, 0x00443333, 0x01443333, 0x02443333, 0x03443333			; delta_frames=12 [1897]
.long -6, 0x00332222, 0x01332222, 0x02332222, 0x03332222			; delta_frames=6 [1903]
.long -6, 0x00221111, 0x01221111, 0x02221111, 0x03221111			; delta_frames=6 [1909]
.long -6, 0x00000000, 0x01000000, 0x02000000, 0x03000000			; delta_frames=6 [1915]
.long 0x80000000	; END_SCRIPT.
