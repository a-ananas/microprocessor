import os
import sys
sys.path.insert(0, os.getcwd())

from lib_carotte import *

# from rom import rom
# from di import di
# from reg import reg
from alu import alu
# from ram import ram
from rdi import rdi

def main() -> None:

    # input program in rom

    # rdi = rdi.next_instr(rdi, opcode, alu, new_rdi) # loop ?

    # rom = rom.rom(rdi)
    
    # values from the instruction decodor
    # di = di.di(rom)
    # opcode = di[0]
    # imm = di[1]
    # rs1 = di[2]
    # rs2 = di[3]
    # rd  = di[4]
    # wenable = di[5]

    # reg = reg.reg(opcode, imm, rs1, rs2, rd, wenable, alu, ram)
    # i1 = reg[0]
    # i2 = reg[1]

    # alu = alu.alu(opcode, i1, i2)
    
    # ram = ram.ram(alu, wenable, i2)
    return 