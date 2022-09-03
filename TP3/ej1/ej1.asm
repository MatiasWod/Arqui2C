GLOBAL main
EXTERN printf

section .rodata
    fmt db "Cantidad de argumentos: %d",10,0
    fmt2 db "Argumento %d: %s",10,0

section .text
main:
    push ebp ; Armado de stack frame
    mov ebp, esp ;
    mov ebx,0 ;inicio contador de argumentos
    mov esi,0 ;prendo el sumador de argumentos
    push dword [ebp+8]
    push fmt
    call printf
    add esp, 2*4
    call ciclo
    mov eax, 0

    mov esp, ebp ; Desarmado de stack frame
    pop ebp
    ret

ciclo:
    cmp ebx,[ebp+8] ; me fijo si ya no quedan argumentos
    je fin
    mov edx,[ebp+12] ;me guardo el 2do argumento
    push dword [edx+esi]
    push dword ebx ;pusheo el numero de argumento
    push fmt2 ;pusheo el formato
    call printf
    inc ebx ;aumento el contador
    add esi,4;paso al siguiente argumento
    add esp,3*4; popeo 3 veces
    jmp ciclo

fin:
    ret

