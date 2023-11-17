.data

.text
main:
    # Basic ORI operation
    ori $t0, $zero, 0xFFFF       # $t0 = 0x0000FFFF

    # ORing a value with zero should give the same value
    ori $t1, $zero, 0xAABB       # $t1 = 0x0000AABB

    # ORing a value with all ones (0xFFFF) should give all ones
    ori $t2, $t1, 0xFFFF         # $t2 = 0x0000FFFF

    # ORing two known values for checking
    li $t3, 0xAABB0000
    ori $t4, $t3, 0xCCDD         # $t4 = 0xAABBCCDD

    # ORing with a mid-range value
    li $t5, 0x00001234           # 0b1001000110100 ori 0b101011001111000
    ori $t6, $t5, 0x5678         # $t6 = 0x567c


.word 0xfeedfeed
