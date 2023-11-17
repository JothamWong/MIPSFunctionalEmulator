echo "Testing extra"
g++ src/sim.cpp src/UtilityFunctions.o -o sim
echo "Compiled successfully."
bin/mips-linux-gnu-as test/aidan/extra.asm -o test/aidan/extra.elf
bin/mips-linux-gnu-objcopy test/aidan/extra.elf -j .text -O binary test/aidan/extra.bin
./sim test/aidan/extra.bin
diff mem_state.out test/aidan/extra_mem_state.out
diff reg_state.out test/aidan/extra_reg_state.out