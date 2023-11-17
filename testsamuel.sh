echo "Testing samuel"
g++ src/sim.cpp src/UtilityFunctions.o -o sim
echo "Compiled successfully."
bin/mips-linux-gnu-as test/samuel/samuel_tests.asm -o test/samuel/samuel_tests.elf
bin/mips-linux-gnu-objcopy test/samuel/samuel_tests.elf -j .text -O binary test/samuel/samuel_tests.bin
./sim test/samuel/samuel_tests.bin