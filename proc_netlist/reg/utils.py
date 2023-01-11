from lib_carotte import *

from global_utils import const
from global_utils import utils

import rdi


# from decodeur
def get_isI(o: Variable):
    a = Not(o[3] | o[4])
    c = o[4] & ~(o[3] | o[2] | o[1] | o[0])
    d = o[4] & o[2] & o[1] & ~o[3] & ~o[0]
    b = And5(o[0],o[1],o[2],o[3],o[4])
    return a | b | c | d


def get_wdata(opcode: Variable, value_from_alu: Variable, value_from_ram: Variable) -> Variable:
    # test input sizes
    assert(opcode.bus_size == const.OPCODE_SIZE)
    assert(value_from_alu.bus_size == const.REG_SIZE)
    assert(value_from_ram.bus_size == const.REG_SIZE)

    # do a mux using opcode to choose either from alu or from ram
    # check if opcode == 00001 (lw)
    selector = rdi.utils.test_eq_opcode(opcode, Constant("00001")) # = 1 if lw, 0 otherwise

    return Mux(selector, value_from_alu, value_from_ram)


def get_i2(opcode: Variable, imm: Variable, i2_from_reg: Variable) -> Variable:
    # test input size
    assert(opcode.bus_size == const.OPCODE_SIZE)
    assert(imm.bus_size == const.REG_SIZE)
    assert(i2_from_reg.bus_size == const.REG_SIZE)

    # do a mux using opcode to choose either from reg box or immediate
    # check if opcode is type I
    isI = get_isI(opcode)
    return Mux(isI, i2_from_reg, imm)


def get_value_from_regid(reg_id) -> Variable:
    return Reg(Defer(const.REG_SIZE, lambda: reg_id))


def get_value_from_reg(reg_address: Variable) -> Variable:
    # test sizes
    assert(reg_address.bus_size == const.REG_SIZE)
    # get the value from all registers
    list_of_cur_reg_values = map(get_value_from_regid, const.REG_IDS)
    # use reg_address as a selector for the correct value
    # do a mux on every registers to choose the one you want
    reg_value = utils.mux_32_to_1_5b_selector(list_of_cur_reg_values, reg_address)
    return reg_value


def write_value_in_reg(reg_address: Variable, wdata: Variable, wenable: Variable) -> Variable:
    # test sizes
    assert(reg_address.bus_size == const.REG_SIZE)
    assert(wdata.bus_size == const.REG_SIZE)
    assert(wenable.bus_size == 1)

    # for each register add a mux : selector = addres, if not then old value, else wdata

    # TODO
    return