#include <stdio.h>

#define SIZE 32
#define DIFF ('a'-'A')

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

    char entrada[SIZE];
    scanf("%s",entrada);

    // Abrimos ambos archivos y le asignamos permisos de lectura
    int fd = sys_open("Datos.txt", _O_RDONLY, S_IRWX);
    if(fd < 0){
        return 1;
    }
    char buffer[SIZE];
    sys_read(fd,buffer,SIZE);
    int count=0;
    int j=0;

    for(int i=0;buffer[i]!=0;i++){
        if (entrada[j]==0 && j!=0){
            count++;
            j=0;
            i--;
        }
        else if (entrada[j]==buffer[i])
            j++;
        else if (entrada[j]<'z' && entrada[j]>'a'){
            if(buffer[i]==(entrada[j]-DIFF)){
                j++;
            }
        }
         else if (entrada[j]<'Z'&& entrada[j]>'A'){
            if(buffer[i]==(entrada[j]+DIFF))
                j++;
        }
        else
            j=0;
    }
    if (entrada[j]==0){
        count++;
    }
    printf("La respuesta es:%d\n",count);

    return 0;
}