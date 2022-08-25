GLOBAL _start
EXTERN print
EXTERN numtostr

section .text

_start:
    
    mov ecx,11
    mov eax,0
    call ciclo
    push placeholder
    push eax
    call numtostr
    mov ebx,esp
    call print
    mov ebx,0
    mov eax,1
    int 80h

ciclo:
    cmp ecx,0
    je fin
    add eax,ecx
    dec ecx
    jmp ciclo
fin:
    ret

section .bss
 placeholder resb 10;me guardo 10 bytes con el nombre placeholder