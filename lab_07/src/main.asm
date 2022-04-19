.MODEL TINY
.CODE
.186

ORG 100H  

MAIN:
    JMP INIT

    CURRENT DB 0
    IS_INIT DB 'y'
    SPEED DB 1Fh
    OLD_BREAKING DD ?

MY_BREAKING:
    PUSHA           ;сохраняет в стеке содержимое восьми 16-битных регистров общего назначения
    PUSH ES
    PUSH DS

    MOV AH, 02h    
    INT 1Ah

    CMP DH, CURRENT
    MOV CURRENT, DH
    JE END_LOOP

    MOV AL, 0F3h
    OUT 60h, AL     ;инструкция OUT выводит данные из регистра AL или AX в порт ввода-вывода
    MOV AL, SPEED
    OUT 60h, AL

    dec SPEED

    TEST SPEED, 1FH
    JZ RESET_SPEED
    JMP END_LOOP

    RESET_SPEED:
        MOV SPEED, 1Fh

    END_LOOP:
        POP DS
        POP ES
        POPA

        JMP CS:OLD_BREAKING

INIT:    
    MOV AX, 3508H                       ;AH = 35H, AL = номер прерывания
    INT 21h                           

    CMP ES:IS_INIT, 'y'
    JE EXIT

    MOV WORD PTR OLD_BREAKING, BX       ;Запоминаем адрес старого обработчика
    MOV WORD PTR OLD_BREAKING + 2, ES   ;Запоминаем адрес ES

    MOV AX, 2508H                      
    MOV DX, OFFSET MY_BREAKING          ;Устанавливаем своего обработчика 08 вместо обработчика по умолчанию
    INT 21H                             

    MOV DX, OFFSET INSTALL_MSG          ; Вывод сообщения
    MOV AH, 9
    INT 21H

    MOV DX, OFFSET INIT
    INT 27H

EXIT:
    PUSHA
    PUSH ES
    PUSH DS

    MOV AX, 2508H
    MOV DX, WORD PTR ES:OLD_BREAKING
    MOV DS, WORD PTR ES:OLD_BREAKING + 2
    INT 21H

    MOV AL, 0F3H
    OUT 60H, AL
    MOV AL, 0
    OUT 60H, AL

    POP DS
    POP ES
    POPA

    MOV AH, 49H
    INT 21H

    MOV DX, OFFSET UNINSTALL_MSG
    MOV AH, 9H
    INT 21H
    
    MOV AX, 4C00H
    INT 21H

	ARG DB 63
    INSTALL_MSG   DB 'Resident$'
    UNINSTALL_MSG DB 'Not resident$'
END MAIN