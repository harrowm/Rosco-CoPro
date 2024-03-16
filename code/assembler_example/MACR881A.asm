*******************************************************************************
*	MACRO CODE TO DRIVE MC68881 AS A PERIPHERAL WITH M68000 FAMILY	      *
*	  www.ATARI-FORUM.com	SFP004 Developer's Kit			      *
*	  (c)2019 tcat <thomas.kral@email.cz>	(c)1987 Motorola AN947_REV0   *
*******************************************************************************
*
* Changes to get this to work on the rosco_m68k VSAM MOT sytax assembler
* Malcolm Harrow March 2024
*	.nlist
*******************************************************************************
*	THESE ARE THE INSTRUCTION BIT PATTERN EQUATES
*******************************************************************************

FMOVE	 EQU	   $00	     ;MOVE
FINT	 EQU	   $01	     ;INTEGER PART
FSINH	 EQU	   $02	     ;SINH
FSQRT	 EQU	   $04	     ;SQUARE ROOT
FLOGNP1	 EQU	   $06	     ;LOGN (1+X)
FETOXM1	 EQU	   $08	     ;[(E**X)-1)]
FTANH	 EQU	   $09	     ;TANH
FATAN	 EQU	   $0A	     ;ARCTAN
FASIN	 EQU	   $0C	     ;ARCSIN
FATANH	 EQU	   $0D	     ;ARCTANH
FSIN	 EQU	   $0E	     ;SINE
FTAN	 EQU	   $0F	     ;TANGENT
FETOX	 EQU	   $10	     ;E**X
FTWOTOX	 EQU	   $11	     ;2**X
FTENTOX	 EQU	   $12	     ;10**X
FLOGN	 EQU	   $14	     ;LOGN
FLOG10	 EQU	   $15	     ;LOG10
FLOG2	 EQU	   $16	     ;LOG2
FABS	 EQU	   $18	     ;ABSOLUTE VALUE
FCOSH	 EQU	   $19	     ;COSH
FNEG	 EQU	   $1A	     ;NEGATE
FACOS	 EQU	   $1C	     ;ARCCOS
FCOS	 EQU	   $1D	     ;COSINET
FGETEXP	 EQU	   $1E	     ;GET EXPONENT
FGETMAN	 EQU	   $1F	     ;GET MANTISSA
FDIV	 EQU	   $20	     ;DIVIDE
FMOD	 EQU	   $21	     ;MODULO REMAINDER
FADD	 EQU	   $22	     ;ADD
FMUL	 EQU	   $23	     ;MULTIPLY
FSGLDIV	 EQU	   $24	     ;SINGLE DIVIDE
FREM	 EQU	   $25	     ;IEEE REMAINDER
FSCALE	 EQU	   $26	     ;SCALE EXPONENT
FSGLMUL	 EQU	   $27	     ;SINGLE MULTIPLY
FSUB	 EQU	   $28	     ;SUBTRACT
FCMP	 EQU	   $38	     ;COMPARE
FTST	 EQU	   $3A	     ;TEST
FSINCOS	 EQU	   $30	     ;SIMULTANEOUS FP SINE AND COSINE

*******************************************************************************
*     THESE ARE THE NUEMONICS USED AS THE CONDITION CODES FOR THE	      *
*	 BRANCH INSTRUCTIONS						      *
*******************************************************************************
EQ	 EQU	   $01	     ;EQUAL
NEQ	 EQU	   $0E	     ;NOT EQUAL
GT	 EQU	   $12	     ;GREATER THAN
NGT	 EQU	   $1D	     ;NOT GREATER THAN
GE	 EQU	   $13	     ;GREATER THAN OR EQUAL
NGE	 EQU	   $1C	     ;NOT (GREATER THAN OR EQUAL)
LT	 EQU	   $14	     ;LESS THAN
NLT	 EQU	   $1B	     ;NOT LES THAN
LE	 EQU	   $15	     ;LESS THAN OR EQUAL
NLE	 EQU	   $1A	     ;NOT (LESS THAN OR EQUAL)
GL	 EQU	   $16	     ;GREATER OR LESS THAN
NGL	 EQU	   $19	     ;NOT (GREATER OR LESS THAN)
GLE	 EQU	   $17	     ;GREATER OR LESS OR EQUAL
NGLE	 EQU	   $18	     ;NOT (GREATER OR LESS OR EQUAL)
OGT	 EQU	   $02	     ;ORDERED GREATER THAN
ULE	 EQU	   $0D	     ;UNORDERED OR LESS OR EQUAL
OGE	 EQU	   $03	     ;ORDERED GREATER THAN OR EQUAL
ULT	 EQU	   $0C	     ;UNORDERED OR LESS THAN
OLT	 EQU	   $04	     ;ORDERED LESS THAN
UGE	 EQU	   $0B	     ;UNORDERED OR GREATER OR EQUAL
OLE	 EQU	   $05	     ;ORDERED LESS THAN OR EQUAL
UGT	 EQU	   $0A	     ;UNORDERED OR GREATER
OGL	 EQU	   $06	     ;ORDERED GREATER OR LESS THAN
UEQ	 EQU	   $09	     ;UNORDERED OR EQUAL
OR	 EQU	   $07	     ;ORDERED
UN	 EQU	   $08	     ;UNORDERED
F	 EQU	   $00	     ;FALSE (NEVER)
T	 EQU	   $0F	     ;TRUE (ALWAYS)
SF	 EQU	   $10	     ;SIGNALING FALSE (NEVER)
ST	 EQU	   $1F	     ;SIGNALING TRUE (ALWAYS)
SEQ	 EQU	   $11	     ;SIGNALING EQUAL
SNEQ	 EQU	   $1E	     ;SIGNALING NOT EQUAL
 
