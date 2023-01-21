INIT:
addi x14 x14 2                      # put address for seconds in ram inside x14
addi x15 x15 3                      # put address for minutes in ram inside x15
addi x16 x16 4                      # put address for hours in ram inside x16
addi x17 x17 5                      # put address for days in ram inside x17
addi x18 x18 6                      # put address for months in ram inside x18
addi x19 x19 7                      # put address for years in ram inside x19

lw x14 x14 0                        # get current seconds from ram in x14
lw x15 x15 0                        # get current minutes from ram in x15
lw x16 x16 0                        # get current hours from ram in x16
lw x18 x18 0                        # get current month from ram in x18
lw x17 x17 0                        # get current day from ram in x17
lw x19 x19 0                        # get current year from ram in x19

# do double dabble here
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

INIT_CONSTANTS:
xor  x31 x31 x31 0                  # re-init x31
xor  x30 x30 x30 0                  # re-init x30
xor  x29 x29 x29 0                  # re-init x29
xor  x28 x28 x28 0                  # re-init x28
xor  x26 x26 x26 0                  # re-init x26
addi x31 x31 60                     # put 60 in x31 for time modulus
addi x30 x30 24                     # put 24 in x30 for time modulus
addi x29 x29 31                     # put 31 in x29 for time modulus
addi x28 x28 12                     # put 12 in x28 for time modulus
xor x27 x27 x27 0                   # put 0 in x27 to use when needed
addi x26 x26 10                     # put 10 in x26 to use when needed

MAIN_LOOP:
UPDATE_COUNTER:
addi x14 x14 1                      # nb_sec_global +1

CHECK_MODULOS_SEC:
bge x14 x14 x31 CHECK_MODULOS_MIN   # if nb_sec_global >= 60 check the minutes
addi x13 x13 1                      # unit_sec +1
bge x13 x13 x26 ADD_TENS_SECS       # if unit_sec >= 10 update dec_sec
jal x13 MAIN_LOOP

ADD_TENS_SECS:
xor x13 x13 x13 0                   # unit_sec = 0
addi x12 x12 1                      # dec_sec +1
jal x13 MAIN_LOOP

CHECK_MODULOS_MIN:
xor x14 x14 x14 0                   # nb_sec_global = 0
xor x13 x13 x13 0                   # unit_sec = 0
xor x12 x12 x12 0                   # dec_sec = 0
addi x15 x15 1                      # nb_min_global +1
bge x15 x15 x31 CHECK_MODULOS_HRS   # if nb_min_global >= 60 check the hours
addi x11 x11 1                      # unit_min +1
bge x11 x11 x26 ADD_TENS_MINS       # if unit_min >= 10 update dec_min
jal x11 MAIN_LOOP

ADD_TENS_MINS:
xor x11 x11 x11 0                   # unit_min = 0
addi x10 x10 1                      # dec_min +1
jal x11 MAIN_LOOP

CHECK_MODULOS_HRS:
xor x15 x15 x15 0                   # nb_min_global = 0
xor x11 x11 x11 0                   # unit_min = 0
xor x10 x10 x10 0                   # dec_min = 0
addi x16 x16 1                      # nb_hours_global +1
bge x16 x16 x30 CHECK_MODULOS_DAY   # if nb_hours_global >= 24 check the day
addi x9 x9 1                        # unit_hours +1
bge x9 x9 x26 ADD_TENS_HOURS        # if unit_hours >= 10 update dec_hours
jal x9 MAIN_LOOP

ADD_TENS_HOURS:
xor x9 x9 x9 0                      # unit_hours = 0
addi x8 x8 1                        # dec_hours +1
jal x9 MAIN_LOOP

CHECK_MODULOS_DAY:
xor x16 x16 x16 0                   # nb_hours_global = 0
xor x9 x9 x9 0                      # unit_hours = 0
xor x8 x8 x8 0                      # dec_hours = 0
addi x17 x17 1                      # nb_days_global +1
blt x17 x29 x17 CHECK_MODULOS_MTH   # if nb_days_global > 31 check the month
addi x5 x5 1                        # unit_days +1
bge x5 x5 x26 ADD_TENS_DAYS         # if unit_days >= 10 update dec_days
jal x5 MAIN_LOOP

ADD_TENS_DAYS:
xor x5 x5 x5 0                      # unit_days = 0
addi x4 x4 1                        # dec_days +1
jal x5 MAIN_LOOP

CHECK_MODULOS_MTH:
addi x17 x27 1                      # nb_days_global = 1
addi x5 x27 1                       # unit_days = 1
xor x4 x4 x4 0                      # dec_days = 0
addi x18 x18 1                      # nb_month_global +1
blt x18 x28 x18 CHECK_MODULOS_YRS   # if nb_month_global > 12 check the year
addi x7 x7 1                        # unit_month +1
bge x7 x7 x26 ADD_TENS_MONTHS       # if unit_month >= 10 update dec_months
jal x7 MAIN_LOOP

ADD_TENS_MONTHS:
xor x7 x7 x7 0                      # unit_month = 0
addi x6 x6 1                        # dec_month +1
jal x7 MAIN_LOOP

CHECK_MODULOS_YRS:
addi x18 x27 1                      # nb_month_global = 1
addi x7 x27 1                       # unit_month = 1
xor x6 x6 x6 0                      # dec_month = 0
addi x19 x19 1                      # nb_years_global +1
addi x3 x3 1                        # unit_years +1
bge x3 x3 x26 ADD_TENS_YEARS        # if unit_years >= 10 update dec_years
jal x3 MAIN_LOOP                    # switch back to main loop

ADD_TENS_YEARS:
xor x3 x3 x3 0                      # unit_years = 0
addi x2 x2 1                        # dec_years +1
bge x2 x2 x26 ADD_HDRDS_YEARS       # if dec_years >= 10 update hdrd_years
jal x3 MAIN_LOOP

ADD_HDRDS_YEARS:
xor x2 x2 x2 0                      # dec_years = 0
addi x1 x1 1                        # hdrd_years +1
bge x1 x1 x26 ADD_THSNDS_YEARS      # if hdrd_years >= 10 update thsnd_years
jal x3 MAIN_LOOP

ADD_THSNDS_YEARS:
xor x1 x1 x1 0                      # hdrd_years = 0
addi x0 x0 1                        # thsnd_years +1
jal x3 MAIN_LOOP