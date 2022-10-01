; ============================================================================
; engine.asm - ARM port of Engine.S
; ============================================================================

.equ _Inline_FreeState, 1
.equ _Inline_WaitState, 1
.equ _Inline_PlotDraw, 1

r_FrameCounter:
    .long 0

r_MaxFrames:
    .long MAX_FRAMES-1

r_BabeFeed:
    .long 0xbabefeed

.if _DEBUG
r_NumTurtles:
    .long 1

r_MaxTurtles:
    .long 0

r_NumCircles:
    .long 0

r_MaxCircles:
    .long 0
.endif

p_ColorScript:
    .long r_ColorScript

p_Sinus:
    .long r_Sinus

p_StateSpace:
	.long r_StateSpace

p_StateLists:
	.long r_StateLists

; ============================================================================
; ColorScript / Palette.
; ============================================================================

RunColorScript:
    str lr, [sp, #-4]!
    ldr r6, p_ColorScript
    ldr r0, [r6]                ; delta_frame.
    adds r0, r0, #1             ; increment frame.
    str r0, [r6]
    bmi .2                      ; not yet.

    adr r1, palette_osword_block
    mov r0, #16
    strb r0, [r1, #1]           ; physical colour
.1:
    ldr r2, [r6, #4]!           ; get index + RGB
    movs r2, r2                 ; status.
    bmi .2                      ; next delta.

    .if _DUAL_PLAYFIELD
    ; Set palette! [tBGR word]
    mov r4, r2, lsr #24         ; tint
    cmp r4, #4                  ; ignore tint 4!
    beq .1

	; Compute layer.
	mov r7, r4, lsr #2  		; layer = tint >> 2 (0 or 1)

	; Compute pixel bits for layer.
	and r8, r4, #3				; pixel = tint & 3

    mov r0, r8, lsl r7
    mov r0, r0, lsl r7          ; shift pixel bits by layer.
    bl set_colour

    cmp r7, #0
    beq .1                      ; layer 0 done

    ; layer 1
    mov r0, r8, lsl #2
    orr r0, r0, #0b01
    bl set_colour               ; and layer 0 pixels 01

    mov r0, r8, lsl #2
    orr r0, r0, #0b10
    bl set_colour               ; and layer 0 pixels 10

    mov r0, r8, lsl #2
    orr r0, r0, #0b11
    bl set_colour               ; and layer 0 pixels 11
    .else
    ; Set palette! [tBGR word]
    mov r0, r2, lsr #24         ; tint
    bl set_colour
    .endif

    b .1

.2:
    str r6, p_ColorScript
    ldr pc, [sp], #4

; r0 = logical colour
; r1 = osword_block
; r2 = xBGR word
; r3 = temp
set_colour:
    strb r0, [r1, #0]       ; logical colour
    strb r2, [r1, #2]       ; red
    mov r3, r2, lsr #8
    strb r3, [r1, #3]       ; green
    mov r3, r2, lsr #16
    strb r3, [r1, #4]       ; blue
    mov r0, #12
    swi OS_Word
    mov pc, lr

.if _DEBUG
; R4 = RGBx word
; Uses R0,R1 
palette_set_border:
    adrl r1, palette_osword_block
    mov r0, #24
    strb r0, [r1, #0]       ; logical colour
    strb r0, [r1, #1]       ; mode
    and r0, r4, #0xff
    strb r0, [r1, #2]       ; red
    mov r0, r4, lsr #8
    strb r0, [r1, #3]       ; green
    mov r0, r4, lsr #16
    strb r0, [r1, #4]       ; blue
    mov r0, #12
    swi OS_Word
    mov pc,lr
.endif

palette_osword_block:
    .skip 8

; ============================================================================
; r0 - r1 = local vars
; r2 = temp.
; r3 = p_StateStack.(preserve)
; r4 = r_Constants. (preserve)
; r5 = p_State.     (preserve)
; r6 = UNUSED (was r_StateSpace.) (PRESERVE AS MIGHT NEED THIS?)
; r7 = r_Sinus.     (preserve)
; r8 - r12 = free
; ============================================================================

RunFrame:
	str lr, [sp, #-4]!			; Push lr on program stack.

    .if _DEBUG
    mov r0, #0
    str r0, r_NumCircles
    .endif

    adr r4, r_Constants
    ldr r7, p_Sinus
    ldr r6, p_StateLists
.1:
    ldr r2, r_FrameCounter
    ldr r3, [r6, r2, lsl #2]    ; p_StateStack
    cmp r3, #0
    beq .2
    ldr r1, [r3], #4            ; pop ptr to next state stack
    str r1, [r6, r2, lsl #2]    ; store this in state list
    ldr r5, [r3], #4            ; pop state ptr
    ldr r1, [r5, #ST_PROC*4]    ; load st_proc
    adr lr, .3
	mov pc, r1                  ; jsr st_proc
    .3:

    .if _DEBUG && _Inline_FreeState != 0
    ldr r8, r_MaxTurtles
    ldr r9, r_NumTurtles
    cmp r9, r8
    strgt r9, r_MaxTurtles
    .endif
    b .1
.2:
	ldr pc, [sp], #4			; Pop lr off program stack.

InitStates:
    ldr r1, p_StateSpace
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
    ldr r6, p_StateLists

    ldr r0, [r5]                ; ptr to prev state.
    .if _Inline_FreeState
    str r0, [r6, #-4]           ; (r_FreeState)
    .else
    str r0, r_FreeState         ; becomes the first free state.
    .endif
    str r1, [r5, #ST_PROC*4]    ; st_proc = r_Instructions (first procedure).
    ldr r0, r_BabeFeed
    str r0, [r5, #ST_RAND*4]    ; st_rand = $BABEFEED
    mov r3, r5                  ; r3 = p_StateStack (grows downwards)
    str r5, [r3, #-4]!          ; push p_State on StateStack.
    ldr r1, [r6, #0]            ; StateLists[0]
    str r1, [r3, #-4]!          ; push ptr to prev StateStack on StateStack!
    str r3, [r6, #0]            ; store StackStack ptr in StateList.
    mov pc, lr

; ============================================================================
; Code Snippets.
; ============================================================================

; r5 = p_State.
.if _Inline_FreeState == 0
FreeState:
    ldr r2, r_FreeState
    str r2, [r5]                ; first word of state block points to prev free state.
    str r5, r_FreeState         ; this state becomes the next free state.

    .if _DEBUG
    ldr r1, r_NumTurtles
    sub r1, r1, #1
    str r1, r_NumTurtles
    .endif
    mov pc, lr
.endif

; r0 = wait_frames
; r1 = address of procedure continue.
; r3 = StateStack.
; r5 = p_State.
; r6 = StateList.
.if _Inline_WaitState == 0
WaitState:
    str r1, [r5, #ST_PROC*4]    ; *pState.st_proc = &continue
    str r5, [r3, #-4]!          ; push p_State on StateStack.

    ldr r2, [r5, #ST_TIME*4]
    add r2, r2, r0
    str r2, [r5, #ST_TIME*4]    ; *pState.st_time += wait_frames
    bic r2, r2, #0xc000         ; remove time fractional part.
;   ldr r6, p_StateLists
    ldr r1, [r6, r2, lsr #14]   ; time >> 16 << 2
    str r1, [r3, #-4]!          ; push previous entry from StateList at that frame.
    str r3, [r6, r2, lsr #14]   ; store new p_StateStack for this frame.
    mov pc, lr
.endif

; r0 = address of procedure.
; r1 = number of arguments.
; r5 = p_CurrentState.
; r6 = StateList.
; r8-r11 = temp.
; r12 = p_NewState.
ForkState:
    .if _Inline_FreeState
    ldr r2, [r6, #-4]           ; (r_FreeState)
    .else
    ldr r2, r_FreeState         ; p_NewState.
    .endif
    ldr r12, [r2]               ; first word of state block is ptr to next state.

    .if _DEBUG
    cmp r12, #0
    adreq r0, outofturtles
    swieq OS_GenerateError
    .endif

    .if _Inline_FreeState
    str r12, [r6, #-4]          ; (r_FreeState)
    .else
    str r12, r_FreeState        ; this becomes the next free state.
    .endif
    str r0, [r2, #ST_PROC*4]    ; *p_NewState.st_proc = procedure address.

    add r12, r5, #4             ; source: p_CurrentState.st_x
    add r0, r2, #4              ; destination: p_NewState.st_x

    ldmia r12!, {r8-r11}        ; st_x, st_y, st_size, st_tint
    stmia r0!, {r8-r11}         ; copy 4 words
    ldmia r12!, {r8-r11}        ; st_rand, st_dir, st_time, st_wire0
    stmia r0!, {r8-r11}         ; copy 4 words
    ldmia r12!, {r8-r11}        ; st_wire1, st_wire2, st_wire3, st_wire4
    stmia r0!, {r8-r11}         ; copy 4 words
    ldmia r12!, {r8-r10}        ; st_wire5, st_wire6, st_wire7
    stmia r0!, {r8-r10}         ; copy 3 words

    .if WIRE_CAPACITY != 8
    .err WIRE_CAPACITY is not 8 as expected!
    .endif

    sub r8, r2, r1, lsl #2      ; p_NewStateStackBottom = p_NewState - num_args * 4
    mov r9, r1
.1:
    cmp r9, #0                  ; while nargs > 0
    beq .2

    ldr r0, [r3], #4            ; pop arg from p_CurrentStateStack.
    str r0, [r8], #4            ; copy arg into p_NewStateStackBottom.
    subs r9, r9, #1
    b .1
.2:

    sub r8, r2, r1, lsl #2      ; p_NewStateStackBottom = p_NewState - num_args * 4
    str r2, [r8, #-4]!          ; push p_NewState onto NewStateStack.

    ldr r0, [r5, #ST_TIME*4]    ; *p_CurrentState.st_time
    bic r0, r0, #0xc000         ; remove time fractional part.
;   ldr r6, p_StateLists
    ldr r9, [r6, r0, lsr #14]   ; r_StateLists[current_time]
    str r9, [r8, #-4]!          ; push existing StateStackPtr onto NewStateStack.
    str r8, [r6, r0, lsr #14]   ; make NewStateStackPtr the new entry in the state list for this frame.

    .if _DEBUG && _Inline_FreeState != 0
    ldr r1, r_NumTurtles
    add r1, r1, #1
    str r1, r_NumTurtles
    .endif
    mov pc, lr

.if _DEBUG
outofturtles: ;The error block
    .long 18
	.byte "Out of turtles!"
	.align 4
	.long 0
.endif

; r0 = units.
; r5 = p_State.
; r7 = r_Sinus
; r8-r10 = temp.
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
    mul r8, r0, r8              ; r8 = units * sine(dir) [14.2] * [1.14] = [14.16]
    mul r9, r0, r9              ; r9 = units * cosine(dir) [14.2] * [1.14] = [14.16]
    b .3

.2:                             ; small move
    mov r0, r0, asr #6          ; keep 10 bits of fractional part [6.10]
    mul r8, r0, r8              ; r8 = units * sine(dir) [6.10] * [1.14] = [6.24]
    mul r9, r0, r9              ; r9 = units * cosine(dir) [6.10] * [1.14] = [6.24]
    mov r8, r8, asr #8         ; [6.16] 
    mov r9, r9, asr #8         ; [6.16]

.3:
    ldr r1, [r5, #ST_X * 4]
    add r1, r1, r9
    str r1, [r5, #ST_X * 4]     ; st_x += units * cosine(st_dir)

    ldr r1, [r5, #ST_Y * 4]
    add r1, r1, r8
    str r1, [r5, #ST_Y * 4]     ; st_y += units * sine(st_dir)
    mov pc, lr

; r8=st_x, r9=st_y, r10=st_size, r11=st_tint.
.if _Inline_PlotDraw == 0
PutCircle:
.if 0
    swi OS_WriteI + 18          ; GCOL
    swi OS_WriteI + 0           ; 0
    mov r0, r11, lsr #16        ; tint
    swi OS_WriteC

    mov r0, #4                  ; MOVE
    mov r1, r8, asr #14         ; X [16.16] -> [16.2]
    mov r2, r9, asr #14         ; Y [16.16] -> [16.2]
    rsb r2, r2, #1024           ; flip for Archie!
    swi OS_Plot
    
    mov r0, #157                ; CIRCLE FILL
    mov r1, r8, asr #14         ; X [16.16] -> [16.2]
    sub r2, r9, r10             ; Y -= size
    mov r2, r2, asr #14         ; Y [16.16] -> [16.2]
    rsb r2, r2, #1024           ; flip for Archie!
    swi OS_Plot
    mov pc, lr
.else
    str lr, [sp, #-4]!
    mov r0, r8, asr #16         ; X
    mov r1, r9, asr #16         ; Y
    mov r2, r10, asr #16        ; RADIUS
    ; Guard against negative radius from dodgy Rose maths...
    cmp r2, #0
    blt .1
    mov r9, r11, lsr #16        ; TINT
	ldr r10, plot_circle_instruction
    bl link_circle
    .1:
    ldr pc, [sp], #4

plot_circle_instruction:
    .long 0xe4dc1001            ; LDRB r1, [r12], #1
.endif
.endif

; r8=st_x, r9=st_y, r10=st_size, r11=st_tint.
.if _Inline_PlotDraw == 0
PutSquare:
.if 0
    swi OS_WriteI + 18          ; GCOL
    swi OS_WriteI + 0           ; 0
    mov r0, r11, lsr #16        ; tint
    swi OS_WriteC

    mov r0, #4                  ; MOVE
    sub r1, r8, r10             ; bottom left X -= st_size
    sub r2, r9, r10             ; bottom left Y -= st_size
    mov r1, r1, asr #14         ; X [16.16] -> [16.2]
    mov r2, r2, asr #14         ; Y [16.16] -> [16.2]
    rsb r2, r2, #1024           ; flip for Archie!
    swi OS_Plot

    mov r0, #101                ; RECTANGLE FILL
    add r1, r8, r10             ; top right X += st_size
    add r2, r9, r10             ; top right Y += st_size
    mov r1, r1, asr #14         ; X [16.16] -> [16.2]
    mov r2, r2, asr #14         ; Y [16.16] -> [16.2]
    rsb r2, r2, #1024           ; flip for Archie!
    swi OS_Plot
    mov pc, lr
.else
    str lr, [sp, #-4]!
    mov r0, r8, asr #16         ; X
    mov r1, r9, asr #16         ; Y
    mov r2, r10, asr #16        ; RADIUS
    ; Guard against negative radius from dodgy Rose maths...
    cmp r2, #0
    blt .1
	ldr r10, plot_square_instruction
    orr r10, r10, r2            ; mov r1, #st_size
    mov r9, r11, lsr #16        ; TINT
    bl link_circle
    .1:
	ldr pc, [sp], #4

plot_square_instruction:
    .long 0xe3a01000            ; mov r1, #0
.endif
.endif

; ============================================================================
