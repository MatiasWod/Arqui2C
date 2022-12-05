#include "lib64.h"

/***
* Funcion que retorna la longitud de un string.

* Argumento:
* - const char * str:  puntero a la direccion de memoria donde se encuentra el string.
*
* Retorno:
* - La longitud del string.
***/

int _strlen(const char * str){
    int i=0;
    while( *(str + (i++)) );
    return i-1;
}

/***
* Funcion que imprime en pantalla una string

* Argumento:
* - const char * str:  puntero a la direccion de memoria donde se encuentra el string.
*
* Retorno:
* - void
***/
void puts_64(char * string) {
    sys_write_64(STDOUT, string, _strlen(string));
}

/***
* Funcion que lee de la STDIN una string hasta max caracteres

* Argumento:
* - const char * str:  puntero a la direccion de memoria donde se encuentra el string.
*
* Retorno:
* - void
***/
int gets_64(char * string, int max) {
    return sys_read_64(STDIN, string, max);
}