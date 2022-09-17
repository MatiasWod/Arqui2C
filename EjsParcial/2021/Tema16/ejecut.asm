EXTERN main
GLOBAL _start

section .text
_start:
    push ebp
    mov ebp,esp
    push dword [ebp+8]
    push dword [ebp+4]
    call main
    mov esp,ebp
    pop ebp
    mov eax,1
    int 80h