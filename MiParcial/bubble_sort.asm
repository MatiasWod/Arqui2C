global bubble_sort

;DA SEG FAULT Y NO COMPRENDO BIEN PORQUE

section .text
bubble_sort:
    push ebp            ; ARMADO DE STACK FRAME
    mov ebp, esp
    push esi
    mov dx, [ebp+12]
oloop:
        mov cx, [ebp+12]
        lea esi, [ebp+8] 
iloop:
        mov al, byte[esi]                 
        cmp al,byte [esi+1]
        jl common1                     
        xchg al,byte [esi+1]
        mov byte [esi], al                   

common1:
        inc esi
        loop iloop
        dec dx
        jnz oloop

exit:
        pop esi
        mov esp, ebp
        pop ebp
        ret

