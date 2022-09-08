; ============================================================================
; engine.asm - ARM port of Engine.S
; ============================================================================

.equ MAX_FRAMES, 10000	        ; Length of Rose animation
.equ MAX_CIRCLES, 200           ; Max circles drawn in a frame (!)
.equ MAX_TURTLES, 500           ; Max turtles alive at the same time (!)
.equ MAX_STACK, 20              ; Max depth of execution stack
.equ MAX_WAIT, 1000             ; Max wait beyond end of program
.equ WIRE_CAPACITY, 8           ; Number of wire slots
.equ MAXRADIUS, 70              ;

; ============================================================================
.equ ST_PROC, 0
.equ ST_X, 1
.equ ST_Y, 2
.equ ST_SIZE, 3
.equ ST_TINT, 4
.equ ST_RAND, 5
.equ ST_DIR, 6
.equ ST_TIME, 7
.equ ST_SIZE, 8
; ============================================================================

.equ STATE_SIZE, ST_SIZE+(WIRE_CAPACITY+MAX_STACK+2)*4

; TODO: Allocate StateLists and StateSpace.
;r_StateLists	rs.l	MAX_FRAMES+MAX_WAIT
;r_StateSpace	rs.b	(MAX_TURTLES+1)*STATE_SIZE

.long r_FreeState             	; Last longword of first free state.

; ============================================================================
; r3 = p_StateStack.
; r4 = r_Constants.
; r5 = p_State.
; r6 = r_StateSpace.
; r7 = r_Sinus.
; ============================================================================

RunFame:
    mov pc, lr

InitStates:
    mov pc, lr

InitMainTurtle:
    mov pc, lr

FreeState:
    mov pc, lr

WaitState:
    mov pc, lr

ForkState:
    mov pc, lr

DoMove:
    mov pc, lr

PutCircle:
    mov pc, lr

PutSquare:
    mov pc, lr

MakeSinus:
    mov pc, lr
