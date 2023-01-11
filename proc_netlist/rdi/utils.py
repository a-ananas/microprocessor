from lib_carotte import *
from global_utils import const
from global_utils import utils

from alu import arith
from alu import logic
from alu import comp

# calculate the address for the next instruction to read
def get_address(old_rdi: Variable, instr_is_jmp: Variable, jmp_cond_fullfiled: Variable, new_rdi_offset: Variable) -> Variable:
    # test input sizes
    assert(old_rdi.bus_size == const.REG_SIZE)
    assert(new_rdi_offset.bus_size == const.REG_SIZE)
    assert(instr_is_jmp.bus_size == 1)
    assert(jmp_cond_fullfiled.bus_size == 1)

    # standard address for the next instruction
    extended_4 = Constant("001"+29*"0")
    assert(extended_4.bus_size == const.REG_SIZE)
    std_next_rdi = arith.addn(extended_4, old_rdi, const.C1B_0())[0]
    assert(std_next_rdi.bus_size == const.REG_SIZE)

    # address for the next instruction if jump
    new_rdi = arith.addn(new_rdi_offset, old_rdi, const.C1B_0())[0]
    jmp_next_rdi = Mux(jmp_cond_fullfiled, std_next_rdi, new_rdi) # if branching condition not valid, then do not jump
    assert(jmp_next_rdi.bus_size == const.REG_SIZE)

    return Mux(instr_is_jmp, std_next_rdi, jmp_next_rdi)

# return 1 if the instruction is a jump 0 otherwise
def get_instr_is_jmp(opcode: Variable) -> Variable:
    # test input size
    assert(opcode.bus_size == const.OPCODE_SIZE)

    # jal  -> 11011
    # jalr -> 11100 
    # beq  -> 10011
    # bne  -> 10100
    # blt  -> 10101
    # blti -> 10110
    # bge  -> 10111
    # if opcode = one of the above then 1 else 0
    instr_is_jmp = utils.test_eq(opcode, Constant("11011"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | utils.test_eq(opcode, Constant("00111"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | utils.test_eq(opcode, Constant("11001"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | utils.test_eq(opcode, Constant("00101"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | utils.test_eq(opcode, Constant("10101"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | utils.test_eq(opcode, Constant("01101"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | utils.test_eq(opcode, Constant("11101"))
    assert(instr_is_jmp.bus_size == 1)
    return instr_is_jmp


# return 1 if the condition for the branchment is valid, 0 otherwise
def get_jmp_cond_fullfiled(opcode: Variable, value_from_alu: Variable) -> Variable:
    # test input sizes
    assert(opcode.bus_size == const.OPCODE_SIZE)
    assert(value_from_alu.bus_size == const.REG_SIZE)

    conditional_jump = comp.eqn(value_from_alu, const.C32B_1())
    assert(conditional_jump.bus_size == 1)

    return conditional_jump