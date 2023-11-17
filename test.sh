# Translate assembly file to a binary elf file
bin/mips-linux-gnu-as test/fib.asm -o test/fib.elf
# Translates elf file into a flat binary file that only contains code and any .word directives
bin/mips-linux-gnu-objcopy test/fib.elf -j .text -O binary test/fib.bin