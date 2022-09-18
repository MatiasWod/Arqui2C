#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double pow(double base, double exp);
int sys_write(int file_descriptor, char * str, int len);

int strlen(char * str);
double str_to_double(char str[]);
void double_to_str(double num, char * ans);
int len_int_part(int num);

int main(int argc, char * argv[]){
    double a = str_to_double(argv[1]);
    double b = str_to_double(argv[2]);
    double c = str_to_double(argv[3]);

    // Test pasaje de str a double
    // printf("A: %f\n", a);
    // printf("B: %f\n", b);
    // printf("C: %f\n", c);

    // Test pasaje de double a string
    // double num = 123.4567;
    // char str_num[256];
    // double_to_str(num, str_num);
    // printf("String %s\n", str_num);

    double discriminant = ((b * b) - (4 * a * c));
    double root1, root2;

    if(discriminant > 0) {
        root1 = (-b + sqrt(discriminant)) / (2 * a);
        root2 = (-b - sqrt(discriminant)) / (2 * a);
        char str_root1[256];
        char str_root2[256];
        double_to_str(root1, str_root1);
        double_to_str(root2, str_root2);
        sys_write(1, "Raiz 1 = ", strlen("Raiz 1 = "));
        sys_write(1, str_root1, strlen(str_root1));
        sys_write(1, "\n", 1);
        sys_write(1, "Raiz 2 = ", strlen("Raiz 2 = "));
        sys_write(1, str_root2, strlen(str_root2));
        sys_write(1, "\n", 1);
    }else if(discriminant == 0) {
        root1 = -b / (2 * a);
        char str_root1[256];
        double_to_str(root1, str_root1);
        sys_write(1, "Raiz 1 = Raiz 2 = ", strlen("Raiz 1 = Raiz 2 = "));
        sys_write(1, str_root1, strlen(str_root1));
        sys_write(1, "\n", 1);
    }else if(discriminant < 0){
        double realPart = -b / (2 * a);
        double imagPart = sqrt(-discriminant) / (2 * a);
        char str_realPart[256];
        char str_imagPart[256];
        double_to_str(realPart, str_realPart);
        double_to_str(imagPart, str_imagPart);
        sys_write(1, "Raiz 1 = ", strlen("Raiz 1 = "));
        sys_write(1, str_realPart, strlen(str_realPart));
        sys_write(1, " + ", strlen(" + "));
        sys_write(1, str_imagPart, strlen(str_imagPart));
        sys_write(1, "i", strlen("i"));
        sys_write(1, "\n", 1);

        sys_write(1, "Raiz 2 = ", strlen("Raiz 2 = "));
        sys_write(1, str_realPart, strlen(str_realPart));
        sys_write(1, " - ", strlen(" + "));
        sys_write(1, str_imagPart, strlen(str_imagPart));
        sys_write(1, "i", strlen("i"));
        sys_write(1, "\n", 1);
    }
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
        ans *= (double) (10);
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
    int neg=0;
    if(num<0){
        neg=1;
    }

    int int_part = (int) num;
    int int_part_len = len_int_part(int_part);

    if (neg){
        int_part*=-1;
        int_part_len++;
    }

    // Sumo la parte entera + el punto + los 3 decimales + el 0 del final
    //char ans[int_part_len + 1 + 3 + 1];
    
    for(int i = 0; i < int_part_len; i++){
        int aux = int_part % 10;
        ans[int_part_len -1 -i] = aux + '0';
        int_part /= 10;
    }
    // Hasta aca tenemos la parte entera
    // Ponemos el "."
    ans[int_part_len] = '.';
    double decimal_part;
    if(neg)
        decimal_part= -1*num - (double) int_part;
    else
        decimal_part= num - (double) int_part;
    int decimal_part_int = decimal_part * 1000;
    for(int j = int_part_len + 1, k = 0; j < int_part_len+4; j++, k++){
        int aux = decimal_part_int % 10;
        ans[int_part_len + 3 - k] = aux + '0';
        decimal_part_int /= 10;
    }
    ans[int_part_len + 1 + 3] = 0;
    if(neg)
        ans[0]='-';
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

double pow(double base, double exp){
    double ans = base;
    for(int i = 0; i < (exp-1); i++){
        ans *= ans;
    }
    return ans;
}

int strlen(char * str){
    int i = 0;
    while(str[i] != 0){
        i++;
    }
    return i;
}