*******************************************************************************
*	 THESE EQUATES REPRESENT THE OFFSETS FOR THE BASE ADDRESS OF	      *
*	   THE MC68881 INTERFACE REGISTERS!				      *
*******************************************************************************
*MC68881	 EQU	   $FFFA40   ;MC68881 BASE ADDRESS
MC68881	 EQU	   $FFC000   ;MC68881 BASE ADDRESS
RESPONSE EQU	   $00	     ;RESPONSE REGISTER
SAVE	 EQU	   $04	     ;SAVE REGISTER
RESTORE	 EQU	   $06	     ;RESTORE REGISTER
COMMAND	 EQU	   $0A	     ;COMMAND REGISTER
COND	 EQU	   $0E	     ;CONDITION REGISTER
OPER	 EQU	   $10	     ;OPERAND REGISTER
REGSEL	 EQU	   $14	     ;REGISTER SELECT
CONTROL	 EQU	   $9000     ;MC68881 CONTROL REGISTER
STATUS	 EQU	   $8800     ;MC68881 STATUS REGISTER
IADDRESS EQU	   $8400     ;MC68881 INSTRUCTION ADDRESS REGISTER
TFBIT	 EQU	   $0	     ;TRUE/FALSE BIT OF THE RESPONSE REGISTER


*******************************************************************************
*	 THESE EQUATES REPRESENT THE FLOATING POINT REGISTERS		      *
*******************************************************************************
FP0	 EQU	   $00	     ;FLOATING POINT REGISTER #0
FP1	 EQU	   $01	     ;	 "	 "	  "   #1
FP2	 EQU	   $02	     ;	 "	 "	  "   #2
FP3	 EQU	   $03	     ;	 "	 "	  "   #3
FP4	 EQU	   $04	     ;FLOATING POINT REGISTER #4
FP5	 EQU	   $05	     ;	  "	 "	  "   #5
FP6	 EQU	   $06	     ;	  "	 "	  "   #6
FP7	 EQU	   $07	     ;	  "	 "	  "   #7
******************************************************************************
*									     *
*	 MC68881 SINGLE PRECISION FP-REG. VALUE TO MEMORY OPERATION	     *
*									     *
*	 REGMEMS   INSTRUCTION,FPM,<EA>					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FMOVE)	     *
*		 FPM= SOURCE FP REGISTER				     *
*		 <EA>= DESTINATION ADDRESSING MODE			     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  DN, (AN)+, -(AN), D(AN), D(AN,IX)	     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
******************************************************************************
	 macro	 REGMEMS
	 if !\?4			;IS <EA>=  INDIRECT WITH INDEXING
	 MOVE.W #$6400+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L MC68881+OPER,\3		;LOW ORDER WORD
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS <EA> NOT = INDIRECT WITH INDEXING
	 MOVE.W #$6400+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L MC68881+OPER,\3,\4	;SINGLE PRECISION DATA TRANSFER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 LONG WORD LENGTH FP-REG. VALUE TO MEMORY OPERATION	     *
*									     *
*	 REGMEMW   INSTRUCTION,FPM,<EA>					     *
*									     *
*   INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FMOVE)			     *
*		 FPM= SOURCE FP REGISTER				     *
*		 <EA>= DESTINATION ADDRESSING MODE			     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  DN, (AN)+, -(AN), D(AN), D(AN,IX)	     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
******************************************************************************
	 macro	 REGMEML
	 if !\?4			;IS <EA>=INDIRECT WITH INDEXING
	 MOVE.W #$6000+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L MC68881+OPER,\3		;LONG WORD TRANSFER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS <EA> NOT = INDIRECT WITH INDEXING
	 MOVE.W #$6000+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L MC68881+OPER,\3,\4	;LONG WORD TRANSFER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 WORD LENGTH FP-REG. VALUE TO MEMORY OPERATION		     *
*									     *
*	 REGMEMW   INSTRUCTION,FPM,<EA>					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FMOVE)	     *
*		 FPM= SOURCE FP REGISTER				     *
*		 <EA>= DESTINATION ADDRESSING MODE			     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  DN, (AN)+, -(AN), D(AN), D(AN,IX)	     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
******************************************************************************
	 macro	 REGMEMW
	 if !\?4			;IS <EA>=INDIRECT WITH INDEXING
	 MOVE.W #$7000+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.W MC68881+OPER,\3		;WORD DATA TRANSFER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS <EA> NOT = INDIRECT WITH INDEXING
	 MOVE.W #$7000+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.W MC68881+OPER,\3,\4	;WORD DATA TRANSFER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 BYTE LENGTH FP-REG. VALUE TO MEMORY OPERATION		     *
*									     *
*	 REGMEMB   INSTRUCTION,FPM,<EA>					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FMOVE)	     *
*		 FPM= SOURCE FP REGISTER				     *
*		 <EA>= DESTINATION ADDRESSING MODE			     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  DN, (AN)+, -(AN), D(AN), D(AN,IX)	     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
******************************************************************************
	 macro	 REGMEMB
	 if !\?4			;IS <EA>=INDIRECT WITH INDEXING
	 MOVE.W #$7800+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.B MC68881+OPER,\3		;BYTE DATA TRANSFER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS <EA> NOT = INDIRECT WITH INDEXING
	 MOVE.W #$7800+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.B MC68881+OPER,\3,\4	;BYTE DATA TRANSFER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 DOUBLE PRECISION FP-REG. VALUE TO MEMORY OPERATION	     *
