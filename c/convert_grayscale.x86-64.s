convert_grayscale:                      # @convert_grayscale
        test    esi, esi
        jle     .LBB0_6
        test    edi, edi
        jle     .LBB0_6
        mov     ecx, edi
        mov     r8d, esi
        add     rdx, 2
        lea     r10, [rcx + 2*rcx]
        xor     r9d, r9d
.LBB0_3:                                # %for.cond1.preheader.us
        xor     edi, edi
.LBB0_4:                                # %for.body4.us
        movzx   eax, byte ptr [rdx + rdi - 2]
        movzx   esi, byte ptr [rdx + rdi - 1]
        movzx   ecx, byte ptr [rdx + rdi]
        lea     eax, [rax + 2*rsi]
        add     eax, ecx
        shr     eax, 2
        mov     byte ptr [rdx + rdi - 2], al
        mov     byte ptr [rdx + rdi - 1], al
        mov     byte ptr [rdx + rdi], al
        add     rdi, 3
        cmp     r10, rdi
        jne     .LBB0_4
        add     r9, 1
        add     rdx, r10
        cmp     r9, r8
        jne     .LBB0_3
.LBB0_6:                                # %for.cond.cleanup
        ret
