section .text
GLOBAL sleep
GLOBAL getTime
GLOBAL printArray
GLOBAL bubbleSort
GLOBAL min
GLOBAL fact
GLOBAL mults
GLOBAL sumFirstN
GLOBAL printNewLine
GLOBAL numToString
GLOBAL toUpper
GLOBAL print
GLOBAL exit

;-----------------------------------------------------------
; sleep - frena el programa por n segundos
;-----------------------------------------------------------
; Argumentos:
;	eax: cantidad de segundos de sleep
;-----------------------------------------------------------
sleep:
	pusha
	pushf

	mov ebx, eax

	call getTime
	add ebx, eax

.loop:
	call getTime
	cmp eax, ebx
	jne .loop

.exit:
	popf
	popa
	ret

;-----------------------------------------------------------
; getTime - devuelve el tiempo actual en unix-time
;-----------------------------------------------------------
; Retorno:
;	eax: tiempo actual en unix-time
;-----------------------------------------------------------
getTime:
	push ebx
	pushf

	mov eax, sys_time
	mov ebx, time
	int 80h

	mov eax, [time]

	popf
	pop ebx
	ret

;-----------------------------------------------------------
; printArray - imprime un array de 4 bytes
;-----------------------------------------------------------
; Argumentos:
;	eax: dirreccion al array en memoria
;	ebx: longitud del array
;-----------------------------------------------------------
printArray:
	pusha
	pushf

.loop:
	cmp ebx, 0
	je .exit
	sub ebx, 4

	push eax
	push ebx
	
	mov eax, [eax]
	mov ebx, num
	call numToString
	call print
	pop ebx
	pop eax
	cmp ebx, 0
	je .exit
	push ebx
	mov ebx, coma
	call print
	pop ebx
	add eax, 4
	jmp .loop

.exit:
	popf
	popa
	ret

;-----------------------------------------------------------
; bubbleSort - ordena un array de 4 bytes
;-----------------------------------------------------------
; Argumentos:
;	eax: dirreccion al array en memoria
;	ebx: longitud del array
;-----------------------------------------------------------
bubbleSort:
	pusha
	pushf

	; en eax tengo la direccion del array
	; en ebx mantengo el tamanio del array, lo reduzco uno cada iteracion
	; en ecx y edx tengo el par q estoy comparando ahora
	; en esi cuento los vistos por ahora, comparo contra ebx
	; en edi guardo si ya esta ordenado

	; pusheo eax para restaurarlo despues
	; cargo en esi 0 para iniciar a recorrer
	; si tengo menos de 2 elementos voy a exit
	; pongo el flag de ordenado en esi, para despues
.newLoop:
	push eax
	mov esi, 0
	cmp ebx, 8
	jl .exit
	mov edi, 1
	jmp .loop

	; incremento eax despues de cada comparacion
.incEax:
	add eax, 0x4
	; aumento la cantidad de posiciones vistas en esi
	; pregunto si llegue al final
	; si llegue al final preparo el siguiente loop
	; si no llegue al final me fijo si tengo q swapear el pais
.loop:
	add esi, 0x4
	cmp esi, ebx
	je .next_loop
	jmp .chechPair

	; me fijo si recorri todo sin hacer un swap -> ya esta ordenado, salgo
	; sino le resto a ebx 4, en la ultima posicion ya puse el mas grande
	; ahora recorro hasta la anterior a esa
	; restauro eax, para empezar un nuevo ciclo
.next_loop:
	cmp edi, 1
	je .exit
	sub ebx, 4
	pop eax
	jmp .newLoop

	; cargo en ecx, y en edx los valores a comparar
	; si es necesario los swapeo
	; sino paso al siguiente par
.chechPair:
	mov ecx, [eax]
	mov edx, [eax + 4]
	cmp ecx, edx
	jl .incEax

	; swapeo, apago el flag de ordenado
	; paso al siguiente par
.swap:
	mov edi, 0
	mov [eax], edx
	mov [eax + 4], ecx
	jmp .incEax

	; popeo el eax que dejo newLoop
	; restauro flags y registros
.exit:
	pop eax
	popf
	popa
	ret

;-----------------------------------------------------------
; min - calcula el minimo en un array de numeros de 4 bytes
;-----------------------------------------------------------
; Argumentos:
;	eax: dirreccion al array en memoria
;	ebx: longitud del array
; Retorno:
;	eax: valor minimo en el array
;	ebx: 1 si hubo errores, 0 si anduvo bien
;-----------------------------------------------------------
min:
	push ecx
	push edx
	pushf
	cmp ebx, 0
	je .err
	mov ecx, [eax]

