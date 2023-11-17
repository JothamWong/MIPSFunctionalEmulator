// Done by Jotham Wong (jw0771) and Shlomo Fortgang (sf6006)

#include <bitset>
#include <climits>
#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include "MemoryStore.h"
#include "RegisterInfo.h"

using namespace std;

union REGS
{
    RegisterInfo reg;
    uint32_t registers[32]{0};
};

union REGS regData;

// fill in the missing hex values of OP_IDs
enum OP_IDS
{
    // R-type opcodes...
    OP_ZERO = 0x0, // zero
                   // I-type opcodes...
    OP_ADDI = 0x8,  // addi
    OP_ADDIU = 0x9, // addiu
    OP_ANDI = 0xc,  // andi
    OP_BEQ = 0x4,   // beq
    OP_BNE = 0x5,   // bne
    OP_LBU = 0x24,  // lbu
    OP_LHU = 0x25,  // lhu
    OP_LUI = 0xf,   // lui
    OP_LW = 0x23,   // lw
    OP_ORI = 0xd,   // ori
    OP_SLTI = 0xa,  // slti
    OP_SLTIU = 0xb, // sltiu
    OP_SB = 0x28,   // sb
    OP_SH = 0x29,   // sh
    OP_SW = 0x2b,   // sw
    OP_BLEZ = 0x6, // blez
    OP_BGTZ = 0x7, // bgtz
                    // J-type opcodes...
    OP_J = 0x2,  // j
    OP_JAL = 0x3 // jal
};

// fill in the missing hex values of FUNCT_IDS
enum FUNCT_IDS
{
    FUN_ADD = 0x20,  // add
    FUN_ADDU = 0x21, // add unsigned (addu)
    FUN_AND = 0x24,  // and
    FUN_JR = 0x08,   // jump register (jr)
    FUN_NOR = 0x27,  // nor
    FUN_OR = 0x25,   // or
    FUN_SLT = 0x2a,  // set less than (slt)
    FUN_SLTU = 0x2b, // set less than unsigned (sltu)
    FUN_SLL = 0x00,  // shift left logical (sll)
    FUN_SRL = 0x02,  // shift right logical (srl)
    FUN_SUB = 0x22,  // substract (sub)
    FUN_SUBU = 0x23  // substract unsigned (subu)
};

// extract specific bits [start, end] from an instruction
uint instructBits(uint32_t instruct, int start, int end)
{
    int run = start - end + 1;
    uint32_t mask = (1 << run) - 1;
    uint32_t clipped = instruct >> end;
    return clipped & mask;
}   

// sign extend while keeping values as uint's
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
    // Shift left twice, this adds 2 0s to the right
    x = x << 2;
    // This is equivalent to 0b11111111111111000000000000000000
    uint32_t extension = 0xfffc0000;
    return (imm & 0x8000) ? x ^ extension : x;
}

uint32_t getJumpAddr(uint32_t address, uint32_t pc)
{
    // First extract 4 bits of pc (which is alr +4), 
    // then shift left by 28 to get it to the correct spot
    // Then sll address by 2 to pad 2 0s to the right
    // then bitwise or will concatenate them
    uint32_t pcBits = instructBits(pc, 31, 28) << 28;
    uint32_t addressBits = address << 2;
    uint32_t jumpResult = pcBits | addressBits;
    return jumpResult;
}

// dump registers and memory
// change so registers is a union with reg. No copying of reg to registers 
void dump(MemoryStore *myMem)
{
    dumpRegisterState(regData.reg);
    dumpMemoryState(myMem);
}

