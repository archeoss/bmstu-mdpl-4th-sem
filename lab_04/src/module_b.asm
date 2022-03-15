PUBLIC StringNumber
PUBLIC PrintSum

DataS           SEGMENT PARA PUBLIC 'DATA'
StringNumber    DB      7
DataS           ENDS

Code    SEGMENT PARA PUBLIC 'CODE'
        ASSUME  CS:Code, DS:DataS
PrintSum:
        mov     AX, seg StringNumber            ; Выставляем указатель на сегмент памяти
                                                ; Через label StringNumber внутри него
        mov     DS, AX                          ; Передаем его в DS
        lea     DX, OFFSET StringNumber + 2     ; Выставляем OFFSET
        mov     SI, DX                          ; Устанавливаем регистр для SI
        mov     AX, 0                           ; Сумма цифр, обнуляем
        add     SI, 1                           ; Нам нужно 2-е число, так что двигаем на 1

	LODSB                                   ; Считываем из DS:SI, SI += 1
        mov     BX, AX                          ; BX = AX (2-е число)
        sub     BX, '0'                         ; Вычитаем ASCII-код

        LODSB                                   ; Повторяем
        add     BX, AX
        sub     BX, 30h
        
        mov     DL, BL                          ; Передаем сумму в DL
        add     DL, 30h                         ; Прибавляем ASCII-код
        mov     AH, 2                           ; Пишем в stdout сумму
        INT     21h

	mov ax, 4c00h                           ; Выход
	int 21h

Code    ENDS
        END
