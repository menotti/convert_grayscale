.data
color:	.word	0x171313, 0x171313, 0x171313, 0x171313, 0x171313, 0x171313, 0x171313, 0x171313
buffer:	.space	 32
grays:	.word	0x141414, 0x141414, 0x141414, 0x141414, 0x141414, 0x141414, 0x141414, 0x141414
.text
	la	s0, color
	la	s1, buffer
	la	s2, grays
loopc:
	lw	a0, (s0)
	addi 	s0, s0, 4	
	# complete o código aqui...
	jal	ra, convert

	
	sw	a0, (s1)
	addi 	s1, s1, 4
	bne	s1, s2, loopc

verify:
	lw	t0, (s0)
	addi 	s0, s0, 4	
	lw	t1, (s1)
	addi 	s1, s1, 4	
	bne	t0, t1, error
	bne	s0, s2, verify
                
ok:	li	a7, 10
	ecall

error:	li	a7, 93
	li	a0, 0x42
	ecall
	
convert:
	srli    a1, a0, 16
        andi    a1, a1, 255
        srli    a2, a0, 7
        andi    a2, a2, 510
        andi    a0, a0, 255
        add     a0, a0, a2
        add     a0, a0, a1
        srli    a0, a0, 2
        slli    a1, a0, 8
        or      a1, a1, a0
        slli    a0, a0, 16
        or      a0, a0, a1
        ret