int main(int argc, char **argv)
{
    ifstream infile;
    infile.open(argv[1], ios::binary | ios::in);

    // get length of file
    infile.seekg(0, ios::end);
    int length = infile.tellg();
    infile.seekg(0, ios::beg);

    char *buf = new char[length];
    infile.read(buf, length);
    infile.close();

    // freopen("output.txt","w",stdout);

    // initialize memory store
    MemoryStore *myMem = createMemoryStore();
    int memLength = length / sizeof(buf[0]);
    int i;
    for (i = 0; i < memLength; i++)
    {
        myMem->setMemValue(i * BYTE_SIZE, buf[i], BYTE_SIZE);
    }

    regData.reg = {};

    // initialize registers to 0
    uint32_t pc = 0; // initialize pc
    bool err = false;

    // branch delay 
    bool branchDelay = false; 
    bool jalDelay = false;
    // branchTarget - Target of branch taken
    // jal_valueToStore -  return address in reg 31 for JAL instruction
    uint32_t branchTarget = 0; 
    uint32_t jal_valueToStore = 0;
    uint32_t nextBranch = 0;
    bool toBranch = false;

    while (!err)
    {
        // fetch current instruction
        uint32_t instruct = 0;
        myMem->getMemValue(pc, instruct, WORD_SIZE);

        pc += 4;
        regData.registers[0] = 0; // reset value of $zero register

        // dump register and memory before exiting
        if (instruct == 0xfeedfeed)
        {
            dump(myMem);
            return 0;
        }

        // parse instruction
        // complete instructBits function for correct bits for each operand
        uint32_t opcode = instructBits(instruct, 31, 26);
        uint32_t rs = instructBits(instruct, 25, 21);
        uint32_t rt = instructBits(instruct, 20, 16);
        uint32_t rd = instructBits(instruct, 15, 11);
        uint32_t shamt = instructBits(instruct, 10, 6);
        uint32_t funct = instructBits(instruct, 5, 0);
        uint16_t immediate = instructBits(instruct, 15, 0);
        uint32_t address = instructBits(instruct, 25, 0);
        
        int32_t signExtImm = signExt(immediate);
        uint32_t zeroExtImm = (uint32_t) immediate;
        uint32_t branchAddr = getBranchAddr(immediate);
        uint32_t jumpAddr = getJumpAddr(address, pc);
        uint32_t fallthruAddr = pc; // assumes PC += 4 just happened
        // Used for loading and storing words
        uint32_t addr;
        uint32_t value;
        int result;
        // fill in operations for all functions and operands.
        switch (opcode)
        {
        case OP_ZERO: // R-type instruction
            switch (funct)
            {
            case FUN_ADD:
                regData.registers[rd] = 
                regData.registers[rs] + regData.registers[rt];
                break;
            case FUN_ADDU:
                regData.registers[rd] = 
                regData.registers[rs] + regData.registers[rt];
                break;
            case FUN_AND:
                regData.registers[rd] = 
                regData.registers[rs] & regData.registers[rt];
                break;
            case FUN_JR:
                nextBranch = regData.registers[rs];
                toBranch = true;
                continue;
            case FUN_NOR:
                regData.registers[rd] = 
                ~(regData.registers[rs] | regData.registers[rt]);
                break;
            case FUN_OR:
                regData.registers[rd] = 
                regData.registers[rs] | regData.registers[rt];
                break;
            case FUN_SLT:
                regData.registers[rd] = 
                static_cast<int>(regData.registers[rs]) 
                < static_cast<int>(regData.registers[rt]) ? 1 : 0;
                break;
            case FUN_SLTU:
                regData.registers[rd] = 
                (regData.registers[rs] < regData.registers[rt]) ? 1 : 0;
                break;
            case FUN_SLL:
                regData.registers[rd] = regData.registers[rt] << shamt;
                break;
            case FUN_SRL:
                regData.registers[rd] = regData.registers[rt] >> shamt;
                break;
            case FUN_SUB:
                regData.registers[rd] = 
                regData.registers[rs] - regData.registers[rt];
                break;
            case FUN_SUBU:
                regData.registers[rd] = 
                regData.registers[rs] - regData.registers[rt];
                break;
            default:
                fprintf(stderr, "\tIllegal funct operation...\n");
                err = true;
            }
            break;

        case OP_ADDI:
            regData.registers[rt] = regData.registers[rs] + signExtImm;
            break;
        case OP_ADDIU:
            regData.registers[rt] = regData.registers[rs] + signExtImm;
            break;
        case OP_ANDI:
            regData.registers[rt] = regData.registers[rs] & zeroExtImm;
            break;
        case OP_BEQ:
            if (regData.registers[rs] == regData.registers[rt])
            {
                nextBranch = pc + branchAddr;
                toBranch = true;
                continue;
            }
            break;
        case OP_BNE:
            if (regData.registers[rs] != regData.registers[rt])
            {
                nextBranch = pc + branchAddr;
                toBranch = true;
                continue;
            }
            break;
        case OP_J:
            nextBranch = jumpAddr;
            toBranch = true;
            continue;
        case OP_JAL:
            jal_valueToStore = pc + 4; // pc was already + 4 earlier
            nextBranch = jumpAddr;
            toBranch = true;
            regData.registers[31] = jal_valueToStore;
            continue;
        case OP_LBU:
            addr = regData.registers[rs] + signExtImm;
            result = myMem->getMemValue(addr, value, BYTE_SIZE);
            regData.registers[rt] = instructBits(value, 7, 0);
            break;
        case OP_LHU:
            addr = regData.registers[rs] + signExtImm;
            result = myMem->getMemValue(addr, value, HALF_SIZE);
            // Do we need to look at store 
            regData.registers[rt] = instructBits(value, 15, 0);
            break;
        case OP_LUI:
            regData.registers[rt] = ((uint32_t) immediate) << 16;
            break;
        case OP_LW:
            addr = regData.registers[rs] + signExtImm;
            result = myMem->getMemValue(addr, value, WORD_SIZE);
            regData.registers[rt] = value;
            break;
        case OP_ORI:
            regData.registers[rt] = regData.registers[rs] | zeroExtImm;
            break;
        case OP_SLTI:
            regData.registers[rt] = 
            (static_cast<int>(regData.registers[rs]) 
            < static_cast<int>(signExtImm)) ? 1 : 0;
            break;
        case OP_SLTIU:
            regData.registers[rt] = 
            ((uint32_t)regData.registers[rs] < (uint32_t)signExtImm) ? 1 : 0;
            break;
        case OP_SB:
            addr = regData.registers[rs] + signExtImm;
            value = instructBits(regData.registers[rt], 7, 0);
            myMem->setMemValue(addr, value, BYTE_SIZE);
            break;
        case OP_SH:
            addr = regData.registers[rs] + signExtImm;
            value = instructBits(regData.registers[rt], 15, 0);
            myMem->setMemValue(addr, value, HALF_SIZE);
            break;
        case OP_SW:
            addr = regData.registers[rs] + signExtImm;
            value = regData.registers[rt];
            myMem->setMemValue(addr, value, WORD_SIZE);
            break;
        case OP_BLEZ:
            if (static_cast<int>(regData.registers[rs]) <= 0)
            {
                nextBranch = pc + (signExt(immediate) << 2);
                toBranch = true;
                continue;
            }
            break;
        case OP_BGTZ:
            if (static_cast<int>(regData.registers[rs]) > 0)
            {
                nextBranch = pc + (signExt(immediate) << 2);
                toBranch = true;
                continue;
            }
            break;
        default:
            fprintf(stderr, "\tIllegal operation...\n");
            err = true;
            break;
        }
        // Handle the delay slots
        if (toBranch) {
            pc = nextBranch;
            toBranch = false;
        }
    }

    // dump and exit with error
    dump(myMem);
    exit(127);
    return -1;
}
