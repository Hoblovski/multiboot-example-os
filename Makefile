CC := gcc
CFLAGS := -g -m32 -Wall -Wextra -pedantic -ansi -ffreestanding -MD -isystem$(PWD)
ASFLAGS = -m32 -gdwarf-2 -Wa,-divide -MD -isystem$(PWD)
LDFLAGS := -nostdlib -z max-page-size=0x1000

ASM := $(wildcard *.S)
SRC := $(wildcard *.c)
OBJS := $(ASM:.S=.o) $(SRC:.c=.o)
-include *.d

all: kernel

kernel: $(OBJS) linker.ld
	$(CC) $(LDFLAGS) -T linker.ld -o $@ $(OBJS)

qemu: kernel
	qemu-system-i386 -kernel kernel

clean:
	rm -rf *.d *.o kernel

.PHONY: clean qemu
