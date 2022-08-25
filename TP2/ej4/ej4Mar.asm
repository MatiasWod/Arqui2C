section .text
GLOBAL _start
EXTERN to_string
EXTERN print
_start:
    mov ecx, 10
    call suma
    mov ebx, placeholder
    mov ecx, ebx
    call to_string
    call print
    mov eax, 1
    mov ebx, 0
    int 80h
suma:
    push ecx
    pushf
    mov eax, 0
.inicio:
    cmp ecx, 0
    je .fin
    add eax, ecx
    dec ecx
    jmp .inicio
.fin:    
    popf
    pop ecx
    ret

section .bss
    placeholder resb 128