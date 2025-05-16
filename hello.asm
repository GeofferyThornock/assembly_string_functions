%include    "functions.asm"


SECTION .data
    msg     db      "Hello, new world!", 0h
    msg2    db      "Now this is an epic gamer moment", 0h
 
SECTION .text
global  _start
_start:
    pop     ecx

nextArg:
    cmp     ecx, 0h
    jz      noMoreArgs
    pop     eax
    call    sprintLF
    dec     ecx
    jmp     nextArg


noMoreArgs:
    call    quit




