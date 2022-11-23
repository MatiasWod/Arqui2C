GLOBAL main
EXTERN function

section .text

main:
    push ebp
    mov ebp, esp

    mov eax, [ebp+12]
    push eax
    mov eax, [ebp+8]
    push eax

    call function

    pop eax
    pop eax
    pop ebp
    mov esp, ebp

    mov eax, 0x01
    mov ebx, 0
    int 80h

