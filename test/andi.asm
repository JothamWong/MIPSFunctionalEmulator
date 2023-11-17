.data
.text

# Basic ANDI Test
li $t0, 0b11001100       # $t0 = 0xCC
andi $t1, $t0, 0xFF      # $t1 should be 0xCC (0b11001100 & 0b11111111)

# ANDI with 0 immediate (result should be 0)
li $t2, 0b10101010       # $t2 = 0xAA
andi $t3, $t2, 0x00      # $t3 should be 0x00 (0b10101010 & 0b00000000)

# ANDI with all 1s immediate (result should be the same as the source register)
li $t4, 0b10101010       # $t4 = 0xAA
andi $t5, $t4, 0xFFFF    # $t5 should be 0xAA (0b10101010 & 0b11111111)

# ANDI with alternating bits
li $t6, 0b10101010       # $t6 = 0xAA
andi $t7, $t6, 0b01010101 # $t7 should be 0x00 (0b10101010 & 0b01010101)

# ANDI with maximum value immediate
li $t8, 0xFFFFFFFF       # $t8 = 0xFFFFFFFF
andi $t9, $t8, 0xFFFF    # $t9 should be 0xFFFF

# ANDI with specific bits set
li $s0, 0b11001100       # $s0 = 0xCC
andi $s1, $s0, 0b00001111 # $s1 should be 0x0C (0b11001100 & 0b00001111)

# ANDI with one bit set
li $s2, 0b10000000       # $s2 = 0x80
andi $s3, $s2, 0b00000001 # $s3 should be 0x00 (0b10000000 & 0b00000001)

# ANDI with negative number (2's complement)
li $s4, -3               # $s4 = 0xFFFFFFFD
andi $s5, $s4, 0xFFFF    # $s5 should be 0xFFFD

.word 0xfeedfeed
