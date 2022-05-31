CC := gcc
CFLAGS := -no-pie $(shell pkg-config --cflags --libs gtk+-3.0)
AS := nasm
ASFLAGS := -felf64
.PHONY: clean

main: out/main.o
	$(CC)  $(CFLAGS) $^ -o $@

out/main.o: src/main.s | out
	$(AS) $(ASFLAGS) $< -o $@

out:
	mkdir $@

clean:
	$(RM) -r out main
