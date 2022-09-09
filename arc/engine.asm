; ============================================================================
; engine.asm - ARM port of Engine.S
; ============================================================================

.equ MAX_FRAMES, 10000	        ; Length of Rose animation
.equ MAX_CIRCLES, 200           ; Max circles drawn in a frame (!)
.equ MAX_TURTLES, 500           ; Max turtles alive at the same time (!)
.equ MAX_STACK, 20              ; Max depth of execution stack
.equ MAX_WAIT, 1000             ; Max wait beyond end of program
.equ WIRE_CAPACITY, 8           ; Number of wire slots <== IF THIS CHANGES CHECK StateFork!!
.equ MAXRADIUS, 70              ;
.equ DEGREES, 16384

; ============================================================================
.equ ST_PROC, 0
.equ ST_X, 1
.equ ST_Y, 2
.equ ST_SIZE, 3
.equ ST_TINT, 4
.equ ST_RAND, 5
.equ ST_DIR, 6
.equ ST_TIME, 7

.equ ST_MAX, 8
; ============================================================================

.long r_FrameCounter
.long r_FreeState             	; Last longword of first free state.

; ============================================================================
; r3 = p_StateStack.
; r4 = r_Constants.
; r5 = p_State.
; r6 = r_StateSpace.            ; Don't think we need this on Archie?
; r7 = r_Sinus.
; ============================================================================

; r2 = Frame
RunFame:
    adr r7, r_Sinus
    adr r4, r_Constants
