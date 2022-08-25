GLOBAL _start
EXTERN numToString
EXTERN print


section .text

_start:
    mov eax,array
    mov ecx,[eax] 
    mov ebx,dim
    call ciclo
    mov ebx,placeholder
    mov eax,ecx
    call numToString
    call print
    mov eax,1
    mov ebx,0
    int 80h

ciclo:
    cmp ebx,0
    je fin
    cmp [eax],ecx
    jl newMin
next:
    dec ebx
    add eax,4
    jmp ciclo
newMin:
    mov ecx,[eax]
    jmp next
fin:
    ret

section .data
    array dd 1,5,7,6,8,13 ;dd es define DoubleWord
    dim equ ($-array)/4 ;divido por 4 porque cada int pesa 4bytes

section .bss
    placeholder resb 10