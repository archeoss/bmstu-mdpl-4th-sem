section .text
global strcpy

; x86-64 Linux System Call convention:
; Аргументы передаются в след. порядке
; RDI, RSI, RDX, RCX, R8, R9
; все остальное улетает в Stack
from_end:
    add rdi, rcx
    add rsi, rcx
    std
    jmp copy
strcpy:
    mov rcx, rdx
    CMP RDI, RSI
    jb from_end
    copy:
        MOVSB
        loop copy
    ret