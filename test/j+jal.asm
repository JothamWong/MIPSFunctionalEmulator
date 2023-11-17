.data
.text

# --- Testing for J ---

# # Jump to 'jumped' label
# li $t0, 0             # $t0 = 0
# j jumped
# li $t0, 1             # Skipped instruction

# jumped:
# li $t1, 1             # $t1 should be 1 if jumped properly
# j endJ

# 2. J with delay slot operation
li $t2, 5             # $t2 = 5
li $t3, 6             # $t3 = 6c
j delayJ
add $t4, $t2, $t3     # This should not be executed, $t4 = 11

delayJ:
li $t5, 1             # $t5 should be 1 if jumped properly after delay slot

endJ:

# --- Testing for JAL ---

# Jump to 'jumpedAndLink' label and link to $ra
li $t6, 0             # $t6 = 0
jal jumpedAndLink
li $t6, 1             # Skipped instruction

jumpedAndLink:
li $t7, 1             # $t7 should be 1 if jumped properly
# $ra should now hold the address of the next instruction after the jal. Let's comment that exact address when you know it.

# 2. JAL with delay slot operation
li $t8, 5             # $t8 = 5
li $t9, 6             # $t9 = 6
jal delayJal
add $s0, $t8, $t9     # This should be executed, $s0 = 11

delayJal:
li $s1, 1             # $s1 should be 1 if jumped properly after delay slot
# Again, $ra should now hold the address of the next instruction after the jal. Let's comment that exact address when you know it.

endJal:

.word 0xfeedfeed
