from lib_carotte import *

from global_utils import const
from global_utils import utils


# from decodeur
def get_isI(o: Variable):
    a = Not(o[3] | o[4])
    c = o[4] & ~(o[3] | o[2] | o[1] | o[0])
    d = o[4] & o[2] & o[1] & ~o[3] & ~o[0]
    b = utils.And5(o[0],o[1],o[2],o[3],o[4])
    return a | b | c | d


def get_wdata(opcode: Variable, value_from_alu: Variable, value_from_ram: Variable) -> Variable:
    # test input sizes
    assert(opcode.bus_size == const.OPCODE_SIZE)
    assert(value_from_alu.bus_size == const.REG_SIZE)
    assert(value_from_ram.bus_size == const.REG_SIZE)
    # do a mux using opcode to choose either from alu or from ram
    # check if opcode == 00001 (lw)
    selector = utils.test_eq(opcode, Constant("00001")) # = 1 if lw, 0 otherwise

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


def get_value_from_regid(reg_id: Variable) -> Variable:
    return Reg(Defer(const.REG_SIZE, lambda: reg_id))


def get_value_from_reg(reg_address: Variable) -> Variable:
    # test sizes
    assert(reg_address.bus_size == const.REG_ADDR_SIZE)
    # get the value from all registers
    list_of_cur_reg_values = list(map(get_value_from_regid, const.REG_IDS))
    assert(len(list_of_cur_reg_values) == const.REG_SIZE)
    # use reg_address as a selector for the correct value
    # do a mux on every registers to choose the one you want
    reg_value = utils.mux_32_to_1_5b_selector(list_of_cur_reg_values, reg_address)
    return reg_value


def write_value_in_reg(reg_address: Variable, wdata: Variable, wenable: Variable) -> Variable:
    # test sizes
    assert(reg_address.bus_size == const.REG_ADDR_SIZE)
    assert(wdata.bus_size == const.REG_SIZE)
    assert(wenable.bus_size == 1)

    # for each register add a mux : selector = addres, 0? old value, 1? wdata
    for i in range(const.REG_SIZE):
        reg_id = "x"+str(i)
        addr_i = Constant('{0:05b}'.format(i)[::-1]) # to change if reg size changes
        assert(addr_i.bus_size == const.REG_ADDR_SIZE)

        selector_i = utils.test_eq(addr_i, reg_address)
        assert(selector_i.bus_size == 1)

        old_value_i = get_value_from_reg(addr_i)
        assert(old_value_i.bus_size == const.REG_SIZE)

        new_value = Mux(selector_i, old_value_i, wdata)

        # if write enable assign new value
        new_value_reg = Mux(wenable, old_value_i, new_value)
        # change variable to correct register name
        new_value_reg.set_as_output(reg_id)

    return