# Компилятор
CC := gcc

# Опции компилятора
CFLAGS := -no-pie $(shell pkg-config --cflags --libs gtk+-3.0)

# Ассемблер
AS := nasm

# Опции ассемблера
ASFLAGS := -felf64

# Фиктивные цели
.PHONY: clean

out/runner: out/main.o
	$(CC)  $(CFLAGS) $^ -o $@

out/main.o: src/main.s | out
	$(AS) $(ASFLAGS) $< -o $@

out:
	mkdir $@

clean:
	$(RM) -r out
