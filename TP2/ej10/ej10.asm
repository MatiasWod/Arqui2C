GLOBAL _start
EXTERN numToString
EXTERN print
EXTERN printNewLine

section .text
_start:
    push ebp
    mov ebp,esp
    mov eax,[ebp+4]
    mov edx,[ebp+4]
    dec edx
    dec eax
    mov ebx,cadena
    call print
    mov ebx,placeholder
    call numToString
    call print
    call printNewLine
    mov ecx,1
    mov eax,ebp
    add eax,8
    call ciclo
    mov esp,ebp
    pop ebp
    mov eax,1
    mov ebx,0
    int 80h


ciclo:
    cmp edx,0
    je fin
    add eax,4
    mov ebx,cadenaArgs
    call print
    push eax
    mov eax,ecx
    mov ebx,placeholder
    call numToString
    call print
    mov ebx,dosPuntos
    call print
    pop eax
    mov ebx,[eax]
    call print
    inc ecx
    dec edx
    call printNewLine
    jmp ciclo

fin:
    ret

section .data
    cadena db "Cantidad de Argumentos:",0
    cadenaArgs db "Argumento Nro ",0
    dosPuntos db ": "

section .bss
    placeholder resb 10