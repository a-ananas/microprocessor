INIT:
addi x14 x14 2                      # put address for seconds in ram inside x14
addi x15 x15 3                      # put address for minutes in ram inside x15
addi x16 x16 4                      # put address for hours in ram inside x16
addi x17 x17 5                      # put address for days in ram inside x17
addi x18 x18 6                      # put address for months in ram inside x18
addi x19 x19 7                      # put address for years in ram inside x19
addi x20 x20 1                      # put address for clock signal in ram inside x20

lw x13 x14 0                        # get current seconds from ram in x13
lw x11 x15 0                        # get current minutes from ram in x11
lw x9 x16 0                          # get current hours from ram in x9
lw x7 x17 0                          # get current day from ram in x7
lw x5 x18 0                          # get current month from ram in x5
lw x3 x19 0                          # get current year from ram in x3

INIT_CONSTANTS:
addi x31 x31 60                     # put 60 in x31 for time modulos
addi x30 x30 24                     # put 24 in x30 for time modulos
addi x29 x29 31                     # put 31 in x29 for time modulos
addi x28 x28 12                     # put 12 in x28 for time modulos
xor x27 x27 x27 0                   # put 0 in x27 to use when needed

# do double dabble here

MAIN_LOOP:
lw x21 x20 0                        # get clock signal from ram in x21
bne x21 x21 x27 UPDATE_COUNTER      # check if clock signal is set to one
jal x21 MAIN_LOOP                   # infinite loop

UPDATE_COUNTER:
add x13 x13 x21 0                   # update the seconds
xor x21 x21 x21 0                   # put 0 in clock signal register

CHECK_MODULOS_SEC:
bge x13 x13 x31 CHECK_MODULOS_MIN   # if nb_sec >= 60 check the minutes
jal x13 MAIN_LOOP

CHECK_MODULOS_MIN:
xor x13 x13 x13 0                   # nb_sec = 0
addi x11 x11 1                      # nb_min +1
bge x11 x11 x31 CHECK_MODULOS_HRS   # if nb_min >= 60 check the hours
jal x11 MAIN_LOOP

CHECK_MODULOS_HRS:
xor x11 x11 x11 0                   # nb_min = 0
addi x9 x9 1                        # nb_hours +1
bge x9 x9 x30 CHECK_MODULOS_DAY     # if nb_hours >= 24 check the day
jal x9 MAIN_LOOP

CHECK_MODULOS_DAY:
xor x9 x9 x9 0                      # nb_hours = 0
addi x7 x7 1                        # nb_days +1
blt x7 x29 x7 CHECK_MODULOS_MTH     # if 31 < nb_days check the month
jal x7 MAIN_LOOP

CHECK_MODULOS_MTH:
addi x7 x27 1                       # nb_days = 1
addi x5 x5 1                        # nb_month +1
blt x5 x28 x5 CHECK_MODULOS_YRS     # if 12 < nb_month check the year
jal x5 MAIN_LOOP

CHECK_MODULOS_YRS:
addi x5 x27 1                       # nb_month = 1
addi x3 x3 1                        # nb_years +1
jal x3 MAIN_LOOP                    # switch back to main loop