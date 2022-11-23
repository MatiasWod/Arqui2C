global sys_read
global sys_write

section .text
sys_read:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 3
    mov ebx, [ebp + 8] ; fd
    mov ecx, [ebp + 12] ; buffer
    mov edx, [ebp + 16] ; count/length
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

sys_write:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 4
    mov ebx, [ebp + 8] ; fd
    mov ecx, [ebp + 12] ; buffer
    mov edx, [ebp + 16] ; count/length
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret