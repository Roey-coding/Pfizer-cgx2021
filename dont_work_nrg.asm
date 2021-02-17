%define BYTE_AFTER_DESIGNATED_JUMP 0xF8E2
%define DESIGNATED_JUMP_POSITION 0x70
%define OPCODE_FOR_JMP 0xA5FF
%define CCCC 0XCCCC
%define FIRST64 0x3E00
%define SECOND64 0xDE00
%define THIRD64 0x5E00
%define FIRST32 0x3C00
%define SECOND32 0xDC00
%define THIRD32 0x5C00
%define FIRST16 0xD800
%define SECOND16 0x3800
%define THIRD16 0x5800
%define FIRST8 0x3000
%define SECOND8 0xD000
%define THIRD8 0x5000
%define FIRST4 0x2000

%define ZOMBPLUS 0x0100
%define CARPET 0xF0F1

%define FIRST_ITERATION 41
%define REAL_OPS_BEFORE_TREE 23
%define NOPS 10
%define FIND_IN_87 0x0300
stosw

mov bx, ax
add bx, start_arr

mov cx, 3
NRG:
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
WAIT
loop NRG

mov cx, CARPET
mov [FIRST64 + ZOMBPLUS], cx
mov [SECOND64 + ZOMBPLUS], cx
mov [THIRD64 + ZOMBPLUS], cx
mov [FIRST32 + ZOMBPLUS], cx
mov [SECOND32 + ZOMBPLUS], cx
mov [THIRD32 + ZOMBPLUS], cx
mov [FIRST16 + ZOMBPLUS], cx
mov [SECOND16 + ZOMBPLUS], cx
mov [THIRD16 + ZOMBPLUS], cx
mov [FIRST8 + ZOMBPLUS], cx
mov [SECOND8 + ZOMBPLUS], cx
mov [THIRD8 + ZOMBPLUS], cx
mov [FIRST4 + ZOMBPLUS], cx

mov dx, ax
add dx, zombie_here
mov word [BYTE_AFTER_DESIGNATED_JUMP], CCCC

xor ax, ax

infinite:
jmp infinite
nop
	; This next line should be executed at step 41
xor ax, [FIRST64 + ZOMBPLUS]
xor ax, [SECOND64 + ZOMBPLUS]
xor ax, [THIRD64 + ZOMBPLUS]
xor ax, [FIRST32 + ZOMBPLUS]
xor ax, [SECOND32 + ZOMBPLUS]
xor ax, [THIRD32 + ZOMBPLUS]
xor ax, [FIRST16 + ZOMBPLUS]
xor ax, [SECOND16 + ZOMBPLUS]
xor ax, [THIRD16 + ZOMBPLUS]
xor ax, [FIRST8 + ZOMBPLUS]
xor ax, [SECOND8 + ZOMBPLUS]
xor ax, [THIRD8 + ZOMBPLUS]
xor ax, [FIRST4 + ZOMBPLUS]

;This will be optimized for ZOMA only, for a different zombie see excel that does not yet exist.

; This'll be once we have finished all the xor's, 
; we'd like to have around 95% certainty that we'd hit a zombie written code by now.

xlatb                   ;al = startL^startH
xchg al, ah             ;ah = startL^startH, al = zombArr[startL]
xlatb                   ;al = startL
xor ah, al

; ax = zombie base address

mov bx, ax
mov word [bx+DESIGNATED_JUMP_POSITION], OPCODE_FOR_JMP ;jmp [nxt_opcode]
; POSSIBLE OPCODES: E2F8, E63F, 0089; 0100-0800, F8E2, 8346, 3FE6, EB3F, CCCC
push ds
pop es
mov di, 0
mov ax, FIND_IN_87 ;little indi
mov dx, 0xE3D1 ;little indi
mov bx, FIND_IN_87 
mov cx, OPCODE_FOR_JMP 
int 0x87

main_loop:


jmp main_loop


END:
jmp END

zombie_here:
; Change to add int 87
push ds
pop es
mov di, 0
mov ax, FIND_IN_87 ;little indi
mov dx, 0xE3D1 ;little indi
mov bx, FIND_IN_87 
mov cx, OPCODE_FOR_JMP 
int 0x87
jmp zombie_here

