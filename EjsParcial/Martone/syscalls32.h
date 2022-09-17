#ifndef SYSCALLS_H
#define SYSCALLS_H

#define NULL ((void *) 0)
#define STDIN 0
#define STDOUT 1
#define STDERR 2

// sys_open permisos con los que abro el archivo
// flags
#define _O_RDONLY   0x000 // Read only
#define _O_WRONLY   0x001 // Write only
#define _O_RDWR     0x002 // Read & Write
#define _O_CREAT    0x040 // Create
#define _O_TRUNC    0x200 // Para reescribir el archivo
#define _O_APPEND   0x400 // Append

// sys_open permisos con los que se crea el archivo
// mode
#define S_IXUSR 0100 // USER exec perm
#define S_IWUSR 0200 // USER write perm
#define S_IRUSR 0400 // USER read perm
#define S_IRWXU 0700 // USER read write exec perm 

// para el clock_gettime
#define CLOCK_REALTIME 0

typedef long int time_t;

typedef struct timespec{
    time_t sec;
    long nanosec; // 0 - 999999999
} timespec;

extern void sys_exit(int errno);
extern int sys_fork();
extern int sys_read(int fd, void * buffer, int bytes);
extern int sys_write(int fd, void * buffer, int bytes);
extern int sys_open(const char * path, int flags, int mode);
extern int sys_close(int fd);
extern int sys_getpid();
extern time_t sys_time(time_t * tloc);
extern int sys_nanosleep(const timespec * req, timespec * rem);
extern int sys_clock_gettime(int clock, timespec * tp);

#endif