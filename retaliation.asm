%define SEMPELING_ADDR 0xE63F
%define SEMPELING_ADDR1 0XF8E2

cmp [SEMPELING_ADDR], 0xcccc
je hzlash: 

mov bx, [SEMPELING_ADDR]

push ds
pop es
mov ax, 0xcccc
mov dx, 0xcccc
mov di, bx
int 0x86

hzlash:

cmp [SEMPELING_ADDR1], 0xcccc
je hzlash: 

mov bx, [SEMPELING_ADDR1]

push ds
pop es
mov ax, 0xcccc
mov dx, 0xcccc
mov di, bx
int 0x86