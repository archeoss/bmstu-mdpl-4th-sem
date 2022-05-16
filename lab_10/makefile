CC := gcc
FLAGS := #-masm=intel
SRC := ./src/
OUT := ./out/
OBJ := ${OUT}matrix.o
HEADERS := ${SRC}matrix.h

main.exe: ${OUT}main.o $(OBJ)
	$(CC) $(FLAGS) $^ -o $@

${OUT}main.o : ${SRC}main.c $(HEADERS)
	$(CC) $(FLAGS) -c $< -o $@

${OUT}matrix.o : ${SRC}matrix.c ${SRC}matrix.h
	$(CC) $(FLAGS) -c $< -o $@

.PHONY : clean

clean :
	$(RM) $(OUT)*.o *.exe
