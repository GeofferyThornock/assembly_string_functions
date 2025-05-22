%include "functions.asm"

SECTION     .data
fizz        db      "Fizz", 0h
buzz        db      "Buzz", 0h

SECTION     .text
global  _start
_start:
    mov     esi, 0      ;initialize counters and checking bools
    mov     edi, 0
    mov     ecx, 0

nextNumber:
    inc     ecx

.checkFizz:
    mov     edx, 0      ; clear the register we divide by
    mov     eax, ecx    ; assign eax to the counter number
    mov     ebx, 3      ; assign the number we are going to divide by
    div     ebx         ; divide eax by 3
    mov     edi, edx    ; move the remainder into our boolean variable
    cmp     edi, 0      ; see if it's true or false
    jne     .checkBuzz  ; if false then jump to .checkBuzz
    mov     eax, fizz   ; move the message into eax then call sprint
    call    sprint
                        ;then moving on to buzz sprint does not print on a seperate line

.checkBuzz:
    mov     edx, 0
    mov     eax, ecx
    mov     ebx, 5
    div     ebx
    mov     esi, edx
    cmp     esi, 0
    jne     .checkInt
    mov     eax, buzz
    call    sprint  

.checkInt:              ; checks if it's just a normal number not divisible by 3 or 5
    cmp     edi, 0
    je      .continue
    cmp     esi, 0
    je      .continue
    mov     eax, ecx
    call    iprint

.continue:              ; moves a new line into the stack so we always have a new line
    mov     eax, 0Ah
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    cmp     ecx, 100
    jne     nextNumber

    call    quit







