PUBLIC Number
PUBLIC Input_Number
EXTRN New_Line:near

DataNumber      SEGMENT Para    PUBLIC  'DATA'
Number          DB      14
                DB      14
                DB      16      DUP     (?)         
DataNumber      ENDS

Code    SEGMENT WORD PUBLIC 'CODE'
        ASSUME  CS:Code
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
