#define GCERR -2               // Error del getchar
#define EOF -1                 // End of file
#define STDIN  0               // FD Standard input
#define STDOUT 1               // FD Standard output
#define STDERR 2               // FD Standard error
#define MAX_BUFF 128

#define UTC -3
#define SECS_DAY (60*60*24)

// flags para sys_open
#define _O_RDONLY 0x0000       // Read only
#define _O_WRONLY 0x0001       // Write only
#define _O_RDWR   0x0002       // Read & Write
#define _O_CREAT  0x0040       // Create
#define _O_TRUNC  0x0200       // ?
#define _O_APPEND 0x0400       // Append

#define IS_NUM(c)  ((c) >= '0' && (c)<='9')
#define IS_DIGIT(c) (((c) >= 'a' && (c)<='z') || ((c) >= 'A' && (c)<='Z'))

// flags de permisos sys_open
#define S_IXUSR 00100          // owner, execute permission
#define S_IWUSR 00200          // owner, write permission
#define S_IRUSR 00400          // owner, read permission
#define S_IRWX  00700          // owner, read, write, execute permission

/***************************************************************************************************/
/***************************************************************************************************/

/* Funcion implementada en ASM que hace syscall con eax en 1 */
extern int sys_write_64(int fd, const void * buf, int count);

/* Funcion implementada en ASM que hace syscall con eax en 0 */
extern int sys_read_64(int fd, const void * buf, int max);

/* Funcion implementada en ASM que hace syscall con eax en 3 */
extern int sys_open_64(const char * pathname, int flags, int mode);

/* Funcion implementada en ASM que hace syscall con eax en 2 */
extern int sys_close_64(int fd);

/***************************************************************************************************/
/***************************************************************************************************/

/* Funcion que retorna la longitud de un string. */
int _strlen(const char * str);

/* Funcion que imprime en STDOUT una string */
void puts_64(char * string);

/* Funcion que lee de STDIN en string hasta max */
int gets_64(char * string, int max);