main:   addi x2, x0, 5          # x2 = 5                            00
        addi x3, x0, 12         # x3 = 12                           04
        addi x7, x3, -9         # x7 = (12 - 9) = 3                 08
        or   x4, x7, x2         # x4 = (3 OR 5) = 7                 0C
        and  x5, x3, x4         # x5 = (12 AND 7) = 4               10
        add  x5, x5, x4         # x5 = (4 + 7) = 11                 14
        beq  x5, x7, end        # shouldn't be taken                18
        slt  x4, x3, x4         # x4 = (12 < 7) = 0                 1C
        beq  x4, x0, around     # should be taken                   20
        addi x5, x0, 0          # shouldn't execute                 24
around: slti x4, x7, 5          # x4 = (3 < 5) = 1                  28
        add  x7, x4, x5         # x7 = (1 + 11) = 12                2C
        sub  x7, x7, x2         # x7 = (12 - 5) = 7                 30    
        sw   x7, 84(x3)         # [84 + x3] [96] = 7                34    
        lw   x2, 96(x0)         # x2 = [96] = 7                     38    
        add  x9, x2, x5         # x9 = (7 + 11) = 18                3C
        jal  x3, end            # jump to end, x3 = 0x44            40    
        addi x2, x0, 1          # shouldn't execute                 44
end:    add  x2, x2, x9         # x2 = (7 + 18) = 25                48    
        ori  x2, x2, 0          # x2 = (25 OR 0) = 25               4C
        andi x2, x2, 25         # x5 = (25 AND 25) = 25             50 
        sw   x2, 0x20(x3)       # [100] = 25 (decimal)              54
done:   beq  x2, x2, done       # infinite loop                     58                                                                   