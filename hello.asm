%include    "functions.asm"


SECTION .data
    msg     db      "Please enter your name: ", 0h
    msg2    db      "Hello, ", 0h
 
SECTION .bss
sinput:     resb 255


SECTION .text
global  _start
_start:

    mov     eax, msg
    call    sprint

    mov     edx, 255        ;number of bytes to read
    mov     ecx, sinput     ;reserved space to store our input
    mov     ebx, 0          ;read from the stdin file
    mov     eax, 3          ;invoke sys_read (kernal OPCODE 3)
    int     80h


    mov     eax, msg2
    call    sprint

    mov     eax, sinput
    call    sprint

    call    quit




