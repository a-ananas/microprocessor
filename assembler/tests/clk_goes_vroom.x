INIT:
lw x13 x13 2                        # get current seconds from ram in x13
lw x11 x11 3                        # get current minutes from ram in x11
lw x9 x9 4                          # get current hours from ram in x9
lw x7 x7 5                          # get current day from ram in x7
lw x5 x5 6                          # get current month from ram in x5
lw x3 x3 7                          # get current year from ram in x3

# do double dabble here

MAIN_LOOP:
UPDATE_COUNTER:
addi x13 x13 1                      # update the value in x13

CHECK_MODULOS_SEC:
bge x13 x13 x31 CHECK_MODULOS_MIN   # if nb_sec >= 60 check the minutes
jal x13 MAIN_LOOP

CHECK_MODULOS_MIN:
xor x13 x13 x13                     # nb_sec = 0
addi x11 x11 1                      # nb_min +1
bge x11 x11 x31 CHECK_MODULOS_HRS   # if nb_min >= 60 check the hours
jal x11 MAIN_LOOP

CHECK_MODULOS_HRS:
xor x11 x11 x11                     # nb_min = 0
addi x9 x9 1                        # nb_hours +1
bge x9 x9 x30 CHECK_MODULOS_DAY     # if nb_hours >= 24 check the day
jal x9 MAIN_LOOP

CHECK_MODULOS_DAY:
xor x9 x9 x9                        # nb_hours = 0
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