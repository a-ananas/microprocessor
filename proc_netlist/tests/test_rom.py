from lib_carotte import *
from rom import rom
from global_utils import const

def test_rom() -> None:
    # next_instr = const.C32B_0()
    next_instr = const.C32B_1()
    rom_out: Variable = rom.rom(next_instr)
    rom_out.set_as_output("rom_out")