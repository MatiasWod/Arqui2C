#include <stdio.h>


#define GCERR -2               // Error del getchar
#define EOF -1                 // End of file
#define STDIN  0               // FD Standard input
#define STDOUT 1               // FD Standard output
#define STDERR 2               // FD Standard error

// flags para sys_open
#define _O_RDONLY 0x0000       // Read only
#define _O_WRONLY 0x0001       // Write only
#define _O_RDWR   0x0002       // Read & Write
#define _O_CREAT  0x0040       // Create

// flags de permisos sys_open
#define S_IXUSR 00100          // owner, execute permission
#define S_IWUSR 00200          // owner, write permission
#define S_IRUSR 00400          // owner, read permission
#define S_IRWX  00700          // owner, read, write, execute permission

extern int sys_write(int fd, void *buffer, int size);
extern int sys_exit(int error);
extern int sys_read(int fd, void *buf, int count);
extern int sys_open(const char *pathname, int flags, int mode);
extern int sys_close(int fd);

int main(){
    // Abrimos ambos archivos y le asignamos permisos de lectura
    int fdA = sys_open("DatosA.txt", _O_RDONLY, 0);
    if(fdA < 0){
        char errmsg[] = "Error, no se pudo abrir el archivo A\n";
        sys_write(STDERR, errmsg , 20);
        sys_exit(fdA);
    }
    char cuenta[10];
    sys_read(fdA,cuenta,10);
    sys_close( fdA);
    int resultado=cuenta[0]-'0';
    int num1=0;
    for (int i=0;i<8;i+=2){
        if(cuenta[i+1]=='-'){
            resultado-=cuenta[i+2]-'0';
        }
        else{
            resultado+=cuenta[i+2]-'0';
        }
    }
    printf("%d\n",resultado);
    return 0;
}

