#include <stdio.h>
#include <stdlib.h> 

//Modifique este código de forma tal que se pueda llamar desde una función C la cual 
//recibirá el número tope desde stdin y pasará esa información al código asm modificado 
//para realizar la impresión de los números primos.

//Asumo que la suma esta bien, Esta imprime la suma de los numeros primos en HEXA

void numeros_primos( int tope );

//Funcion de la cual llamamos a numeros_primos 

void function(int args_qty, char * args[]){

    // Se reciben dos argumentos, el nombre del archivo (./primos) 
    // y el numero que el usuario envie como parametro

    if ( args_qty != 2 ){
        printf("Error en la cantidad de argumentos\n");
        return;
    }

    int tope = atoi( args[1] );

    if( tope==0 && ( args[1][0]=='0' && args[1][1]!=0 ) ){
        printf("El parametro debe ser un numero.\n");
        return;
    }
    if( tope<2 ){
        printf("0\n");
        return;
    }
    
    numeros_primos( tope );
}