# Насчет соглашений

На линухе даже если попытаться зафорсить cdecl соглашение, то gcc его проигнорирует и будет использовать 
x86-64 Linux System Call convention:

main.o - вызов strcpy
![main.o](./docs/proof.png)
