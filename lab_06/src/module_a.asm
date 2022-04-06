; Матрица: прямоугольная цифровая 9x9

; Преобразование
; заменить значения в чётных строках последними
; цифрами суммы соответствующих элементов
; предыдущей и следующей строки.

EXTRN Number:byte
EXTRN Output_binary:near
EXTRN Output_hex:near
EXTRN Input_Number:near

DataMessages    SEGMENT WORD 'DATA'
HelloMessage    DB      13
                DB      10
                DB      'MDPL, Lab 06. Select command:'
;                DB      '$'
;InputMessage    DB      13
                DB      10
                DB      '1. Input: Unsigned decimal number'
;                DB      '$'
;Output_A        DB      13
                DB      10
                DB      '2. Output 1: Unsigned binary number'
;                DB      '$'
;Output_B        DB      13
                DB      10
                DB      '3. Output 2: Signed hexadecimal number'
;                DB      '$'
                DB      10
                DB      '4. Quit'
                DB      10
                DB      'Input command>>>'
                DB      '$'
DataMessages    ENDS

DataCommands    SEGMENT WORD 'DATA'
Commands        DW      Input_Number,
                        Output_binary,
                        Output_hex,
                        Quit
DataCommands    ENDS
StkSeg  SEGMENT PARA STACK 'STACK'
        DB      200h DUP    (?)
StkSeg  ENDS

Code    SEGMENT WORD PUBLIC 'CODE'
        ASSUME  CS:Code, SS:StkSeg, DS:DataMessages
New_Line:
        mov     DL, 0Ah                 ; Выставляем курсор на новую строку (0A в stdout)
        mov     AH, 2                   ; Вывод в stdout 
        INT     21h
        mov     DL, '$'                 ; Выставляем курсор на новую строку (0A в stdout)
        mov     AH, 2                   ; Вывод в stdout 
        INT     21h
        ret  
Print_Menu:
        ASSUME  DS:DataMessages
        mov     AX, DataMessages        ; Выставляем указатель на сегмент памяти
        mov     DS, AX                  ; Передаем его в DS
        mov     DX,OFFSET HelloMessage

        mov     AH,9
        INT     21h
        
        ASSUME  DS:DataCommands
        mov     AX, DataCommands        ; Выставляем указатель на сегмент памяти
        mov     DS, AX                  ; Передаем его в DS
        
        mov     AH,01h                  ; Считывание в AL
        INT     21h
        
        mov     AH,00
        sub     AX,'1'
        mov     CX,2
        mul     CX
        mov     SI,AX
        call    New_Line
        call    Commands[SI]
        jmp     Print_Menu
Quit:
        mov     AX,4C00h
        int     21h
      
Code    ENDS
        END     Print_Menu
