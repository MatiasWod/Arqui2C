GLOBAL _start
EXTERN numToString
EXTERN printNewLine
EXTERN print

_start:
    mov eax,10 ;n
    mov ebx,6;k
    call ciclo
    ;si popeo aca da seg fault
    mov eax,1
    mov ebx,0
    int 80h



ciclo:
    push eax
    push ebx
    inc ecx
    cmp ecx,ebx
    jg fin
    div ecx
    cmp edx,0
    jne next
    mov eax,ecx
    mov ebx,cadena
    call numToString
    call print
    call printNewLine
    jmp next

next:
    pop ebx
    pop eax 
    jmp ciclo

fin:
    pop ebx
    pop eax
    ret

section .data 
    cadena db 10, 0 
section .bss
    placeholder resb 10;me guardo 10 bytes con el nombre placeholder