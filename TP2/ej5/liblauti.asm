GLOBAL print
GLOBAL exit
GLOBAL to_string
GLOBAL digits

section .text

;-----------------------------------------------------------
; print - imprimer una cadena en la salida estandar
;-----------------------------------------------------------
; Argumentos:
;	ebx: cadena a imprimir en pantalla, terminada con 0
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
; exit - calcula la longitud de una cadena terminada con 0
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
; digits - calcula la cantidad de digitos que tiene un numero
;-----------------------------------------------------------
; Argumentos:
;	eax: numero cuyos digitos se quieren contabilizar
; Retorno:
;	cl: cantidad de digitos 
;-----------------------------------------------------------

digits:
	push eax
	push ebx
	push edx
	mov cl, 0	; seteamos el contador en 0
.cicle:
	mov ebx, 10
	div ebx
	mov edx, 0 ; hago edx cero para que no lo use como parte del dividendo siguiente
	inc cl
	cmp eax, 0
	je .end
	jmp .cicle
.end:
	pop edx
	pop ebx
	pop eax
	ret

;-----------------------------------------------------------
; tostring - transforma un numero en un string de dicho numero dejandolo en una direccion de memoria pasado como parametro
;-----------------------------------------------------------
; Argumentos:
;	eax: numero cuyos digitos se quieren convertir a ASCII
;	ebx: direccion donde cargar el string 
;-----------------------------------------------------------

;Mem 100h 101h 102h 103h
;	       10    0

;eax=100h
;ebx=100h
;ecx=
;edx=


to_string:
    pushad					; hago backup de los registros
    pushf                   ; hago un backup de los flags
	push 0					; pusheo el 0 del final

    mov ecx, 10d            ; guardo en ecx 10, que es el divisor que quiero usar

.breakdown:
    mov edx, 0              ; lleno de 0s la parte alta del dividendo para que se mantenga el num que quiero en la division
    div ecx                 ; divido el num por 10, el resultado quedara en eax y el resto queda en edx (en la parte baja)
   
    add edx, '0'            ; en edx tenemos el resto y le sumamos el valor del '0' para transformarlo en string (un numero + el ASCII del 0 es el numero en string)
	push edx				; pusheo al stack, el ASCII resultante de la linea anterior

    cmp eax, 0              ; me fijo si tengo números para dividir
    jnz .breakdown          ; si NO es cero, sigo el loop

.reverse:
	pop edx					; popeo a edx último ascii del stack
	mov  [ebx], edx			; muevo la parte baja de edx (dl) a lo que apunta [ebx]. En la parte baja son los ultimos 8 bits asi voy de a 1
	inc ebx					; incremento ebx una vez ya que solo movi 1 solo byte
	cmp edx, 0				; comparo edx con el cero final
	jnz .reverse			; si no popee el 0 final, sigo

    popf
    popad
    ret