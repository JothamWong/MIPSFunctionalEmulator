.data
.text

# ----- AND Operation Test Cases -----

# Test with two arbitrary binary values
# li $t0, 0b11001100  # $t0 = 204
# li $t1, 0b10100101  # $t1 = 165
# and $t2, $t0, $t1   # $t2 = 0b10000100 = 132
# # After execution, $t2 should contain 132

# # Test AND with one zero value
# li $t3, 0b11001100  # $t3 = 204
# li $t4, 0           # $t4 = 0
# and $t5, $t3, $t4   # $t5 = 0
# # After execution, $t5 should contain 0

# # Test AND with two zeroes
# li $t6, 0           # $t6 = 0
# li $t7, 0           # $t7 = 0
# and $t8, $t6, $t7   # $t8 = 0
# # After execution, $t8 should contain 0

# # Test AND with maximum possible values
# li $t9, 0xFFFFFFFF  # $t9 = all 1s
# li $s0, 0xFFFFFFFF  # $s0 = all 1s
# and $s1, $t9, $s0   # $s1 = all 1s
# After execution, $s1 should contain 0xFFFFFFFF


# # ----- NOR Operation Test Cases -----

# Test NOR with two arbitrary binary values
# li $s2, 0b11001100  # $s2 = 204
# li $s3, 0b10100101  # $s3 = 165
# nor $s4, $s2, $s3   # $s4 = 0b01111011 = 123
# # After execution, $s4 should contain 123

# # Test NOR with one zero value
# li $s5, 0b11001100  # $s5 = 204
# li $s6, 0           # $s6 = 0
# nor $s7, $s5, $s6   # $s7 = 0b00110011 = 51
# # After execution, $s7 should contain 51

# # Test NOR with two zeroes
# li $s5, 0           # $s8 = 0
# li $s6, 0           # $s9 = 0
# nor $t0, $s5, $s6   # $t0 = 0xFFFFFFFF = -1 (when considered signed)
# After execution, $t0 should contain -1 or 0xFFFFFFFF


# ----- OR Operation Test Cases -----

# Test OR with two arbitrary binary values
li $t1, 0b11001100  # $t1 = 204
li $t2, 0b10100101  # $t2 = 165
or $t3, $t1, $t2    # $t3 = 0b11101101 = 237
# After execution, $t3 should contain 237

# Test OR with one zero value
li $t4, 0b11001100  # $t4 = 204
li $t5, 0           # $t5 = 0
or $t6, $t4, $t5    # $t6 = 0b11001100 = 204
# After execution, $t6 should contain 204

# Test OR with two zeroes
li $t7, 0           # $t7 = 0
li $t8, 0           # $t8 = 0
or $t9, $t7, $t8    # $t9 = 0
# After execution, $t9 should contain 0

# Test OR with maximum possible values
li $s0, 0xFFFFFFFF  # $s0 = all 1s
li $s1, 0xFFFFFFFF  # $s1 = all 1s
or $s2, $s0, $s1    # $s2 = all 1s
# After execution, $s2 should contain 0xFFFFFFFF
.word 0xfeedfeed