.afterloop:
	add eax, 0x4
	sub ebx, 0x4
	jnz .loop
	jmp .exit

.updtMin:
	mov ecx, edx
	jmp .afterloop

.loop:
	mov edx, [eax]
	cmp ecx, edx
	jg .updtMin
	jmp .afterloop

.err:
	mov ebx, 1
.exit:
	mov eax, ecx
	popf
	pop edx
	pop ecx
	ret

;-----------------------------------------------------------
; fact - calcula el factorial de un numero
;-----------------------------------------------------------
; Argumentos:
;	eax: numero del cual calcular el factorial
; Retorno:
;	eax: factorial del numero recibido
;-----------------------------------------------------------
fact:
	push ebx
	push edx
	pushf
	cmp eax, 0
	je .load1
	cmp eax, 1
	je .load1
	mov ebx, eax
	dec ebx

.loop:
	mul ebx
	dec ebx
	jnz .loop
	jmp .exit

.load1:
	mov eax, 1
.exit:
	popf
	pop edx
	pop ebx
	ret

;-----------------------------------------------------------
; mults - calcula los multiplos de n entre 1 y k 
;-----------------------------------------------------------
; Argumentos:
;	eax: el divisor (n)stack
;	ebx: el limite superior (k)
; Retorno:
;	eax: direccion al stack donde estan los multiplos
;	ebx: cantidad de multiplos
;-----------------------------------------------------------
mults:
	push ebp 	; dir de ret
	mov ebp, esp
	push ecx
	push edx
	push edi
	push esi
	pushf

	mov ecx, eax
	mov esi, 0
	mov edi, 0

.loop:
	mov ecx, eax
	mov esi, 0
	mov edi, 0

.sig:
	cmp esi, ebx
	jne .loop
	jmp .exit

.carga:
	inc edi
	push esi	; en cada push subo el stack pointer 4 bytes
	jmp .sig

.exit:
	mov eax, edi
	mov edx, 0x4
	mul edx
	mov ecx, eax
	mov eax, esp	; me guardo donde quedaron los datos en el stack
	add esp, ecx	; decremento el stack pointer para que quede encima de las flags asi puedo popearlas
	mov ebx, edi	; cargo en ebx la cantidad de elementos que pushee

	popf
	pop esi
	pop edi
	pop edx
	pop ecx
	mov esp, ebp
	pop ebp
	ret

;-----------------------------------------------------------
; sumFirstN - calcula la suma de los primeros n enteros
;-----------------------------------------------------------
; Argumentos:
;	eax: el limite superior (n)
; Retorno:
;	eax: la suma de los primeros n enteros
;-----------------------------------------------------------
sumFirstN:
	push ebx
	pushf
	mov ebx, 0

.loop:
	add ebx, eax
	dec eax
	jnz .loop

.exit:
	mov eax, ebx
	popf
	pop ebx
	ret

;-----------------------------------------------------------
; printNewLine - imprime un \n
;-----------------------------------------------------------
printNewLine:
	pusha
	pushf

	mov ebx, newLine
	call print

.exit:
	popf
	popa
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
	mov [ebx], dl
	inc ebx
	dec esi
	jnz .loadStr

	mov dl, 00h	; \0
	mov [ebx], dl  
	
.exit:
	popf
	popa
	ret


;-----------------------------------------------------------
; toUpper - pasa un string a mayuscula
;-----------------------------------------------------------
; Argumentos:
;	eax: longitud de la cadena
;	ebx: puntero a la cadena
;-----------------------------------------------------------
toUpper:
	pushad
	cmp eax, 0
	jz .exit

.start:
	mov cl, [ebx]

	cmp cl, 'a'
	jl .nextChar

	cmp cl, 'z'
	jg .nextChar
	
	sub cl, distance
	mov [ebx], cl

.nextChar:
	inc ebx
	dec eax
	jnz .start
	
.exit:
	popad
	ret

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

section .data
	distance equ 'a'-'A'
	doubleSize equ 4

	sys_exit equ 1
	sys_fork equ 2
	sys_read equ 3
	sys_write equ 4
	sys_time equ  13

	newLine db 0Ah, 00h
	coma db ", ", 00
	
section .bss
	time resd 1
	num resb 16