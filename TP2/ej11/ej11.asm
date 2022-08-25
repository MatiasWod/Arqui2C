GLOBAL _start
EXTERN print


_start:
    push ebp
    mov ebp, esp
    mov ebx,[ebp+84]
    call print
    mov esp,ebp
    pop ebp
    mov eax,1
    mov ebx,0
    int 80h






