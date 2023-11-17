.data
    output: .word 0

.text
main:
    # Case 1: Negative value shouldn't branch
    li $t0, -5
    bgtz $t0, isPositive
    add $t0, $t0, 5   # This should be executed
    j continue1 

isPositive:
    sub $t0, $t0, 10  # This shouldn't be executed
continue1:
    # At this point, $t0 should be 0 if branching and delay slot worked correctly

    # Case 2: Zero value shouldn't branch
    li $t1, 0
    bgtz $t1, isZeroPositive
    add $t1, $t1, 5   # This should be executed
    j continue2

isZeroPositive:
    sub $t1, $t1, 10  # This shouldn't be executed
continue2:
    # At this point, $t1 should be 5 if branching and delay slot worked correctly

    # Case 3: Positive value should branch
    li $t2, 1
    bgtz $t2, isPositive2
    add $t2, $t2, 5   # This shouldn't be executed

isPositive2:
    sub $t2, $t2, 10  # This should be executed, because $t2 > 0
    # At this point, $t2 should be -9 if branching and delay slot worked correctly


.word 0xfeedfeed