*									     *
*	 REGMEMD   INSTRUCTION,FPM,<EA>					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FMOVE)	     *
*		 FPM= SOURCE FP REGISTER				     *
*		 <EA>= AN ADDRESS REGISTER, SURROUNDED BY PARENTHESIS,	     *
*		       CONTAINING THE PREVIOUSLY LOADED EFFECTIVE ADDRESS    *
*		       (I.E. (A0)).					     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  (AN)					     *
*									     *
******************************************************************************
	 macro	 REGMEMD
	 MOVE.W #$7400+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L MC68881+OPER,\3		;HIGH ORDER LONG WORD
	 MOVE.L MC68881+OPER,4\3	;LOW ORDER LONG WORD
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endm
******************************************************************************
*									     *
*	 MC68881 EXTENDED PRECISION FP-REG. VALUE TO MEMORY OPERATION	     *
*									     *
*	 REGMEMX   INSTRUCTION,FPM,<EA>					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FMOVE)	     *
*		 FPM= SOURCE FP REGISTER				     *
*		 <EA>= AN ADDRESS REGISTER, SURROUNDED BY PARENTHESIS,	     *
*		       CONTAINING THE PREVIOUSLY LOADED EFFECTIVE ADDRESS    *
*		       (I.E. (A0)).					     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  (AN)					     *
*									     *
******************************************************************************
	 macro	 REGMEMX
	 MOVE.W #$6800+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L MC68881+OPER,\3		;HIGH ORDER LONG WORD
	 MOVE.L MC68881+OPER,4\3	;MID-ORDER
	 MOVE.L MC68881+OPER,8\3	;LOW ORDER WORD
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endm
******************************************************************************
*									     *
*	 MC68881 PACKED BCD FP-REG. VALUE TO MEMORY OPERATION		     *
*									     *
*	 REGMEMP   INSTRUCTION,FPM,<EA>,[K-FACTOR]			     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FADD)	     *
*		 FPM= SOURCE FP REGISTER				     *
*		 <EA>= DESTINATION ADDRESSING MODE			     *
*		 [K-FACTOR]= OPTIONAL IMMEDIATE K-FACTOR		     *
*									     *
*    ***IF [K-FACTOR] OPTION NOT TAKEN, THE K-FACTOR MUST BE PLACED IN D0!   *
*									     *
*	 VALID ADDRESSING MODES:  (AN)					     *
*									     *
******************************************************************************
	 macro	 REGMEMP
	 if !\?4			;IS K-FACTOR IN REGISTER?
	 MOVE.W #$7C00+(\2<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL TRANSFER MAIN PROCESSOR REG
	 MOVE.L D0,MC68881+OPER		;PASS K-FACTOR FROM D0
.AGAIN\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .AGAIN\@			;REREAD UNTIL EVALUATE EFFECTIVE ADDRESS
					;AND TRANSFER DATA
	 MOVE.L MC68881+OPER,\3		;LOW ORDER LONG WORD
	 MOVE.L MC68881+OPER,4\3	;MID-ORDER LONG WORD
	 MOVE.L MC68881+OPER,8\3	;HIGH ORDER LONG WORD
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS K-FACTOR IN INSTRUCTION?
	 MOVE.W #$6C00+(\2<<7)+\4,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EFFECTIVE ADDRESS
					;AND TRANSFER DATA
	 MOVE.L MC68881+OPER,\3		;LOW ORDER WORD
	 MOVE.L MC68881+OPER,4\3	;MID-ORDER WORD
	 MOVE.L MC68881+OPER,8\3	;HIGH ORDER WORD
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 BYTE IN MEMORY OR IN Dn TO FP-REG. OPERATION		     *
*									     *
*	 MEMREGB   INSTRUCTION,<EA>,FPN					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FADD)	     *
*		 <EA>= SOURCE ADDRESSING MODE				     *
*		 FPN= DESTINATION REGISTER				     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  DN, (AN)+, -(AN), D(AN), D(AN,IX)	     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
*	 THE COMMENTED OUT CODE SHOWS HOW A USER MAY IMPLEMENT FSINCOS	     *
*	 IN A MEM. TO REG. TRANSFER USING THE FOLLOWING INSTRUCTION FORMAT:  *
*									     *
*	 MEMREGB INSTRUCTION,<EA>,FPN,FPQ	(FPQ= 2ND DESTINATION REG.)  *
*									     *
******************************************************************************
	 macro	 MEMREGB
	 if \1 = 'FSINCOS'		;IS INSTRUCTION FSINCOS
	 if !\?5			;IS INDEXING PART OF THE ADDR.MODE
	 MOVE.W #$5800+(\4<<7)+\3+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.B \2,MC68881+OPER		;BYTE DATA TRANSFER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS <EA> NOT = INDIRECT WITH INDEXING
	 MOVE.W #$5800+(\5<<7)+\4+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.B \2,\3,MC68881+OPER	;BYTE DATA TRANSFER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 else				;IS INSTRUCTION NOT FSINCOS
	 if !\?4			;IS <EA>=INDIRECT WITH INDEXING
	 MOVE.W #$5800+(\3<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.B \2,MC68881+OPER		;MOVE DATA INTO OPERAND REGISTER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS <EA>=NOT INDIRECT WITH INDEXING
	 MOVE.W #$5800+(\4<<7)+\1,MC68881+COMMAND ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.B \2,\3,MC68881+OPER	;BYTE DATA TRANSFER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 WORD IN MEMORY OR IN Dn TO FP-REG. OPERATION		     *
