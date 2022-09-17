#include <stdio.h>
#include <string.h>

#define SIZE 32

#define CHARTOINT(x) (x-'0')

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
    char flag = 0;
    int i = 0;
    int res = 0, aux = 0,acum = 0;
    char buf[64];
    read_exp(buf);
    while(buf[i] != '='){
        while(buf[i] <= '9' && buf[i] >= '0'){
            printf("%c\n",buf[i]);
            aux = (CHAR_TO_INT(buf[i])) + aux * pow(10,acum);
            printf("aux = %d\n",aux);
            i++;
            acum=1;
        }
        printf("%c\n",buf[i]);
        acum = 0;
        if(flag == 1){
            res -= aux;
            aux = 0;
            flag = 0;
        }
        else if(flag == 0){
            res += aux;
            aux = 0;
        }
        if(buf[i] == '-'){
            flag = 1;
            i++;
        }
        if(buf[i] == '+')
            i++;
    }
    printf("%d\n",res);
}


void read_exp(char * buf){
    int fdA = sys_open("DatosA.txt", _O_RDONLY, 0);
    if(fdA < 0){
        char errmsg[] = "Error, no se pudo abrir el archivo A\n";
        sys_write(STDERR, errmsg , strlen(errmsg));
        sys_exit(fdA);
    }
    sys_read(fdA,buf,64);
    sys_close(fdA);
}

int strlen(char * str){
    int i = 0;
    while(str[i] != 0){
        i++;
    }
    return i;
}
    
}