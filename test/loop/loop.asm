main:                                   # @main
        addiu   $sp, $sp, -24
        sw      $ra, 20($sp)                    # 4-byte Folded Spill
        sw      $fp, 16($sp)                    # 4-byte Folded Spill
        move    $fp, $sp
        lui     $1, %hi($__const.main.D)
        lw      $2, %lo($__const.main.D)($1)
        sw      $2, 4($fp)
        addiu   $1, $1, %lo($__const.main.D)
        lw      $2, 8($1)
        sw      $2, 12($fp)
        lw      $1, 4($1)
        sw      $1, 8($fp)
        addiu   $1, $zero, 1
        sw      $1, 0($fp)
        lw      $1, 0($fp)
        sll     $2, $1, 2
        addiu   $1, $fp, 4
        addu    $2, $1, $2
        addiu   $1, $zero, 3
        sw      $1, 0($2)
        move    $sp, $fp
        lw      $fp, 16($sp)                    # 4-byte Folded Reload
        lw      $ra, 20($sp)                    # 4-byte Folded Reload
        addiu   $sp, $sp, 24
        jr      $ra
        nop
$__const.main.D:
        .4byte  1                               # 0x1
        .4byte  1                               # 0x1
        .4byte  1                               # 0x1