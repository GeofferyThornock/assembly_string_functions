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