*									     *
*	 MEMREGW   INSTRUCTION,<EA>,FPN					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FADD)	     *
*		 <EA>= SOURCE ADDRESSING MODE				     *
*		 FPN= DESTINATION REGISTER				     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  DN, (AN)+, -(AN), D(AN), D(AN,IX)	     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
******************************************************************************
	 macro	 MEMREGW
	 if !\?4			;IS <EA>=INDIRECT WITH INDEXING
	 MOVE.W #$5000+(\3<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.W \2,MC68881+OPER		;WORD DATA TO FP-REG.
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS <EA> NOT = INDIRECT WITH INDEXING
	 MOVE.W #$5000+(\4<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.W \2,\3,MC68881+OPER	;WORD DATA TO FP REG.
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 LONG WORD IN MEMORY OR IN Dn TO FP-REG. OPERATION	     *
*									     *
*	 MEMREGL   INSTRUCTION,<EA>,FPN					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FADD)	     *
*		 <EA>= SOURCE ADDRESSING MODE				     *
*		 FPN= DESTINATION REGISTER				     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  DN, (AN)+, -(AN), D(AN), D(AN,IX)	     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
******************************************************************************
	 macro	 MEMREGL
	 if !\?4			;IS <EA>=INDIRECT WITH INDEXING
	 MOVE.W #$4000+(\3<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L \2,MC68881+OPER		;LONG WORD DATA TO FP REG.
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS <EA> NOT = INDIRECT WITH INDEXING
	 MOVE.W #$4000+(\4<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L \2,\3,MC68881+OPER	;LONG WORD DATA TO FP REG.
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 SINGLE PRECISION VALUE MEMORY TO FP-REG. OPERATION	     *
*									     *
*	 MEMREGS   INSTRUCTION,<EA>,FPN					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FADD)	     *
*		 <EA>= SOURCE ADDRESSING MODE				     *
*		 FPN= DESTINATION REGISTER				     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  DN, (AN)+, -(AN), D(AN), D(AN,IX)	     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
******************************************************************************
	 macro	 MEMREGS
	 if !\?4			;IS <EA>=INDIRECT WITH INDEXING
	 MOVE.W #$4400+(\3<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L \2,MC68881+OPER		;SINGLE PRECISION DATA TO FP REG.
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS <EA> NOT = INDIRECT WITH INDEXING
	 MOVE.W #$4400+(\4<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L \2,\3,MC68881+OPER	;SINGLE PRECISION DATA TO FP REG.
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 DOUBLE PRECISION VALUE MEMORY TO FP-REG. OPERATION	     *
*									     *
*	 MEMREGD   INSTRUCTION,<EA>,FPN					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FADD)	     *
*		 <EA>= SOURCE ADDRESS REGISTER,SURROUNDED BY PARENTHEIS,     *
*		       CONTAINING THE PREVIOUSLY ENTERED ADDRESSING MODE     *
*		       (I.E. (AN)).					     *
*		 FPN= DESTINATION REGISTER				     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  (AN)					     *
*									     *
******************************************************************************
	 macro	 MEMREGD
	 MOVE.W #$5400+(\3<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L \2,MC68881+OPER		;HIGH ORDER LONG WORD
	 MOVE.L 4\2,MC68881+OPER	;LOW ORDER LONG WORD
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endm
******************************************************************************
*									     *
*	 MC68881 EXTENDED PRECISION VALUE MEMORY TO FP-REG. OPERATION	     *
*									     *
*	 MEMREGX   INSTRUCTION,<EA>,FPN					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FADD)	     *
*		 <EA>= SOURCE ADDRESS REGISTER,SURROUNDED BY PARENTHESIS,    *
*		       CONTAINING THE PREVIOUSLY ENTERED ADDRESSING MODE     *
*		       (I.E. (AN)).					     *
*		 FPN= DESTINATION REGISTER				     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  (AN)					     *
*									     *
*******************************************************************************
	 macro	 MEMREGX
	 MOVE.W #$4800+(\3<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L \2,MC68881+OPER		;HIGH ORDER LONG WORD

	 MOVE.L 4\2,MC68881+OPER	;MID-ORDER LONG WORD
	 MOVE.L 8\2,MC68881+OPER	;LOW ORDER LONG WORD
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endm
******************************************************************************
*									     *
*	 MC68881 PACKED BCD VALUE MEMORY TO FP-REG. OPERATION		     *
*									     *
*	 MEMREGP   INSTRUCTION,<EA>,FPN					     *
*									     *
*	 WHERE:	 INSTRUCTION= FP INSTRUCTION NUEMONIC (I.E. FADD)	     *
*		 <EA>= SOURCE ADDRESS REGISTER,SURROUNDED BY PARENTHESIS,    *
*		       CONTAINING THE PREVIOUSLY ENTERED ADDRESSING MODE     *
*		       (I.E. (AN)).					     *
*		 FPN = DESTINATION REGISTER				     *
*									     *
*	 NO REGISTERS MODIFYED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  (AN)					     *
*									     *
******************************************************************************
	 macro	 MEMREGP
	 MOVE.W #$4C00+(\3<<7)+\1,MC68881+COMMAND  ;MEM. TO REG. OPERATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL EVALUATE EA AND TRANSFER
					;DATA
	 MOVE.L \2,MC68881+OPER		;HIGH ORDER LONG WORD
	 MOVE.L 4\2,MC68881+OPER	;MID-ORDER LONG WORD
	 MOVE.L 8\2,MC68881+OPER	;LOW ORDER LONG WORD
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endm
******************************************************************************
*									     *
*	 MC68881 FP-REG. TO FP-REG. OPERATION				     *
*									     *
*	 REGREG	  INSTRUCTION,FPM,FPN,FNQ				     *
*									     *
*	 WHERE:	 INSTRUCTION= NUEMONIC FOR THE FP INSTRUCTION (I.E. FADD)    *
*		 FPM= FP SOURCE REGISTER				     *
*		 FPN= FP DESTINATION REGISTER				     *
*		 FNQ= SECOND FP DESTINATION REGISTER FOR FSINCOS	     *
*									     *
*	 NO REGISTERS MODIFIED OR DESTROYED!				     *
*									     *
******************************************************************************
	 macro	 REGREG
	 if \1 = 'FSINCOS'		;IF INSTR. IS FSINCOS DO THIS ROUTINE
	 MOVE.W #(\2<<10)+(\4<<7)+\3+\1,MC68881+COMMAND	 ;REG. TO REG. FSINCOS
