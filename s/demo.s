;---------------------------------------------;
; FEATURE DEMONSTRATION FILE v1.0
;---------------------------------------------;
; pointer and memory visualisations
primes	DCD	1,2,3,5,7
LDR		R0,	=primes
LDR		R1,	[R0]
;---------------------------------------------;
; shift operation visualisations
LDR		R0,	=0xBEEF
LSL		R1,	R0,	#4
LSR		R2,	R0,	#8
ASR		R3,	R0,	#15
ROR		R4,	R0,	#16
RRX		R5,	R0
;---------------------------------------------;
; stack visualisation
STMFD	SP!,	{R0-R5}
MOV		R0,	#0
MOV		R1,	#0
MOV		R2,	#0
MOV		R3,	#0
MOV		R4,	#0
MOV		R5,	#0
LDMFD	SP!,	{R0-R5}
;---------------------------------------------;
; branch visualisation
MOV		R0,	#0
countToTen
ADD		R0,	R0,	#1
CMP		R0,	#10
BNE		countToTen
END