.1:
    adr r6, r_StateLists
    ldr r3, [r6, r2, lsl #2]    ; p_StateStack
    cmp #0
    beq .2
    ldr r1, [r3], #4            ; pop ptr to next state stack
    str r1, [r6, r2, lsl #2]    ; store this in state list
    ldr r5, [r3], #4            ; pop state ptr
    ldr r1, [r5, #ST_PROC*4]    ; load st_proc
	str lr, [sp, #-4]!			; Push lr on program stack.
    adr lr, .3
    ; TODO: Think about stashing registers?
	mov pc, r1                  ; jsr st_proc
    .3:
	ldr lr, [sp], #4			; Pop lr off program stack.
    b .1
.2:
    mov pc, lr

InitStates:
    adr r1, r_StateSpace
    mov r7, #MAX_TURTLES-1
.1:
    add r5, r1, #STATE_SIZE
    str r1, [r5]                ; first word of each state block points to previous one.
    mov r1, r5
    subs r7, r7, #1
    bpl .1
; FALLS THROUGH!
; r5 = p_State (last state in state space)
; r6 = StateList
InitMainTurtle:
    adr r1, r_Instructions
    ldr r0, [r5]                ; ptr to prev state.
    str r0, r_FreeState         ; becomes the first free state.
    str r1, [r5, #ST_PROC*4]    ; st_proc = r_Instructions (first procedure).
    ; TODO: USERANDOM
    mov r3, r5                  ; r3 = p_StateStack (grows downwards)
    str r5, [r3, #-4]!          ; push p_State on StateStack.
    adr r6, r_StateLists
    ldr r1, [r6, #0]            ; StateLists[0]
    str r1, [r3, #-4]!          ; push ptr to prev StateStack on StateStack!
    str r3, [r6, #0]            ; store StackStack ptr in StateList.
    mov pc, lr

; r5 = p_State
; r6 = <temp>
FreeState:
    ldr r6, r_FreeState
    str r6, [r5]                ; first word of state block points to prev free state.
    str r5, r_FreeState         ; this state becomes the next free state.
    mov pc, lr

; r0 = wait_frames
; r1 = address of procedure continue.
; r3 = StateStack.
; r5 = p_State.
; r6 = StateList.
WaitState:
    str r1, [r5, #ST_PROC*4]    ; *pState.st_proc = &continue
    str r5, [r3, #-4]!          ; push p_State on StateStack.

    ldr r2, [r5, #ST_TIME*4]
    add r2, r2, r0
    str r2, [r5, #ST_TIME*4]    ; *pState.st_time += wait_frames
    bic r2, r2, #0xffff         ; remove time fractional part.
    adr r6, r_StateLists
    ldr r1, [r6, r2, lsr #14]   ; time >> 16 << 2
    str r1, [r3, #-4]!          ; push previous entry from StateList at that frame.
    str r3, [r6, r2, lsr #14]   ; store new p_StateStack for this frame.
    mov pc, lr

; r0 = address of procedure.
; r1 = number of arguments.
; r2 = p_NewState.
; r5 = p_CurrentState.
; r6 = <temp>
; r8-r11 = <temp>
ForkState:
    ldr r2, r_FreeState         ; p_NewState.
    ldr r6, [r2]                ; first word of state block is ptr to next state.
    str r6, r_FreeState         ; this becomes the next free state.
    str r0, [r2, #ST_PROC*4]    ; *p_NewState.st_proc = procedure address.

    add r6, r5, #4              ; source: p_CurrentState.st_x
    add r0, r2, #4              ; destination: p_NewState.st_x

    ldmia r6!, {r8-r11}         ; st_x, st_y, st_size, st_tint
    stmia r0!, {r8-r11}         ; copy 4 words
    ldmia r6!, {r8-r11}         ; st_rand, st_dir, st_time, st_wire0
    stmia r0!, {r8-r11}         ; copy 4 words
    ldmia r6!, {r8-r11}         ; st_wire1, st_wire2, st_wire3, st_wire4
    stmia r0!, {r8-r11}         ; copy 4 words
    ldmia r6!, {r8-r10}         ; st_wire5, st_wire6, st_wire7
    stmia r0!, {r8-r10}         ; copy 3 words

    sub r8, r2, r1, lsl #2      ; p_NewStateStackBottom = p_NewState - num_args * 4
.1:
    cmp r1, #0                  ; while nargs > 0
    beq .2

    ldr r0, [r3], #4            ; pop arg from p_CurrentStateStack.
    str r0, [r8], #4            ; copy arg into p_NewStateStackBottom.
    subs r1, r1, #1
    b .1
.2:

    sub r8, r2, r1, lsl #2      ; p_NewStateStackBottom = p_NewState - num_args * 4
    str r2, [r8, #-4]!          ; push p_NewState onto NewStateStack.

    ldr r0, [r5, #ST_TIME*4]    ; *p_CurrentState.st_time
    bic r0, r0, #0xffff         ; remove time fractional part.
    adr r6, r_StateLists
    ldr r9, [r6, r0, lsr #14]   ; r_StateLists[current_time]
    str r9, [r8, #-4]!          ; push existing StateStackPtr onto NewStateStack.
    str r8, [r6, r0, lsr #14]   ; make NewStateStackPtr the new entry in the state list for this frame.
    mov pc, lr

; r0 = units.
; r5 = p_State.
; r6 = <temp>
; r8 = <temp>
; r9 = <temp>
DoMove:
    ldr r1, [r5, #ST_DIR*4]     ; get p_State.st_dir
    bic r1, r1, #0xff000000     ; clear top byte.
    mov r1, r1, lsr #10         ; shift down to 14-bits (16384 entries).
    ldr r8, [r7, r1, lsl #2]    ; load sine (r1)

    ldr r1, [r5, #ST_DIR*4]     ; get p_State.st_dir
    add r1, r1, #0x00400000     ; add quarter of the table
    bic r1, r1, #0xff000000     ; clear top byte.
    mov r1, r1, lsr #10         ; shift down to 14-bits (16384 entries).
    ldr r9, [r7, r1, lsl #2]    ; load cosine (r1)

    cmp r0, #32<<16
    bge .1                      ; big move
    cmp r0, #-32<<16
    bgt .2                      ; small move

.1:                             ; big move
    mov r0, r0, asr #14         ; keep only 2 bits of fractional part [14.2]
    mul r8, r8, r0              ; r8 = units * sine(dir) [14.2] * [1.16] = [14.18]
    mul r9, r9, r0              ; r9 = units * cosine(dir) [14.2] * [1.16] = [14.18]
    ; TODO: Check fp position here!
    mov r8, r8, #asr 2          ; [14.16]
    mov r9, r9, #asr 2          ; [14.16]
    b .3

.2:                             ; small move
    mov r0, r0, asr #6          ; keep 10 bits of fractional part [6.10]
    mul r8, r8, r0              ; r8 = units * sine(dir) [6.10] * [1.16] = [6.26]
    mul r9, r9, r0              ; r9 = units * cosine(dir) [6.10] * [1.16] = [6.26]
    ; TODO: Check fp position here!
    mov r8, r8, #asr 10         ; [6.16]
    mov r9, r9, #asr 10         ; [6.16]

.3:
    ldr r1, [r5, #ST_X * 4]
    add r1, r1, r9
    str r1, [r5, #ST_X * 4]     ; st_x += units * cosine(st_dir)

    ldr r1, [r5, #ST_Y * 4]
    add r1, r0, r8
    str r1, [r5, #ST_Y * 4]     ; st_y += units * sine(st_dir)
    mov pc, lr

; r8=st_x, r9=st_y, r10=st_size, r11=st_tint.
PutCircle:
    swi OS_WriteI + 18          ; GCOL
    swi OS_WriteI + 0           ; 0
    mov r0, r11                 ; tint
    swi OS_WriteC

    mov r0, #4                  ; MOVE
    mov r1, r8, lsl #2          ; X
    mov r2, r9, lsl #2          ; Y
    swi 0x45
    mov r0, #157                ; CIRCLE FILL
    mov r1, r8, lsl #2          ; X
    sub r9, r9, r10             ; Y -= size
    mov r2, r9, lsl #2          ; Y
    swi 0x45
    mov pc, lr

; r8=st_x, r9=st_y, r10=st_size, r11=st_tint.
PutSquare:
    swi OS_WriteI + 18          ; GCOL
    swi OS_WriteI + 0           ; 0
    mov r0, r11                 ; tint
    swi OS_WriteC

    mov r0, #4                  ; MOVE
    mov r1, r8, lsl #2          ; X
    mov r2, r9, lsl #2          ; Y
    sub r1, r1, r10, lsl #1     ; X -= st_size
    sub r2, r2, r10, lsl #1     ; Y -= st_size
    swi 0x45
    mov r0, #101                ; RECTANGLE FILL
    mov r1, r8, lsl #2          ; X
    mov r2, r9, lsl #2          ; Y
    add r1, r1, r10, lsl #1     ; X += st_size
    add r2, r2, r10, lsl #1     ; Y += st_size
    swi 0x45
    mov pc, lr

MakeSinus:
    adr r8, r_Sinus
    mov r0, #0
    str r0, [r8], #4
    add r9, r8, DEGREES/2*4-4
    str r0, [r9]

    mov r7, #1
.1:
    mov r1, r7
    mul r1, r1, r7          ; r7 ^2
    mov r1, r1, lsr #8

    mov r0, #2373
    mul r0, r0, r1
    mov r0, r0, lsr #16
    rsb r0, r0, #0
    add r0, r0, #21073
    mul r0, r0, r1
    mov r0, r0, lsr #16
    rsb r0, r0, #0
    add r0, r0, #51469
    mul r0, r0, r7
    mov r0, r0, lsr #13

    str r0, [r8], #4
    str r0, [r9, #-4]!
    rsb r0, r0, #0
    str r0, [r9, #DEGREES/2*4]
    str r0, [r8, #DEGREES/2*4-4]

    add r7, r7, #1
    cmp r7, #DEGREES/4
    blt .1

    rsb r0, r0, #0
    str r0, [r9, #-4]!
    rsb r0, r0, #0
    str r0, [r9, #DEGREES/2*4]
    mov pc, lr

; ============================================================================

.equ STATE_SIZE, ST_MAX+(WIRE_CAPACITY+MAX_STACK+2)*4

r_StateLists:
    .long	MAX_FRAMES+MAX_WAIT

r_StateSpace:
    .byte   (MAX_TURTLES+1)*STATE_SIZE

r_Sinus:
    .long   DEGREES

; ============================================================================
