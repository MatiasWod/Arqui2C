GLOBAL _start

section .text
_start:
    mov ecx,texto
    mov edx,longitud
    mov ebx,ecx ;puntero al puntero al string
    call ciclo
    mov ebx,1
    mov eax,4
    int 80h
    mov ebx,0
    mov eax,1
    int 80h

ciclo:
    mov ah,[ebx]
    cmp ah,0
    jz end
    cmp ah,'a'
    jl next
    cmp ah,'z'
    jg next
    sub ah,32d
    mov [ebx],ah
next:
    inc ebx ;avanzo con ebx porque si uso ecx voy avanzando en las direcciones de memoria y pierdo el string
    jmp ciclo
end:
    ret

section .data
 texto db "h4ppy c0d1ng",10
 longitud equ $-texto
 
section .bss
 placeholder resb 10;me guardo 10 bytes con el nombre placeholder