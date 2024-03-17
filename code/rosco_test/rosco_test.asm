; Just testing f-line for Malcolm Harrow
;

    section .text

kmain::
    move.l  #trap,$2c

    ; generate a bus error to trigger LA
    move.l  $8,BERR
    move.l  #berr,$8
    move.l  $100000,D0
    move.l  BERR,$8

    lea.l   TEST,A0
    jsr     mcprintln

    ; try to get the value of PI out of the FPU, convert to an integer and print
    fmovecr  #$00,FP0
    fintrz   FP0,FP0
    fmove.l  FP0,D1                   ; move directly to D1 for print routine

    ; print number
    moveq.l #15,D0
    move.b  #10,D2                    ; base 10
    trap    #15

    lea.l   BLANK,A0
    jsr     mcprintln
    lea.l   ANSWER,A0
    jsr     mcprintln

    lea.l   GOOD,A0
    jsr     mcprintln

exit:
    rts

berr:
    move.l  D0,-(A7)
    move.w  $E(A7),D0
    bclr    #8,D0
    move.w  D0,$E(A7)
    move.l  (A7)+,D0
    rte

trap:
    lea.l   BANG,A0
    jsr     mcprintln
    move.l  #exit,2(A7)
    rte

mcprintln:
    move.l  A0,-(A7)
    jsr     mcPrintln
    addq.l  #4,A7
    rts

BERR    ds.l    1
TEST    dc.b    "TESTING", 0
BANG    dc.b    "F-Line", 0
GOOD    dc.b    "Okay", 0
BLANK   dc.b    0
ANSWER  dc.b    "Answer above should be 3", 0
