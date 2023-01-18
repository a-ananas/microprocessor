from lib_carotte import *

from . import utils

def reg(opcode: Variable, imm: Variable, rs1: Variable, rs2: Variable, rd: Variable, wenable: Variable, value_from_alu: Variable, value_from_ram: Variable) -> tuple[Variable, Variable]:
    # get real wdata
    wdata = utils.get_wdata(Reg(opcode), value_from_alu, value_from_ram)

    # write new datas in registers
    utils.write_value_in_reg(rd, wdata, wenable)

    # get values to read
    i1 = utils.get_value_from_reg(rs1)
    i2_from_reg = utils.get_value_from_reg(rs2)
    # get real i2, mux if format I then immediate else value read from register
    i2 = utils.get_i2(opcode, imm, i2_from_reg)
    
    return (i1, i2)