.data
.text
main:
    # Initialize registers with some test values
    li $t0, 4000  # A sample word
    li $t1, 550      # A sample half-word
    li $t2, 22        # A sample byte
    la $t4, 76

    # Store values to memory
    sw $t0, 0($t4)      # Store word value
    sh $t1, 4($t4)    # Store half-word value
    sb $t2, 8($t4)    # Store byte value

    # Load values from memory to check them
    lw $s0, 0($t4)      # Load stored word value to $s0
    lhu $s1, 6($t4)    # Load stored half-word value to $s1
    lbu $s2, 8($t4)    # Load stored byte value to $s2

.word 0xfeedfeed
.word 0x0
.word 0x0
.word 0x0
.word 0x0
