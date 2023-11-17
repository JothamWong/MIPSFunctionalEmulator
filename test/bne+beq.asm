# .set noreorder
.data
.text

# --- Testing for BEQ ---

# # 1. BEQ with equal values
# li $t0, 5             # $t0 = 5
# li $t1, 5             # $t1 = 5
# li $t6, 5
# beq $t0, $t1, equal   # Branches to equal
# li $t6, 0             # Skipped instruction
# j endBeq    

# equal:
# li $t2, 1             # $t2 should be 1 if branched properly
# j endBeq

# # 2. BEQ with unequal values
# li $t0, 5             # $t0 = 5
# li $t1, 6             # $t1 = 6
# beq $t0, $t1, unequal # Does not branch
# li $t3, 1             # $t3 should be 1
# j endBeq
# li $t4, 1

# unequal:
# li $t3, 3             # Skipped instruction

# # 3. BEQ with delay slot operation
# li $t0, 7             # $t0 = 7
# li $t1, 7             # $t1 = 7
# beq $t0, $t1, delayBeq
# add $t4, $t0, $t1     # This should be executed, $t4 = 14

# delayBeq:
# li $t5, 1             # $t5 should be 1 if branched properly after delay slot

# endBeq:


# --- Testing for BNE ---

# # 1. BNE with unequal values
# li $t6, 5             # $t6 = 5
# li $t7, 6             # $t7 = 6
# bne $t6, $t7, notEqual # Branches to notEqual
# li $t9, 1             # Skipped instruction
# j endBne

# notEqual:
# li $t8, 1             # $t8 should be 1 if branched properly
# j endBne
# li $s0, 1
# 2. BNE with equal values
# li $t6, 8             # $t6 = 8
# li $t7, 8             # $t7 = 8
# bne $t6, $t7, isEqual  # Does not branch
# li $t9, 1             # $t9 should be 1
# j endBne

# isEqual:
# li $t9, 0             # Skipped instruction

# 3. BNE with delay slot operation
li $t6, 9             # $t6 = 9
li $t7, 10            # $t7 = 10
bne $t6, $t7, delayBne
add $s0, $t6, $t7     # This should be executed, $s0 = 19

delayBne:
li $s1, 1             # $s1 should be 1 if branched properly after delay slot

endBne:

.word 0xfeedfeed
