; ============================================================================
; Fast MODE 9 circle renderer.
; Kindly provided by Progen (Sarah Walker).
; ============================================================================

.equ MAX_CIRCLES, 200           ; Max circles drawn in a frame (!)
.equ CIRCLEDATA, 5				; centre_x, colour word, ptr to size table, line count

circle_lookup_p:
	.long circle_lookup

gen_code_pointers_p:
	.long gen_code_pointers

r_FreeCircle:
	.long r_circleBufEnd

p_CircleBufPtrs:
	.long r_CircleBufPtrs

;r0 = X centre
;r1 = Y centre
;r2 = radius of circle
;r4 = plot instruction
;r11 = colour
link_circle:
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
	ADD r3, r1, r14
	CMP r3, #Screen_Height
	BCC clip_circle_notbottom
	SUB r3, r3, #Screen_Height
	SUB r14, r14, r3

clip_circle_notbottom:
	; Dupe tint to colour word.
	ORR r9, r11, r11, LSL #4
	ORR r9, r9, r9, LSL #8
	ORR r9, r9, r9, LSL #16

	; r1 = Y start

	; Circle data to save:
	;  r14 = line count (clipped)
	;  r12 = ptr to circle size table (clipped) OR square size const!
	;  r9 = colour (expanded)
	;  r4 = plot instruction (circle or square)
	;  r0 = X centre
	;  r8 = ptr to next circle.

	ldr r7, p_CircleBufPtrs
	ldr r10, [r7, r1, lsl #2]			; get ptr to first circle for Y
	ldr r8, r_FreeCircle				; get next free circle in buffer
	stmfd r8!, {r0, r4, r9, r12, r14}		; push all vars needed to plot this circle.
	str r10, [r8, #-4]!					; push ptr to next circle for Y
	str r8, [r7, r1, lsl #2]			; this becomes first circle for Y
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
	; r14 = line count (clipped)
	; r12 = ptr to circle size table (clipped) OR square size const!
	; r9 = colour (expanded)
	; r0 = X centre
	; r8 = Y start

	ldr r10, [r7], #4					; ptr to next circle.
	ldmia r7!, {r0, r4, r9, r12, r14}		; pop all vars needed to plot this circle.
	str r4, circle_loop					; self-mod plot command!
	mov r7, r10

	LDR r11, screen_addr
	ADD r11, r11, r8, LSL #7
	ADD r11, r11, r8, LSL #5 ;r11 = screen addr

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
	;MOV r3, #1
	AND r4, r2, #7 ;start offset
	LDR r5, gen_code_pointers_p
	ADD r4, r4, r3, LSL #3
	LDR pc, [r5, r4, LSL #2]

circle_skip_line:
	ADD r11, r11, #Screen_Stride
	SUBS r14, r14, #1
	BNE circle_loop

circle_end:
	b circles_per_Y_loop

no_circles_on_this_Y:
	ldr r7, p_CircleBufPtrs
	mov r0, #0
	str r0, [r7, r8, lsl #2]			; cclear CircleBufPtr for this Y.

	add r8, r8, #1
	cmp r8, #Screen_Height
	blt plot_Y_loop

	LDR pc, [sp], #4


.if 0
;r0 = X centre
;r1 = Y centre
;r2 = radius of circle
;r11 = colour
;screen_addr = address of screen buffer
plot_circle:
	STR lr, [sp, #-4]!

	;MOV r0, #204
	;MOV r1, #2
	;MOV r2, #40

	ORR r9, r11, r11, LSL #4
	ORR r9, r9, r9, LSL #8
	ORR r9, r9, r9, LSL #16

	LDR r12, circle_lookup_p
;	ADRL r12, circle_lookup
        LDR r12, [r12, r2, LSL #2] ;r12 = circle data

	SUB r1, r1, r2
	SUB r1, r1, #1 ;Starting line
	MOV r14, r2, LSL #1
	ADD r14, r14, #1 ;Line count

	CMP r1, #Screen_Height ;Off bottom of screen?
	BCC isnt_off_top
	TST r1, r1
	LDRPL pc, [sp], #4

isnt_off_top:
	CMP r1, #0 ;Off top of screen?
	BPL plot_circle_nottop
	SUB r12, r12, r1
	ADDS r14, r14, r1
	LDREQ pc, [sp], #4
	LDRMI pc, [sp], #4
	MOV r1, #0
;	CMP r14, #0

plot_circle_nottop:
	ADD r3, r1, r14
	CMP r3, #Screen_Height
	BCC plot_circle_notbottom
	SUB r3, r3, #Screen_Height
	SUB r14, r14, r3

plot_circle_notbottom:
	LDR r11, screen_addr
	ADD r11, r11, r1, LSL #7
	ADD r11, r11, r1, LSL #5 ;r11 = screen addr

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
	;MOV r3, #1
	AND r4, r2, #7 ;start offset
	LDR r5, gen_code_pointers_p
	ADD r4, r4, r3, LSL #3
	LDR pc, [r5, r4, LSL #2]

circle_skip_line:
	ADD r11, r11, #Screen_Stride
	SUBS r14, r14, #1
	BNE circle_loop

circle_end:
	LDR pc, [sp], #4
.endif





gen_first_word_1:
	LDR r3, [r10]
	AND r3, r3, #0xf
	ORR r3, r3, r9, LSL #4
	STR r3, [r10], #4
gen_first_word_2:
	LDR r3, [r10]
	AND r3, r3, #0xff
	ORR r3, r3, r9, LSL #8
	STR r3, [r10], #4
gen_first_word_3:
	LDR r3, [r10]
	MOV r3, r3, LSL #20
	MOV r3, r3, LSR #20
	ORR r3, r3, r9, LSL #12
	STR r3, [r10], #4
gen_first_word_4:
	LDR r3, [r10]
	MOV r3, r3, LSL #16
	MOV r3, r3, LSR #16
	ORR r3, r3, r9, LSL #16
	STR r3, [r10], #4
gen_first_word_5:
	LDR r3, [r10]
	MOV r3, r3, LSL #12
	MOV r3, r3, LSR #12
	ORR r3, r3, r9, LSL #20
	STR r3, [r10], #4
gen_first_word_6:
	LDR r3, [r10]
	BIC r3, r3, #0xff000000
	ORR r3, r3, r9, LSL #24
	STR r3, [r10], #4
gen_first_word_7:
	LDR r3, [r10]
	BIC r3, r3, #0xf0000000
	ORR r3, r3, r9, LSL #28
	STR r3, [r10], #4
gen_first_word_over:

gen_first_word_table:
	.long 0
	.long gen_first_word_1
	.long gen_first_word_2
	.long gen_first_word_3
	.long gen_first_word_4
	.long gen_first_word_5
	.long gen_first_word_6
	.long gen_first_word_7
	.long gen_first_word_over

gen_same_word_0:
        AND r1, r1, #7
	MOV r1, r1, LSL #2
	RSB r1, r1, #28
	MVN r3, #0
	MOV r1, r3, LSR r1

	LDR r3, [r10]
	BIC r3, r3, r1
	AND r6, r9, r1
	ORR r3, r3, r6
	STR r3, [r10]

gen_same_word_1:
        AND r1, r1, #7
	MOV r1, r1, LSL #2
	RSB r1, r1, #28
	MVN r3, #0
	MOV r1, r3, LSR r1

	LDR r3, [r10]
	BIC r1, r1, #0xf
	BIC r3, r3, r1
	AND r6, r9, r1
	ORR r3, r3, r6
	STR r3, [r10]

gen_same_word_2:
        AND r1, r1, #7
	MOV r1, r1, LSL #2
	RSB r1, r1, #28
	MVN r3, #0
	MOV r1, r3, LSR r1

	LDR r3, [r10]
	BIC r1, r1, #0xff
	BIC r3, r3, r1
	AND r6, r9, r1
	ORR r3, r3, r6
	STR r3, [r10]

gen_same_word_3:
        AND r1, r1, #7
	MOV r1, r1, LSL #2
	RSB r1, r1, #28
	MVN r3, #0
	MOV r1, r3, LSR r1

	LDR r3, [r10]
	MOV r1, r1, LSR #12
	BIC r3, r3, r1, LSL #12
	AND r6, r9, r1, LSL #12
	ORR r3, r3, r6
	STR r3, [r10]

gen_same_word_4:
        AND r1, r1, #7
	MOV r1, r1, LSL #2
	RSB r1, r1, #28
	MVN r3, #0
	MOV r1, r3, LSR r1

	LDR r3, [r10]
	MOV r1, r1, LSR #16
	BIC r3, r3, r1, LSL #16
	AND r6, r9, r1, LSL #16
	ORR r3, r3, r6
	STR r3, [r10]

gen_same_word_5:
        AND r1, r1, #7
	MOV r1, r1, LSL #2
	RSB r1, r1, #28
	MVN r3, #0
	MOV r1, r3, LSR r1

	LDR r3, [r10]
	MOV r1, r1, LSR #20
	BIC r3, r3, r1, LSL #20
	AND r6, r9, r1, LSL #20
	ORR r3, r3, r6
	STR r3, [r10]

gen_same_word_6:
        AND r1, r1, #7
	MOV r1, r1, LSL #2
	RSB r1, r1, #28
	MVN r3, #0
	MOV r1, r3, LSR r1

	LDR r3, [r10]
	MOV r1, r1, LSR #24
	BIC r3, r3, r1, LSL #24
	AND r6, r9, r1, LSL #24
	ORR r3, r3, r6
	STR r3, [r10]

gen_same_word_7:
        AND r1, r1, #7
	MOV r1, r1, LSL #2
	RSB r1, r1, #28
	MVN r3, #0
	MOV r1, r3, LSR r1

	LDR r3, [r10]
	MOV r1, r1, LSR #28
	BIC r3, r3, r1, LSL #28
	AND r6, r9, r1, LSL #28
	ORR r3, r3, r6
	STR r3, [r10]
gen_same_word_over:

gen_same_word_table:
	.long gen_same_word_0
	.long gen_same_word_1
	.long gen_same_word_2
	.long gen_same_word_3
	.long gen_same_word_4
	.long gen_same_word_5
	.long gen_same_word_6
	.long gen_same_word_7
	.long gen_same_word_over

gen_main_loop:
	STR r9, [r10], #4
gen_main_loop_end:

gen_last_word_0:
	MOV r0, r0
gen_last_word_1:
	LDRB r5, [r10]
	BIC r5, r5, #0x0f
	ORR r5, r5, r9, LSR #28
	STRB r5, [r10]
gen_last_word_2:
	STRB r9, [r10]
gen_last_word_3:
	LDR r5, [r10]
	MOV r5, r5, LSR #12
	MOV r5, r5, LSL #12
	ORR r5, r5, r9, LSR #20
	STR r5, [r10]
gen_last_word_4:
	LDR r5, [r10]
	MOV r5, r5, LSR #16
	MOV r5, r5, LSL #16
	ORR r5, r5, r9, LSR #16
	STR r5, [r10]
gen_last_word_5:
	LDR r5, [r10]
	MOV r5, r5, LSR #20
	MOV r5, r5, LSL #20
	ORR r5, r5, r9, LSR #12
	STR r5, [r10]
gen_last_word_6:
	LDR r5, [r10]
	AND r5, r5, #0xff000000
	ORR r5, r5, r9, LSR #8
	STR r5, [r10]
gen_last_word_7:
	LDR r5, [r10]
	AND r5, r5, #0xf0000000
	ORR r5, r5, r9, LSR #4
	STR r5, [r10]
gen_last_word_over:

gen_last_word_table:
	.long gen_last_word_0
	.long gen_last_word_1
	.long gen_last_word_2
	.long gen_last_word_3
	.long gen_last_word_4
	.long gen_last_word_5
	.long gen_last_word_6
	.long gen_last_word_7
	.long gen_last_word_over

gen_end_code:
	ADD r11, r11, #Screen_Stride
	SUBS r14, r14, #1
gen_end_code_end:
	BNE circle_loop
	.long circle_loop
	B circle_end
	.long circle_end

gen_code_pointers_p2:
	.long gen_code_pointers
gen_code_start_p:
	.long gen_code_start

gen_code:
	STR lr, [sp, #-4]!

	LDR r11, gen_code_pointers_p2
	LDR r12, gen_code_start_p
        MOV r0, #0 ;first pixel offset - 0-7
	MOV r1, #1 ;length - 1-320

gen_code_main_loop:
	CMP r0, #0
	BNE gen_code_dont_print

;	STMDB sp!, {r0-r12, r14}
;	MOV r0, r1
;	ADRL r1, str_buf
;	MOV r2, #12
;	SWI OS_ConvertHex8
; 	SWI OS_WriteO
;	MOV r0, #32
;	SWI OS_WriteC
;	LDMIA sp!, {r0-r12, r14}
;	STMDB sp!, {r0-r12, r14}
;	MOV r0, r12
;	ADRL r1, str_buf
;	MOV r2, #12
;	SWI OS_ConvertHex8
;	SWI OS_WriteO
;	SWI OS_NewLine
;	LDMIA sp!, {r0-r12, r14}

gen_code_dont_print:
	ADD r12, r12, #0xc ;Align to 16 byte boundary
	BIC r12, r12, #0xc
	STR r12, [r11], #4

;	STMDB sp!, {r0-r12}
;	MOV r0, #30
;	SWI OS_WriteC
;	LDR r0, [sp]
;	ADRL r1, str_buf
;	MOV r2, #12
;	SWI OS_ConvertHex8
;	SWI OS_WriteO
;	SWI OS_NewLine
;	LDR r0, [sp, #4]
;	ADRL r1, str_buf
;	MOV r2, #12
;	SWI OS_ConvertHex8
;	SWI OS_WriteO
;	SWI OS_NewLine
;	LDR r0, [sp, #48]
;	ADRL r1, str_buf
;	MOV r2, #12
;	SWI OS_ConvertHex8
;	SWI OS_WriteO
;	SWI OS_NewLine
;	LDMIA sp!, {r0-r12}

	MOV r5, #0     ;current pixel

	ADD r2, r0, r1
	CMP r2, #8     ;Start and end lie in same word?
	BCC gen_code_same_word

	TST r0, #7
	BEQ gen_code_no_offset

	;Copy code to generate first word
	ADRL r2, gen_first_word_table
	ADD r2, r2, r0, LSL #2
	LDMIA r2, {r2-r3} ;r2-r3 - start and end addresses of code
gen_code_first_word_copy:
	LDR r4, [r2], #4
	STR r4, [r12], #4
	CMP r2, r3
	BNE gen_code_first_word_copy

	RSB r5, r0, #8

gen_code_no_offset:
;	STMDB sp!, {r0-r12}
;	LDR r0, [sp, #20]
;	ADRL r1, str_buf
;	MOV r2, #12
;	SWI OS_ConvertHex8
;	SWI OS_WriteO
;	SWI OS_NewLine
;	LDMIA sp!, {r0-r12}

;gen_code_no_offset_double_loop:
;	SUB r2, r1, r5  ;If less than 16 pixels remaining then jump to last word
;	CMP r2, #16
;	BCC gen_code_no_offset_loop
;
;	ADRL r2, gen_main_loop2
;	ADRL r3, gen_main_loop2_end
;gen_code_main_loop2_copy:
;	LDR r4, [r2], #4
;	STR r4, [r12], #4
;	CMP r2, r3
;	BNE gen_code_main_loop2_copy
;
;	ADD r5, r5, #16
;	B gen_code_no_offset_double_loop

gen_code_no_offset_loop:
	SUB r2, r1, r5  ;If less than 8 pixels remaining then jump to last word
	CMP r2, #8
	BCC gen_code_last_word

	ADRL r2, gen_main_loop
	ADRL r3, gen_main_loop_end
gen_code_main_loop_copy:
	LDR r4, [r2], #4
	STR r4, [r12], #4
	CMP r2, r3
	BNE gen_code_main_loop_copy

	ADD r5, r5, #8
	B gen_code_no_offset_loop

gen_code_last_word:
;	STMDB sp!, {r0-r12}
;	LDR r0, [sp, #8]
;	ADRL r1, str_buf
;	MOV r2, #12
;	SWI OS_ConvertHex8
;	SWI OS_WriteO
;	SWI OS_NewLine
;	LDMIA sp!, {r0-r12}

	TST r2, r2
	BEQ gen_code_complete

	;Copy code to generate last word
	ADR r3, gen_last_word_table
	ADD r2, r3, r2, LSL #2
	LDMIA r2, {r2-r3} ;r2-r3 - start and end addresses of code
gen_code_last_word_copy:
	LDR r4, [r2], #4
	STR r4, [r12], #4
	CMP r2, r3
	BNE gen_code_last_word_copy

gen_code_complete:
	;End of code
	ADRL r2, gen_end_code
	ADRL r3, gen_end_code_end
gen_code_end_copy:
	LDR r4, [r2], #4
	STR r4, [r12], #4
	CMP r2, r3
	BNE gen_code_end_copy

	LDMIA r2!, {r3-r4}
	AND r3, r3, #0xff000000
	SUB r4, r4, r12
	SUB r4, r4, #8
	MOV r4, r4, LSL #6
	ORR r3, r3, r4, LSR #8
	STR r3, [r12], #4

	LDMIA r2!, {r3-r4}
	AND r3, r3, #0xff000000
	SUB r4, r4, r12
	SUB r4, r4, #8
	MOV r4, r4, LSL #6
	ORR r3, r3, r4, LSR #8
	STR r3, [r12], #4



;	LDMIA r2, {r2-r3}
;	STMIA r12!, {r2-r3}

	ADD r0, r0, #1
	ANDS r0, r0, #7
	BNE gen_code_main_loop
	ADD r1, r1, #1
	CMP r1, #Screen_Width
	BNE gen_code_main_loop

;gen_code_ended:
;	B gen_code_ended
;	MOV pc, lr
	LDR pc, [sp], #4


gen_code_same_word:
	;Copy code to generate same word
	ADRL r2, gen_same_word_table
	ADD r2, r2, r0, LSL #2
	LDMIA r2, {r2-r3} ;r2-r3 - start and end addresses of code
gen_code_same_word_copy:
	LDR r4, [r2], #4
	STR r4, [r12], #4
	CMP r2, r3
	BNE gen_code_same_word_copy

	B gen_code_complete


.INCLUDE "circledat.asm"
