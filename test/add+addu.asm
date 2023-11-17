.data
.text

# Two positive numbers addition
li $t0, 5            # $t0 = 5
li $t1, 7            # $t1 = 7
add $t2, $t0, $t1    # $t2 = 5 + 7 = 12
# After execution, $t2 should contain 12

# Two positive numbers addition
li $t0, 5            # $t0 = 5
li $t1, 7            # $t1 = 7
addu $t2, $t0, $t1    # $t2 = 5 + 7 = 12
# After execution, $t2 should contain 12

# Addition with zero
li $t3, 5            # $t3 = 5
li $t4, 0            # $t4 = 0
add $t5, $t3, $t4    # $t5 = 5 + 0 = 5
# After execution, $t5 should contain 5

# Addition with two zeroes
li $t6, 0            # $t6 = 0
li $t7, 0            # $t7 = 0
add $t8, $t6, $t7    # $t8 = 0 + 0 = 0
# After execution, $t8 should contain 0

# Result should be negative
li $t9, 5            # $t9 = 5
li $s0, -7           # $s0 = -7
add $s1, $t9, $s0    # $s1 = 5 + (-7) = -2
# After execution, $s1 should contain -2

# Negative input with addu
li $s2, -1   # $s2 = -1 (when considered signed)
li $s3, 5            # $s3 = 5
addu $s4, $s2, $s3   # $s4 = 4294967295 + 5 = 4 (due to wrapping)
# After execution, $s4 should contain 4

# Negative + Negative with add
li $s5, -5           # $s5 = -5
li $s6, -7           # $s6 = -7
add $s7, $s5, $s6    # $s7 = -5 + (-7) = -12
# After execution, $s7 should contain -12
.word 0xfeedfeed
