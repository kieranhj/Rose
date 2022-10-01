; ============================================================================
; sinus.asm - ARM port of Sinus.S
; ============================================================================

.equ MakeReciprocalTable, 1
.equ UseReciprocalTable, 1

; Makes sine values [0-0x4000]
MakeSinus:
    ; adrl r8, r_Sinus
    ldr r8, p_Sinus
    mov r10, #DEGREES/2*4       ; offset halfway through the table.
    sub r11, r10, #4            ; #DEGREES/2*4-4

    mov r0, #0
    str r0, [r8], #4
    add r9, r8, r11             ; #DEGREES/2*4-4
    str r0, [r9]

    mov r7, #1
.1:
    mov r1, r7
    mul r1, r7, r1          ; r7 ^2
    mov r1, r1, lsr #8

    mov r0, #2373
    mul r0, r1, r0
    mov r0, r0, lsr #16
    rsb r0, r0, #0
    add r0, r0, #21073
    mul r0, r1, r0
    mov r0, r0, lsr #16
    rsb r0, r0, #0
    add r0, r0, #51469
    mul r0, r7, r0
    mov r0, r0, lsr #13

    str r0, [r8], #4
    str r0, [r9, #-4]!
    rsb r0, r0, #0
    str r0, [r9, r10]              ; #DEGREES/2*4
    str r0, [r8, r11]              ; #DEGREES/2*4-4

    add r7, r7, #1
    cmp r7, #DEGREES/4
    blt .1

    rsb r0, r0, #0
    str r0, [r9, #-4]!
    rsb r0, r0, #0
    str r0, [r9, r10]
    mov pc, lr

; Divide R0 by R1
; Taken from Archimedes Operating System, page 28.
divide:
    CMP R1,#0                   ; Test for division by zero
    ADREQ R0,divbyzero          ; and flag an error
    SWIEQ OS_GenerateError      ; when necessary

    cmp r0, #0                  ; Test if result is zero
    moveq pc, lr

    ; Signed division - any better way to do this?
    eor r10, r0, r1             ; R0 eor R1 indicates sign of result
    cmp r0, #0
    rsbmi r0, r0, #0            ; make positive
    cmp r1, #0
    rsbmi r1, r1, #0            ; make positive  

    .if UseReciprocalTable
    ldr r12, [r6, #-16]         ; reciprocal_table
    bic r11, r1, #0xff0000      ; lowest 16-bits only.
    ldr r11, [r12, r11, lsl #2]
    mov r12, r0, asr #8
    mul r9, r12, r11            ; let's see!
    mov r9, r9, asr #16
    .else

    MOV R8, #1
    MOV R9, #0
    CMP R1, #0
    .1:                         ; raiseloop
    BMI .3
    CMP R1,R0
    BHI .2
    MOVS R1,R1,LSL #1
    MOV R8,R8,LSL #1
    B .1  
    .3:                         ; raisedone
    CMP R0,R1
    SUBCS R0,R0,R1
    ADDCS R9,R9,R8              ; Accumulate result
    .2:                         ; nearlydone
    MOV R1,R1,LSR #1
    MOVS R8,R8,LSR #1
    BCC .3

    .endif

    movs r10, r10               ; get sign back
    movpl r0, r9                ; Move positive result into R0*
    rsbmi r0, r9, #0            ; Neative result into R0*
    MOV PC,R14                  ; and return

    ; * Remove the lines marked with asterisks to
    ; return R0 MOD R1 instead of R0 DIV R1

    divbyzero: ;The error block
    .long 18
	.byte "Divide by Zero"
	.align 4
	.long 0

.if MakeReciprocalTable
MakeReciprocal:
    ldr r6, p_StateLists
    ldr r12, [r6, #-16]         ; reciprocal_table

    mov r2, #0
    str r2, [r12], #4
 
    mov r2, #1
.4:
    mov r0, #1<<24
    mov r1, r2

    MOV R8, #1
    MOV R9, #0
    CMP R1, #0
    .1:                         ; raiseloop
    BMI .3
    CMP R1,R0
    BHI .2
    MOVS R1,R1,LSL #1
    MOV R8,R8,LSL #1
    B .1  
    .3:                         ; raisedone
    CMP R0,R1
    SUBCS R0,R0,R1
    ADDCS R9,R9,R8              ; Accumulate result
    .2:                         ; nearlydone
    MOV R1,R1,LSR #1
    MOVS R8,R8,LSR #1
    BCC .3

    str r9, [r12], #4
    add r2, r2, #1
    cmp r2, #1<<16
    blt .4

    mov pc, lr
.endif
