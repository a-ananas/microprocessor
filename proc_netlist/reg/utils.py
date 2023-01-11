from lib_carotte import *

from global_utils import const
import rdi

def get_wdata(opcode: Variable, value_from_alu: Variable, value_from_ram: Variable) -> Variable:
    # test input sizes
    assert(opcode.bus_size == const.opcode_size)
    assert(value_from_alu.bus_size == const.reg_size)
    assert(value_from_ram.bus_size == const.reg_size)

    # do a mux using opcode to choose either from alu or from ram
    # check if opcode == 00001 (lw)
    selector = rdi.utils.test_eq_opcode(opcode, Constant("00001")) # = 1 if lw, 0 otherwise

    return Mux(selector, value_from_alu, value_from_ram)


def get_i2(opcode: Variable, imm: Variable, i2_from_reg: Variable) -> Variable:
    # test input size

    # do a mux using opcode to choose either from reg box or immediate
    # check if opcode is type I
    
    return 