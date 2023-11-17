#include <iostream>
#include <bitset>

using namespace std;


void printBinary(uint32_t x)
{
    std::cout << "instruct: " << std::bitset<32>(x) << '\n';
}

// extract specific bits [start, end] from an instruction
uint instructBits(uint32_t instruct, int start, int end)
{
    int run = start - end + 1;
    std::cout << "instruct \n" << std::endl;
    printBinary(instruct);
    uint32_t mask = (1 << run) - 1;
    std::cout << "mask \n" << std::endl;
    printBinary(mask);
    uint32_t clipped = instruct >> end;
    std::cout << "clipped \n" << std::endl;
    printBinary(clipped);
    std::cout << "result \n" << std::endl;
    uint32_t result = clipped & mask;
    printBinary(result);
    return result;
}

int main()
{
    uint32_t x = 0xffffffff;
    printBinary(x);
    uint32_t y = instructBits(x, 31, 28);
    printBinary(y);
}