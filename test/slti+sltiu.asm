.data

.text
main:
    # Initialize some test values
    li $t0, 2002  # Maximum positive 32-bit integer
    li $t1, -1          # -1 in two's complement
    li $t2, -2002  # Minimum 32-bit integer (negative)

    # Basic slti operation with positive values
    slti $s0, $t0, 1     # $s0 = 0 (since 2002 is not less than than 1)
    slti $s1, $t0, -1    # $s1 = 0 (since 2002 is not less than -1)
    slti $s2, $t1, 1     # $s2 = 1 (since -1 is less than 1)
    slti $s3, $t2, -1    # $s3 = 1 (since -2002 is less than -1 when treated as signed)

    # Basic sltiu operation with positive values
    sltiu $s4, $t0, 1     # $s4 = 0 (since 2002 is not less than 1)
    sltiu $s5, $t1, 1     # $s5 = 0 (since -1 is not less than 1 when treated as unsigned)
    sltiu $s6, $t2, 1     # $s6 = 0 (since -2002 is not less than 1 when treated as unsigned)

.word 0xfeedfeed
