%define BYTE_AFTER_DESIGNATED_JUMP 0xF8E2
%define DESIGNATED_JUMP_POSITION 0x70
%define OPCODE_FOR_JMP 0xA5FF
%define CCCC 0XCCCC
%define MEMORY_XCHANGE_AREA 0xDDDD
%define FIRST64 0x3F00
%define SECOND64 0xDF00
%define THIRD64 0x5F00
%define FIRST32 0x3D00
%define SECOND32 0xDD00
%define THIRD32 0x5D00
%define FIRST16 0xD900 ;
%define SECOND16 0x3900
%define THIRD16 0x5900
%define FIRST8 0x3100 ;
%define SECOND8 0xD100
%define THIRD8 0x5100
%define FIRST4 0x2100

%define ZOMBPLUS 0x0200
%define ZOMBPLUS87 0x0300
%define CARPET 0xF0F1

%define FIRST_ITERATION 41
%define REAL_OPS_BEFORE_TREE 23
%define NOPS 10
%define OPCODES_AFTER_NRG 19
%define ITERATIONS_AFTER_NRG 13
%define JUMP_NRG_BYTE 0x6b
%define DOUBLE_NOP 0x9090
%define DEADS 6
%define START_LIST 224


; Saving the at-risk code in stack.
mov si, ax
and si, 0xff00
add si, 0x0100
push word [si]
add si, 0x0100
push word [si]
; Finish save.

mov bx, [MEMORY_XCHANGE_AREA]

mov cx, bx
add cx, 0x0300
and cx, 0x0700
; Now cx is the zombie we'd like to find.


push bx
mov bx, cx
;;;;;;;;;;;;;;;;;;;;
mov dx, ax
add dx, zombie_here
mov byte [CCCC], 0xB8
mov word [CCCC + 1], dx
mov word [CCCC + 3], 0xE0FF
mov word [0x26FF], CCCC
;;;;end

; Dead stuffs
mov cx, DEADS
dead_iterations:
loop dead_iterations

mov cx, CARPET					; Would you take a look at this beauty?
mov [FIRST32 + bx], cx
mov [SECOND32 + bx], cx
mov [THIRD32 + bx], cx
mov [FIRST16 + bx], cx
mov [SECOND16 + bx], cx
mov [THIRD16 + bx], cx
mov [FIRST8 + bx], cx
mov [SECOND8 + bx], cx
mov [THIRD8 + bx], cx
mov [FIRST4 + bx], cx




xchg bx,cx
; Realese second survivor
pop bx
push ax
mov ax, CARPET
add bx, START_LIST
push bx
mov word [BYTE_AFTER_DESIGNATED_JUMP], CCCC
mov word [bx + (JUMP_NRG_BYTE - START_LIST)], 0x8433
xchg bx,cx


; This next line should be executed at step 41
xor ax, [FIRST32 + bx]
xor ax, [SECOND32 + bx]
xor ax, [THIRD32 + bx]
xor ax, [FIRST16 + bx]
xor ax, [SECOND16 + bx]
xor ax, [THIRD16 + bx]
xor ax, [FIRST8 + bx]
xor ax, [SECOND8 + bx]
xor ax, [THIRD8 + bx]
xor ax, [FIRST4 + bx]

xchg bx,cx

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

pop ax
pop cx
mov [si], cx
sub si, 0x0100
pop cx
mov [si], cx

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
db 0xcc
db 0xcc
push ds
pop es
mov di, 0
mov ax, ZOMBPLUS87 ;little indi
mov dx, 0xE3D1 ;little indi
mov bx, ZOMBPLUS87
mov cx, OPCODE_FOR_JMP 
int 0x87
jmp zombie_here
