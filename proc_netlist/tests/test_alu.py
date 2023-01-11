import os
import sys
sys.path.insert(0, os.getcwd())

from lib_carotte import *
from alu import *

def test_alu() -> None:

    '''Entry point of this example'''
    i1 = Constant("1101"+28*"0")
    i2 = Constant("1011"+28*"0")
    add_op = Constant("00010")
    sub_op = Constant("10010")
    and_op = Constant("10110")
    or_op  = Constant("01110")
    xor_op = Constant("11110")
    beq_op = Constant("11001")
    bne_op = Constant("00101")
    blt_op = Constant("10101")
    bge_op = Constant("11101")

    res_add = alu.alu(add_op, i1, i2)
    res_sub = alu.alu(sub_op, i1, i2)
    res_and = alu.alu(and_op, i1, i2)
    res_or  = alu.alu(or_op, i1, i2)
    res_xor = alu.alu(xor_op, i1, i2)
    res_beq = alu.alu(beq_op, i1, i2)
    res_bne = alu.alu(bne_op, i1, i2)
    res_blt = alu.alu(blt_op, i1, i2)
    res_bge = alu.alu(bge_op, i1, i2)

    i1.set_as_output("i1_in")
    i2.set_as_output("i2_in")
    res_add.set_as_output("add")
    res_sub.set_as_output("sub")
    res_and.set_as_output("and")
    res_or.set_as_output("or")
    res_xor.set_as_output("xor")
    res_beq.set_as_output("beq")
    res_bne.set_as_output("bne")
    res_blt.set_as_output("blt")
    res_bge.set_as_output("bge")