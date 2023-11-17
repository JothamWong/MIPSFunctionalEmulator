.set noreorder
.data
.text

# Set up some values for testing
li $t0, 0          # $t0 = 0, used for arithmetic in delay slots
li $t1, 5          # $t1 = 5, used for arithmetic in delay slots

# Basic JR Test
# After the jump, it should skip the next two instructions

li $t2, jumpTarget # Loading address of `jumpTarget` into $t2
jr $t2             # Jump to jumpTarget
add $t0, $t0, $t1  # This is in the delay slot, it should execute. $t0 = 5 after this.
li $t3, 10         # This should be skipped
li $t4, 15         # This should also be skipped

jumpTarget:
# After the jump, execution should resume here
li $t5, 25         # This should execute. $t5 = 25

# Jump to an address in a register with a zero value
# This is a kind of corner case, though in practice this might lead to an error in real hardware
# Still, if your simulator handles it, it would go to address 0

# li $t6, 0          # $t6 = 0
# jr $t6             # Jump to address 0
# add $t1, $t1, $t0  # This is in the delay slot, it should execute. $t1 = 10 after this.
# li $t7, 35         # Assuming address 0 doesn't have valid instructions, this might not execute.

# You might want to be careful with the above, because if your simulator doesn't have safety checks, it might try to fetch and execute instructions at address 0 which could lead to unpredictable behavior.
.word 0xfeedfeed
