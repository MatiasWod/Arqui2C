GLOBAL seven

section .text

seven:
    push ebp
    mov ebp,esp
    mov eax,7
    mov esp,ebp
    pop ebp
    ret