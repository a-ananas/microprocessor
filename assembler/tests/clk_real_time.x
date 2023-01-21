INIT:
addi x14 x14 2                      # put address for seconds in ram inside x14
addi x15 x15 3                      # put address for minutes in ram inside x15
addi x16 x16 4                      # put address for hours in ram inside x16
addi x17 x17 5                      # put address for days in ram inside x17
addi x18 x18 6                      # put address for months in ram inside x18
addi x19 x19 7                      # put address for years in ram inside x19
addi x20 x20 1                      # put address for clock signal in ram inside x20

lw x14 x14 0                        # get current seconds from ram in x14
lw x15 x15 0                        # get current minutes from ram in x15
lw x16 x16 0                        # get current hours from ram in x16
lw x18 x18 0                        # get current month from ram in x18
lw x17 x17 0                        # get current day from ram in x17
lw x19 x19 0                        # get current year from ram in x19

# do double dabble here

INIT_CONSTANTS:
addi x31 x31 60                     # put 60 in x31 for time modulos
addi x30 x30 24                     # put 24 in x30 for time modulos
addi x29 x29 31                     # put 31 in x29 for time modulos
addi x28 x28 12                     # put 12 in x28 for time modulos
xor x27 x27 x27 0                   # put 0 in x27 to use when needed
addi x26 x26 10                     # put 10 in x26 to use when needed

MAIN_LOOP:
lw x21 x20 0                        # get clock signal from ram in x21
bne x21 x21 x27 UPDATE_COUNTER      # check if clock signal is set to one
jal x21 MAIN_LOOP                   # infinite loop

UPDATE_COUNTER:
add x14 x14 x21 0                   # nb_sec_global +1
xor x21 x21 x21 0                   # put 0 in clock signal register
sw x21 x21 x20 0                    # reset ram clock signal

CHECK_MODULOS_SEC:
bge x14 x14 x31 CHECK_MODULOS_MIN   # if nb_sec_global >= 60 check the minutes
add x13 x13 x21 0                   # unit_sec +1
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