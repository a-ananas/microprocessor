from lib_carotte import *

from alu.const import reg_size, opcode_size

from . import utils

# calculate the address for the next instruction to read
def next_instr(old_rdi: Variable, opcode: Variable, value_from_alu: Variable, new_rdi: Variable) -> Variable:
    # test input sizes
    assert(old_rdi.bus_size == reg_size)
    assert(opcode.bus_size == opcode_size)
    assert(value_from_alu.bus_size == reg_size)
    assert(new_rdi.bus_size == reg_size)

    instr_is_jmp = utils.get_instr_is_jmp(opcode)
    assert(instr_is_jmp.bus_size == 1)

    jmp_cond_fullfiled = utils.get_jmp_cond_fullfiled(opcode, value_from_alu)
    assert(jmp_cond_fullfiled.bus_size == 1)

    return utils.get_address(old_rdi, instr_is_jmp, jmp_cond_fullfiled, new_rdi)