xor x14 x14 x14                         # put 0 in x14
MAIN:
add x0 x0 x14                           # put x14 in x0 Y1
addi x1 x0 1                            # add 1 to x1 Y2
addi x2 x1 1                            # add 1 to x2 Y3
addi x3 x2 1                            # add 1 to x3 Y4
addi x4 x3 1                            # add 1 to x4 D1
addi x5 x4 1                            # add 1 to x5 D2
addi x6 x5 1                            # add 1 to x6 M1
addi x7 x6 1                            # add 1 to x7 M2
addi x8 x7 1                            # add 1 to x8 H1
addi x9 x8 1                            # add 1 to x9 H2
xor x10 x10 x10                         # put 0 in x10 M1
xor x11 x11 x11                         # put 0 in x11 M2
xor x12 x12 x12                         # put 0 in x12 S1
xor x13 x13 x13                         # put 0 in x13 S1
addi x14 x14 1                          # increment x14
jal x15 MAIN