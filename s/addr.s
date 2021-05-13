primes	dcd		1, 2,3,5,7
		;Offset-------------------------------------
		ldr		r0, =primes
		mov		r1, #0
loop
		ldr		r2, [r0, r1]
		add		r1, r1, #4
		cmp		r1, #20
		bne		loop
		;Post-index-------------------------------------
		mov		r1, #4
loop_pos
		ldr		r2, [r0], r1
		cmp		r0, #0x114
		bne		loop_pos
		;Pre-index-------------------------------------
		ldr		r0, =primes
		;sub		r0, r0, #4 ; BUG?
loop_pre
		ldr		r2, [r0, r1]!
		cmp		r0, #0x110
		bne		loop_pre
		add		r0, r0, #4
