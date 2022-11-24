
GLOBAL sys_write_64
GLOBAL sys_read_64
GLOBAL sys_close_64
GLOBAL sys_open_64

section .text

;-----------------------------------------------------------
; sys_write_64 - escribe a fd los primeros count bytes de buff
; ssize_t write(int fd, const void *buf, size_t count)
;-----------------------------------------------------------
; Argumentos:
;   int fd
;   const void * buffer
;   long long count/length
; Returns:
;   long long number of bytes written
;   -1 means there was an error
;-----------------------------------------------------------
sys_write_64:
    push rbp
    mov rbp, rsp
    
    mov rax, 0x01           ; no tengo que modificar nada, ya 
                            ; tengo todo donde lo quiero!
    syscall

    mov rsp, rbp
    pop rbp
    ret

;-----------------------------------------------------------
; sys_read_64 - lee a fd los primeros count bytes de buff
; ssize_t write(int fd, const void *buf, size_t count)
;-----------------------------------------------------------
; Argumentos:
;   int fd
;   const void * buffer
;   long long count/length
; Returns:
;   long long number of bytes written
;   -1 means there was an error
;-----------------------------------------------------------
sys_read_64:
    push rbp
    mov rbp, rsp
    
    mov rax, 0x00           ; no tengo que modificar nada, ya 
                            ; tengo todo donde lo quiero!
    syscall

    mov rsp, rbp
    pop rbp
    ret

;-----------------------------------------------------------
; sys_close_64 - cierra un fd
;-----------------------------------------------------------
; Argumentos:
;   int fd
; Returns:
;   int 0 if succeded
;   -1 on error
;-----------------------------------------------------------
sys_close_64:
    push rbp
    mov rbp, rsp
    
    mov rax, 0x03           ; no tengo que modificar nada, ya 
                            ; tengo todo donde lo quiero!
    syscall

    mov rsp, rbp
    pop rbp

;-----------------------------------------------------------
; sys_open_64 - gets a file descriptor for a file
;-----------------------------------------------------------
; Argumentos:SIZE
;   int fd for the file
;   -1 if there was an error
;-----------------------------------------------------------
sys_open_64:
    push rbp
    mov rbp, rsp
    
    mov rax, 0x02           ; no tengo que modificar nada, ya 
                            ; tengo todo donde lo quiero!
    syscall

    mov rsp, rbp
    pop rbp