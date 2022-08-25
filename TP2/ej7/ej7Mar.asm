section .text

GLOBAL _start
EXTERN print
EXTERN number_tostring
EXTERN exit

_start:
    push ebp
    mov ebp, esp
    push dim
    push vector
    call min
    mov ebx, placeholder
    call number_tostring
    call print
    mov esp, ebp
    pop ebp
    call exit

;retorna en eax el minimo
;usa ebx como auxiliar
min:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    mov ebx, [ebp+8] ;vector
    mov ecx, [ebp+12] ;dim
    mov eax, [ebx]
.ciclo:
    dec ecx
    cmp ecx, 0
    je .fin
    add byte ebx, 4
    cmp eax, [ebx]
    jl .ciclo
    mov eax, [ebx]
    jmp .ciclo
.fin:
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
    
section .data
    vector dd 11, 13, 8, 15
    dim equ ($-vector)/4

section .bss
    placeholder resb 16