
GLOBAL print
GLOBAL exit
GLOBAL numtostr
GLOBAL numToString
section .text

;-----------------------------------------------------------
; print - imprimer una cadena en la salida estandar
;-----------------------------------------------------------
; Argumentos:
;	ebx: cadena a imprimer en pantalla, terminada con 0
;-----------------------------------------------------------
print:
	pushad		; hago backup de los registros

	call strlen
	mov ecx, ebx	; la cadena esta en ebx
	mov edx, eax	; en eax viene el largo de la cadena

	mov ebx, 1		; FileDescriptor (STDOUT)
	mov eax, 4		; ID del Syscall WRITE
	int 80h
	
	popad 		; restauro los registros
	ret	
	
;-----------------------------------------------------------
; exit - termina el programa
;-----------------------------------------------------------
; Argumentos:
;	ebx: valor de retorno al sistema operativo
;-----------------------------------------------------------
exit:
	mov eax, 1		; ID del Syscall EXIT
	int 80h			; Ejecucion de la llamada


;-----------------------------------------------------------
; strlen - calcula la longitud de una cadena terminada con 0
;-----------------------------------------------------------
; Argumentos:
;	ebx: puntero a la cadena
; Retorno:
;	eax: largo de la cadena
;-----------------------------------------------------------
strlen:
	push ecx ; preservo ecx	
	push ebx ; preservo ebx
	pushf	; preservo los flags

	mov ecx, 0	; inicializo el contador en 0
.loop:			; etiqueta local a strlen
	mov al, [ebx] 	; traigo al registo AL el valor apuntado por ebx
	cmp al, 0	; lo comparo con 0 o NULL
	jz .fin 	; Si es cero, termino.
	inc ecx		; Incremento el contador
	inc ebx
	jmp .loop
.fin:				; etiqueta local a strlen
	mov eax, ecx	
	
	popf
	pop ebx ; restauro ebx	
	pop ecx ; restauro ecx
	ret
;-----------------------------------------------------------
; numtostr - convierte un entero en un string guardandolo en 
; el stack
;-----------------------------------------------------------
; Argumentos:
;	el numero entero de 32 bit que se recibe en el stack
; ESP +4 a convertir
; Retorno:
;	los caracteres ASCII en el stack se devuelven  
;-----------------------------------------------------------
numtostr:
	
	
	mov ebp,esp ; guardo el puntero del stack
	pushad	
	MOV ECX,10
	MOV EDX,0   ; Pongo en cero la parte mas significativa
	Mov EAX, dword[EBp +4]  ;Cargo el numero a convertir
	MOV EBX,dword[ebp +8]
	ADD EBX,9               ; me posiciono al final del string para empezar a colocar
	mov byte [ebx], 0       ; los caracteres ASCII de derecha a izquierda comenzando con cero
	dec ebx                 ; binario
.sigo	DIV ECX
	OR Dl, 0x30  ; convierto el resto  menor a 10 a ASCII
	mov byte [ebx], Dl  
	DEC EBX      ; si el cociente es mayor a 0 sigo dividiendo
	cmp al,0
	jz .termino
	mov edx,0
	jmp .sigo
.termino inc ebx
	 call print
         POPAD
	 mov esp,ebp	 
	 ret

;-----------------------------------------------------------
; numToString - imprime numeros enteros positivos
;-----------------------------------------------------------
; Argumentos:
;	eax: numero para pasar a string
;	ebx: direccion donde guardar el string
;-----------------------------------------------------------
numToString:
	pusha
	pushf
	mov esi, 0	; inicio el contador de caracteres
	
.loadNum:	
	mov edx, 0 	; reinicio el valor del remainder
  	mov ecx, 10 	; en eax queda el numero dividido y en edx el resto
	div ecx
	add dl, '0'  	; paso el valor del resto a ascii
	push dx		; cargo el caracter al stack
	inc esi 	; cuento cuantos voy
	cmp eax, 0 	; si eax no es 0 sigo cargando numeros
	jne .loadNum

.loadStr:
	pop dx
	mov [ebx], dlSS
	inc ebx
	dec esi
	jnz .loadStr

	mov dl, 00h	; \0
	mov [ebx], dl  
	
.exit:
	popf
	popa
	ret
