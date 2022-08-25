GLOBAL _start
EXTERN print
EXTERN numToString
_start:
    mov eax,14
    int 80h
    mov ebx,placeholder
    call numToString
    call print
    mov eax,1
    int 80h

section .bss
    placeholder resb 10