GLOBAL _start

section .text
_start:
    mov ecx,texto ;puntero a la cadena
    mov edx,longitud ;largo de cadena
    mov ebx,1 ;file descriptor
    mov eax,4 ;ID de WRITE
    int 80h
exit:
    mov eax,1 ;ID EXIT
    mov ebx,0 ;Valor de retorno
    int 80h


section .data
 texto db "Hola Mundo!",10
 longitud equ $-texto
 
section .bss
 placeholder resb 10;me guardo 10 bytes con el nombre placeholder