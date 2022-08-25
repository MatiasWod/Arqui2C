GLOBAL _start
EXTERN print
EXTERN numToString


_start:
    mov ebx,num
    mov eax,0
    push ebp
    mov ebp,esp
    call loop
    mov ebx,num
    call numToString
    call print
    mov esp,ebp
    pop ebp
    mov eax,1
    int 80h


loop: 
      add eax,1
      add ebp,4
      mov ebx,[ebp]
      cmp ebx,0
      jne loop
      ret

section .bss
    num resb 16