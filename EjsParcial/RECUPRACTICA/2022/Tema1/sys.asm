GLOBAL sys_open
GLOBAL sys_close
GLOBAL sys_read
GLOBAL sys_write
GLOBAL sys_exit

sys_open:
    push ebp
    mov ebp, esp

    push ebx

    mov eax, 0x05
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
    mov edx, [ebp+16]
    int 80h

    pop ebx

    mov esp, ebp
    pop ebp
    ret

sys_close:
    ; Armado del stackFrame
    push ebp
    mov ebp, esp
    ; Como debo preservar ebx entre llamados de C
    ; pusheo el valor actual de ebx
    push ebx
    mov eax, 0x06 ; La syscall exit es de valor 0x06
    mov ebx, [ebp+8] ; Porque es el el fd es el primer argumento que recibe
    int 0x80 ; Llamo al kernel para que haga la syscall
    ; Preservo el valor previo de ebx
    pop ebx
    ; Desarmado del stackFrame
    mov esp, ebp
    pop ebp
    ret

sys_read:
    push ebp
    mov ebp, esp

    push ebx

    mov eax, 0x03
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
    mov edx, [ebp+16]
    int 80h

    pop ebx

    mov esp, ebp
    pop ebp
    ret

sys_write:
    ; Armado de Stack frame
    push ebp
    mov ebp, esp

    mov eax, 0x04
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
    mov edx, [ebp+16]
    int 80h

    mov esp, ebp
    pop ebp
    ret

sys_exit:
    push ebp
    mov ebp, esp

    push ebx
    
    mov eax, 0x01
    mov ebx, [ebp+8]
    int 80h

    pop ebx

    mov esp, ebp
    pop ebx
    ret



