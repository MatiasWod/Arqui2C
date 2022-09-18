#include <math.h>

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

double str_to_double(char str[]);
void double_to_str(double num, char * ans);
int promedio(int argc, char *argv[]);
len_int_part(int num);

int promedio(int argc, char *argv[]){
    double sum;
    char resp[32]={0};
    for(int i=1;i<argc;i++){
        sum+=str_to_double(argv[i]);
    }
    double_to_str(sum/(argc-1), resp);
    sys_write(0,resp,32);
    return 0;
}

double str_to_double(char str[]){
    int i = 0;
    int negative_number = 0;
    // Verifico si es un numero negativo
    // Si es negativo entonces tengo que aumentar en 1 el i y ademas encender el flag negative_number
    if(str[i] == '-'){
        i++;
        negative_number = 1;
    }
    // Creo la variable donde voy a guardar el valor a retornar
    double ans = 0;
    // Recorro el string hasta el punto o hasta que encuentre un 0
    for(; str[i] != 0 && str[i] != '.'; i++){
        ans *= (double) (10*i);
        int number = str[i] - '0';
        ans += (double)number;
    }
    // Creo una variable que me indica si el numero ingresado tiene un punto
    int dot = 0;
    // Si tiene un punto enciendo el flag dot
    if(str[i] == '.'){
        dot = 1;
    }
    // Si tiene un punto me falta aumentar toda la parte decimal al numero final
    if(dot){
        // Incremento i para empezar a leer los decimales
        i++;
        // Me creo una variable para obtener los decimales
        double decimal_part = 0;
        // Creo una variable para poder saber cuantos decimales tiene
        int decimal_count = 0;
        // Recorro el string hasta obtener un 0 y obtengo la parte decimal como entera
        for(int j = 0; str[i] != 0; i++, j++){
            decimal_part *= (double) (10*j);
            int number = str[i] - '0';
            decimal_part += (double)number;
            decimal_count++;
        }
        // Teniendo la parte decimal como entera la divido por 10 a la cantidad de decimales
        // para poder pasar de entera a decimal
        decimal_part = decimal_part / pow(10, decimal_count);
        // Finalmente se lo sumamos a la respuesta para poder retornarlo
        ans += decimal_part;
    }
    // Si es un numero negativo lo que tengo que hacer es multiplicar el total por -1
    if(negative_number){
        ans *= -1;
    }
    // Retornamos el numero
    return ans;
}

void double_to_str(double num, char * ans){
    int int_part = (int) num;
    int int_part_len = len_int_part(int_part);
    // Sumo la parte entera + el punto + los 3 decimales + el 0 del final
    //char ans[int_part_len + 1 + 3 + 1];
    
    for(int i = 0; i < int_part_len; i++){
        int aux = int_part % 10;
        ans[int_part_len - 1 - i] = aux + '0';
        int_part /= 10;
    }
    // Hasta aca tenemos la parte entera
    // Ponemos el "."
    ans[int_part_len] = '.';
    double decimal_part = num - (double) int_part;
    int decimal_part_int = decimal_part * 1000;
    for(int j = int_part_len + 1, k = 0; j < int_part_len+4; j++, k++){
        int aux = decimal_part_int % 10;
        ans[int_part_len + 3 - k] = aux + '0';
        decimal_part_int /= 10;
    }
    ans[int_part_len + 1 + 3] = 0;
}

int len_int_part(int num){
    if(num == 0){
        return 1;
    }
    int i = 0;
    while(num != 0){
        i++;
        num = num/10;
    }
    return i;
}
