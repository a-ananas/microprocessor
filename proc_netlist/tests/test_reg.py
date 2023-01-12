from lib_carotte import *
from reg import reg
from alu import alu
from global_utils import const

def test_reg() -> None:
    rs1 = Constant("00000") # rs1 = reg x0
    rs2 = Constant("10000") # rs2 = reg x1
    # rd  = Constant("00000") # rd  = reg x0
    rd  = Constant("10000") # rd  = reg x1
    wenable = Constant("1") # wenable = true
    res_ram = Constant((const.REG_SIZE//4) * "0001") # from_ram = 00010001...0001
    res_alu = Constant((const.REG_SIZE//2) * "01") # from alu = 010101...01 -> chosen value, in reg x0 at the end
    # opcode = Constant("00000") # addi 
    imm = Constant((const.REG_SIZE) * "1") # imm = 111...1
    opcode = Constant("00010") # add (useless, just not an I format)

    ret = reg.reg(opcode, imm, rs1, rs2, rd, wenable, res_alu, res_ram)
    i1 = ret[0]
    i2 = ret[1]

    i1.set_as_output("i1")
    i2.set_as_output("i2")
    
    # for r in const.REG_IDS:
    #     name = r.get_full_name().split(':',1)[0]
    #     r.set_as_output(name)
