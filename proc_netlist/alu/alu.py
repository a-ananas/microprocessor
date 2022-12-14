from lib_carotte import *

import arith
import comp
import const
import logic
import utils
import shift

# return the format of an operation from an opcode
def get_format(opcode: Variable) -> Variable:
    #             s0 s1
    # format R ->  0  0
    # format U ->  1  0
    # format I ->  0  1
    assert(opcode.bus_size == 5)
    s1 = (~opcode[3]) | (opcode[4] & opcode[2] & opcode[1] & opcode[0])
    s0 = opcode[4] & opcode[3] & (~opcode[2])
    format = s0 + s1
    assert(format.bus_size == 2)
    return s0+s1 


# the main alu
def alu(instr: Variable) -> Variable:
    # get opcode
    assert(instr.bus_size == 32)
    opcode = instr[0:5]

    # get values according to opcode
    format = get_format(opcode)

    # do the operation according to opcode
    # return the result
    return format