GLOBAL sys_write
GLOBAL sys_read
GLOBAL sys_open_file
GLOBAL sys_close_file
section .text
sys_close_file:
    push ebp
    mov ebp,esp
    mov eax,0x06
    mov ebx,[ebp+8]; paso el fd
    int 0x80
    mov esp,ebp
    pop ebp
    ret

sys_write:
    push ebp
    mov ebp, esp
    push ebx ;preservar ebx
    mov eax, 0x4
    mov ebx, [ebp+8] ; fd
    mov ecx, [ebp+12] ; buffer
    mov edx, [ebp+16] ; length
    int 0x80
    pop ebx
    mov esp, ebp
    pop ebp
    ret

sys_open_file:
    push ebp
    mov ebp, esp
    ; Abrir el archivo
    ; Utilizo la syscall sys_open
    ; Cargo en ebx el pathname
    mov ebx, [ebp+8]
    ; Cargo en ecx lo que quiero hacer con el archivo
    ; O_RDONLY         00
    ; O_WRONLY         01
    ; O_RDWR           02
    ; En este caso cargamos que solo queremos leerlo.
    mov ecx, [ebp+12]
    ; En eax ponemos el numero de syscall que queremos llamar
    ; sys_open tiene el numero 0x05
    mov eax, 0x05
    int 80h
    ; Me retorna el file descriptor del archivo en eax
    mov esp,ebp
    pop ebp
    ret

sys_read:
    push ebp
    mov ebp, esp
    ; Read a file
    ; Pongo en ebx el file descriptor del archivo a leer
    mov ebx,[ebp+8]     ; fd
    ; En ecx guardo el buffer
    mov ecx,[ebp+12]   ; buf
    ; En edx pongo la cantidad de caracteres a leer
    mov edx, 32  ; count
    ; En eax pongo el numero sys_call que es 0x03
    mov eax, 0x03
    int 80h
    mov esp,ebp
    pop ebp
    ret