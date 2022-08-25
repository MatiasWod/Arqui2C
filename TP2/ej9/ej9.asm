GLOBAL _start
EXTERN numToString
EXTERN print


section .text
_start:
    push ebp
    mov ebp,esp
    mov eax,[ebp+4]
    dec eax
    mov ebx,placeholder
    call numToString
    call print
    mov esp,ebp
    pop ebp
    mov eax,1
    mov ebx,0
    int 80h


section .bss
    placeholder resb 10