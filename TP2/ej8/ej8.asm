GLOBAL _start
EXTERN printArray


section .text

_start:
    mov eax,array;array[j-1]
    mov ecx,eax
    add ecx,4 ;array[j] 
    mov ebx,dim
    dec ebx
    call ciclo
    mov ebx,dim
    call printArray
    mov eax,1
    mov ebx,0
    int 80h

ciclo:
    cmp ebx,0
    je fin
    cmp eax,ecx
    jg switch
next:
    dec ebx
    add eax,4
    add ecx,4
    jmp ciclo

switch:
    push eax ;pusheo el valor de eax
    mov eax,ecx ;cambio el contenido
    pop ecx ;meto el valor de eax en donde apunta ebx
    jmp next

fin:
    sub eax,4*(dim-1) ;vuevlo al estado original de eax esta vez ordenado
    ret

section .data
    array dd 1,5,7,6,8,13 ;dd es define DoubleWord (32bits)
    dim equ ($-array)/4 ;divido por 4 porque cada int pesa 4bytes

section .bss
    placeholder resb 10