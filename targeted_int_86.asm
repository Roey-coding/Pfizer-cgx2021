%define ADDR 0x0000

push ds
pop es
mov ax, 0xFF26
mov dx, 0xFF26
mov di, ADDR
int 0x86