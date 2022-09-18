#include <stdio.h>
#include <stdlib.h> 
#include <string.h>

#define _O_RDONLY   0x000

int sys_write(int fd, char * str, int len);
int sys_read(int fd, void * buffer, int bytes);
int sys_open(const char * path, int flags, int mode);
int sys_close(int fd);
void function(int args_qty, char * args[]);



void function(int args_qty, char * args[]){

    if( args_qty != 5 ){
        sys_write( 0 , "Error" , 5 );
        return;
    }


    int cant[5]={0};
    char current[1]={0};
    int err=1;

    int fd = sys_open( "file.txt" , 0x002 , 0 );
    //Asumo que no tiene mas de 100 caracteres
    for( int i=0 ; i<100 && (err==1) ; i++  ){
        err = sys_read( fd , current , 1 );
        //printf("%c\n",current[0]);
        for( int j=1 ; j<5 ; j++ ){
            if( current[0] == args[j][0] ){
                //printf("bol/n");
                cant[j] = cant[j]+1;
            }
        }
    }
    sys_close(fd);

    printf("%d\n",cant[1]);
    printf("%d\n",cant[2]);
    printf("%d\n",cant[3]);
    printf("%d\n",cant[4]);
}