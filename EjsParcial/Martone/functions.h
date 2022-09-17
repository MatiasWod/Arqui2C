#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include "syscalls32.h"
#define EOF -1
#define GET_CHAR_ERR -2

#define CLEAN_BUFFER {if(c != '\n' && c > 0) while(getchar() != '\n');}
#define isNum(a) ((a) >= '0' && (a) <= '9')
#define isMinus(c) ((c) >= 'a' && (c) <= 'z')
#define isMayus(c) ((c) >= 'A' && (c) <= 'Z')
#define charToNum(a) ((a) - '0')
#define UTC -3
#define SECS_DAY (60*60*24)

// devuelve la longitud del str
int strlen(const char * str);

// imprime a STDOUT la cantidad de bytes
// recibidos por parametro del string recibido
void printBytes(const char * str, int bytes);

// imprime el string a STDOUT
void print(const char * str);

// imprime a STDOUT el caracter que recibe por parametro
void _putchar(char c);


void perror(const char * str);

// imprime un '\n' a STDOUT
void newLine();

// imprime el long recibido
void printLong(long num);

// imprime el int recibido
void printInt(int num);

// obtiene el caracter actual de STDOUT
int getchar();

// obtiene el caracter actual en el fd que recibe
int getcharfd(int fd);

// obtiene una linea de el archivo que recibe, guarda el String en buffer, hasta bufferlen caracteres
int getlinefd(int fd, char * buffer, unsigned long bufferlen);

// guarda el numero que recibe en el buffer, hasta bufferSize caracteres
long numToString(long number, char * buffer, long bufferSize);


// funciones para timear
// inicia el timer
int startClock();
// termina el timer
int endClock();
// devuelve por parametro el tiempo que paso en segundos y nanosegundos en el intervalo
int getClockInterval(long * sec, long * nanosec);

// devuelve el numero obtenido de STDIN
long getNum();

// devuelve el numero presente actualmente en el archivo
// representado por el fd, lee hasta digitcount
// si no hay un numero en donde lee hace cualquier cosa
int getNumfd(int fd, int digitCount);

// devuelve el numero que recibe en formato string
// si el string no esta en formato numero hace cualquier cosa
long strToNum(char * str);

// imprime la fecha X segundos desde EPOCH 
void printDate(long secSinceEpoch);

// imprime la hora del dia X segundos desde EPOCH 
void printHour(long secSinceEpoch);

// frena el programa sec segundos
int sleep(long sec);

// frena el programa sec segundos y nanosec nanosegundos
int nanoSleep(long sec, long nanosec);


// mergesort, recibe un arr de int el indice de la izq y el indice de la derecha
// si quiero ordenar todo un arr le paso (arr, 0, dim - 1)
void mergeSort(int arr[], int l, int r);

// imprime a pantalla los primeros dim elementos del arr
void printArray(int arr[], int dim);

// devuelve la cantidad de veces que la palabra en buff de tamanio longitud esta en el archivo fd
int KMPsearch(char * buffer,int longitud,int fd);

// KMPsearch, pero no case sensitive
int KMPsearchNonSensitive(char * buffer,int longitud,int fd);


// void printHexa(char byte[4]);
#endif