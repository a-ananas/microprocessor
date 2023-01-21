# x0 -> milliers des années
# x1 -> centaines des années
# x2 -> dizaines des années
# x3 -> unités des années
# 
# x4 -> dizaines du jour
# x5 -> unités du jour
# 
# x6 -> dizaines du mois
# x7 -> unités du mois
# 
# x8 -> dizaines des heures
# x9 -> unités des heures
# 
# x10 -> dizaines des minutes
# x11 -> unités des minutes
# 
# x12 -> dizaines des secondes
# x13 -> unités des secondes

# input années dans x3
# input mois dans x5
# input jours dans x7
# input heures dans x9
# input minutes dans x11
# input secondes dans x13
xor  x3 x3 x3
xor  x5 x5 x5
xor  x7 x7 x7
xor  x9 x9 x9
xor  x11 x11 x11
xor  x13 x13 x13
xor  x21 x21 x21
addi x3 x3 2023
addi x7 x7 12
addi x5 x5 31
addi x9 x9 13
addi x11 x11 59
addi x13 x13 59


YRS:
addi x26 x3 0
slli x26 x26 1
addi x26 x26 1
BOUCLE_YRS:
andi x25 x26 2048
srli x25 x25 11
slli x23 x23 1
add  x23 x23 x25
slli x26 x26 1

andi x24 x26 2047
beq  x24 x24 x21 END_YRS

jal x23 TEST_UNT

TEST_UNT:
xor  x24 x24 x24
addi x24 x24 4              # 4
andi x25 x23 15             # x
bge  x23 x24 x25 TEST_TEN   # si 4 >= x
addi x23 x23 3              # +3 aux unités
jal  x23 TEST_TEN           
                            
TEST_TEN:                   
addi x24 x24 60             # 64
andi x25 x23 240            # x
bge  x23 x24 x25 TEST_HUN   # si 4 >= x
addi x23 x23 48             # +3 aux dizaines
jal  x23 TEST_HUN           
                            
TEST_HUN:                   
addi x24 x24 960            # 1024
andi x25 x23 3840           # x
bge  x23 x24 x25 TEST_THO   # si 4 >= x
addi x23 x23 768            # +3 aux centaines
jal  x23 TEST_THO           
                            
TEST_THO:                   
addi x24 x24 15360          # 16384
andi x25 x23 61440          # x
bge  x23 x24 x25 BOUCLE_YRS # si 4 >= x
addi x23 x23 12304          # +3 aux milliers
jal  x23 BOUCLE_YRS

END_YRS:
andi x3 x23 15
srli x23 x23 4
andi x2 x23 15
srli x23 x23 4
andi x1 x23 15
srli x23 x23 4
andi x0 x23 15
jal x0 MTH

MTH:
xor  x23 x23 x23
addi x26 x7 0
slli x26 x26 1
addi x26 x26 1
BOUCLE_MTH:
andi x25 x26 16
srli x25 x25 4
slli x23 x23 1
add  x23 x23 x25
slli x26 x26 1

andi x24 x26 15
beq  x24 x24 x21 END_MTH

jal x23 TEST_UMH

TEST_UMH:
xor  x24 x24 x24
addi x24 x24 4              # 4
andi x25 x23 15             # x
bge  x23 x24 x25 TEST_TMH   # si 4 >= x
addi x23 x23 3              # +3 aux unités
jal  x23 TEST_TMH           
                            
TEST_TMH:                   
addi x24 x24 60             # 64
andi x25 x23 240            # x
bge  x23 x24 x25 BOUCLE_MTH # si 4 >= x
addi x23 x23 48             # +3 aux dizaines
jal  x23 BOUCLE_MTH           

END_MTH:
andi x7 x23 15
srli x23 x23 4
andi x6 x23 15
jal  x6 DAY

DAY:
xor  x23 x23 x23
addi x26 x5 0
slli x26 x26 1
addi x26 x26 1
BOUCLE_DAY:
andi x25 x26 32
srli x25 x25 5
slli x23 x23 1
add  x23 x23 x25
slli x26 x26 1

