from lib_carotte import *

from alu import arith
from global_utils import const
from alu import logic
from alu import comp

# calculate the address for the next instruction to read
def get_address(old_rdi: Variable, instr_is_jmp: Variable, jmp_cond_fullfiled: Variable, new_rdi: Variable) -> Variable:
    # test input sizes
    assert(old_rdi.bus_size == const.reg_size)
    assert(new_rdi.bus_size == const.reg_size)
    assert(instr_is_jmp.bus_size == 1)
    assert(jmp_cond_fullfiled.bus_size == 1)

    # standard address for the next instruction
    extended_4 = Constant("001"+29*"0")
    assert(extended_4.bus_size == const.reg_size)
    std_next_rdi = arith.addn(extended_4, old_rdi, const.c1b_0())[0]
    assert(std_next_rdi.bus_size == const.reg_size)

    # address for the next instruction if jump
    jmp_next_rdi = Mux(jmp_cond_fullfiled, std_next_rdi, new_rdi) # if branching condition not valid, then do not jump
    assert(jmp_next_rdi.bus_size == const.reg_size)

    return Mux(instr_is_jmp, std_next_rdi, jmp_next_rdi)


def test_eq_opcode(opcode: Variable, cst: Variable) -> Variable:
    assert(opcode.bus_size == const.opcode_size)
    assert(cst.bus_size == const.opcode_size)
    return (~(opcode[0]^cst[0])) & (~(opcode[1]^cst[1])) & (~(opcode[2]^cst[2])) & (~(opcode[3]^cst[3])) & (~(opcode[4]^cst[4]))


# return 1 if the instruction is a jump 0 otherwise
def get_instr_is_jmp(opcode: Variable) -> Variable:
    # test input size
    assert(opcode.bus_size == const.opcode_size)

    # jal  -> 11011
    # jalr -> 11100 
    # beq  -> 10011
    # bne  -> 10100
    # blt  -> 10101
    # blti -> 10110
    # bge  -> 10111
    # if opcode = one of the above then 1 else 0
    instr_is_jmp = test_eq_opcode(opcode, Constant("11011"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | test_eq_opcode(opcode, Constant("00111"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | test_eq_opcode(opcode, Constant("11001"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | test_eq_opcode(opcode, Constant("00101"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | test_eq_opcode(opcode, Constant("10101"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | test_eq_opcode(opcode, Constant("01101"))
    assert(instr_is_jmp.bus_size == 1)
    instr_is_jmp = instr_is_jmp | test_eq_opcode(opcode, Constant("11101"))
    assert(instr_is_jmp.bus_size == 1)
    return instr_is_jmp


# return 1 if the condition for the branchment is valid, 0 otherwise
def get_jmp_cond_fullfiled(opcode: Variable, value_from_alu: Variable) -> Variable:
    # test input sizes
    assert(opcode.bus_size == const.opcode_size)
    assert(value_from_alu.bus_size == const.reg_size)

    conditional_jump = comp.eqn(value_from_alu, const.c32b_1())
    assert(conditional_jump.bus_size == 1)

    return conditional_jump