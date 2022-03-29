; Матрица: прямоугольная цифровая 9x9

; Преобразование
; заменить значения в чётных строках последними
; цифрами суммы соответствующих элементов
; предыдущей и следующей строки.

DataMatr        SEGMENT PARA 'DATA'
ROWS            DB      13
COLS            DB      13
Matrix          DB      9*9 DUP (0)
DataMatr        ENDS

StkSeg  SEGMENT PARA STACK 'STACK'
        DB      200h DUP    (?)
StkSeg  ENDS

Code    SEGMENT WORD 'CODE'
        ASSUME  CS:Code, SS:StkSeg, DS:DataMatr

New_Line:
        mov     DL, 0Ah                 ; Выставляем курсор на новую строку (0A в stdout)
        mov     AH, 2                   ; Вывод в stdout 
        INT     21h
        ret
Main:
        mov     AX,DataMatr             ; Выставляем указатель на сегмент памяти
        mov     DS, AX                  ; Передаем его в DS

        mov     AH,01h                  ; Считывание количества строк в AL
        INT     21h
        sub     AL, '0'
        mov     ROWS,AL

        call    New_Line

        mov     AH,01h                  ; Считывание количества столбцов в AL
        INT     21h
        sub     AL, '0'
        mov     COLS,AL

        call    New_Line

        mov     CX,0
        mov     AX,0
        
        mov     DH,ROWS

        mov     BX,0
        read_matrix:
                mov     CL,COLS
                read_row:
                        mov     AH,01h
                        int     21h
                        sub     AL, '0'
                        mov     [Matrix + BX],AL

                        mov     DL, ' '                 
                        mov     AH, 2                   ; Вывод в stdout 
                        INT     21h

                        inc     BX              ; Увеличиваем индекс
                        loop    read_row
                
                call    New_Line
                sub     BL,COLS
                add     BX,9
                mov     CL,DH
                dec     DH
                loop read_matrix


        mov     AX,0
        mov     AL,ROWS
        mov     BL,2                            ; Проходим только по четным строчкам -> количество циклов делим на 2
        div     BL
        mov     BX,0
        mov     DH,AL
        transform_matrix:
                mov     CL,COLS
                transform_row:
                        mov     AX, 0
                        mov     AL,[Matrix + BX]        ; Считываем i * 2 строку

                        add     BL, 9
                        add     BL, 9
                        add     AL,[Matrix + BX]        ; Считываем (i + 1) * 2 строку
                        sub     BL, 9

                        mov     DL,10                   ; Берем остаток от деленения на 10
                        div     DL
                        
                        mov     [Matrix + BX],AH        ; Заносим это в (i + 1) * 2 - 1 строку

                        sub     BL, 9
                        inc     BL

                        loop    transform_row

                sub     BL,COLS
                add     BL, 9  
                add     BL, 9                           ; Прыгаем на 2 строчки вперед
                mov     CL,DH
                dec     DH
                loop transform_matrix

        call    New_Line
        mov     CL,COLS
        mov     DH,ROWS

        mov     BX,0
        
        print_matrix:
                mov     CL,COLS
                print_row:
                        mov     DL,[Matrix + BX]        ; Считываем значение матрицы
                        add     DL,'0'
                        mov     AH, 2                   ; Вывод в stdout 
                        INT     21h

                        mov     DL, ' '                 
                        mov     AH, 2                   ; Вывод в stdout 
                        INT     21h

                        inc     BX
                        loop    print_row
                
                call    New_Line
                sub     BL,COLS
                add     BX,9
                mov     CL,DH
                dec     DH
                loop print_matrix

	mov ax, 4c00h                           ; Выход
	int 21h
        
Code    ENDS
        END     Main
