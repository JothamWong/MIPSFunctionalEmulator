echo "Testing fib"
g++ src/sim.cpp src/UtilityFunctions.o -o sim
echo "Compiled successfully."
bin/mips-linux-gnu-as test/fib/fib.asm -o test/fib/fib.elf
bin/mips-linux-gnu-objcopy test/fib/fib.elf -j .text -O binary test/fib/fib.bin
./sim test/fib/fib.bin
diff mem_state.out test/fib/fib_mem_state.out
diff reg_state.out test/fib/fib_reg_state.out