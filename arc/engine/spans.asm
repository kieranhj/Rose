; ============================================================================
; Fast MODE 9 span plot routines.
; Code generated at runtime.
; Kindly provided by Progen (Sarah Walker).
; ============================================================================

.equ MAXSPAN, (MAXRADIUS+1)*2       ; otherwise Screen_Width

gen_code_pointers_p:
	.long gen_code_pointers_no_adr

; Registers used during span plotting.
; r0 = X centre [preserve]
; r1 = X end [computed]
; r2 = X start [computed]
; r3 = read word from screen
; r4 = X word offset [unused?]
; r5 = LAYER MASK
; r6 = temp
; r7 = ptr to next circle block [preserve]
; r8 = Y rasterline for outer loop [preserve]
; r9 = colour word [preserve]
; r10 = screen ptr [computed]
; r11 = screen rasterline addr [preserve]
; r14 = line counter [preserve]

; screen=abcdefgh
; colour=iiiiiiii

gen_first_word_1:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsl #4		; .......h
	.else
	AND r3, r3, #0xf
	.endif
	ORR r3, r3, r9, LSL #4		; iiiiiiih
	STR r3, [r10], #4
gen_first_word_2:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsl #8		; ......gh
	.else
	AND r3, r3, #0xff
	.endif
	ORR r3, r3, r9, LSL #8		; iiiiiigh
	STR r3, [r10], #4
gen_first_word_3:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsl #12		; .....fgh
	.else
	MOV r3, r3, LSL #20
	MOV r3, r3, LSR #20
	.endif
	ORR r3, r3, r9, LSL #12		; iiiiifgh
	STR r3, [r10], #4
gen_first_word_4:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsl #16		; ....efgh
	.else
	MOV r3, r3, LSL #16
	MOV r3, r3, LSR #16
	.endif
	ORR r3, r3, r9, LSL #16		; iiiiefgh
	STR r3, [r10], #4
gen_first_word_5:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsl #20		; ...defgh
	.else
	MOV r3, r3, LSL #12
	MOV r3, r3, LSR #12
	.endif
	ORR r3, r3, r9, LSL #20		; iiidefgh
	STR r3, [r10], #4
gen_first_word_6:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsl #24		; ..cdefgh
	.else
	BIC r3, r3, #0xff000000
	.endif
	ORR r3, r3, r9, LSL #24		; iicdefgh
	STR r3, [r10], #4
gen_first_word_7:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsl #28		; .bcdefgh
	.else
	BIC r3, r3, #0xf0000000
	.endif
	ORR r3, r3, r9, LSL #28		; ibcdefgh
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
	.if _DUAL_PLAYFIELD
	MOV r1, r5, LSR r1		; layer mask.
	.else
	MVN r3, #0
	MOV r1, r3, LSR r1
	.endif

	LDR r3, [r10]
	BIC r3, r3, r1
	AND r6, r9, r1
	ORR r3, r3, r6
	STR r3, [r10]

gen_same_word_1:
        AND r1, r1, #7
	MOV r1, r1, LSL #2
	RSB r1, r1, #28
	.if _DUAL_PLAYFIELD
	MOV r1, r5, LSR r1		; layer mask.
	.else
	MVN r3, #0
	MOV r1, r3, LSR r1
	.endif

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
	.if _DUAL_PLAYFIELD
	MOV r1, r5, LSR r1		; layer mask.
	.else
	MVN r3, #0
	MOV r1, r3, LSR r1
	.endif

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
	.if _DUAL_PLAYFIELD
	MOV r1, r5, LSR r1		; layer mask.
	.else
	MVN r3, #0
	MOV r1, r3, LSR r1
	.endif

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
	.if _DUAL_PLAYFIELD
	MOV r1, r5, LSR r1		; layer mask
	.else
	MVN r3, #0
	MOV r1, r3, LSR r1
	.endif

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
	.if _DUAL_PLAYFIELD
	MOV r1, r5, LSR r1		; layer mask
	.else
	MVN r3, #0
	MOV r1, r3, LSR r1
	.endif

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
	.if _DUAL_PLAYFIELD
	MOV r1, r5, LSR r1		; layer mask
	.else
	MVN r3, #0
	MOV r1, r3, LSR r1
	.endif

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
	.if _DUAL_PLAYFIELD
	MOV r1, r5, LSR R1		; layer mask
	.else
	MVN r3, #0
	MOV r1, r3, LSR r1
	.endif

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
	.if _DUAL_PLAYFIELD
	ldr r6, [r10]
	bic r6, r6, r5			; mask out old pixels for layer.
	orr r6, r6, r9			; mask in new pixels for layer.
	STR r6, [r10], #4
	.else
	STR r9, [r10], #4
	.endif
gen_main_loop_end:

; screen=abcdefgh
; colour=iiiiiiii

gen_last_word_0:
	MOV r0, r0
gen_last_word_1:
	LDRB r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsr #28		; .h
	.else
	BIC r3, r3, #0x0f
	.endif
	ORR r3, r3, r9, LSR #28		; ih
	STRB r3, [r10]
gen_last_word_2:
	.if _DUAL_PLAYFIELD
	LDRB r3, [r10]
	bic r3, r3, r5, lsr #24		; ..
	ORR r3, r3, r9, LSR #24		; ii
	STRB r3, [r10]
	.else
	STRB r9, [r10]
	.endif
gen_last_word_3:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsr #20		; abcde...
	.else
	MOV r3, r3, LSR #12
	MOV r3, r3, LSL #12
	.endif
	ORR r3, r3, r9, LSR #20		; abcdeiii
	STR r3, [r10]
gen_last_word_4:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsr #16		; abcd....
	.else
	MOV r3, r3, LSR #16
	MOV r3, r3, LSL #16
	.endif
	ORR r3, r3, r9, LSR #16		; abcdiiii
	STR r3, [r10]
gen_last_word_5:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsr #12		; abc.....
	.else
	MOV r3, r3, LSR #20
	MOV r3, r3, LSL #20
	.endif
	ORR r3, r3, r9, LSR #12		; abciiiii
	STR r3, [r10]
gen_last_word_6:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsr #8		; ab......
	.else
	AND r3, r3, #0xff000000
	.endif
	ORR r3, r3, r9, LSR #8		; abiiiiii
	STR r3, [r10]
gen_last_word_7:
	LDR r3, [r10]
	.if _DUAL_PLAYFIELD
	bic r3, r3, r5, lsr #4		; a.......
	.else
	AND r3, r3, #0xf0000000
	.endif
	ORR r3, r3, r9, LSR #4		; aiiiiiii
	STR r3, [r10]
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
	.long gen_code_pointers_no_adr
gen_code_start_p:
	.long gen_code_start_no_adr

gen_code:
	STR lr, [sp, #-4]!

	LDR r11, gen_code_pointers_p2
	LDR r12, gen_code_start_p
        MOV r0, #0 ;first pixel offset - 0-7
	MOV r1, #1 ;length - 1-320

gen_code_main_loop:
	CMP r0, #0
	BNE gen_code_dont_print

gen_code_dont_print:
	ADD r12, r12, #0xc ;Align to 16 byte boundary
	BIC r12, r12, #0xc
	STR r12, [r11], #4

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

	ADD r0, r0, #1
	ANDS r0, r0, #7
	BNE gen_code_main_loop
	ADD r1, r1, #1
	CMP r1, #MAXSPAN
	BNE gen_code_main_loop
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

; ============================================================================
