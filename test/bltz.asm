.data
    # output: .word 0

.text
main:
    # Case 1: Positive value shouldn't branch
    li $t0, 5
    blez $t0, isNegative
    add $t0, $t0, 5   # This should be executed
    j continue1

isNegative:
    sub $t0, $t0, 10  # This shouldn't be executed
continue1:
    # At this point, $t0 should be 10 if branching and delay slot worked correctly

    # Case 2: Zero value should branch
    li $t1, 0
    blez $t1, isZeroNegative
    add $t1, $t1, 5   # This should not be executed
    j continue2

isZeroNegative:
    sub $t1, $t1, 10  # This shouldn't be executed
continue2:
    # At this point, $t1 should be 5 if branching and delay slot worked correctly

    # Case 3: Negative value should branch
    li $t2, -1
    blez $t2, isNegative2
    add $t4, $t2, 5   # This shouldn't be executed

isNegative2:
    sub $t2, $t2, 10  # This should be executed, because $t2 < 0
    # At this point, $t2 should be -11 if branching and delay slot worked correctly

.word 0xfeedfeed
