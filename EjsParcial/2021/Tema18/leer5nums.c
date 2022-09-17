#include <string.h>
#include <stdio.h>
#define SIZE (5*5+4)

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

int main(void){
    int fdA = sys_open("DatosA.txt", _O_RDONLY, 0);
    if(fdA < 0){
        char errmsg[] = "Error, no se pudo abrir el archivo A\n";
        sys_write(STDERR, errmsg , strlen(errmsg));
        sys_exit(fdA);
    }
    int fdB = sys_open("DatosB.txt",_O_RDONLY, 0);
    if(fdB < 0){
        char errmsg[] = "Error, no se pudo abrir el archivo B\n";
        sys_write(STDERR, errmsg , strlen(errmsg));
        sys_exit(fdA);
    }
    int fdC = sys_open("DatosC.txt",_O_CREAT|_O_RDWR, S_IRWX);
    if(fdC < 0){
        char errmsg[] = "Error, no se pudo crear el archivo C\n";
        sys_write(STDERR, errmsg , strlen(errmsg));
        sys_exit(fdA);
    }
    char bufferA[SIZE];
    char bufferB[SIZE];
    sys_read(fdA,bufferA,SIZE);
    sys_read(fdA,bufferB,SIZE);

    for (int i=0;i<SIZE;i++){
        printf("caca");
        if(bufferA[i]==bufferB[i]){   
                sys_write(fdC,bufferA[i],1);
            }
    }
    sys_close(fdA);
    sys_close(fdB);
    sys_close(fdC);
    return 0;
}