from lib_carotte import *

import arith
import comp
import const
import logic
import utils
import shift


# the main alu
def alu(status_reg: Variable, opcode: Variable, i1: Variable, i2: Variable) -> Variable:
    assert(status_reg.bus_size == const.reg_size)
    assert(opcode.bus_size == const.opcode_size)
    assert(i1.bus_size == const.reg_size)
    assert(i2.bus_size == const.reg_size)

    # get result of all the operations
    (add_op, c_add) = arith.addn(i1, i2, Constant("0"))
    (sub_op, c_sub) = arith.addn(i1, i2, Constant("1"))
    or_op  = logic.orn(i1, i2)
    xor_op = logic.xorn(i1, i2)
    and_op = logic.andn(i1, i2)
    no_op = const.c32b_0()
    assert(add_op.bus_size == const.reg_size)
    assert(sub_op.bus_size == const.reg_size)
    assert(or_op.bus_size == const.reg_size)
    assert(xor_op.bus_size == const.reg_size)
    assert(and_op.bus_size == const.reg_size)
    assert(no_op.bus_size == const.reg_size)
    
    # choose the correct operation according to opcode
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
    #    1    0    0    0    0 || slt
    #    1    0    0    0    1 || slt
    #    1    0    0    1    0 || 
    #    1    0    0    1    1 || beq
    #    1    0    1    0    0 || bne
    #    1    0    1    0    1 || blt
    #    1    0    1    1    0 || blt
    #    1    0    1    1    1 || bgr
    #    1    1    0    0    0 || lui
    #    1    1    0    0    1 || auipc
    #    1    1    0    1    0 || 
    #    1    1    0    1    1 || jal
    #    1    1    1    0    0 || jalr
    #    1    1    1    0    1 || 
    #    1    1    1    1    0 || lw
    #    1    1    1    1    1 || sw
    l = [add_op,  no_op,  no_op,  no_op,
          no_op, and_op,  or_op, xor_op,
         add_op, sub_op,  no_op,  no_op,
          no_op, and_op,  or_op, xor_op,
          no_op,  no_op,  no_op,  no_op,
          no_op,  no_op,  no_op,  no_op,
          no_op,  no_op,  no_op,  no_op,
          no_op,  no_op,  no_op,  no_op]

    tmp1 = utils.mux_16_to_1(l[0:16],  opcode[0:4])
    tmp2 = utils.mux_16_to_1(l[16:32], opcode[0:4])

    # return the result
    return Mux(opcode[4], tmp1, tmp2)