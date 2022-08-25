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
    call sort
    mov eax, [vector+12] ;hice a mano la impresion de los 4 numeros para probar
    mov ebx, placeholder
    call number_tostring
    call print
    mov esp, ebp
    pop ebp
    call exit
sort:
    push ebp
    mov ebp, esp
    pushad
    mov ecx, 0 ;ecx = i
    mov edx, [ebp+8] ;edx = &arr[j]
.ciclo:
    inc ecx
    cmp ecx, [ebp+12] ;ebp+12 = dim
    jge .fin
    mov edx, [ebp+8] ;edx se para al principio del vector
    add edx, ecx ;y se mueve ecx-posiciones, lo hago 4 veces porque son numeros de 4 bytes
    add edx, ecx
    add edx, ecx
    add edx, ecx
    mov eax, ecx ;eax = j
.while:
    cmp eax, 0 ;si j<=0
    jle .ciclo
    sub edx, 4
    mov ebx, [edx]
    add edx, 4
    cmp ebx, [edx] ;o si vector[j-1] <= vector[j]
    jle .ciclo ;vuelvo al ciclo "for"
.swap:    
    push DWORD [edx]
    mov [edx], ebx
    sub edx, 4
    pop DWORD [edx]
    sub eax, 1 ;j--
    jmp .while

.fin:
    popad
    mov esp, ebp
    pop ebp
    ret

section .data
    vector dd 11, 13, 8, 15
    dim equ ($-vector)/4

section .bss
    placeholder resb 16