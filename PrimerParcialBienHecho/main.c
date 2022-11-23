#include <string.h>
#include <stdlib.h>
#include <stdio.h>
extern int sys_read(int fd, void * buffer, int bytes);
extern void binarySearch(int search,int* array,int size);
extern int sys_write(int fd, void * buffer, int bytes);
long strToNum(char * str);
#define charToNum(a) ((a) - '0')


long strToNum(char * str) {
    long num = 0;
    for(int i = 0; str[i] != 0; i++) {
        num *= 10;
        num += charToNum(str[i]); 
    }
    return num;
}

int main(int argc,char * argv[]){
   
    int num=strToNum(argv[1]);

    int array[31];
    int size=strlen(argv[2]);
    char * token=strtok(argv[2],",");
    int i=0;
    while(token!=NULL && i<size ){
        array[i]=strToNum(token);
        token=strtok(NULL,",");
        i++;
    }
    size=i-1;


    binarySearch(num,array,size);
}