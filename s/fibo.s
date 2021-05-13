fibo		dcd	0, 1			; words
save		fill		256			; bytes (aligned)
endm		dcd	0xCAFEBABE, 0xDEADFA11, 0xFEEDC0DE
		ldr		r0, =fibo	; load address
		mov		r1, #4		; set address increment
		ldr		r2, [r0], r1	; post-index
		ldr		r3, [r0], r1
loop
		adds		r4, r3, r2	; set flags
		mov		r2, r3
		mov		r3, r4
		strvc		r4, [r0], r1	; condition: overflow clear
		bvc		loop
		end
