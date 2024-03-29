from lib_carotte import *
from global_utils import const

from decoder import decoder
from reg import reg
from alu import alu
from ram import ram
from rom import rom
from rdi import rdi

def microproc() -> None:
    allow_ribbon_logic_operations(True)

    # input program in rom
    
    rom_out: Variable = rom.rom(Reg(Defer(const.REG_SIZE, lambda: rdi_out)))
    
    # values from the instruction decoder
    di: Variable = decoder.decoder(rom_out)
    opcode: Variable = di[0]
    imm: Variable = di[1]
    rs1: Variable = di[2]
    rs2: Variable = di[3]
    rd:  Variable = di[4]
    wenableReg: Variable = di[5]
    wenableRam: Variable = di[6]

    reg_out: Variable = reg.reg(opcode, imm, rs1, rs2, 
                                Reg(rd),
                                Reg(wenableReg), 
                                Reg(Defer(const.REG_SIZE, lambda: alu_out)), 
                                Reg(Defer(const.REG_SIZE, lambda: ram_out)))
    i1: Variable = reg_out[0]
    i2: Variable = reg_out[1]

    alu_out: Variable = alu.alu(opcode, i1, i2)
    
    ram_out: Variable = ram.ram(alu_out, wenableRam, Reg(i2))

    rdi_out: Variable = rdi.next_instr(Reg(Defer(const.REG_SIZE, lambda: rdi_out)), opcode, alu_out, imm)

    # watching one step
    # rom_out.set_as_output("rom")
    # opcode.set_as_output("opcode")
    # imm.set_as_output("imm")
    # rs1.set_as_output("rs1")
    # rs2.set_as_output("rs2")
    # rd.set_as_output("rd")
    # wenableReg.set_as_output("wenableReg")
    # wenableRam.set_as_output("wenableRam")
    # i1.set_as_output("i1")
    # i2.set_as_output("i2")
    # alu_out.set_as_output("alu")
    # ram_out.set_as_output("ram")
    # rdi_out.set_as_output("rdi")

    return 
