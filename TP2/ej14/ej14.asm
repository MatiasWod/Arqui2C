section .text
GLOBAL _start
EXTERN print
EXTERN exit

_start:
    mov eax,0x02 ; id de fork
    int 80h
    cmp eax,0 
    je hijo ; si da 0 es el hijo
    jg padre ; si da mas grande es el padre
    mov ebx,errormessage
    call print
    jmp fin
    
padre:
    mov ebx,padremessage
    call print
    jmp fin

hijo:
    mov ebx,hijomessage
    call print
    jmp fin

fin:
    call exit

section .data
    padremessage db "Soy el padre", 10
    hijomessage db "Soy el hijo", 10
    errormessage db "Error xd",10

section .bss
    pepe resb 16