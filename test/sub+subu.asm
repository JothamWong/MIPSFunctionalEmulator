.data
.text

# Basic SUB Test
# li $t0, 10         # $t0 = 10
# li $t1, 5          # $t1 = 5
# sub $t2, $t0, $t1  # $t2 should be 5 because 10 - 5 = 5

# # Basic SUBU Test
# li $t3, 10         # $t3 = 10
# li $t4, 5          # $t4 = 5
# subu $t5, $t3, $t4 # $t5 should be 5 because 10 - 5 = 5

# # Test with zero subtraction
# li $t6, 20         # $t6 = 20
# li $t7, 0          # $t7 = 0
# sub $t8, $t6, $t7  # $t8 should be 20 because 20 - 0 = 20
# subu $t9, $t6, $t7 # $t9 should also be 20 for the same reason

# Test with subtraction result being negative
# li $s0, 10         # $s0 = 10
# li $s1, 20         # $s1 = 20
# sub $s2, $s0, $s1  # $s2 should be -10 because 10 - 20 = -10
# subu $s3, $s0, $s1 # $s3 will wrap around and become a large positive value

# Test with both values being negative
# li $s1, -10        # $s4 = -10
# li $s2, -5         # $s5 = -5
# sub $s1, $s1, $s2  # $s6 should be -5 because -10 - (-5) = -5
# # subu $s2, $s4, $s5 # This will result in subtraction of two large positive values (when treated as unsigned)

# # Test with largest positive and negative values for potential edge cases
# li $s3, 0x7FFFFFFF  # $s8 = 2147483647, the largest positive 32-bit integer
# li $s4, 0x80000000  # $s9 = -2147483648, the largest negative 32-bit integer (two's complement representation)
# sub $t0, $s6, $s7  # $a0 should be a positive overflow, as 2147483647 - (-2147483648) > 2147483647
# subu $t1, $s6, $s7 # This will result in subtraction of two large positive values (when treated as unsigned)

# # Test with zero
# li $a2, 0          # $a2 = 0
# sub $t3, $t2, $s6  # $a3 should be -2147483647 because 0 - 2147483647 = -2147483647
# subu $a4, $a2, $s6 # $a4 will be a large positive value (when treated as unsigned)
# sub $a5, $s7, $a2  # $a5 should be -2147483648, as -2147483648 - 0 = -2147483648
# subu $a6, $s7, $a2 # $a6 will be a large positive number (when treated as unsigned)

.word 0xfeedfeed
