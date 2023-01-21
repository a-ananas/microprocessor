# x0 -> milliers des années
# x1 -> centaines des années
# x2 -> dizaines des années
# x19 -> unités des années
# 
# x4 -> dizaines du jour
# x17 -> unités du jour
# 
# x6 -> dizaines du mois
# x18 -> unités du mois
# 
# x8 -> dizaines des heures
# x16 -> unités des heures
# 
# x10 -> dizaines des minutes
# x15 -> unités des minutes
# 
# x12 -> dizaines des secondes
# x14 -> unités des secondes

# input années dans x19
# input mois dans x17
# input jours dans x18
# input heures dans x16
# input minutes dans x15
# input secondes dans x14
xor  x19 x19 x19
xor  x17 x17 x17
xor  x18 x18 x18
xor  x16 x16 x16
xor  x15 x15 x15
xor  x14 x14 x14
xor  x21 x21 x21
addi x19 x19 2023
addi x18 x18 12
addi x17 x17 31
addi x16 x16 13
addi x15 x15 59
addi x14 x14 59


YRS:
addi x26 x19 0
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
addi x27 x23 0
jal x0 MTH

MTH:
xor  x23 x23 x23
addi x26 x18 0
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
addi x28 x23 0
jal  x6 DAY

DAY:
xor  x23 x23 x23
addi x26 x17 0
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
addi x29 x23 0
jal  x4 HUR

HUR:
xor  x23 x23 x23
addi x26 x16 0
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
addi x30 x23 0
jal  x8 MIN

MIN:
xor  x23 x23 x23
addi x26 x15 0
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
addi x31 x23 0
jal  x10 SEC

SEC:
xor  x23 x23 x23
addi x26 x14 0
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
jal  x12 END

END:
# SEC
andi x13 x23 15
srli x23 x23 4
andi x12 x23 15

# MIN
andi x11 x31 15
srli x31 x31 4
andi x10 x31 15

# HOUR
andi x9 x30 15
srli x30 x30 4
andi x8 x30 15

# MONTH
andi x7 x28 15
srli x28 x28 4
andi x6 x28 15

# DAY
andi x5 x29 15
srli x29 x29 4
andi x4 x29 15

#YEAR
andi x3 x27 15
srli x27 x27 4
andi x2 x27 15
srli x27 x27 4
andi x1 x27 15
srli x27 x27 4
andi x0 x27 15

jal x0 SUCCESS_LOOP

SUCCESS_LOOP:
addi x0 x0 0
