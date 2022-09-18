section .data
    syscall_exit            equ 1
    syscall_fork            equ 2
    syscall_read            equ 3
    syscall_write           equ 4
    syscall_open            equ 5
    syscall_close           equ 6
    syscall_time            equ 13
    syscall_getpid          equ 20
    syscall_nanosleep       equ 162
    syscall_clock_gettime   equ 265
    
section .text
%macro bst 0
    push ebp
    mov ebp, esp
%endmacro

%macro dst 0
    mov esp, ebp
    pop ebp
%endmacro

;-----------------------------------------------------------
; sys_exit - corta la ejecucion del programa
;-----------------------------------------------------------
; Argumentos:
;   int error_code
;-----------------------------------------------------------
global sys_exit
sys_exit:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, syscall_exit
    mov ebx, [ebp + 8]
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

;-----------------------------------------------------------
; sys_fork - crea un proceso hijo
;-----------------------------------------------------------
; Retorna:
;   int pid
; retorna 0 en el hijo
; retorna > 0 (el pid del hijo) en el padre
; si retorna -1 hubo un error creando el hijo
;-----------------------------------------------------------
global sys_fork
sys_fork:
    push ebp
    mov ebp, esp

    mov eax, syscall_fork
    int 80h

    mov esp, ebp
    pop ebp
    ret
;-----------------------------------------------------------
; sys_read - guarda en buff los primeros count bytes de fd
;-----------------------------------------------------------
; Argumentos:
;   int fd
;   (void *) buffer
;   size_t count/length
; Returns:
;   ssize_t number of bytes read
;   0 means EOF was reached
;-----------------------------------------------------------
global sys_read
sys_read:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, syscall_read
    mov ebx, [ebp + 8] ; fd
    mov ecx, [ebp + 12] ; buffer
    mov edx, [ebp + 16] ; count/length
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

;-----------------------------------------------------------
; sys_write - escribe a fd los primeros count bytes de buff
;-----------------------------------------------------------
; Argumentos:
;   int fd
;   const void * buffer
;   size_t count/length
; Returns:
;   ssize_t number of bytes written
;   -1 means there was an error
;-----------------------------------------------------------
global sys_write
sys_write:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, syscall_write
    mov ebx, [ebp + 8] ; fd
    mov ecx, [ebp + 12] ; buffer
    mov edx, [ebp + 16] ; count/length
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

;-----------------------------------------------------------
; sys_open - gets a file descriptor for a file
;-----------------------------------------------------------
; Argumentos:
;   const char * filename
;   int flags
;   umode_t mode
; Returns:
;   int fd for the file
;   -1 if there was an error
;-----------------------------------------------------------
global sys_open
sys_open:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, syscall_open
    mov ebx, [ebp + 8] ; filename
    mov ecx, [ebp + 12] ; flasgs
    mov edx, [ebp + 16] ; mode
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

;-----------------------------------------------------------
; sys_close - closes a fd
;-----------------------------------------------------------
; Argumentos:
;   int fd
; Returns:
;   int 0 if succeded
;   -1 on error
;-----------------------------------------------------------
global sys_close
sys_close:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, syscall_close
    mov ebx, [ebp + 8] ; fd
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

;-----------------------------------------------------------
; sys_time - returns the current time since epoch
;-----------------------------------------------------------
; Argumentos:
;   time_t * tloc
; Returns:
;   time_t current time since epoch
;   if tloc != null it also saves the time there
;-----------------------------------------------------------
global sys_time
sys_time:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, syscall_time
    mov ebx, [ebp + 8] ; tloc
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret


;-----------------------------------------------------------
; sys_getpid - returns the current program pid
;-----------------------------------------------------------
; Returns:
;   int pid program proccess id
;-----------------------------------------------------------
global sys_getpid
sys_getpid:
    push ebp
    mov ebp, esp

    mov eax, syscall_getpid
    int 80h

    mov esp, ebp
    pop ebp
    ret

;-----------------------------------------------------------
; sys_nanosleep - stalls the program execution
;-----------------------------------------------------------
; Returns:
;   int 0 if succeded 
;   -1 if interrupted
;-----------------------------------------------------------
global sys_nanosleep
sys_nanosleep:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, syscall_nanosleep
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

;-----------------------------------------------------------
; sys_clock_gettime - 
;-----------------------------------------------------------
global sys_clock_gettime
sys_clock_gettime:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, syscall_clock_gettime
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret