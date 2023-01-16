from lib_carotte import *
from decoder import decoder, utils
from global_utils import const

def testDi() -> None:
    a = Input(32)
    opcode,imm,rs1,rs2,rd,wenableReg,wenableRAM = decoder.decoder(a) 
    opcode.set_as_output("opcode")
    imm.set_as_output("imm")
    rs1.set_as_output("rs1")
    rs2.set_as_output("rs2")
    rd.set_as_output("rd")
    wenableReg.set_as_output("wenableReg")
    wenableRAM.set_as_output("wenableRAM")

def testFormat() -> None:
    a = Input(32)
    opcode = a[0:const.OPCODE_SIZE]
    r = utils.get_isR(opcode)
    i = utils.get_isI(opcode)
    u = utils.get_isU(opcode)

    imm_r, wenableReg_r, wenableRAM_r = utils.get_field_R(a,opcode)
    imm_i, wenableReg_i, wenableRAM_i = utils.get_field_I(a,opcode)
    imm_u, wenableReg_u, wenableRAM_u = utils.get_field_U(a,opcode)

    r.set_as_output("is_r")
    imm_r.set_as_output("imm_r")
    wenableReg_r.set_as_output("wenableReg_r")
    wenableRAM_r.set_as_output("wenableRAM_r")
    i.set_as_output("is_i")
    imm_i.set_as_output("imm_i")
    wenableReg_i.set_as_output("wenableReg_i")
    wenableRAM_i.set_as_output("wenableRAM_i")
    u.set_as_output("is_u")
    imm_u.set_as_output("imm_u")
    wenableReg_u.set_as_output("wenableReg_u")
    wenableRAM_u.set_as_output("wenableRAM_u")