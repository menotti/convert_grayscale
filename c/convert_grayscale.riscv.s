convert_grayscale:                      # @convert_grayscale
        sgtz    a3, a1
        sgtz    a4, a0
        and     a3, a3, a4
        beqz    a3, .LBB0_5
        mv      a7, zero
        addi    t0, a2, 2
        slli    a4, a0, 1
        add     a6, a4, a0
.LBB0_2:                                # =>This Loop Header: Depth=1
        mv      a5, t0
        mv      a4, a0
.LBB0_3:                                #   Parent Loop BB0_2 Depth=1
        lbu     a3, -1(a5)
        lbu     a2, -2(a5)
        lbu     t1, 0(a5)
        slli    a3, a3, 1
        add     a2, a2, a3
        add     a2, a2, t1
        srli    a2, a2, 2
        sb      a2, -2(a5)
        sb      a2, -1(a5)
        sb      a2, 0(a5)
        addi    a4, a4, -1
        addi    a5, a5, 3
        bnez    a4, .LBB0_3
        addi    a7, a7, 1
        add     t0, t0, a6
        bne     a7, a1, .LBB0_2
.LBB0_5:
        ret
