from lib_carotte import *
from global_utils import utils
from global_utils import const

# return a 1 iff instruction is of type I
def get_isI(o: Variable) -> Variable:
    # test input size
    assert(o.bus_size == const.OPCODE_SIZE)
    a = Not(o[3] | o[4]) # codes starting with 00 are of type I
    # codes 10 000 and 10 110
    c = o[4] & ~(o[3] | o[2] | o[1] | o[0])
    d = o[4] & o[2] & o[1] & ~o[3] & ~o[0]
    # codes 11 111
    b = o[0] & o[1] & o[2] & o[3] & o[4]
    return (a | b | c | d) & ~(o[0] & ~o[1] & ~o[2])

# return a 1 iff instruction is of type R
def get_isR(o: Variable) -> Variable:
    # test input size
    assert(o.bus_size == const.OPCODE_SIZE)
    # codes starting with 01
    a = And(Not(o[4]),o[3])
    # code 11 110
    b = o[4] & o[3] & o[2] & o[1] & ~o[0]
    # codes 10 + all but 000, 110 and 010 (useless, but better to have isR to false) 
    oneOfThree = ~(o[2] | o[1] | o[0]) | (o[2] & o[1] & ~o[0]) | (~o[2] & o[1] & ~o[0])
    c = o[4] & ~o[3] & ~oneOfThree
    return a | b | c

# return a 1 iff instruction is of type U
def get_isU(o: Variable):
    # test input size
    assert(o.bus_size == const.OPCODE_SIZE)
    # starting with 110
    return o[4] & o[3] & ~o[2]



def get_field_U(instr: Variable, opcode: Variable) -> tuple[Variable,Variable,Variable]:
    assert(instr.bus_size == const.REG_SIZE)
    assert(opcode.bus_size == const.OPCODE_SIZE)
    imm0 = instr[10:const.REG_SIZE] + Constant(10 * '0')
    imm1 = instr[10:const.REG_SIZE] + Constant(10 * '1')
    imm = Mux(instr[const.REG_SIZE-1],imm0,imm1)
    # wenable = 1 for 11000 and 11001, 0 otehrwise (aka 11010 11011)
    wenableReg = ~opcode[1]
    return (imm, wenableReg, const.C1B_0())


# return the fields from an instruction of type I
def get_field_I(instr: Variable, opcode: Variable) -> tuple[Variable,Variable,Variable]:
    assert(instr.bus_size == const.REG_SIZE)
    assert(opcode.bus_size == const.OPCODE_SIZE)
    imm1 = instr[15:const.REG_SIZE] + Constant(15 * '1')
    imm0 = instr[15:const.REG_SIZE] + Constant(15 * '0')
    imm = Mux(instr[const.REG_SIZE-1], imm0, imm1)
    # must be equal 0 if 01 + any (except 000)
    wenableReg = Not(~opcode[4] & opcode[3] & (opcode[2] | opcode[1] | opcode[0]))
    return (imm, wenableReg, const.C1B_0())


# return the fields from an instruction of type R
def get_field_R(instr: Variable, opcode: Variable) -> tuple[Variable,Variable,Variable]:
    assert(instr.bus_size == const.REG_SIZE)
    assert(opcode.bus_size == const.OPCODE_SIZE)
    imm1 = instr[20:const.REG_SIZE] + Constant(20 * '1')
    imm0 = instr[20:const.REG_SIZE] + Constant(20 * '0')
    imm = Mux(instr[const.REG_SIZE-1], imm0, imm1)
    wenableReg = Mux(opcode[0], const.C1B_1(), Mux(opcode[1], const.C1B_0(), const.C1B_1())) # all the R not starting by 10 are yes on wenableReg
    wenableRAM = utils.test_eq(opcode, Constant("10001")) # only true for Sw
    return (imm, wenableReg, wenableRAM)