andi x24 x26 31
beq  x24 x24 x21 END_DAY

jal x23 TEST_UDY

TEST_UDY:
xor  x24 x24 x24
addi x24 x24 4              # 4
andi x25 x23 15             # x
bge  x23 x24 x25 TEST_TDY   # si 4 >= x
addi x23 x23 3              # +3 aux unités
jal  x23 TEST_TDY           
                            
TEST_TDY:                   
addi x24 x24 60             # 64
andi x25 x23 240            # x
bge  x23 x24 x25 BOUCLE_DAY # si 4 >= x
addi x23 x23 48             # +3 aux dizaines
jal  x23 BOUCLE_DAY           

END_DAY:
andi x5 x23 15
srli x23 x23 4
andi x4 x23 15
jal  x4 HUR

HUR:
xor  x23 x23 x23
addi x26 x9 0
slli x26 x26 1
addi x26 x26 1
BOUCLE_HUR:
andi x25 x26 32
srli x25 x25 5
slli x23 x23 1
add  x23 x23 x25
slli x26 x26 1

andi x24 x26 31
beq  x24 x24 x21 END_HUR

jal x23 TEST_UHR

TEST_UHR:
xor  x24 x24 x24
addi x24 x24 4              # 4
andi x25 x23 15             # x
bge  x23 x24 x25 TEST_THR   # si 4 >= x
addi x23 x23 3              # +3 aux unités
jal  x23 TEST_THR           
													
TEST_THR:                   
addi x24 x24 60             # 64
andi x25 x23 240            # x
bge  x23 x24 x25 BOUCLE_HUR # si 4 >= x
addi x23 x23 48             # +3 aux dizaines
jal  x23 BOUCLE_HUR           

END_HUR:
andi x9 x23 15
srli x23 x23 4
andi x8 x23 15
jal  x8 MIN

MIN:
xor  x23 x23 x23
addi x26 x11 0
slli x26 x26 1
addi x26 x26 1
BOUCLE_MIN:
andi x25 x26 64
srli x25 x25 6
slli x23 x23 1
add  x23 x23 x25
slli x26 x26 1

andi x24 x26 63
beq  x24 x24 x21 END_MIN

jal x23 TEST_UMN

TEST_UMN:
xor  x24 x24 x24
addi x24 x24 4              # 4
andi x25 x23 15             # x
bge  x23 x24 x25 TEST_TMN   # si 4 >= x
addi x23 x23 3              # +3 aux unités
jal  x23 TEST_TMN           
                            
TEST_TMN:                   
addi x24 x24 60             # 64
andi x25 x23 240            # x
bge  x23 x24 x25 BOUCLE_MIN # si 4 >= x
addi x23 x23 48             # +3 aux dizaines
jal  x23 BOUCLE_MIN           

END_MIN:
andi x11 x23 15
srli x23 x23 4
andi x10 x23 15
jal  x10 SEC

SEC:
xor  x23 x23 x23
addi x26 x13 0
slli x26 x26 1
addi x26 x26 1
BOUCLE_SEC:
andi x25 x26 64
srli x25 x25 6
slli x23 x23 1
add  x23 x23 x25
slli x26 x26 1

andi x24 x26 63
beq  x24 x24 x21 END_SEC

jal x23 TEST_USC

TEST_USC:
xor  x24 x24 x24
addi x24 x24 4              # 4
andi x25 x23 15             # x
bge  x23 x24 x25 TEST_TSC   # si 4 >= x
addi x23 x23 3              # +3 aux unités
jal  x23 TEST_TSC           
                            
TEST_TSC:                   
addi x24 x24 60             # 64
andi x25 x23 240            # x
bge  x23 x24 x25 BOUCLE_SEC # si 4 >= x
addi x23 x23 48             # +3 aux dizaines
jal  x23 BOUCLE_SEC           

END_SEC:
andi x13 x23 15
srli x23 x23 4
andi x12 x23 15
jal  x12 END

END:
addi x0 x0 0
jal x0 END
