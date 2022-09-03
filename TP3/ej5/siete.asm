GLOBAL siete

section .text
siete:
    push ebp
    mov ebx,esp

    mov eax,7
    mov [ebp-4],eax
    mov eax,[ebp-4]
    
    mov esp,ebp
    pop ebp
    ret