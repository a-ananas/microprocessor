from lib_carotte import *
from global_utils import const

# from decodeur import decodeur
from reg import reg
from alu import alu
from ram import ram
from rom import rom
from rdi import rdi

def microproc() -> None:
    allow_ribbon_logic_operations(True)

    # input program in rom
    
    rom_out: Variable = rom.rom(Reg(Defer(const.REG_SIZE, lambda: rdi_out)))
    
    # values from the instruction decodor
    # di: Variable = decodeur.decodeur_dinstructions(rom_out)
    # temporary
    di: Variable = [Constant("01000"), const.C32B_0(), Constant("00000"), Constant("10000"), Constant("10000"), const.C1B_1()]
    opcode: Variable = di[0]
    imm: Variable = di[1]
    rs1: Variable = di[2]
    rs2: Variable = di[3]
    rd:  Variable = di[4]
    wenable: Variable = di[5]

    reg_out: Variable = reg.reg(opcode, imm, rs1, rs2, rd, wenable, Reg(Defer(const.REG_SIZE, lambda: alu_out)), Reg(Defer(const.REG_SIZE, lambda: ram_out)))
    i1: Variable = reg_out[0]
    i2: Variable = reg_out[1]

    alu_out: Variable = alu.alu(opcode, i1, i2)
    
    ram_out: Variable = ram.ram(alu_out, wenable, i2)

    rdi_out: Variable = rdi.next_instr(Reg(Defer(const.REG_SIZE, lambda: rdi_out)), opcode, alu_out, imm)

    # watching one step
    rom_out.set_as_output("rom")
    opcode.set_as_output("opcode")
    imm.set_as_output("imm")
    rs1.set_as_output("rs1")
    rs2.set_as_output("rs2")
    rd.set_as_output("rd")
    wenable.set_as_output("wenable")
    i1.set_as_output("i1")
    i2.set_as_output("i2")
    alu_out.set_as_output("alu")
    ram_out.set_as_output("ram")
    rdi_out.set_as_output("rdi")

    return 