.NULCA\@: TST.B MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BMI.S .NULCA\@			;REREAD UNTIL NULL RELEASE (CA=0)
	 else				;ROUTINE FOR ALL OTHER ARITHMETIC INSTRS.
	 MOVE.W #(\2<<10)+(\3<<7)+\1,MC68881+COMMAND	;REG. TO REG. OPERATION
.NULCA\@: TST.B MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BMI.S .NULCA\@			;REREAD UNTIL NULL RELEASE (CA=0)
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 CONSTANT IN ROM TO FP-REG. OPERATION			     *
*									     *
*	 FMOVEROM  CC,FPN						     *
*									     *
*	 WHERE:	    CC = MC68881 CONSTANT				     *
*		   $00	     PI						     *
*		   $0B	     LOG10(2)					     *
*		   $0C	     E						     *
*		   $0D	     LOG2(E)					     *
*		   $0E	     LOG10(E)					     *
*		   $0F	     0.0					     *
*		   $30	     LOGN(2)					     *
*		   $31	     LOGN(10)					     *
*		   $32	     10^0					     *
*		   $33	     10^1					     *
*		   $34	     10^2					     *
*		   $35	     10^4					     *
*		   $36	     10^8					     *
*		   $37	     10^16					     *
*		   $38	     10^32					     *
*		   $39	     10^64					     *
*		   $3A	     10^128					     *
*		   $3B	     10^256					     *
*		   $3C	     10^512					     *
*		   $3D	     10^1024					     *
*		   $3E	     10^2048					     *
*		   $3F	     10^4096					     *
*		 FPN= FP DESTINATION REGISTER				     *
*									     *
*	 NO REGISTERS MODIFIED OR DESTROYED!				     *
*									     *
******************************************************************************
	 macro	 FMOVEROM
	 MOVE.W #$5C00+(\2<<7)+\1,MC68881+COMMAND  ;REG. TO REG. OPERATION
.NULCA\@: TST.B MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BMI.S .NULCA\@			;REREAD UNTIL NULL RELEASE (CA=0)
	 endm
*******************************************************************************
*									      *
*	 MC68881 CONDITIONAL BRANCH					      *
*									      *
*	 FBCC.<SIZE> CONDITION,ADDRESS					      *
*									      *
*	 WHERE:	 <SIZE>= ALLOWABLE BRANCH SIZES				      *
*		 CONDITION= CC, THE FLOATING POINT CONDITION (I.E. GT)	      *
*		 ADDRESS= BRANCH ADDRESS				      *
*									      *
*									      *
*	 REGISTERS MODIFIED OR DESTROYED: 0 1 2 3 4 5 6 7		      *
*					D X				      *
*					A				      *
*									      *
*******************************************************************************
	 macro	 FBCC
	 MOVE.W #\1,MC68881+COND	;BEGIN COPROCESSOR COMMUNICATION
.NOPASS\@: MOVE.W MC68881+RESPONSE,D0	;IS CA-BIT SET
	 BMI.S .NOPASS\@		;REREAD UNTIL NULL RELEASE (CA=0)
	 BTST #TFBIT,D0			;IS CONDITION TRUE
	 BNE\! \2			;BRANCH IF CONDITION TRUE!
	 endm
*******************************************************************************
*									      *
*	 MC68881 TEST FP CONDITION, DECREMENT, AND BRANCH		      *
*									      *
*	 FDBCC	 CONDITION,DN,ADDRESS					      *
*									      *
*	 WHERE:	 CONDITION= CC, FLOATING POINT CONDITION		      *
*		 DN= MAIN PROCESSOR DATA REGISTER TO BE DECREMENTED	      *
*		 ADDRESS= BRANCH ADDRESS				      *
*									      *
*	 REGISTERS MODIFIED OR DESTROYED: 0 1 2 3 4 5 6 7		      *
*					D X				      *
*					A				      *
*									      *
*******************************************************************************
	 macro	 FDBCC
	 MOVE.W #\1,MC68881+COND	;BEGIN COPROCESSOR COMMUNICATION
.NOPASS\@: MOVE.W MC68881+RESPONSE,D0	;IS CA-BIT SET
	 BMI.S .NOPASS\@		;REREAD UNTIL NULL RELEASE (CA=0)
	 BTST #TFBIT,D0			;IS CONDITION TRUE
	 DBNE \2,\3			;SUBTRACT 1 FROM COUNTER UNTIL COUNTER
					;EQUALS -1
	 endm
*******************************************************************************
*									      *
*	 MC68881 CONDITIONAL SET					      *
*									      *
*	 FSCC CONDITION,ADDRESS						      *
*									      *
*	 WHERE:	 CONDITION= CC, FLOATING POINT CONDITION		      *
*		 ADDRESS= BRANCH ADDRESS				      *
*									      *
*	 REGISTERS MODIFIED OR DESTROYED: 0 1 2 3 4 5 6 7		      *
*					D X				      *
*					A				      *
*									      *
*******************************************************************************
	 macro	FSCC
	 MOVE.W #\1,MC68881+COND	;BEGIN COPROCESSOR COMMUNICATION
