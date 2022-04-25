section .text
global strcpy

; x86-64 Linux System Call convention:
; Аргументы передаются в след. порядке
; RDI, RSI, RDX, RCX, R8, R9
; все остальное улетает в Stack
strcpy:
    mov rcx, rdx
    copy:
        MOVSB
        loop copy
    ret