;------------------------------------------
; int atoi(Integer Number)
; Ascii to integer function (atoi)
atoi:
    push    ebx                 ; clear and save values for later use after the function
    push    ecx
    push    edx
    push    esi
    mov     esi, eax            ; assign esi to the location of eax (eax is the number we are trying to convert)
    mov     eax, 0              ;set eax and ecx to 0
    mov     ecx, 0

.multiplyLoop:
    xor     ebx, ebx            ; set the lower register bit to 0
    mov     bl, [esi+ecx]       ; assign ebx lower bit to the location of the number we are trying to convert
    cmp     bl, 48              ; check if it is a number
    jl      .finished           ; ^
    cmp     bl, 57              ; |
    jg      .finished           ; |

    sub     bl, 48              ; convert lower register bit to decimal
    add     eax, ebx            ; add ebx to our total int value
    mov     ebx, 10             ;
    mul     ebx                 ; multiply eax by ebx to get the place value
    inc     ecx                 ; increment counter
    jmp     .multiplyLoop

.finished:
    cmp     ecx, 0              ; check if there were any args
    je      .restore            ; if it was equal to zero then restore stack values
    mov     ebx, 10             ; assign ebx to 10
    div     ebx                 ; divide eax by 10 to get original number

.restore:
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx
    ret






;------------------------------------------
; void iprint(Integer number)
; Integer printing function

iprint:
    push    eax
    push    ecx
    push    edx
    push    esi
    mov     ecx, 0

divideLoop:
    inc     ecx                     ; count each byte to print

    mov     edx, 0                  ; make sure edx is empty
    mov     esi, 10                 ; move 10 into the esi to divide with

    idiv    esi                     ; divides eax by esi
    add     edx, 48                 ; converts edx to ACSII (edx holds the remainder after division)
    push    edx                     ; pushes converted character to the stack
    cmp     eax, 0
    jnz     divideLoop

printLoop:
    dec     ecx
    mov     eax, esp                ; move eax to the first address of the int we need to print
    call    sprint
    pop     eax                     ; unused don't take up memory
    cmp     ecx, 0                  
    jnz     printLoop

    pop     esi
    pop     edx
    pop     ecx
    pop     eax
    ret


;------------------------------------------
; void iprintLF(Integer number)
; Integer printing function with line feed (itoa)

iprintLF:
    call    iprint

    push    eax                     ; save value
    mov     eax, 0Ah
    push    eax                     ; push line feed character to stack
    mov     eax, esp
    call    sprint
    
    pop     eax                     ; popped to remove line feed character
    pop     eax                     ; popped to return to original value before function
    ret





;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    ebx                      ; pushes the value in ebx onto the stack for reuse after the function
    mov     ebx, eax

nextchar:
    cmp     byte[eax], 0             ; compare the byte pointed to by EAX at this address against zero
    jz      finished
    inc     eax                      ; increment eax if the zero flag has not been set
    jmp     nextchar                 ; reloop

finished:
    sub     eax, ebx
    pop     ebx                      ; takes the original value of ebx and reassigns it
    ret                              ; returns to where the function was called



;--------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen

    mov     edx, eax
    pop     eax

    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h

    pop     ebx
    pop     ecx
    pop     edx
    ret


;------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint


    push    eax
    mov     eax, 0Ah

    push eax


    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret


;-------------------------------------------
; void exit()
; exit program and restore resources
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret





