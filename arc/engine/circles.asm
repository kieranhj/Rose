; ============================================================================
; Fast MODE 9 circle renderer.
; Kindly provided by Progen (Sarah Walker).
; ============================================================================

.if _DUAL_PLAYFIELD
.equ CIRCLEDATA, 6				; centre_x, colour word, ptr to size table, line count
.else
.equ CIRCLEDATA, 5				; centre_x, colour word, ptr to size table, line count
.endif

circle_lookup_p:
	.long circle_lookup

r_FreeCircle:
	.long r_circleBufEnd_no_adr

p_CircleBufPtrs:
	.long r_CircleBufPtrs_no_adr

p_CircleBufEnd:
	.long r_circleBufEnd_no_adr

; ============================================================================

;r0 = X centre
;r1 = Y centre
;r2 = radius of circle
;r3-r7 = preserve
;r9 = tint
;r10 = plot instruction
link_circle:
	cmp r2, #0
	movmi pc, lr			; in case Rose sends a bad radius!

    .if _DEBUG
    cmp r2, #MAXRADIUS
    adrgt r0, circletoolarge
    swigt OS_GenerateError
    .endif

	STR lr, [sp, #-4]!

	LDR r12, circle_lookup_p
    LDR r12, [r12, r2, LSL #2] ;r12 = circle data

	SUB r1, r1, r2
	SUB r1, r1, #1 ;Starting line
	MOV r14, r2, LSL #1
	ADD r14, r14, #1 ;Line count

	CMP r1, #Screen_Height ;Off bottom of screen?
	BCC clip_isnt_off_top
	TST r1, r1
	LDRPL pc, [sp], #4

clip_isnt_off_top:
	CMP r1, #0 ;Off top of screen?
	BPL clip_circle_nottop
	SUB r12, r12, r1
	ADDS r14, r14, r1
	LDREQ pc, [sp], #4
	LDRMI pc, [sp], #4
	MOV r1, #0

clip_circle_nottop:
	ADD r2, r1, r14
	CMP r2, #Screen_Height
	BCC clip_circle_notbottom
	SUB r2, r2, #Screen_Height
	SUB r14, r14, r2

clip_circle_notbottom:
	.if _DUAL_PLAYFIELD
	and r9, r9, #0x07					; limit to 8 (2x4) colours for DPF.

	; Compute layer.
	mov r2, r9, lsr #2					; layer = tint >> 2 (0 or 1)

	; Compute layer mask.
	ldr r11, layer_0_mask
	mov r11, r11, lsl r2
	mov r11, r11, lsl r2				; shift mask to correct layer.

	; Hoffman says tint 0 erases both layers, but I don't think this is true!
	; cmp r9, #0
	; moveq r11, #0xffffffff			; except tint 0 affects both layers.
	
	; Compute pixel bits for layer.
	and r9, r9, #3					; pixel = tint & 3
	mov r9, r9, lsl r2 
	mov r9, r9, lsl r2 				; shift pixel bits to correct layer.
	.endif

	; Dupe pixel bits to colour word.
	ORR r9, r9, r9, LSL #4
	ORR r9, r9, r9, LSL #8
	ORR r9, r9, r9, LSL #16

	; Circle data to save:
	;  r0 = X centre
	;  r1 = Y start (not saved - used to index Circle Buffer)
	;  r8 = ptr to next circle (pushed separately).
	;  r9 = colour (expanded)
	;  r10 = plot instruction (circle or square)
	;  r11 = layer mask (DPF only)
	;  r12 = ptr to circle size table (clipped to top)
	;  r14 = line count (clipped)

	ldr r2, p_CircleBufPtrs
	add r1, r2, r1, lsl #2				; p_CircleBufPtrs[Y]

	ldr r2, [r1]						; get ptr to first circle for Y
	ldr r8, r_FreeCircle				; get next free circle in buffer

	.if _DEBUG
	cmp r8, #0
    adreq r0, outofcircles
    swieq OS_GenerateError
	.endif

	.if _DUAL_PLAYFIELD
	stmfd r8!, {r0, r9, r10, r11, r12, r14}	; push all vars needed to plot this circle.
	.else
	stmfd r8!, {r0, r9, r10, r12, r14}		; push all vars needed to plot this circle.
	.endif
	str r2, [r8, #-4]!					; push ptr to next circle for Y
	str r8, [r1]						; this becomes first circle for Y
	str r8, r_FreeCircle

    .if _DEBUG
    ldr r1, r_NumCircles
    ldr r2, r_MaxCircles
    add r1, r1, #1
    str r1, r_NumCircles
    cmp r1, r2
    strgt r1, r_MaxCircles
    .endif

	ldr pc, [sp], #4

.if _DUAL_PLAYFIELD
layer_0_mask:
	.long 0x33333333
.endif

.if _DEBUG
circletoolarge: ;The error block
    .long 18
	.byte "Radius too large!"
	.align 4
	.long 0

outofcircles:
    .long 18
	.byte "Out of circles!"
	.align 4
	.long 0

spantoolong:
    .long 18
	.byte "Span too long!"
	.align 4
	.long 0
.endif


plot_all_circles:
	STR lr, [sp, #-4]!

	; An array of circles:
	;  4x4 bytes for data plus 1x4 bytes for ptr to next circle.
	; Next free circle just next one in the array.

	; An array of ptrs, one per Y.
	;  Plot all circles in Y order.
	mov r8, #0							; Y
	ldr r7, p_CircleBufPtrs

plot_Y_loop:
	ldr r7, [r7, r8, lsl #2]			; ptr to first circle for this Y.

circles_per_Y_loop:
	cmp r7, #0
	beq no_circles_on_this_Y

	; Circle data to load:
	;  r0 = X centre
	;  r8 = ptr to next circle (pushed separately).
	;  r9 = colour (expanded)
	;  r10 = plot instruction (circle or square)
	;  r11 = layer mask (DPF only)
	;  r12 = ptr to circle size table (clipped to top)
	;  r14 = line count (clipped)

	ldr r4, [r7], #4						; ptr to next circle.
	.if _DUAL_PLAYFIELD
	ldmia r7!, {r0, r9, r10, r11, r12, r14}	; pop all vars needed to plot this circle.
	mov r5, r11
	.else
	ldmia r7!, {r0, r9, r10, r12, r14}		; pop all vars needed to plot this circle.
	.endif
	str r10, circle_loop					; self-mod plot command!
	mov r7, r4

	LDR r11, screen_addr
	ADD r11, r11, r8, LSL #7
	ADD r11, r11, r8, LSL #5 ;r11 = screen addr
	.if Screen_Width == 352
	ADD r11, r11, r8, LSL #4 ;r11 = screen addr
	.else
	.if Screen_Width != 320
	.err Screen_Width calculation not accounted for!
	.endif
	.endif

circle_loop:
	LDRB r1, [r12], #1 ;neg offset from X
	SUB r2, r0, r1 ;r2 = start X
	ADD r1, r0, r1 ;r1 = end X

	TST r2, r2 ;Clip on left?
	MOVMI r2, #0
	CMP r2, #Screen_Width ;Off left?
	BCS circle_skip_line
	CMP r1, #0 ;Off right?
	BMI circle_skip_line
	CMP r1, #Screen_Width ;Clip on right?
	MOVCS r1, #Screen_Width
	SUBCS r1, r1, #1

	MOV r3, r2, LSR #3
	ADD r10, r11, r3, LSL #2 ;Start word

	SUB r3, r1, r2 ;length

	.if _DEBUG
	cmp r3, #MAXSPAN
    adrgt r0, spantoolong
    swigt OS_GenerateError
	.endif

	;MOV r3, #1
	AND r4, r2, #7 ;start offset
	LDR r6, gen_code_pointers_p
	ADD r4, r4, r3, LSL #3
	LDR pc, [r6, r4, LSL #2]

circle_skip_line:
	ADD r11, r11, #Screen_Stride
	SUBS r14, r14, #1
	BNE circle_loop

circle_end:
	b circles_per_Y_loop

no_circles_on_this_Y:
	ldr r7, p_CircleBufPtrs
	mov r0, #0
	str r0, [r7, r8, lsl #2]			; clear CircleBufPtr for this Y.

	add r8, r8, #1
	cmp r8, #Screen_Height
	blt plot_Y_loop

	LDR pc, [sp], #4

; ============================================================================
