# Decodeur d'instructions, en premiere approximation, 
#cest jusytre une hrosse fonction avec une entree de traille 32
#et une sortie avec absolument tout, a voir
from lib_carotte import *

from . import utils

from global_utils import const

def decoder(instr: Variable):
    #verification que c'est bien le format d'une instruction
    assert(instr.bus_size == const.REG_SIZE)
    opcode = instr[0:const.OPCODE_SIZE]
    isR = utils.get_isR(opcode)
    isI = utils.get_isI(opcode)
    isU = utils.get_isU(opcode)
    #set defaults
    immD = const.C32B_0() #immediat sur 32 bits
    wenableD = const.C1B_0()

    rd = instr[const.OPCODE_SIZE:const.OPCODE_SIZE+const.REG_ADDR_SIZE]
    rs1 = instr[const.OPCODE_SIZE+const.REG_ADDR_SIZE:const.OPCODE_SIZE+2*const.REG_ADDR_SIZE]
    rs2 = instr[const.OPCODE_SIZE+2*const.REG_ADDR_SIZE:const.OPCODE_SIZE+3*const.REG_ADDR_SIZE]
     
    immR, wenableReg_r, wenableRAM_r = utils.get_field_R(instr, opcode)
    immI, wenableReg_i, wenableRAM_i = utils.get_field_I(instr, opcode)
    immU, wenableReg_u, wenableRAM_u = utils.get_field_U(instr, opcode)

    imm = Mux(isU,Mux(isI,Mux(isR,immD,immR),immI),immU)

    wenableReg = Mux(isU,Mux(isI,Mux(isR,wenableD,wenableReg_r),wenableReg_i),wenableReg_u)
    wenableRAM = Mux(isU,Mux(isI,Mux(isR,wenableD,wenableRAM_r),wenableRAM_i),wenableRAM_u)

    return opcode, imm, rs1, rs2, rd, wenableReg, wenableRAM