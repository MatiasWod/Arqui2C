section  .data
         holder   db "%x", 10, 0 ; We are declaring a variable for printing the sum.



;COMENTO EN MAYUSCULA LAS SECCIONES DE CODIGO QUE MOFIFIQUE PARA CLARIDAD 





section  .text
         global numeros_primos             ; SE CAMBIA EL NOMBRE DE LA FUNCION PARA QUE 
                                           ; EL MAIN/_START ESTE EN OTRO ARCHIVO Y PUEDA LLAMAR A NUMEROS_PRIMOS
         extern printf           ; We are using printf to print numbers to stdout.


numeros_primos:
        push ebp            ; ARMADO DE STACK FRAME
        mov ebp, esp
        push ebx
         xor   edx, edx          ; Reset edx to 0x00.
         xor   ecx, ecx          ; Reset ecx to 0x00.
         mov   ecx, [ebp+8] ; CARGO EN ECX EL TOPE QUE RECIBE COMO ARGUMENTO LA FUNCION NUMEROS_PRIMOS
         mov   edx, 2            ; edx will hold the sum. We are starting with adding the first prime number which is 2.

primus:
         cmp   ecx, 2            ; Check if ecx equals to 2.
         je    exit              ; If it is, then we are done. Jump to exit.
         mov   eax, ecx          ; Copy the current number to eax. We will use it later on for division.
         xor   ebx, ebx          ; Reset ebx to 0x00.
         mov   bl, 1             ; Load 1 to lower 8 bits of ebx. This register will behave as flag. Initially it is 1, which compromises
                                 ; that the current number is prime.
         push  ecx               ; Store ecx onto the stack.
         sub   ecx, 1            ; Decrease ecx by 1.

looop:
         cmp   ecx, 1            ; ecx == 1 ? 
         je    cont              ; If it is, we are done looking for this number. Continue with 'cont'.
         push  eax               ; Backup eax.
         div   cl                ; Perform an 8 bit division. 
         cmp   ah, 0             ; If the division operation yielded no remainder,
         je    flag_down         ; then, jump to flag_down. This number (which was stored in eax) is not prime.
         pop   eax               ; If it did, continue looking for the other numbers less than eax, the current number we are testing its primity.^^;
         loop  looop

cont:
         cmp   bl, 1             ; Is flag up? Is the number prime?
         je    sum               ; If yes, jump to 'sum'.
         pop   ecx               ; Else, do not add it to sum. Restore ecx and continue looking next number, whether it is prime or not.
         loop  primus

flag_down:
         mov   bl, 0             ; Wrong alarm, flag down. No prime.
         jmp   cont              ; Continue.

sum:
         pop   ecx               ; Restore ecx, which was holding the current number.
         add   edx, ecx          ; Now that, we verified that this number is prime, add it to the sum which is being kept by edx.
         loop  primus            ; Continue looking for new numbers.

exit:
         push  edx               ; Now, we have all the prime numbers summed in edx. Push it onto stack as printf will use it as parameter.
         push  holder            ; Likewise, push the holder onto the stack.
         call  printf            ; Print the sum to the screen.
         add   sp, 2*4           ; Although not necessary for this program, restore the stack pointer. It seems like a good habit.

        pop ebx              ; DESARMADO DE STACK FRAME
        mov esp, ebp
        pop ebp
        ret               