.NOPASS\@: MOVE.W MC68881+RESPONSE,D0	;IS CA-BIT SET
	 BMI.S .NOPASS\@		;REREAD UNTIL NULL RELEASE (CA=0)
	 BTST #TFBIT,D0			;IS CONDITION TRUE
	 SNE \2				;SET BYTE AT POINTER(\2) TO 1'S IF
					;CONDITION TRUE, IF CONDITION FALSE
					;SET BYTE TO 0'S
	 endm
******************************************************************************
*									     *
*	 MC68881 FP MOVE MULTIPLE COPROCESSOR REGISTERS TO MEMORY	     *
*									     *
*	 FMOVEMRM FPR0,FPR1,FPR2,FPR3,FPR4,FPR5,FPR6,FPR7,<EA>,PREDECREMENT  *
*									     *
*	 WHERE:	 FPR0=(FP REG.#0)    1 IF SELECTED, 0 IF NOT		     *
*		 FPR1=(	  "   #1)    "		    "			     *
*		 FPR2=(	  "   #2)    "		    "			     *
*		 FPR3=(	  "   #3)    "		    "			     *
*		 FPR4=(	  "   #4)    "		    "			     *
*		 FPR5=(	  "   #5)    "		    "			     *
*		 FPR6=(	  "   #6)    "		    "			     *
*		 FPR7=(	  "   #7)    "		    "			     *
*		 <EA>= DESTINATION ADDRESSING MODE			     *
*		 PREDECREMENT=	Y (IF PREDECREMENT MODE IS BEING USED), OR   *
*				N (IF OTHER MODE IS BEING USED).	     *
*									     *
*	  REGISTERS MODIFIED OR DESTROYED: 0 1 2 3 4 5 6 7		     *
*					A  X				     *
*					D  X X X X			     *
*									     *
*	 VALID ADDRESSING MODES:  AN, -(AN), D(AN), D(AN,IX)		     *
*				  XXX.W, XXX.L				     *
*									     *
******************************************************************************
	 macro	 FMOVEMRM
	 if \0 = 'Y'			;IS THE ADDRESSING MODE PREDECREMEN
*
*  THIS CODE IS FOR PREDECREMENT ADDRESSING MODE
*
	 MOVE.W #$E000+%\8\7\6\5\4\3\2\1,MC68881+COMMAND    ;FP REGISTER BIT
					;MASK INTO COMMAND REGISTER
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL TRANSFER MULTIPLE REGS.
*
*   THIS CODE CALCULATES THE TOTAL # OF REGISTERS TO BE TRANSFERRED
*
	 MOVEQ #\1+\2+\3+\4+\5+\6+\7+\8-1,D3

	 TST.W MC68881+REGSEL		;READ REGISTER RESPONSE REGISTER
	 MOVE.L MC68881+OPER,A0		;A0=ADDRESS OF THE OPERAND REG.
.AGAIN\@: MOVE.L (A0),D0		;LOAD HIGH ORDER WORDS
	 MOVE.L (A0),D1			;LOAD MID ORDER WORDS
	 MOVE.L (A0),D2			;LOAD LOW ORDER WORDS
	 MOVEM.L D0-D2,\9		;STACK HIGH ORDER WORD IN LOW ORDER
					;MEMORY AND LOW ORDER WORD IN HIGH
					;ORDER MEMORY
	 DBRA D3,.AGAIN\@		;HAVE ALL REGISTERS BEEN TRANSFERRED


.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 if \0 = 'N'			;IS ADDRESSING MODE NOT PREDECREMENT
***************************************************************************
*
*	  THIS CODE IS FOR ALL VALID ADDRESSING MODES OTHER
*	  THAN PREDECREMENT
*
***************************************************************************
	 MOVE.W #$F000+%\1\2\3\4\5\6\7\8,MC68881+COMMAND    ;CP REGISTER BIT
					;MASK AND START CP COMMUNICATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL TRANSFER MULTIPLE REGS.
	 MOVEQ.L #(\8+\7+\6+\5+\4+\3+\2+\1)*3-1,D0  ;COUNT REG. FOR DBRA STMT.
	 TST.W MC68881+REGSEL		;READ REGISTER RESPONSE REGISTER
	 LEA \9,A0			;SET UP A MEMORY POINTER
.AGAIN\@: MOVE.L MC68881+OPER,(A0)+	;LOAD DATA ON TO THE STACK
	 DBRA D0,.AGAIN\@		;LOOP UNTIL ALL DATA IS LOADED
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 FP MOVE TO MULTIPLE COPROCESSOR REGISTERS FROM MEMORY	     *
*									     *
*	 FMOVEMMR <EA>,FPR0,FPR1,FPR2,FPR3,FPR4,FPR5,FPR6,FPR7,POSTINCREMENT *
*									     *
*	 WHERE:	 <EA>= DESTINATION ADDRESSING MODE			     *
*		 FPR0=(FP REG.#0)    1 IF SELECTED, 0 IF NOT		     *
*		 FPR1=(	  "   #1)    "		    "			     *
*		 FPR2=(	  "   #2)    "		    "			     *
*		 FPR3=(	  "   #3)    "		    "			     *
*		 FPR4=(	  "   #4)    "		    "			     *
*		 FPR5=(	  "   #5)    "		    "			     *
*		 FPR6=(	  "   #6)    "		    "			     *
*		 FPR7=(	  "   #7)    "		    "			     *
*		 POSTINCREMENT= Y (IF POST-INCREMENT MODE IS BEING USED)     *
*				N (IF OTHER VALID MODE IS BEING USED).	     *
*									     *
*	  REGISTERS MODIFIED OR DESTROYED: 0 1 2 3 4 5 6 7		     *
*					A  X				     *
*					D  X				     *
*									     *
*	 VALID ADDRESSING MODES:  AN, (AN)+, D(AN), D(AN,IX)		     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
******************************************************************************
	 macro	 FMOVEMMR
	 MOVE.W #$D000+%\2\3\4\5\6\7\8\9,MC68881+COMMAND  ;CP REGISTER BIT
					;MASK AND START CP COMMUNICATION
.NULCA\@: CMPI #$8900,MC68881+RESPONSE	;READ RESPONSE REGISTER
	 BEQ.S .NULCA\@			;REREAD UNTIL TRANSFER MULTIPLE REGS.
	 MOVEQ.L #(\9+\8+\7+\6+\5+\4+\3+\2)*3-1,D0  ;DECREMENT REG. FOR DBRA
	 TST.W MC68881+REGSEL		;READ REGISTER RESPONSE REGISTER
	 if \0 = 'N'			;IS ADDRESSING MODE NOT POSTINCREMENT
	 LEA \1,A0			;SET UP A MEMORY POINTER
.AGAIN\@: MOVE.L (A0)+,MC68881+OPER	;LOAD DATA ON TO THE STACK
	 DBRA D0,.AGAIN\@		;LOOP UNTIL ALL DATA IS LOADED
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 if \0 = 'Y'			;IS ADDRESSING MODE POSTINCREMENT
.AGAIN\@: MOVE.L \1,MC68881+OPER	;LOAD DATA ON TO THE STACK
	 DBRA D0,.AGAIN\@		;LOOP UNTIL ALL DATA IS LOADED
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 FP MOVE TO CONTROL, STATUS,OR INSTRUCTION ADDRESS REGISTER  *
*									     *
*	 MOVINCSI <EA>,REGISTER						     *
*									     *
*	 WHERE:	  <EA>= VALID SOURCE ADDRESSING MODE			     *
*		  REGISTER= CONTROL,STATUS, OR IADDRESS			     *
*									     *
*	 NO REGISTERS MODIFIED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  DN, AN, (AN)+, -(AN), D(AN), D(AN,IX)	     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
******************************************************************************
	 macro	 MOVINCSI
	 if !\?3			;IS ADDR.MODE INDEXED?
	 MOVE.W #\2,MC68881+COMMAND	;MOVE BIT PATTERN IN COMMAND REG.
.NULCA\@: CMPI.W #$8900,MC68881+RESPONSE  ;IS RESPONSE NULL COME AGAIN?
	 BEQ.S .NULCA\@			;COME AGAIN UNTIL NEW RESPONSE
	 MOVE.L \1,MC68881+OPER		;PASS DATA TO REGISTER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS ADDRESS MODE INDEXED?
	 MOVE.W #\3,MC68881+COMMAND	;MOVE BIT PATTERN IN COMMAND REG.
.NULCA\@: CMPI.W #$8900,MC68881+RESPONSE  ;IS RESPONS NULL COME AGAIN?
	 BEQ.S .NULCA\@			;COME AGAIN UNTIL NEW RESPONSE
	 MOVE.L \1,\2,MC68881+OPER	;PASS DATA TO REGISTER FROM INDEXED ADDR.
					;MODE
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 FP MOVE FROM CONTROL/STATUS/INSTRUCTION ADDRESS REGISTER    *
*									     *
*	 MOVOUCSI REGISTER,<EA>						     *
*									     *
*	 WHERE:	  REGISTER= CONTROL,STATUS, OR IADDRESS			     *
*		  <EA>= VALID SOURCE ADDRESSING MODE			     *
*									     *
*	 NO REGISTERS MODIFIED OR DESTROYED!				     *
*									     *
*	 VALID ADDRESSING MODES:  DN, AN, (AN)+, -(AN), D(AN), D(AN,IX)	     *
*				  XXX.W, XXX.L, (D,PC), D(PC,IX)	     *
*									     *
******************************************************************************
	 macro	 MOVOUCSI
	 if !\?3			;IS ADDR.MODE INDEXED?
	 MOVE.W #\1+$2000,MC68881+COMMAND  ;MOVE BIT PATTERN TO COMMAND REG.
.NULCA\@: CMPI.W #$8900,MC68881+RESPONSE   ;IS RESPONSE NULL COME AGAIN?
	 BEQ.S .NULCA\@			;COME AGAIN UNTIL NEW RESPONSE
	 MOVE.L MC68881+OPER,\2		;PASS DATA TO REGISTER
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 else				;IS ADDR.MODE INDEXED?
	 MOVE.W #\1+$2000,MC68881+COMMAND  ;MOVE BIT PATTERN TO COMMAND REG.
.NULCA\@: CMPI.W #$8900,MC68881+RESPONSE   ;IS RESPONSE NULL COME AGAIN?
	 BEQ.S .NULCA\@			;COME AGAIN UNTIL NEW RESPONSE
	 MOVE.L MC68881+OPER,\2,\3	;PASS DATA TO REGISTER FROM INDEXED A
					;MODE
.NULREL\@: TST.B MC68881+RESPONSE	;IS RESPONSE NULL RELEASE?
	 BMI.S .NULREL\@		;BRANCH UNTIL NULL RELEASE
	 endif
	 endm
******************************************************************************
*									     *
*	 MC68881 FSAVE THE INTERNAL OF THE MACHINE			     *
*									     *
*	 THIS IS A PRIVILEDGED INSTRUCTION WHICH IS GENERALLY ONLY USED	     *
*	 IN THE OPERATING SYSTEM FOR CONTEXT SWITCHING!			     *
*									     *
*	 FSAVEST <EA>							     *
*									     *
*	 WHERE:	 <EA>= PREDECREMENT MODE   -(AN)			     *
*									     *
*	 REGISTERS MODIFIED OR DESTROYED:  0 1 2 3 4 5 6 7		     *
*					 A X				     *
*					 D X X				     *
*									     *
*	 VALID ADDRESSING MODES:  -(AN)					     *
*									     *
******************************************************************************
	 macro	 FSAVEST
.START\@: MOVE.W MC68881+SAVE,D0	;READ THE SAVE REGISTER
	 MOVE.W D0,D1			;MAKE A COPY OF THE FORMAT WORD
	 ANDI.W #$FF00,D1		;ISOLATE THE FORMAT WORD
	 BEQ.S .NULL\@			;IF NULL IDLE, NO STATE SAVE
	 CMPI.W #$0100,D1		;IS THE COPROCESSOR BUSY
	 BEQ.S .START\@			;KEEP CHECKING UNTIL CP IS FINISHED
					;PROCESSING
	 LEA MC68881+OPER,A0		;LOAD OPERAND REGISTER TO A0

	 MOVE.B D0,D1			;THE LENGTH OF THE DATA TO BE TRANSFERED
	 LSR.B #2,D1			;DIVIDE BY 2 TO ADJUST FOR WORD TRANSFER
	 EXT.W D1			;ESTABLISH COUNT AS A WORD FOR DBRA
	 SUBQ.W #1,D1			;D1= COUNTER FOR DBRA
.LOAD\@: MOVE.L (A0),\1			;STORE THE INVISBLE STATE
	 DBRA D1,.LOAD\@		;REPEAT UNTIL ALL DATA IS TRANSFERRED
.NULL\@: SWAP D0			;PLACE FORMAT WORD IN UPPER 16 BITS OF D0
	 MOVE.L D0,\1			;STORE FORMAT WORD ON THE STACK
	 endm
******************************************************************************
*									     *
*	 MC68881 FRESTORE OF THE INTERNAL OF THE MACHINE		     *
*									     *
*	 THIS IS A PRIVILEDGED INSTRUCTION WHICH IS GENERALLY ONLY USED	     *
*	 IN THE OPERATING SYSTEM FOR CONTEXT SWITCHING!			     *
*									     *
*	 FRESTRST <EA>							     *
*									     *
*	 WHERE:	 <EA>= POSTINCREMENT MODE    (AN)+			     *
*									     *
*	 REGISTERS MODIFIED OR DESTROYED:  0 1 2 3 4 5 6 7		     *
*					 A X				     *
*					 D X X				     *
*									     *
*	 VALID ADDRESSING MODES:  (AN)+					     *
*									     *
******************************************************************************
	 macro	 FRESTRST
	 MOVE.L \1,D0			;MOVE FORMAT WORD AND RESERVED WORD TO D0
	 SWAP D0			;PLACE FORMAT WORD AS THE LOW ORDER
	 MOVE.W D0,MC68881+RESTORE	;STORE FORMAT WORD IN RESTORE REG.
	 MOVE.W MC68881+RESTORE,D0	;READ THE RESTORE REGISTER
	 MOVE.W D0,D1			;MAKE A COPY OF THE RESPONSE FORMAT WORD
	 ANDI.W #$FF00,D1		;ISOLATE THE FORMAT WORD
	 BEQ.S .NULREL\@		;IF NULL IDLE RESPONSE, NO STATE RESTORED
	 LEA MC68881+OPER,A0		;LOAD OPERAND REGISTER TO A0

	 MOVE.B D0,D1			;THE LENGTH OF THE DATA TO BE TRANSFERED
	 LSR.B #2,D1			;DIVIDE BY 2 TO ADJUST FOR WORD TRANSFER
	 EXT.W D1			;ESTABLISH COUNT AS A WORD FOR DBRA
	 SUBQ.W #1,D1			;D1= COUNTER FOR DBRA
.LOAD\@: MOVE.L \1,(A0)			;STORE THE INVISBLE STATE
	 DBRA D1 .LOAD\@		;REPEAT UNTIL ALL DATA IS TRANSFERRED
.NULREL\@: EQU *
	 endm
******************************************************************************
*									     *
*	 MC68881 FNOPP COMMAND						     *
*									     *
*	 FNOP								     *
*									     *
*	 NO REGISTERS MODIFIED OR DESTROYED!				     *
*									     *
******************************************************************************
	 macro	 FNOPP
	 MOVE.W #$0000,MC68881+COND	;FNOP COMMAND TO FP REG.
.NOPAS\@: TST.B MC68881+RESPONSE	;TEST RESPONSE
	 BMI.S .NOPAS\@
	 endm 


*
*  Just hack in my program here for now ...
*

    section .text                     ; This is normal code

kmain::
    lea.l   HELLO,A0                  ; Get the address of the message
    move.l  A0,-(A7)                  ; Push it on the stack
    jsr     mcPrintln                 ; Call mcPrintln (from the machine lib)

	; the exciting part ..
    FMOVEROM $00,FP0                  ; move PI const to FP0
    REGMEMW  FMOVE,FP0,D0             ; convert to short integer

    move.l  D0,D1                     ; number to print
    moveq.l #15,D0
    move.b  #10,D2                    ; base 10
    trap    #15

    lea.l   GOODBYE,A0                  ; Get the address of the message
    move.l  A0,-(A7)                  ; Push it on the stack
    jsr     mcPrintln                 ; Call mcPrintln (from the machine lib)

    addq.l  #4,A7                     ; Clean up the stack (important!)
    rts                               ; And return

                                      ; At this point, the machine will reboot.
                                      ; Don't return from kmain if you don't want
                                      ; to reboot the machine!

HELLO   dc.b    "PI as an int is 3.  The FPU says:", 0 ; Our message 
GOODBYE dc.b    "Pretty exciting stuff!", 0 ; Our message 

* FC2 ignore
* FC1 and FC0
* A10-A23
* matches FFFC00