from lib_carotte import *

from alu import arith
from alu import const
from alu import logic
from alu import comp

# calculate the address for the next instruction to read
def get_address(old_rdi: Variable, selector: Variable, jump_enable: Variable, new_rdi: Variable) -> Variable:
    # test input sizes
    assert(old_rdi.bus_size == const.reg_size)
    assert(new_rdi.bus_size == const.reg_size)
    assert(selector.bus_size == 1)
    assert(jump_enable.bus_size == 1)

    # standard address for the next instruction
    extended_4 = Constant("001"+29*"0")
    assert(extended_4.bus_size == const.reg_size)
    std_next_rdi = arith.addn(extended_4, old_rdi, const.c1b_0())[0]
    assert(std_next_rdi.bus_size == const.reg_size)

    # address for the next instruction if jump
    jmp_next_rdi = Mux(jump_enable, std_next_rdi, new_rdi) # if branching condition not valid, then do not jump
    assert(jmp_next_rdi.bus_size == const.reg_size)

    return Mux(selector, std_next_rdi, jmp_next_rdi)


def test_eq_opcode(opcode: Variable, cst: Variable) -> Variable:
    assert(opcode.bus_size == const.opcode_size)
    assert(cst.bus_size == const.opcode_size)
    return (~(opcode[0]^cst[0])) & (~(opcode[1]^cst[1])) & (~(opcode[2]^cst[2])) & (~(opcode[3]^cst[3])) & (~(opcode[4]^cst[4]))


# return 1 if the instruction is a jump 0 otherwise
def get_selector(opcode: Variable) -> Variable:
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
    selector = test_eq_opcode(opcode, Constant("11011"))
    assert(selector.bus_size == 1)
    selector = selector | test_eq_opcode(opcode, Constant("00111"))
    assert(selector.bus_size == 1)
    selector = selector | test_eq_opcode(opcode, Constant("11001"))
    assert(selector.bus_size == 1)
    selector = selector | test_eq_opcode(opcode, Constant("00101"))
    assert(selector.bus_size == 1)
    selector = selector | test_eq_opcode(opcode, Constant("10101"))
    assert(selector.bus_size == 1)
    selector = selector | test_eq_opcode(opcode, Constant("11101"))
    assert(selector.bus_size == 1)
    return selector


# return 1 if the condition for the branchment is valid, 0 otherwise
def get_jump_enable(opcode: Variable, value_from_alu: Variable) -> Variable:
    # test input sizes
    assert(opcode.bus_size == const.opcode_size)
    assert(value_from_alu.bus_size == const.reg_size)

    # if jal or jalr then 1
    unconditional_jump = test_eq_opcode(opcode, Constant("11011")) | test_eq_opcode(opcode, Constant("00111"))
    # if condition, if value_from_alu = 1x32b then 1 else 0
    conditional_jump = comp.eqn(value_from_alu, Constant(const.reg_size*"1"))

    assert(unconditional_jump.bus_size == 1)
    assert(conditional_jump.bus_size == 1)

    return unconditional_jump | conditional_jump