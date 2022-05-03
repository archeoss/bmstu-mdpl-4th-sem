CC := gcc
FLAGS := -Werror -masm=intel

OBJ := 32bit.o 64bit.o 80bit.o
HEADERS := 32bit.h 64bit.h 80bit.h

m	 : FLAGS += -m80387
m	 : main.exe

nom	 : FLAGS += -msoft-float --with-multilib-list=armv6-m
nom	 : main.exe

main.exe: main.o $(OBJ)
	$(CC) $(FLAGS) $^ -o $@
	$(RM) $(OUT)*.o

main.o : main.c $(HEADERS)
	$(CC) $(FLAGS) -c $<

32bit.o : 32bit.c 32bit.h
	$(CC) $(FLAGS) -c $<

64bit.o : 64bit.c 64bit.h
	$(CC) $(FLAGS) -c $<

80bit.o : 80bit.c 80bit.h
	$(CC) $(FLAGS) -c $<	

.PHONY : clean m nom

clean :
	$(RM) $(OUT)*.o *.exe
