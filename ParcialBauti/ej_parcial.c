#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define GCERR -2               // Error del getchar
#define STDIN  0               // FD Standard input
#define STDOUT 1               // FD Standard output
#define STDERR 2               // FD Standard error

#define MAX_BUFF 128

extern int sys_write(int fd, void *buffer, int size);
extern int sys_read(int fd, void *buf, int count);
extern int sys_exit(int error);
void print_primes(int tope);

int str_to_num(char * str, int longitud);
int strlen(char * str);
int _getline(char * buffer);
int _getchar(int fd);


int main(){
    sys_write(STDOUT,"Ingrese la cantidad de numeros que desea imprimir:\n",strlen("Ingrese la cantidad de numeros que desea imprimir:\n"));
    char buffer[MAX_BUFF];
    /*Funcion que me permite leer lo que se ingresa por consola*/
    _getline(buffer);
    /*valido que lo ingresado sean numeros*/
    int i = 0;
    for( i = 0 ; buffer[i] != 0 ; i++){
        if( (buffer[i] < '0') || (buffer[i]>'9') ){
            char errmsg[] = "La linea ingresada no es un numero\n";
            sys_write(STDERR, errmsg , strlen(errmsg));
            sys_exit(-1);
        }
    }
    int tope = str_to_num(buffer,strlen(buffer));
    print_primes(tope);
}

int str_to_num(char * str, int longitud){
    int neg = 0;
    if(str[0] == '-'){
        neg = 1;
    }
    int num = 0;
    for(int i=neg ; i<longitud ; i++){
        num = num*10 + str[i] - '0';
    }
    if(neg){
        num*=-1;
    }
    return num;
}

int strlen(char * str){
    int i = 0;
    while(str[i] != 0){
        i++;
    }
    return i;
}

int _getline(char * buffer){
    int idx;
    char c;
    for(idx = 0 ; (idx< MAX_BUFF ) && (c=_getchar(STDIN))!='\n' ; idx++){
        buffer[idx] = c;
    }
    if(idx == MAX_BUFF){
        char errmsg[] = "La linea ingresada es demasiado larga \n";
        sys_write(STDERR, errmsg , strlen(errmsg));
        sys_exit(-1);
    }
    buffer[idx] = 0;
    return idx;
}

int _getchar(int fd) {
    char c;
    int returnval = sys_read(fd, &c, 1);
    if ( returnval == 1)
        return c;
    if( returnval < 0 )
        return GCERR;
    return EOF;
}