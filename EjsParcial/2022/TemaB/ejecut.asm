EXTERN promedio
GLOBAL _start

section .text
_start:
    push ebp
    mov ebp,esp
    mov eax, ebp
    add eax, 8
    push eax
    mov eax, [ebp+4]
    push eax
    call promedio
    mov esp,ebp
    pop ebp
    mov eax,1
    int 80h
    