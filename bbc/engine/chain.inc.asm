; ============================================================================
; Shared middle-store chain — at a FIXED address: rose2bbc.py's generated
; SWRAM span routines bake `jmp chain_rts - 4k` entries into their code.
; Entering k units early stores A at offsets 8k, 8(k-1), ..., 8 from scr.
; ============================================================================
.chain_top
FOR n, 31, 1, -1
    ldy #n*8
    sta (scr),y
NEXT
.chain_rts
    rts
chain30 = chain_rts - 120
ASSERT chain_rts = &0E7C            ; must match rose2bbc.py CHAIN_RTS
ASSERT RFILL = &6E                  ; must match rose2bbc.py SPAN_RFILL
ASSERT TMPB = &6F                   ; must match rose2bbc.py SPAN_TMPB
