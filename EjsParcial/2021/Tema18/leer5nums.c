#include <stdio.h>
#include <stdlib.h> 
#include <string.h>

// sys_open permisos con los que abro el archivo
// flags
#define _O_RDONLY   0x000 // Read only
#define _O_WRONLY   0x001 // Write only
#define _O_RDWR     0x002 // Read & Write
#define _O_CREAT    0x040 // Create
#define _O_TRUNC    0x200 // Para reescribir el archivo
#define _O_APPEND   0x400 // Append

// sys_open permisos con los que se crea el archivo
// mode
#define S_IXUSR 0100 // USER exec perm
#define S_IWUSR 0200 // USER write perm
#define S_IRUSR 0400 // USER read perm
#define S_IRWXU 0700 // USER read write exec perm 

int sys_read(int fd, void * buffer, int bytes);
int sys_write(int fd, void * buffer, int bytes);
int sys_open(const char * path, int flags, int mode);
int sys_close(int fd);
void function(int args_qty, char * args[]);


int compareNumbers(char a[],char b[])  
{  
    int flag=1,i=0;  
    while(i<5 && flag==1)  
    {  
       if(a[i]!=b[i])  
       {  
           flag=0;   
       }  
       i++;  
    }  
    if(flag==1){  
        return 1;  
    }
    return 0;  
}  


int main(void){

    int fdA = sys_open( "DatosA.txt" , 0x000 , 0 );
    int fdB = sys_open( "DatosB.txt" , 0x000 , 0 );

    char bufferA[5][5];
    char bufferB[5][5];
    char basura;

    for( int i=0 ; i<5 ; i++ ){
        sys_read( fdA , bufferA[i] , 5 );
        sys_read( fdA , &basura , 1 );
    }
    for( int i=0 ; i<5 ; i++ ){
        sys_read( fdB , bufferB[i] , 5 );
        sys_read( fdB , &basura , 1 );
    }    

    int fdC = sys_open( "DatosC.txt" , _O_CREAT | _O_RDWR , S_IRWXU );

    for( int i=0 ; i<5 ; i++ ){
        for( int j=0 ; j<5 ; j++ ){
            if( compareNumbers( bufferA[i] , bufferB[j] ) == 1 ){
                sys_write( fdC , bufferA[i] , 5 );
                sys_write( fdC , "\n" , 1 );
                j = 5;
            }
        }
    }
    sys_close(fdA);
    sys_close(fdC);
    sys_close(fdC);
}

