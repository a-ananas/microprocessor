from lib_carotte import *

from global_utils.const import REG_SIZE, OPCODE_SIZE

from . import utils

# calculate the address for the next instruction to read
def next_instr(old_rdi: Variable, opcode: Variable, value_from_alu: Variable, new_rdi_offset: Variable) -> Variable:
    # test input sizes
    assert(old_rdi.bus_size == REG_SIZE)
    assert(opcode.bus_size == OPCODE_SIZE)
    assert(value_from_alu.bus_size == REG_SIZE)
    assert(new_rdi_offset.bus_size == REG_SIZE)

    instr_is_jmp = utils.get_instr_is_jmp(opcode)
    assert(instr_is_jmp.bus_size == 1)

    jmp_cond_fullfiled = utils.get_jmp_cond_fullfiled(opcode, value_from_alu)
    assert(jmp_cond_fullfiled.bus_size == 1)

    return utils.get_address(old_rdi, instr_is_jmp, jmp_cond_fullfiled, new_rdi_offset)