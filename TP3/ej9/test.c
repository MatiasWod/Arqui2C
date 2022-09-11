//ej9.c
#include<string.h>
#include<stdio.h>
#define STDOUT 1
#define STDIN 0
#define SIZE 32

//Devuelve el numero de bytes que escribio
int puts(const char*);

//Devuelve el numero de bytes que leyo
int read(int,const char*);

//Devuelve el filedescriptor
int openFile(const char*,int,int);

//Devuelve en caso de error, el codigo de error
//void closeFile(int);

int sys_write(int fd, void *buffer, int size);
int sys_read(int fd,void* buffer,int size);
int sys_open_file(const char* filename,int accesmode,int filepermissions);
void sys_close_file(int filedescriptor);
void print(const char* string);

int read(int fd,const char* str){
    int length = strlen(str);
    return sys_read(fd,(void *) str,length);
}

int openFile(const char* filename,int accessmode,int permisos){
    return sys_open_file(filename,accessmode,permisos);
}

void closeFile(int filedescriptor){
    sys_close_file(filedescriptor);
}

int writeFile(int filedescriptor,char* data,int size){
    return sys_write(filedescriptor,data,size);
}

int main(int argc,char* argv[]){
    int filedescriptor = openFile("ejemplo.txt",2,0777);
    //pongo 0 para que me de read only access, y pongo
    //0777 para que me de read,write y exec
    char buffer[SIZE];
    int sizeRead =read(filedescriptor,buffer);
    printf("%d\n",sizeRead);
    char* data="1";
    int sizeWrite = writeFile(filedescriptor,data,strlen(data));
    printf("%d\n",sizeWrite);
    for(int i=0;i < 7;i++)
        sizeWrite = writeFile(filedescriptor,data,strlen(data));
    closeFile(filedescriptor);
    sizeRead = read(filedescriptor,buffer);//deberia saltar
    //error ya que el fd ya no es valido
    printf("%d\n",sizeRead);
    return 0;
}