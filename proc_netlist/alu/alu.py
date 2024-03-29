from lib_carotte import *
from global_utils import const
from global_utils import utils

from . import arith
from . import comp
from . import logic
from . import shift


# the main alu
def alu(opcode: Variable, i1: Variable, i2: Variable) -> Variable:
    assert(opcode.bus_size == const.OPCODE_SIZE)
    assert(i1.bus_size == const.REG_SIZE)
    assert(i2.bus_size == const.REG_SIZE)

    # get result of all the operations
    (add_op, c_add) = arith.addn(i1, i2, const.C1B_0())
    (sub_op, c_sub) = arith.addn(i1, i2, const.C1B_1())
    or_op  = logic.orn(i1, i2)
    xor_op = logic.xorn(i1, i2)
    # xor_op.set_as_output("xor_op")
    and_op = logic.andn(i1, i2)
    srl_op = shift.srln(i1, i2)
    sra_op = shift.sran(i1, i2)
    sll_op = shift.slln(i1, i2)

    # for branching/jumps, return 0 if should jump, 1 otherwise (extended to 32 bits)
    # we'll get the address where to jump in the rdi module using the immediate from di
    jal_op = const.C32B_1()
    jalr_op = const.C32B_1()

    eq_op  = comp.eqn(i1, i2)
    # eq_op.set_as_output("eq_op")
    beq_op = Mux(eq_op, const.C32B_0(), const.C32B_1())
    neq_op = ~eq_op
    bne_op = Mux(neq_op, const.C32B_0(), const.C32B_1()) 
    lt_op  = comp.ltn_natural(i1, i2, const.C1B_0())
    # lt_op.set_as_output("lt_op")
    blt_op = Mux(lt_op, const.C32B_0(), const.C32B_1()) # same for slt operations
    geq_op = ~lt_op
    bge_op = Mux(geq_op, const.C32B_0(), const.C32B_1())

    # for ram manipulation, we just return the read address (i.e. the first input)
    ram_op = i1

    no_op = const.C32B_0() # return 0 when not a valid instruction ?

    assert(add_op.bus_size == const.REG_SIZE)
    assert(sub_op.bus_size == const.REG_SIZE)
    assert(or_op.bus_size == const.REG_SIZE)
    assert(xor_op.bus_size == const.REG_SIZE)
    assert(and_op.bus_size == const.REG_SIZE)
    assert(no_op.bus_size == const.REG_SIZE)
    
    # op_4 op_3 op_2 op_1 op_0 || R
    #    0    0    0    0    0 || add
    #    0    0    0    0    1 || 
    #    0    0    0    1    0 || srl
    #    0    0    0    1    1 || sra
    #    0    0    1    0    0 || sll
    #    0    0    1    0    1 || and
    #    0    0    1    1    0 || or
    #    0    0    1    1    1 || xor
    #    0    1    0    0    0 || add
    #    0    1    0    0    1 || sub
    #    0    1    0    1    0 || srl
    #    0    1    0    1    1 || sra
    #    0    1    1    0    0 || sll
    #    0    1    1    0    1 || and
    #    0    1    1    1    0 || or
    #    0    1    1    1    1 || xor
    #    1    0    0    0    0 || lw
    #    1    0    0    0    1 || sw
    #    1    0    0    1    0 || 
    #    1    0    0    1    1 || beq
    #    1    0    1    0    0 || bne
    #    1    0    1    0    1 || blt
    #    1    0    1    1    0 || blt
    #    1    0    1    1    1 || bge
    #    1    1    0    0    0 || lui
    #    1    1    0    0    1 || auipc
    #    1    1    0    1    0 || 
    #    1    1    0    1    1 || jal
    #    1    1    1    0    0 || jalr
    #    1    1    1    0    1 || 
    #    1    1    1    1    0 || slt
    #    1    1    1    1    1 || slt

    # choose the correct operation according to opcode
    l = [add_op,  no_op, srl_op, sra_op,
         sll_op, and_op,  or_op, xor_op,
         add_op, sub_op, srl_op, sra_op,
         sll_op, and_op,  or_op, xor_op,
         ram_op, ram_op,  no_op, beq_op,
         bne_op, blt_op, blt_op, bge_op,
          no_op,  no_op, jal_op, jalr_op,
          no_op,  no_op, blt_op, blt_op]

    res = utils.mux_32_to_1_5b_selector(l, opcode)

    # return the result
    return res