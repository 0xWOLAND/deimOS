AS = i686-elf-as
CC = i686-elf-gcc-12.2.0

C_SOURCES = $(wildcard *.c)
ASM_SOURCES = $(wildcard *.s)

OBJ = ${C_SOURCES:.c=.o} ${ASM_SOURCES:.s=.o}

all: myos.iso

%.o: %.c
	${CC} -c $< -o $@ -std=gnu99 -ffreestanding -O2 -Wall -Wextra

%.o: %.s
	${AS} $< -o $@

myos.bin: ${OBJ}
	${CC} -T linker.ld -o $@ -ffreestanding -O2 -nostdlib $^ -lgcc

check-multiboot: myos.bin
	grub-file --is-x86-multiboot myos.bin

myos.iso: check-multiboot
	rm -rf isodir/
	mkdir -p isodir/boot/grub
	cp myos.bin isodir/boot/myos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o myos.iso isodir


clean:
	rm -rf isodir/
	rm -rf *.o
kernel:
	 qemu-system-i386 -kernel myos.bin

compile_kernel:
	${CC} -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

compile_boot:
	i686-elf-as boot.s -o boot.o

run: myos.iso kernel
