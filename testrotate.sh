echo "Testing rotate"
g++ src/sim.cpp src/UtilityFunctions.o -o sim
echo "Compiled successfully."
bin/mips-linux-gnu-as test/aidan/rotate.asm -o test/aidan/rotate.elf
bin/mips-linux-gnu-objcopy test/aidan/rotate.elf -j .text -O binary test/aidan/rotate.bin
./sim test/aidan/rotate.bin
diff mem_state.out test/aidan/rotate_mem_state.out
diff reg_state.out test/aidan/rotate_reg_state.out