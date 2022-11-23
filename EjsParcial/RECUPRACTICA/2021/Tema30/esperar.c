#include <time.h>
#include <stdio.h>
#include <unistd.h>

#define UTC -3
#define SECS_DAY (60*60*24)

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
extern long sys_time(long * tloc);

int main(){
    // Abrimos ambos archivos y le asignamos permisos de lectura
    int fdA = sys_open("DatosA.txt", _O_RDONLY, 0);
    if(fdA < 0){
        char errmsg[] = "Error, no se pudo abrir el archivo A\n";
        printf("%s",errmsg);
        sys_exit(fdA);
    }
    char buf[64];
    sys_read(fdA, buf, 64);
    extern int sys_close(fdA);

    int count=0;
    int esperar=0;
    for(int i=0;buf[i]!=0;i++){
        if (buf[i]!=' '){
            esperar+=(buf[i]-'0')*pow(10,count); //seria al revez aca multiplico al ultimo por 10
            count++;
        }
        if(buf[i]==' ' || buf[i+1]==0){
            if(esperar!=0){
                sleep(esperar);
                long time;
                sys_time(&time);
                time += UTC * 3600;
                print_hour(time);
                print_date(time);
                printf("\n");
            }
            count=0;
            esperar=0;
        }
    }

    return 0;
}

void print_hour(long time){
int t = time%SECS_DAY;
char hour[] = {'0','0',':','0','0',':','0','0'};
int seg = t%60;
int min = (t%3600)/60;
int h = t/3600;
hour[0] += h/10;
hour[1] += h%10;
hour[3] += min/10;
hour[4] += min%10;
hour[6] += seg/10;
hour[7] += seg%10;
sys_write(STDOUT, "hora: ", 6);
sys_write(STDOUT, hour, 8);
sys_write(STDOUT, "\n", 1);
}

void print_date(long time){
    int mdays[2][12] = {{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
{31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}};
// String con el formato a imprimir
char date[] = {'0','0','/','0','0','/','0','0','0','0'};
// Cantidad de dias desde epoch
int t = time/(SECS_DAY) + 1;
int year = 1970;
int month = 1;
while( t >= (365 + leapYear(year)) ){
t -= 365 + leapYear(year);
year++;
}
int leap = leapYear(year);
while( t >= mdays[leap][month-1] ){
t -= mdays[leap][month-1];
month++;
}
// Completamos el string de fecha
date[0]+= t/10;
date[1]+= t%10;
date[3]+= month/10;
date[4]+= month%10;
date[6]+= year/1000;
date[7]+= (year%1000)/100;
date[8]+= (year%100)/10;
date[9]+= year%10;
sys_write(STDOUT, "fecha: ", 7);
sys_write(STDOUT, date, 10);
sys_write(STDOUT, "\n", 1);
}

int leapYear(int year){
if (year % 400 == 0) {
return 1;
}
else if (year % 100 == 0) {
return 0;
}
else if (year % 4 == 0) {
return 1;
}
return 0;
}

double pow(double base, double exp){
    double ans = base;
    for(int i = 0; i < (exp-1); i++){
        ans *= ans;
    }
    return ans;
}