%include    "functions.asm"


SECTION .data
    msg     db      "Hello, new world!", 0h
    msg2    db      "Now this is an epic gamer moment", 0h
 
SECTION .text
global  _start
_start:
    mov     eax, msg
    call    sprintLF
    
    mov     eax, msg2
    call    sprintLF

    call quit




