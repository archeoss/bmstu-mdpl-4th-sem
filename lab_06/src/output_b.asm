PUBLIC Output_hex
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

	    LODSB                                   ; Считываем из DS:SI, SI += 1
    
        sub     AX, '0'
        mov     DX, AX
        mov     AX, BX
        mov     BL, 10
        mul     BL
        mov     BX,AX
        add     BX,DX
        loop    read
        jmp     process
Output_hex:
        ASSUME  DS: seg Number
        mov     AX, seg Number        ; Выставляем указатель на сегмент памяти
        mov     DS, AX                  ; Передаем его в DS
        mov     DX,OFFSET Number + 2

        mov     SI, DX                          ; Устанавливаем регистр для SI
        
        xor     cx, cx
        mov     CL, Number + 1
        mov     AX, 0                           ; Сумма цифр, обнуляем
        mov     BX, 0                           ; Сумма цифр, обнуляем
        jmp     read
    process:
        xor     cx, cx 
        mov     AX, BX
        mov     bx, 10h ; основание сс. 10 для десятеричной и т.п.

    oi2:
        xor     dx,dx
        div     bx
        push    dx
        inc     cx
        test    ax, ax
        jnz     oi2
        mov     ah, 02h
    oi3:
        pop     dx
        cmp     dl,9
        jbe     oi4
        add     dl,7
    oi4:
        add     dl, '0'
        int     21h
        loop    oi3
        
        ret
      
Code    ENDS
        END