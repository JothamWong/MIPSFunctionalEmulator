.data
.text

# Basic ADDI Test
li $t0, 5                # $t0 = 5
addi $t1, $t0, 3         # $t1 should be 8 (5 + 3)

# Basic ADDIU Test
li $t2, 5                # $t2 = 5
addiu $t3, $t2, 3        # $t3 should be 8 (5 + 3)

# # ADDI with negative immediate
# li $t4, 10               # $t4 = 10
# addi $t5, $t4, -5        # $t5 should be 5 (10 - 5)

# # ADDIU with negative immediate
# li $t6, 10               # $t6 = 10
# addiu $t7, $t6, -5       # $t7 should be 5 (10 - 5)

# # ADDI with zero immediate
# li $t8, 7                # $t8 = 7
# addi $t9, $t8, 0         # $t9 should be 7 (7 + 0)

# # ADDIU with zero immediate
# li $s0, 7                # $s0 = 7
# addiu $s1, $s0, 0        # $s1 should be 7 (7 + 0)

# # ADDI with negative register value
# li $s2, -5               # $s2 = -5
# addi $s3, $s2, 4         # $s3 should be -1 (-5 + 4)

# # ADDIU with negative register value
# li $s4, -5               # $s4 = -5
# addiu $s5, $s4, 4        # $s5 should be -1 (-5 + 4)

# # ADDI with both negative values
# li $s6, -5               # $s6 = -5
# addi $s7, $s6, -2        # $s7 should be -7 (-5 + (-2))

# ADDIU with both negative values
li $s7, -5               # $s8 = -5
addiu $t1, $s7, -2       # $s9 should be -7 (-5 + (-2))

# ADDI with maximum positive immediate (using 0x7FFF since we're not considering overflow)
li $t0, 1                # $a0 = 1
addi $t2, $t0, 0x7FFF    # $a1 should be 32768 (1 + 32767)

# ADDIU with maximum positive immediate
li $s2, 1                # $a2 = 1
addiu $t3, $s2, 0x7FFF   # $a3 should be 32768 (1 + 32767)

# ADDI with maximum negative immediate (using 0x8000, which is -32768 in signed 2's complement)
li $s4, 1                # $a4 = 1
addi $t5, $s4, -32768    # $a5 should be -32767 (1 - 32768)

# ADDIU with maximum negative immediate
li $s6, 1                # $a6 = 1
addiu $t7, $s6, 0x8000   # $a7 should be -32767 (1 + (-32768))

.word 0xfeedfeed
