from lib_carotte import *

C1B_0 = lambda : Constant("0")
C1B_1 = lambda : Constant("1")

C2B_0 = lambda : Constant("00")
C2B_1 = lambda : Constant("10")

C4B_0 = lambda : Constant("0000")
C4B_1 = lambda : Constant("1000")

C8B_0 = lambda : Constant(8*"0")
C8B_1 = lambda : Constant("1"+7*"0")

C16B_0 = lambda : Constant(16*"0")
C16B_1 = lambda : Constant("1"+15*"0")

C32B_0 = lambda : Constant(32*"0")
C32B_1 = lambda : Constant("1"+31*"0")

REG_SIZE = 32
REG_ADDR_SIZE = 5
REG_IDS = ["x"+i for i in range(REG_SIZE)]

OPCODE_SIZE = 5