#define SIZE 11

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

int strlen(const char * str);
long numToString(long number, char * buffer, long bufferSize);
int getlinefd(int fd, char * buffer, unsigned long bufflen);
int getcharfd(int fd);
void print(const char * str);
void printBytes(const char * str, int bytes);
void newLine();
void _putchar(char c);
void printLong(long num);
void printInt(int num);

int main(){
    char buffer[SIZE];
    getlinefd(0,buffer,SIZE);
    int count=0;
    int counts[9]={0};
    for(int i=0;buffer[i]!=0;i++){
        if(counts[buffer[i]-'0']==0){
            for(int j=i;buffer[j]!=0;j++){
                if(buffer[i]==buffer[j])
                    counts[buffer[i]-'0']++;
            }
        }
    }
    int max;
    count=0;
    for(int i=0;i<9;i++){
        if(count<counts[i]){
            max=i;
            count=counts[i];
        }
            
    }
    print("El numero que aparece mas veces es:");
    printInt(max);
    newLine();
    
    return 0;
}


int strlen(const char * str) {
    int len;
    for(len = 0; str[len] != '\0'; len++);
    return len;
}

int getlinefd(int fd, char * buffer, unsigned long bufflen) {
    int dim = 0;
    int c;
    while(dim < (bufflen - 1) && (c = getcharfd(fd)) != '\n' && c != EOF) {
        buffer[dim++] = c;
    }
    buffer[dim] = '\0';
    return dim;
}

int getcharfd(int fd) {
    char c;
    int read = sys_read(fd, &c, 1);
    if(read == 1) return c;
    if(read < 0 || read > 1) return GCERR;
    return EOF;
}
void print(const char * str) {
    printBytes(str, strlen(str));
}
void printBytes(const char * str, int bytes) {
    sys_write(STDOUT, (void *)str, bytes);
}
void newLine() {
    _putchar('\n');
}
void _putchar(char c) {
    sys_write(STDOUT, (void *) &c, 1);
}
void printLong(long num) {
    char buff[32];
    printBytes(buff, numToString(num, buff, 32));
}
void printInt(int num) {
    printLong(num);
}

long numToString(long num, char * buffer, long bufferSize) {
    if(bufferSize <= 0) return 0;

    if(num == 0) {
        buffer[0] = '0';
        buffer[1] = '\0';
        return 1;
    }
    int isNeg = 0;
    if(num < 0) {
        buffer[0] = '-';
        num = -num;
        isNeg = 1;
    }
    long aux = num;
    long digitcount = 0;
    while(aux > 0) {
        aux /= 10;
        digitcount++;
    }
    
    long startPos = digitcount + isNeg - 1;
    if(startPos + 1 > bufferSize) return 0;
    buffer[startPos+1] = '\0';
    for(int i = 0; i < digitcount; i++) {
        buffer[startPos - i] = num % 10 + '0';
        num /= 10;
    }
    return startPos + 1;
}
