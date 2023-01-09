from lib_carotte import *

from alu.const import reg_size, opcode_size

from . import utils

# calculate the address for the next instruction to read
def rdi(old_rdi: Variable, opcode: Variable, value_from_alu: Variable, new_rdi: Variable) -> Variable:
    # test input sizes
    assert(old_rdi.bus_size == reg_size)
    assert(opcode.bus_size == opcode_size)
    assert(value_from_alu.bus_size == reg_size)
    assert(new_rdi.bus_size == reg_size)

    selector = utils.get_selector(opcode)
    assert(selector.bus_size == 1)

    jump_enable = utils.get_jump_enable(opcode, value_from_alu)
    assert(jump_enable.bus_size == 1)

    return utils.get_address(old_rdi, selector, jump_enable, new_rdi)