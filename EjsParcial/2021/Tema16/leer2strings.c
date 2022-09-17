#define GCERR -2 // Error del getchar
#define EOF -1   // End of file
#define STDIN 0  // FD Standard input
#define STDOUT 1 // FD Standard output
#define STDERR 2 // FD Standard error
// flags para sys_open
#define _O_RDONLY 0x0000 // Read only
#define _O_WRONLY 0x0001 // Write only
#define _O_RDWR 0x0002   // Read & Write
#define _O_CREAT 0x0040  // Create
// flags de permisos sys_open
#define S_IXUSR 00100 // owner, execute permission
#define S_IWUSR 00200 // owner, write permission
#define S_IRUSR 00400 // owner, read permission
#define S_IRWX 00700  // owner, read, write, execute permission
extern int sys_write(int fd, void *buffer, int size);
extern int sys_exit(int error);
extern int sys_read(int fd, void *buf, int count);
extern int sys_open(const char *pathname, int flags, int mode);
extern int sys_close(int fd);
int _getchar(int fd);
int _strlen(const char *str);
void replace(char *buffer, char *new, int longitud, int fdA, int fdB);
int main(int argc, char *argv[])
{
    int fdA = sys_open("DatosA.txt", _O_RDONLY, 0);
    if (fdA < 0)
    {
        char errmsg[] = "Error, no se pudo abrir el archivo A\n";
        sys_write(STDERR, errmsg, _strlen(errmsg));
        sys_exit(fdA);
    }
    int fdB = sys_open("DatosB.txt", _O_RDWR | _O_CREAT, S_IRWX);
    if (fdB < 0)
    {
        char errmsg[] = "Error, no se pudo abrir el archivo A\n";
        sys_write(STDERR, errmsg, _strlen(errmsg));
        sys_exit(fdB);
    }
    char *s1 = argv[1];
    char *s2 = argv[2];
    replace(s1, s2, _strlen(s1), fdA, fdB);
    if (sys_close(fdA) < 0)
    {
        char errmsg[] = "Error al cerrar el archivo A, puede que sus datos no se guarden correctamente \n";
        sys_write(STDERR, errmsg, _strlen(errmsg));
    }
    if (sys_close(fdB) < 0)
    {
        char errmsg[] = "Error al cerrar el archivo A, puede que sus datos no se guarden correctamente \n";
        sys_write(STDERR, errmsg, _strlen(errmsg));
    }
    return 0;
}
void nextComputation(char *buffer, char *next)
{
    next[0] = 0;
    int border = 0;
    for (int rec = 1; buffer[rec]; rec++)
    {
        while ((border > 0) && (buffer[border] != buffer[rec]))
            border = next[border - 1];
        if (buffer[border] == buffer[rec])
            border++;
        next[rec] = border;
    }
}
void replace(char *buffer, char *new, int longitud, int fdA, int fdB)
{
    char next[longitud];
    
    nextComputation(buffer, next);
    int c;
    int finish = ((c = _getchar(fdA)) == EOF);
    int pbuff = 0;
    while (!finish)
    {
        if (c == buffer[pbuff])
        {
            finish = ((c = _getchar(fdA)) == EOF);
            pbuff++;
            if (pbuff == longitud)
            {
                sys_write(fdB, new, _strlen(new));
                pbuff = 0;
            }
        }
        else if (pbuff != 0)
        {
            sys_write(fdB, buffer, pbuff - next[pbuff - 1]);
            pbuff = next[pbuff - 1];
        }
        else
        {
            sys_write(fdB, &c, 1);
            finish = ((c = _getchar(fdA)) == EOF);
        }
    }
    if (pbuff != 0)
    {
        sys_write(fdB, buffer, pbuff);
    }
}
/***
 * Funcion que retorna la longitud de un string.
 * Argumento:
 * - const char * str: puntero a la direccion de memoria donde se encuentra el string.
 *
 * Retorno:
 * - La longitud del string.
 ***/
int _strlen(const char *str)
{
    int i = 0;
    while (*(str + (i++)))
        ;
    return i - 1;
}
/***
 * Funcion que lee un unico caracter de un file descriptor especifico.
 *
 * Argumento:
 * - int fd: file descriptor del que se quiere leer el caracter.
 *
 * Retorno:
 * - En caso de error al leer el caracter, devuelve -2 (GCERR).
 * - Si se termina el archivo devuelve -1 (EOF).
 * - Sino, devuelve el caracter leido.
 *********** Usa sys_read y las constantes GCERR EOF *********************+
 ***/
int _getchar(int fd)
{
    char c;
    int returnval = sys_read(fd, &c, 1);
    if (returnval == 1)
        return c;
    if (returnval < 0)
        return GCERR;
    return EOF;
}