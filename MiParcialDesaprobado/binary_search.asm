section  .data
        ;NO SE PORQUE NO FUNCIONA YA QUE MODIFICO LAS ZONAS DE MEMORIA y EL CONTENIDO DE LAS ZONAS DE MEMORIA DE LOS ARGUMENTS
        ;SI TUVIERA QUE ADIVINAR CREO QUE ESTOY SUMANDO MAL LOS BYTES
         ; 'mid' is the variable that holds the middle point in every iteration.
         ; And finally msg_ok and msg_not_so_ok are the variables that hold the strings.
         iter           db 0
         mid            db 0
         msg_ok         db "found", 10, 0
         msg_not_so_ok  db "not found", 10, 0

section  .text
         global   binary_search   ; Our program will start running from 'binary_search'.
         extern   printf         ; We will use printf to print to stdout.

binary_search:
        push ebp
        mov ebp,esp
         xor   ecx, ecx          ; Reset ecx to 0.
         xor   edx, edx          ; Reset edx to 0.
         mov   dh, [ebp+12]            ; DH will hold the number we are searching.
         lea   esi, [ebp+8]        ; Load effective address of 'arr' into esi.

while:
         xor   eax, eax          ; Reset eax to 0.
         xor   ebx, ebx          ; Reset ebx to 0.
         mov   ah, [ebp+16]        ; Get 'left' into ah.
         mov   al, [ebp+20]       ; Get 'right' into al.
         mov   bl, 2             ; Set bl 2. We will use it later for division operation.
         cmp   al, ah            ; Compare the value of right with left.
         jae   iteration         ; right >=  left ? If so, jump to 'iteration'.
         jmp   not_found         ; Else, than we are done searching. Sad end.

iteration:
         sub   al, ah            ; Perform (right - left)
         xor   ah, ah            ; Reset ah to 0 or it will be a nuisance later when we add eax to esi.
         div   bl                ; And, perform al/bl. Remember that al was holding (right - left).
                                 ; So the result is the middle point of upper and lower bounds.
         xor   ah, ah            ; Reset ah to 0 again, for the very same reason above.
         add   al, [ebp+16]        ; After the division, al was loaded (right - left) / 2 which is the middle
                                 ; point of upper and lower bounds. Now we are adding the value of left to the 
                                 ; middle value because we want to find the middle point relative to the lower
                                 ; bound.
         mov   [mid], al         ; And, load 'mid' the value we calculated in the al.
         push  esi               ; Store esi onto the stack.
         add   esi, eax;         ; Update esi by incrementing it by eax (or 'mid') to get the value at the index of 'mid'. Namely, arr[mid].
         mov   dl, [esi]         ; And get arr[mid] to dl.
         pop   esi               ; Restore esi from the stack.
         cmp   dh, dl            ; And, compare the value we are searching with dl.
         je    found             ; If dh == dl. Gotcha! Jump to 'found'.
         jb    below             ; If the number we are searching is less than the number we are comparing, jump to 'below'.
         ja    above             ; Else if the number we are searching is greater than the number we are comparing, jump to 'above'.

found:
         mov   cx, 1             ; Set cx to 1. We will use this as a flag in the 'printscr' procedure.
         inc   byte [iter]       ; Increment the value stored in 'iter' since we have done with this iteration.
         call  printscr          ; Call the procedure which will print "found" to the screen.
         jmp   exit              ; After printscr, jump to 'exit' to exit the program.

below:
         dec   byte [mid]        ; If below, decrement the value that pointed by mid by 1.
         mov   cl, [mid]         ; cl is an intermediate register for moving [mid] into [right].
         mov   [ebp+20], cl       ; Perform the mov operation described above. Doing this, we are restricting the upper bound.
         inc   byte [iter]       ; Increment the value stored in 'iter' since we have done with this iteration.
         jmp   while             ; Continue searching.

above:
         inc   byte [mid]        ; If above, increment the value pointed by mid by 1.
         mov   cl, [mid]         ; Again, cl is an intermediate register for moving [mid] into [left].
         mov   [ebp+16], cl        ; Perform the mov operation described above. Doing this, we are restricting the lower bound.
         inc   byte [iter]       ; Increment the value stored in 'iter' since we have done with this iteration.
         jmp   while             ; Continue searching.

not_found:
         mov   cx, 0             ; Set cx to 0. We will use this as a flag in the 'printscr' procedure.
         call  printscr          ; Call the procedure which will print "not found" to the screen.
         jmp   exit              ; After printscr, jump to 'exit' to exit the program.

printscr:
         cmp   cx, 1             ; cx = 1 means 'found' and cx = 0 means 'not found' as you may have expected.
         jne   not_ok            ; If cx = 0, jump to 'not_ok'.
         push  msg_ok            ; If cx = 1, push msg_ok to the stack as a parameter of printf function.
         call  printf            ; Print "found" to stdout.
         add   esp, 4            ; Restore the stack pointer.
         ret                     ; Return to the callee.
not_ok:
         push  msg_not_so_ok     ; Push msg_not_so_ok to the stack as a parameter of printf function.
         call  printf            ; Printf "not found" to stdout.
         add   esp, 4            ; Restore the stack pointer.
         ret                     ; Return to callee.

exit:
        pop ebp
        mov esp,ebp
        ret