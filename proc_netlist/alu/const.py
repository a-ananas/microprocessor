from lib_carotte import *

c1b_0 = lambda : Constant("0")
c1b_1 = lambda : Constant("1")

c2b_0 = lambda : Constant("00")
c2b_1 = lambda : Constant("01")

c4b_0 = lambda : Constant("0000")
c4b_1 = lambda : Constant("0001")

c8b_0 = lambda : Constant(8*"0")
c8b_1 = lambda : Constant(7*"0"+"1")

c16b_0 = lambda : Constant(16*"0")
c16b_1 = lambda : Constant(15*"0"+"1")

c32b_0 = lambda : Constant(32*"0")
c32b_1 = lambda : Constant(31*"0"+"1")