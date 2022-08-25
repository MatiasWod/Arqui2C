GLOBAL _start
EXTERN print

_start:
    mov ebx,empieza
    call print
    mov eax,0xa2
    mov ebx,delay
    int 80h
    mov ebx,termina
    call print
    mov eax,1
    int 80h

section .data
    empieza db "Se supende",10,0
    termina db "Terminado",10,0
    delay dq 5,5000000000;5 segundos y 500,000,500 nanos segundos (5,5 segundos)
                        ;usamos dq porque timespec es el tipo que toma la syscall y toma 2 q words