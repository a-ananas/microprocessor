MAIN:
addi x0 x0 1
addi x1 x1 2
xor x3 x3 x3 0

blt x0 x0 x1 B
bge x0 x0 x1 A
C:
addi x3 x3 7
jal x0 END

A:
addi x3 x3 9
jal x0 END

B:
addi x3 x3 8
jal x0 END

END: