
main.exe : main.o strcpy.o
	gcc strcpy.o main.o -o main.exe

main.o : main.c
	gcc main.c -c -o main.o

strcpy.o : strcpy.asm
	nasm -f elf64 strcpy.asm -o strcpy.o
