GLOBAL _start
EXTERN numToString
EXTERN print


section .text
_start:
    mov eax,2;n
    mov ebx,eax
    mov ecx,1
    call ciclo
    mov ebx,placeholder
    call numToString
    call print
    mov eax,1
    mov ebx,0
    int 80h


ciclo:
    cmp ebx,0
    je fin2
    cmp ecx,ebx
    je fin
    mul ecx
    inc ecx
    jmp ciclo

fin:
    ret
fin2:
    inc eax
    ret

    
section .bss
    placeholder resb 10