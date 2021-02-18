%define SEMPELING_ADDR 0xE63F

xor [0xE63F], 0xcccc
je hzlash: 

mov bx, [0xE63F]

push ds
pop es
mov ax, 0xcccc
mov dx, 0xcccc
mov di, bx
int 0x86

hzlash: