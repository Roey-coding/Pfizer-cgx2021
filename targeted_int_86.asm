%define ADDR 0x0000

push ds
pop es
mov ax, 0xcc
mov dx, 0xcc
mov di, ADDR
int 0x86