MAIN:
xor x0 x0 x0 # put 0 in x0
addi x1 x0 1 # put 1 in x1
xor x3 x3 x3 # put 0 in x3
lw x2 x0 0 # get current unix time from ram in x2
LOOP:
lw x3 x1 0 # get clock signal from ram in x3
bne x3 x3 x0 UPDATE # check if x3 is set to one
jal x4 LOOP # infinite loop
UPDATE:
add x2 x2 x3 # update the value in x2
xor x3 x3 x3 # put 0 in x3
jal x4 LOOP