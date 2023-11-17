.data

.text
main:
    # Test basic functionality
    lui $t0, 1        # $t0 = 

    # Test all zeros
    lui $t1, 0          # $t1 = 

    # Test all ones (i.e., 0xFFFF)
    lui $t2, 2       # $t2 = 

    # Check with other operations (not a real corner case, but helps ensure functionality)
    add $t3, $t0, $t1     # $t3 = $t0 + $t1 = 0x12340000

    .word 0xfeedfeed
