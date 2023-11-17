.data
.text

# Basic SLL Test
# li $t0, 0b0001          # $t0 = 1
# sll $t1, $t0, 2         # $t1 should be 4 because 1 << 2 = 4

# # Basic SRL Test
# li $t2, 0b1000          # $t2 = 8
# srl $t3, $t2, 2         # $t3 should be 2 because 8 >> 2 = 2

# # Test SLL with zero shift
# li $t4, 0b1100          # $t4 = 12
# sll $t5, $t4, 0         # $t5 should be 12 because 12 << 0 = 12

# # Test SRL with zero shift
# li $t6, 0b1100          # $t6 = 12
# srl $t7, $t6, 0         # $t7 should be 12 because 12 >> 0 = 12

# # Test SLL with maximal shift (31 for MIPS 32-bit)
# li $t8, 0b0001          # $t8 = 1
# sll $t9, $t8, 31        # $t9 should be 0x80000000 because 1 << 31 sets the highest bit

# # Test SRL with maximal shift (31 for MIPS 32-bit)
# li $s0, 0x80000000      # $s0 = -2147483648, the most significant bit set
# srl $s1, $s0, 31        # $s1 should be 1 because the highest bit gets shifted to the least significant position

# # Test SLL with a number that has bits set in higher positions
# li $s2, 0x70000000      # $s2 has the three highest bits set
# sll $s3, $s2, 2         # $s3, after shifting left, should have its top two bits dropped off and be 0x80000000

# # Test SRL with a number that has bits set in higher positions
# li $s4, 0xC0000000      # $s4 has the two highest bits set
# srl $s5, $s4, 2         # $s5, after shifting right, should become 0x30000000

# # Test SLL with zero value
# li $s6, 0               # $s6 = 0
# sll $s7, $s6, 5         # $s7 should be 0 because 0 shifted any amount is still 0

# Test SRL with zero value
li $s8, 0               # $s8 = 0
srl $s1, $s8, 5         # $s1 should be 0 because 0 shifted any amount is still 0

# Test SRL on a negative number (ensure the logical shift brings in zeros)
li $a0, -1              # $a0 = -1, which is all 1's in two's complement
srl $a1, $a0, 5         # $a1 should be 0x07FFFFFF because -1 >> 5 brings in zeros at the top
.word 0xfeedfeed
