CC := gcc
FLAGS := -masm=intel
SRC := ./src/
OUT := ./out/
OBJH := ${OUT}32bit.o ${OUT}64bit.o ${OUT}80bith.o ${OUT}sin.o
OBJS := ${OUT}32bit.o ${OUT}64bit.o ${OUT}80bits.o ${OUT}sin.o
HEADERS := ${SRC}32bit.h ${SRC}64bit.h ${SRC}80bit.h ${SRC}sin.h

hard	 : FLAGS += -m80387
hard	 : mainh.exe

soft	 : FLAGS += -mno-80387
soft	 : mains.exe

mains.exe: ${OUT}main.o $(OBJS)
	$(CC) $(FLAGS) $^ -o $@

mainh.exe: ${OUT}main.o $(OBJH)
	$(CC) $(FLAGS) $^ -o $@

${OUT}main.o : ${SRC}main.c $(HEADERS)
	$(CC) $(FLAGS) -c $< -o $@

${OUT}32bit.o : ${SRC}32bit.c ${SRC}32bit.h
	$(CC) $(FLAGS) -c $< -o $@

${OUT}64bit.o : ${SRC}64bit.c ${SRC}64bit.h
	$(CC) $(FLAGS) -c $< -o $@

${OUT}80bith.o : ${SRC}80bit.c ${SRC}80bit.h
	$(CC) $(FLAGS) -c $< -o $@

${OUT}80bits.o : ${SRC}80bit.c ${SRC}80bit.h
	$(CC) -masm=intel -c $< -o $@

${OUT}sin.o : ${SRC}sin.c ${SRC}sin.h
	$(CC) $(FLAGS) -c $< -o $@

.PHONY : clean hard soft

clean :
	$(RM) $(OUT)*.o *.exe
