PUBLIC Output_binary
PUBLIC New_Line
EXTRN Number:byte

StkSeg  SEGMENT PARA STACK 'STACK'
        DB      200h DUP    (?)
StkSeg  ENDS

Code    SEGMENT WORD PUBLIC 'CODE'
        ASSUME  CS:Code, SS:StkSeg

New_Line:
        mov     DL, 0Ah                 ; Выставляем курсор на новую строку (0A в stdout)
        mov     AH, 2                   ; Вывод в stdout 
        INT     21h
        mov     DL, '$'                 ; Выставляем курсор на новую строку (0A в stdout)
        mov     AH, 2                   ; Вывод в stdout 
        INT     21h
        ret   
    read:                           ; Нам нужно 2-е число, так что двигаем на 1

        xor     AX,AX
	    LODSB                                   ; Считываем из DS:SI, SI += 1
    
        sub     AX, '0'
        mov     BX, AX
        mov     AX, DX
        xor     DX,DX
        mov     DL, 10
        mul     DX
        mov     DX,AX
        add     DX,BX
        loop    read
        mov     BX,DX
        jmp     process
Output_binary:
        ASSUME  DS: seg Number
        mov     AX, seg Number        ; Выставляем указатель на сегмент памяти
        mov     DS, AX                  ; Передаем его в DS
        mov     DX,OFFSET Number + 2

        mov     SI, DX                          ; Устанавливаем регистр для SI
        
        xor     cx, cx
        mov     CL, Number + 1
        mov     AX, 0                           ; Сумма цифр, обнуляем
        mov     BX, 0 
        mov     DX, 0                           
        jmp     read
    process:
        xor     cx, cx 
        mov     AX, BX
        mov     bx, 2                           ; основание CC

    stack_push:
        xor     dx,dx
        div     bx
        push    dx
        inc     cx
        test    ax, ax
        jnz     stack_push
        mov     ah, 02h
    print:
        pop     dx
        add     dl, '0'
        int     21h
        loop    print
        
        ret
      
Code    ENDS
        END