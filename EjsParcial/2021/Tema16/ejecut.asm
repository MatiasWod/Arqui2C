EXTERN main
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
    call main
    mov esp,ebp
    pop ebp
    mov eax,1
    int 80h

    sys_write:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, syscall_write
    mov ebx, [ebp + 8] ; fd
    mov ecx, [ebp + 12] ; buffer
    mov edx, [ebp + 16] ; count/length
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret