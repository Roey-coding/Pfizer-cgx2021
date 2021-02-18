%define BYTE_AFTER_DESIGNATED_JUMP 0xF8E2
%define DESIGNATED_JUMP_POSITION 0x70
%define OPCODE_FOR_JMP 0xA5FF
%define CCCC 0XCCCC
%define MEMORY_XCHANGE_AREA 0xDDDD
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

%define ZOMBPLUS 0x0200
%define ZOMBPLUS87 0x0300
%define CARPET 0xF0F1

%define FIRST_ITERATION 41
%define REAL_OPS_BEFORE_TREE 23
%define NOPS 10
%define OPCODES_AFTER_NRG 19
%define ITERATIONS_AFTER_NRG 13
%define JUMP_NRG_BYTE 0x5F
%define DOUBLE_NOP 0x9090
%define DEADS 25
%define START_LIST 214

db 0x90
mov bx, [MEMORY_XCHANGE_AREA]

;;;;;;;;;;;;;;;;;;;;
mov dx, ax
add dx, zombie_here
mov byte [CCCC], 0xB8
mov word [CCCC + 1], dx
mov word [CCCC + 3], 0xE0FF
mov word [0x26FF], CCCC

;;;;end

mov cx, CARPET					; Would you take a look at this beauty?
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


; Dead stuffs
mov cx, DEADS
dead_iterations:
loop dead_iterations

; Realese second survivor

mov ax, CARPET
add bx, START_LIST
mov word [BYTE_AFTER_DESIGNATED_JUMP], CCCC
mov word [bx + (JUMP_NRG_BYTE - START_LIST)], 0x0633

; This next line should be executed at step 41
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
mov word [bx+DESIGNATED_JUMP_POSITION], OPCODE_FOR_JMP

push ds
pop es
mov di, 0
mov ax, ZOMBPLUS87 ;little indi
mov dx, 0xE3D1 ;little indi
mov bx, ZOMBPLUS87
mov cx, OPCODE_FOR_JMP 
int 0x87

END:
jmp END

zombie_here:
; Change to add int 87
push ds
pop es
mov di, 0
mov ax, ZOMBPLUS87 ;little indi
mov dx, 0xE3D1 ;little indi
mov bx, ZOMBPLUS87
mov cx, OPCODE_FOR_JMP 
int 0x87
jmp zombie_here
