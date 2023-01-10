all: run

write.o: write.asm
	nasm -f elf write.asm

write: write.o
	ld -m elf_i386 -s -o write write.o

run: write
	./write

clean:
	rm write.o write
