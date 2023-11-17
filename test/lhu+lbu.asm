.data
# byte_data:     .byte 0xFF        # This byte data should be interpreted as 255 (unsigned) by LBU
# halfword_data: .half 0xFFFF      # This halfword data should be interpreted as 65535 (unsigned) by LHU

.text
main:
    # Load constant values for arithmetic tests
    li   $t6, 1               # Load immediate value 1 into $t6

    # Test for LBU
    la   $t0, 20            # Load the address of byte_data into $t0
    lbu  $t1, 0($t0)          # Load the byte from memory into $t1 using LBU
    add  $t7, $t1, $t6        # Increment $t7 by 1
    
    # After this instruction, if the value was unsigned, $t1 will be 0x00000100 (256 in decimal)
    # Comment: Check if $t1 is 0x00000100 after this instruction
    # Test for LHU
    la   $t2, 32          # Load the address of halfword_data into $t2
    lhu  $t3, 0($t2)          # Load the halfword from memory into $t3 using LHU

    add  $s1, $t3, $t6        # Increment $t3 by 1

    # After this instruction, if the value was unsigned, $t3 will be 0x00010000 (65536 in decimal)
    # Comment: Check if $t3 is 0x00010000 after this instruction

    # Example for corner cases: Subtracting to test for unsigned nature

    lbu  $t4, 0($t0)          # Load the byte from memory into $t4 using LBU
    sub  $t4, $t4, $t6        # Decrement $t4 by 1

    # If the value was truly unsigned, the subtraction will result in 0x000000FE (254 in decimal)
    # Comment: Check if $t4 is 0x000000FE

    lhu  $t5, 0($t2)          # Load the halfword from memory into $t5 using LHU
    sub  $t5, $t5, $t6        # Decrement $t5 by 1

    # If the value was truly unsigned, the subtraction will result in 0x0000FFFE (65534 in decimal)
    # Comment: Check if $t5 is 0x0000FFFE

    # End of tests
    # jr $ra

.word 0xfeedfeed
