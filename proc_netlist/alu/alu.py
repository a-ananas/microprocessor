from lib_carotte import *

import arith
import comp
import const
import logic
import utils
import shift

# the main alu
def alu(instr: Variable) -> Variable:
    # get opcode
    assert(instr.bus_size == 32)
    opcode = instr[0:5]

    # get values according to opcode
    # do the operation according to opcode
    # return the result
    assert(False)