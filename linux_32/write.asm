section .text
   global _start         ; precisa ser declarado para o gcc

_start:                  ; informa o linker sobre o procedimento de entrada
   ; cria o arquivo
   mov eax, 8            ; chamada de sistema (sys_creat)
   mov ebx, file_name    ; nome do arquivo
   mov ecx, 664o         ; leitura e escrita para usuario e grupo, somente leitura para os demais (sufixo 'o' para base octal)
   int 0x80              ; interrupcao
   mov [fd_out], eax     ; salva o descritor do arquivo que retornou
    
   ; escreve no arquivo
   mov eax, 4            ; chamada de sistema (sys_write)
   mov ebx, [fd_out]     ; descritor do arquivo
   mov ecx, msg          ; conteudo a ser escrito
   mov edx, len          ; numero de bytes
   int 0x80

   ; fecha o arquivo
   mov eax, 6            ; chamada de sistema (sys_close)
   mov ebx, [fd_out]     ; descritor do arquivo
   int 0x80

   ; imprime mensagem indicando escrita do arquivo
   mov eax, 4            ; chamada de sistema (sys_write)
   mov ebx, 1            ; descritor (saida padrao)
   mov ecx, msg_done     ; conteudo a ser escrito
   mov edx, len_done     ; numero de bytes
   int  0x80
    
   ; abre arquivo para leitura
   mov eax, 5            ; chamada de sistema (sys_open)
   mov ebx, file_name    ; nome do arquivo
   mov ecx, 0            ; apenas para leitura
   mov edx, 664o         ; leitura e escrita para usuario e grupo, somente leitura para os demais (sufixo 'o' para base octal)
   int  0x80
   mov  [fd_in], eax     ; salva o descrito do arquivo que retornou
    
   ; le do arquivo
   mov eax, 3            ; chamada de sistema (sys_read)
   mov ebx, [fd_in]      ; descritor do arquivo
   mov ecx, info         ; buffer que recebe os dados lidos
   mov edx, len          ; numero de bytes
   int 0x80
    
   ; fecha o arquivo
   mov eax, 6            ; chamada de sistema (sys_close)
   mov ebx, [fd_in]      ; descritor do arquivo
   int 0x80

   ; imprime a informacao lida
   mov eax, 4            ; chamada de sistema (sys_write)
   mov ebx, 1            ; descritor (saida padrao)
   mov ecx, info         ; conteudo a ser escrito
   mov edx, len          ; numero de bytes
   int 0x80

   ; imprime mensagem de debug
   mov eax, 4            ; chamada de sistema (sys_write)
   mov ebx, 1            ; descritor (saida padrao)
   mov ecx, msg_debug    ; conteudo a ser escrito
   mov edx, len_debug    ; numero de bytes
   int  0x80
    
   ; encerra o programa
   mov eax, 1            ; chamada de sistema (sys_exit)
   mov ebx, 0
   int 0x80

section .data
file_name db 'myfile.txt', 0x0
msg db 'Welcome to Tutorials Point (corrected)!', 0xa
len equ $-msg

msg_done db 'Written to file', 0xa
len_done equ $-msg_done

msg_debug db 'Debug...', 0xa
len_debug equ $-msg_debug

section .bss
fd_out resb  1
fd_in  resb  1
info   resb  len

