PUBLIC Number
PUBLIC Input_Number
DataNumber      SEGMENT Para    PUBLIC  'DATA'
Number          DB      14
                DB      14
                DB      16      DUP     (?)         
DataNumber      ENDS

Code    SEGMENT WORD PUBLIC 'CODE'
        ASSUME  CS:Code
New_Line:
        mov     DL, 0Ah                 ; Выставляем курсор на новую строку (0A в stdout)
        mov     AH, 2                   ; Вывод в stdout 
        INT     21h
        mov     DL, '$'                 ; Выставляем курсор на новую строку (0A в stdout)
        mov     AH, 2                   ; Вывод в stdout 
        INT     21h
        ret  
Input_Number:
        ASSUME  DS:DataNumber
        mov     AX, DataNumber        ; Выставляем указатель на сегмент памяти
        mov     DS, AX                  ; Передаем его в DS

        lea     DX,OFFSET Number
        mov     AH,0Ah                  ; Считывание строки в DS:DX
        INT     21h
        call    New_Line
        ret
      
Code    ENDS
        END
