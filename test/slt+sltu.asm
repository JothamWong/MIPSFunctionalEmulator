.data
.text

# Basic SLT Test
# li $t0, 5          # $t0 = 5
# li $t1, 10         # $t1 = 10
# slt $t2, $t0, $t1  # $t2 should be 1 because 5 is less than 10

# # Basic SLTU Test
# li $t3, 5          # $t3 = 5
# li $t4, 10         # $t4 = 10
# sltu $t5, $t3, $t4 # $t5 should be 1 because 5 is less than 10

# # Test with equal values
# li $t6, 20         # $t6 = 20
# li $t7, 20         # $t7 = 20
# slt $t8, $t6, $t7  # $t8 should be 0 because 20 is not less than 20
# sltu $t9, $t6, $t7 # $t9 should also be 0 for the same reason

# # Test with a negative and a positive value
# li $s0, -1        # $s0 = -15
# li $s1, 1         # $s1 = 15
# slt $s2, $s0, $s1  # $s2 should be 1 because -15 is less than 15
# sltu $s3, $s0, $s1 # $s3 should be 0 because SLTU treats values as unsigned. Thus, $s0 is a large positive number.

# Test with two negative values
li $s4, -20        # $s4 = -20
li $s5, -10        # $s5 = -10
slt $s6, $s4, $s5  # $s6 should be 1 because -20 is less than -10
sltu $s7, $s4, $s5 # $s7 should be 0 because when treated as unsigned, $s4 is larger than $s5

# # Test with largest positive and negative values to check for corner cases
li $s8, 0x7FFFFFFF  # $s8 = 2147483647, the largest positive 32-bit integer
li $s9, 0x80000000  # $s9 = -2147483648, the largest negative 32-bit integer (two's complement representation)
slt $a0, $s8, $s9  # $a0 should be 0, as 2147483647 is not less than -2147483648
sltu $a1, $s8, $s9 # $a1 should be 1, as when treated as unsigned, $s8 (2147483647) is less than $s9 (which is a huge positive number)

# # Test with zero
li $a2, 0          # $a2 = 0
slt $a3, $a2, $s8  # $a3 should be 1, as 0 is less than 2147483647
sltu $a4, $a2, $s8 # $a4 should also be 1 for the same reason
slt $a5, $s9, $a2  # $a5 should be 1, as -2147483648 is less than 0
sltu $a6, $s9, $a2 # $a6 should be 0, as when treated as unsigned, $s9 (a huge positive number) is not less than 0

.word 0xfeedfeed
