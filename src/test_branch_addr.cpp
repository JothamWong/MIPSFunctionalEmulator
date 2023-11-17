#include <iostream>
#include <bitset>

using namespace std;

uint32_t signExt(uint16_t smol) 
{
    uint32_t x = smol;
    uint32_t extension = 0xffff0000;
    return (smol & 0x8000) ? x ^ extension : x;
}

// implements the MIPS branchAddr
uint32_t getBranchAddr(uint16_t imm)
{
    // Pads 16 more significant bits with 0s
    uint32_t x = imm;
    cout << x << "\n";
    // Shift left twice, this adds 2 0s to the right
    x = x << 2;
    cout << x << "\n";
    // This is equivalent to 0b11111111111111000000000000000000
    uint32_t extension = 0xfffc0000;
    return (imm & 0x8000) ? x ^ extension : x;
}

int main(void)
{
    uint16_t x = 0x9003;
    std::bitset<16> tt(x);
    cout << tt << "\n";
    std::bitset<32> zt(signExt(x));
    cout << zt << "\n";
    std::bitset<32> test(getBranchAddr(x));
    cout << test;
}
