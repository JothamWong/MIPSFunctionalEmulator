.data
word1: .word 0xAABBCCDD
word2: .word 0xFFFFFFFF
word3: .word 0x00000000

.text
main:
    # Basic load
    lw $t4, word1         # $t4 = 0xAABBCCDD

    # Load all ones
    lw $t5, word2         # $t5 = 0xFFFFFFFF

    # Load all zeros
    lw $t6, word3         # $t6 = 0x00000000

    # Offset-based load
    addi $a0, $zero, word1
    lw $t7, 4($a0)        # $t7 = 0xFFFFFFFF, assuming contiguous memory allocation by assembler
