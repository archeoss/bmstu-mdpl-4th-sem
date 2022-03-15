; Требуется написать программу из двух модулей.
; В первом ввести строку цифр от 0 до 5 в сегмент
; данных, объявленный во втором модуле, затем передать
; управление дальним переходом и вывести сумму 2-й и 3-й цифр.

EXTRN StringNumber: byte
EXTRN PrintSum: far

StkSeg  SEGMENT PARA STACK 'STACK'
        DB      200h DUP    (?)
StkSeg  ENDS

Code    SEGMENT WORD 'CODE'
        ASSUME  CS:Code, SS:StkSeg

Main:
        mov     AX, seg StringNumber    ; Выставляем указатель на сегмент памяти
                                        ; Через label StringNumber внутри него
        ASSUME  DS:seg StringNumber
        mov     DS, AX                  ; Передаем его в DS
        lea     DX, OFFSET StringNumber ; Выставляем OFFSET

        mov     AH,0Ah                  ; Считывание строки в DS:DX
        INT     21h
        
        mov     DL, 0Ah                 ; Выставляем курсор на новую строку (0A в stdout)
        mov     AH, 2                   ; Вывод в stdout 
        INT     21h

        jmp     PrintSum                ; Дальний переход

Code    ENDS
        END     Main
