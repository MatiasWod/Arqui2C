section .text
GLOBAL _start
EXTERN exit
EXTERN print
EXTERN toUpper

_start:
    push ebp
    mov ebp, esp

    mov eax, 3 ;sys call read
    mov ebx, 0 ;fd 0
    mov ecx, placeholder ;espacio para la string
    mov edx, 16 ;maximo de longitud 16
    int 80h 

    mov ebx,placeholder
    call toUpper ;(toUpper recibe en eax la longitud)
    call print
    mov esp, ebp
    pop ebp
    call exit

section .bss
    placeholder resb 16