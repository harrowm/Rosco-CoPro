*
*  Just hack in my program here for now ...
*

    section .text                     ; This is normal code

kmain::
    lea.l   HELLO,A0                  ; Get the address of the message
    jsr     mcprintln                 ; Call mcPrintln (from the machine lib)

    ; the exciting part ..
    move.l  #10,D1
    fmove   D1,FP1
    fmovecr #$00,FP0                  ; move PI const to FP0
    fmul    FP1,FP0
    fintrz  FP0,FP0                   ; convert to short integer
    fmove   FP0,D1                    ; move back to CPU               

    moveq.l #15,D0
    move.b  #10,D2                    ; base 10
    trap    #15

    lea.l   BLANK,A0
    jsr     mcprintln


    lea.l   GOODBYE,A0
    jsr     mcprintln
    rts
    
mcprintln:
    move.l  A0,-(A7)
    jsr     mcPrintln
    addq.l  #4,A7
    rts

HELLO   dc.b    "pi*10 as an int is 31.  The FPU says:",0
BLANK   dc.b    0 
GOODBYE dc.b    "Pretty exciting stuff!",0  