start_arr:
db  0x0
db  0x2e
db  0x88
db  0xa6
db  0x2b
db  0x5
db  0xa3
db  0x8d
db  0x93
db  0xbd
db  0x1b
db  0x35
db  0xb8
db  0x96
db  0x30
db  0x1e
db  0x4e
db  0x60
db  0xc6
db  0xe8
db  0x65
db  0x4b
db  0xed
db  0xc3
db  0xdd
db  0xf3
db  0x55
db  0x7b
db  0xf6
db  0xd8
db  0x7e
db  0x50
db  0xfa
db  0xd4
db  0x72
db  0x5c
db  0xd1
db  0xff
db  0x59
db  0x77
db  0x69
db  0x47
db  0xe1
db  0xcf
db  0x42
db  0x6c
db  0xca
db  0xe4
db  0xb4
db  0x9a
db  0x3c
db  0x12
db  0x9f
db  0xb1
db  0x17
db  0x39
db  0x27
db  0x9
db  0xaf
db  0x81
db  0xc
db  0x22
db  0x84
db  0xaa
db  0x6a
db  0x44
db  0xe2
db  0xcc
db  0x41
db  0x6f
db  0xc9
db  0xe7
db  0xf9
db  0xd7
db  0x71
db  0x5f
db  0xd2
db  0xfc
db  0x5a
db  0x74
db  0x24
db  0xa
db  0xac
db  0x82
db  0xf
db  0x21
db  0x87
db  0xa9
db  0xb7
db  0x99
db  0x3f
db  0x11
db  0x9c
db  0xb2
db  0x14
db  0x3a
db  0x90
db  0xbe
db  0x18
db  0x36
db  0xbb
db  0x95
db  0x33
db  0x1d
db  0x3
db  0x2d
db  0x8b
db  0xa5
db  0x28
db  0x6
db  0xa0
db  0x8e
db  0xde
db  0xf0
db  0x56
db  0x78
db  0xf5
db  0xdb
db  0x7d
db  0x53
db  0x4d
db  0x63
db  0xc5
db  0xeb
db  0x66
db  0x48
db  0xee
db  0xc0
db  0x80
db  0xae
db  0x8
db  0x26
db  0xab
db  0x85
db  0x23
db  0xd
db  0x13
db  0x3d
db  0x9b
db  0xb5
db  0x38
db  0x16
db  0xb0
db  0x9e
db  0xce
db  0xe0
db  0x46
db  0x68
db  0xe5
db  0xcb
db  0x6d
db  0x43
db  0x5d
db  0x73
db  0xd5
db  0xfb
db  0x76
db  0x58
db  0xfe
db  0xd0
db  0x7a
db  0x54
db  0xf2
db  0xdc
db  0x51
db  0x7f
db  0xd9
db  0xf7
db  0xe9
db  0xc7
db  0x61
db  0x4f
db  0xc2
db  0xec
db  0x4a
db  0x64
db  0x34
db  0x1a
db  0xbc
db  0x92
db  0x1f
db  0x31
db  0x97
db  0xb9
db  0xa7
db  0x89
db  0x2f
db  0x1
db  0x8c
db  0xa2
db  0x4
db  0x2a
db  0xea
db  0xc4
db  0x62
db  0x4c
db  0xc1
db  0xef
db  0x49
db  0x67
db  0x79
db  0x57
db  0xf1
db  0xdf
db  0x52
db  0x7c
db  0xda
db  0xf4
db  0xa4
db  0x8a
db  0x2c
db  0x2
db  0x8f
db  0xa1
db  0x7
db  0x29
db  0x37
db  0x19
db  0xbf
db  0x91
db  0x1c
db  0x32
db  0x94
db  0xba
db  0x10
db  0x3e
db  0x98
db  0xb6
db  0x3b
db  0x15
db  0xb3
db  0x9d
db  0x83
db  0xad
db  0xb
db  0x25
db  0xa8
db  0x86
db  0x20
db  0xe
db  0x5e
db  0x70
db  0xd6
db  0xf8
db  0x75
db  0x5b
db  0xfd
db  0xd3
db  0xcd
db  0xe3
db  0x45
db  0x6b
db  0xe6
db  0xc8
db  0x6e
db  0x40