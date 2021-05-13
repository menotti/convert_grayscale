convert_grayscale:
        push    {r4, r5, r6, r7, r11, lr}
        cmp     r1, #1
        cmpge   r0, #1
        blt     .LBB0_5
        add     r12, r0, r0, lsl #1
        add     lr, r2, #2
        mov     r3, #0
.LBB0_2:                                @ =>This Loop Header: Depth=1
        mov     r2, lr
        mov     r4, r0
.LBB0_3:                                @   Parent Loop BB0_2 Depth=1
        ldrb    r5, [r2, #-2]
        ldrb    r6, [r2, #-1]
        ldrb    r7, [r2]
        subs    r4, r4, #1
        add     r5, r5, r6, lsl #1
        add     r5, r5, r7
        lsr     r5, r5, #2
        strb    r5, [r2]
        strb    r5, [r2, #-1]
        strb    r5, [r2, #-2]
        add     r2, r2, #3
        bne     .LBB0_3
        add     r3, r3, #1
        add     lr, lr, r12
        cmp     r3, r1
        bne     .LBB0_2
.LBB0_5:
        pop     {r4, r5, r6, r7, r11, lr}
        bx      lr
