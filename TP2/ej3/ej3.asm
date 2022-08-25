section .text

GLOBAL _start
EXTERN print

_start:
    mov ebx, 10
    mov eax, placeholder
    call tonum
    mov ebx, eax
    call print
    mov eax, 1 
    mov ebx, 0
    int 80h	 ;exit

    ;eax deja el string
tonum:
    push ebp
    mov ebp, esp
    mov byte [ebp-4], 0 ;contador
    mov [ebp-8], eax ; placeholder
    mov eax, ebx ;dividendo
    mov ecx, 10 ;divisor
.ciclo:
    inc byte [ebp-4]
    mov edx, 0
    div ecx
    cmp eax, 0
    jne .ciclo


    mov eax, [ebp-8]
    add eax, [ebp-4]
    mov byte [eax], 0
    mov [ebp-8], eax ; posicion del string
    mov [ebp-12], ebx ; dividendo
    mov eax, [ebp-12]

.ciclo2:
    cmp eax, 0
    je .fin

    mov eax, [ebp-8]
    dec eax
    mov [ebp-8], eax

    mov eax, [ebp-12]
    mov edx, 0
    div ecx
    mov [ebp-12], eax ;guardo el resultado de la div

    add edx, '0'
    mov eax, [ebp-8]
    mov byte [eax], dl

    mov eax, [ebp-12]
    jmp .ciclo2

.fin:    
    mov eax, placeholder
    mov esp, ebp
    pop ebp
    ret

section .bss
    placeholder resb 16