; ============================================================================
; rose2arc.py
; input = arc/tree/bytecodes.bin.
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

; ============================================================================
; r3 = p_StateStack.
; r4 = r_Constants.
; r5 = p_State.
; r6 = r_StateSpace.
; r7 = r_Sinus.
; ============================================================================

proc_0_start:
	; BC_CONST [90]
	ldr r0, [r4, #16*4]			; r0=rConstants[16]
	; BC_CONST [8f]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #15*4]			; r0=rConstants[15]
	; BC_WSTATE [51]
	str r0, [r5, #ST_X*4]		; State[ST_X]=r0
	; BC_WSTATE [52]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_Y*4]		; State[ST_Y]=r0
	; BC_CONST [8d]
	ldr r0, [r4, #13*4]			; r0=rConstants[13]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_WSTATE [56]
	str r0, [r5, #ST_DIR*4]		; State[ST_DIR]=r0
	; BC_CONST [8a]
	ldr r0, [r4, #10*4]			; r0=rConstants[10]
	; BC_SEED [0c]
	; TODO: Implement BC_SEED as State[ST_RAND]=r0*0x9d3d+r0 etc.
	mov r0, r0, asr #16			; FIXED SEED
	str r0, [r5, #ST_RAND*4]	; State[ST_RAND]=r0
	; BC_CONST [85]
	ldr r0, [r4, #5*4]			; r0=rConstants[5]
	; BC_CONST [87]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #7*4]			; r0=rConstants[7]
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_0_end:

proc_1_start:
	; BC_CONST [80]
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_1_target_0
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [81]
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [81]
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_WAIT [0a]
	adr r1, proc_1_continue_1
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_1:
	; BC_RAND [03]
	; TODO: Set R0 from RNG using State[st_rand].
	ldr r0, [r5, #ST_RAND*4]	; FIXED RAND
	bic r0, r0, #0xff000000
	bic r0, r0, #0x00ff0000
	; BC_CONST [80]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #0*4]			; r0=rConstants[0]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1f]
	ble proc_1_target_2
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_RLOCAL [61]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_ELSE [01]
	b proc_1_target_3
proc_1_target_2:
	; BC_CONST [89]
	ldr r0, [r4, #9*4]			; r0=rConstants[9]
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	; TODO: Set R0 from RNG using State[st_rand].
	ldr r0, [r5, #ST_RAND*4]	; FIXED RAND
	bic r0, r0, #0xff000000
	bic r0, r0, #0x00ff0000
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, lsr #8
	mov r1, r1, lsr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_CONST [86]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #6*4]			; r0=rConstants[6]
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
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
	; BC_CONST [81]
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_CONST [83]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #3*4]			; r0=rConstants[3]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, lsr #8
	mov r1, r1, lsr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_NEG [0d]
	rsb r0, r0, #0				; r0=0-r0
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, lsr #8
	mov r1, r1, lsr #8
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
	; BC_RAND [03]
	; TODO: Set R0 from RNG using State[st_rand].
	ldr r0, [r5, #ST_RAND*4]	; FIXED RAND
	bic r0, r0, #0xff000000
	bic r0, r0, #0x00ff0000
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_OP [39]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	sub r0, r0, r1				; r0=r0 sub r1
	; BC_CONST [83]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #3*4]			; r0=rConstants[3]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, lsr #8
	mov r1, r1, lsr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_PROC [07]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	adr r0, proc_1_start		; r0=r_Procedures[1]
	; BC_FORK [22]
	mov r1, #2
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl ForkState				; r0=proc address, r1=num_args
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_DONE [00]
proc_1_target_3:
	; BC_RAND [03]
	; TODO: Set R0 from RNG using State[st_rand].
	ldr r0, [r5, #ST_RAND*4]	; FIXED RAND
	bic r0, r0, #0xff000000
	bic r0, r0, #0x00ff0000
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	movs r0, r0					; update Status flags
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_CONST [88]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #8*4]			; r0=rConstants[8]
	; BC_RLOCAL [63]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-4*4]			; r0=StateStack[-4]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, lsr #8
	mov r1, r1, lsr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, lsr #8
	mov r1, r1, lsr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_1_target_4
	; BC_CONST [8c]
	ldr r0, [r4, #12*4]			; r0=rConstants[12]
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
	; BC_MOVE [0e]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl DoMove
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_CONST [83]
	ldr r0, [r4, #3*4]			; r0=rConstants[3]
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_DONE [00]
proc_1_target_4:
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_POP [08]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	; BC_ELSE [01]
	b proc_1_target_5
proc_1_target_0:
	; BC_RSTATE [72]
	ldr r0, [r5, #ST_Y*4]		; r0=State[ST_Y]
	movs r0, r0					; update Status flags
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	movs r0, r0					; update Status flags
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, lsr #8
	mov r1, r1, lsr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_SEED [0c]
	; TODO: Implement BC_SEED as State[ST_RAND]=r0*0x9d3d+r0 etc.
	mov r0, r0, asr #16			; FIXED SEED
	str r0, [r5, #ST_RAND*4]	; State[ST_RAND]=r0
	; BC_CONST [8b]
	ldr r0, [r4, #11*4]			; r0=rConstants[11]
	; BC_RAND [03]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	; TODO: Set R0 from RNG using State[st_rand].
	ldr r0, [r5, #ST_RAND*4]	; FIXED RAND
	bic r0, r0, #0xff000000
	bic r0, r0, #0x00ff0000
	; BC_MUL [0f]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	mov r0, r0, lsr #8
	mov r1, r1, lsr #8
	mul r0, r1, r0				; r0=r0*r1
	; BC_WAIT [0a]
	adr r1, proc_1_continue_6
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_1_continue_6:
	; BC_PROC [07]
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_CONST [8e]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #14*4]			; r0=rConstants[14]
	; BC_RSTATE [71]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #ST_X*4]		; r0=State[ST_X]
	movs r0, r0					; update Status flags
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_1_target_7
	; BC_CONST [83]
	ldr r0, [r4, #3*4]			; r0=rConstants[3]
	; BC_ELSE [01]
	b proc_1_target_8
proc_1_target_7:
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_DONE [00]
proc_1_target_8:
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
proc_1_target_5:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_1_end:

proc_2_start:
	; BC_CONST [82]
	ldr r0, [r4, #2*4]			; r0=rConstants[2]
	; BC_WAIT [0a]
	adr r1, proc_2_continue_9
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl WaitState				; Add r5 to StateList, r0=wait_frames, r1=&continue.
	ldr pc, [sp], #4			; Return
proc_2_continue_9:
	; BC_RLOCAL [60]
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_WSTATE [53]
	str r0, [r5, #ST_SIZE*4]		; State[ST_SIZE]=r0
	; BC_RLOCAL [61]
	ldr r0, [r5, #-2*4]			; r0=StateStack[-2]
	movs r0, r0					; update Status flags
	; BC_WSTATE [54]
	str r0, [r5, #ST_TINT*4]		; State[ST_TINT]=r0
	; BC_DRAW [04]
	add r6, r5, #4
	ldmia r6, {r8-r11}			; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl PutCircle
	ldr lr, [sp], #4			; Pop lr off program stack.
	; BC_CONST [84]
	ldr r0, [r4, #4*4]			; r0=rConstants[4]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_OP [3b]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	cmp r0, r1					; r0 cmp r1
	; BC_WHEN [1c]
	bge proc_2_target_10
	; BC_PROC [07]
	adr r0, proc_2_start		; r0=r_Procedures[2]
	; BC_CONST [81]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r4, #1*4]			; r0=rConstants[1]
	; BC_RLOCAL [60]
	str r0, [r3, #-4]!			; Push r0 on StateStack.
	ldr r0, [r5, #-1*4]			; r0=StateStack[-1]
	movs r0, r0					; update Status flags
	; BC_OP [3d]
	ldr r1, [r3], #4			; Pop r1 off StateStack.
	add r0, r0, r1				; r0=r0 add r1
	; BC_WLOCAL [40]
	str r0, [r5, #-1*4]			; StateStack[-1]=r0
	; BC_WSTATE [50]
	ldr r0, [r3], #4			; Pop r0 off StateStack.
	str r0, [r5, #ST_PROC*4]		; State[ST_PROC]=r0
	; BC_TAIL [05]
	ldr r1, [r5, #ST_PROC*4]	; Jump to State.st_proc
	mov pc, r1
	; BC_DONE [00]
proc_2_target_10:
	; BC_END [02]
	str lr, [sp, #-4]!			; Push lr on program stack.
	bl FreeState				; Add r5 to r_FreeState list.
	ldr pc, [sp], #4			; Return.
proc_2_end:


; ============================================================================
; Constants.
; ============================================================================

r_Constants:
.long 0x00000000				; [0] = 0.0
.long 0x00010000				; [1] = 1.0
.long 0x00020000				; [2] = 2.0
.long 0x00030000				; [3] = 3.0
.long 0x00050000				; [4] = 5.0
.long 0x00080000				; [5] = 8.0
.long 0x000a0000				; [6] = 10.0
.long 0x001e0000				; [7] = 30.0
.long 0x00200000				; [8] = 32.0
.long 0x00280000				; [9] = 40.0
.long 0x002a0000				; [10] = 42.0
.long 0x00320000				; [11] = 50.0
.long 0x003c0000				; [12] = 60.0
.long 0x00400000				; [13] = 64.0
.long 0x00640000				; [14] = 100.0
.long 0x00b00000				; [15] = 176.0
.long 0x00fa0000				; [16] = 250.0
