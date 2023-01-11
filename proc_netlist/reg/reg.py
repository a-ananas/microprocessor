from lib_carotte import *

from . import utils

def reg(opcode: Variable, imm: Variable, rs1: Variable, rs2: Variable, rd: Variable, wenable: Variable, value_from_alu: Variable, value_from_ram: Variable) -> tuple[Variable, Variable]:
    # get real wdata
    wdata = utils.get_wdata(opcode, value_from_alu, value_from_ram)

    
    # get real i2
    real_i2 = utils.get_i2(opcode, imm, i2_from_reg)
    
    return