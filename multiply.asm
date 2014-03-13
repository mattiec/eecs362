; Start instrs at address 0
.text 0x0000
; Start data somewhere else
.data 0x0000
.global _f
_f:
.word 256
.word 4

; Instructions
.text


.proc _mult
.global _mult
_mult:
    ; Initialize r1-r2
    lw r1, _f(r0)
    lw r2, (_f+4)(r0)
    mult r3, r1, r2
    xor r10, r10, r10
    xor r10, r10, r10
    xor r10, r10, r10
    addui r6, r6, #8
    sw  _f(r6), r3
    nop
    nop
    nop
    nop
    trap #0x300

.endproc _fib
