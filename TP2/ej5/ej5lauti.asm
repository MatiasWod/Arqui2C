section .text

GLOBAL _start
EXTERN print
EXTERN exit
EXTERN to_string

_start:

    ; Dado un número n y un valor k, imprimir todos los valores múltiplos de n desde 1 hasta k 
    mov eax, 1;
    mov ecx, 2 ; pongo la n en cl
    mov edx, 10 ; pongo la k en dl
    mov ebx, cadena ; pongo en ebx la direccion de la cadena


_cycle:
    cmp eax, edx 
    jg _end
    push eax    ;;como me queda el orden cuando pusheo todo cual registro queda en tope? 
    push edx
    mov edx, 0
    div ecx ; divido eax por ecx, deja el resto en edx
    cmp edx, 0
    pop edx         ;;que es lo que vuelve aca ?el valor de verdad de edx
    pop eax 
    jnz _notprint
    call to_string
    call print
_notprint:
    inc eax
    jmp _cycle

_end:
    call exit


section .data
cadena db "a", 10, 0

section .bss
    placeholder resb 10