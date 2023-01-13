from lib_carotte import *
from rom import rom
from global_utils import const

def test_rom() -> None:
    next_instr_0 = const.C32B_0()
    next_instr_4 = Constant("001"+29*"0")
    rom_out_0: Variable = rom.rom(next_instr_0)
    rom_out_0.set_as_output("rom_out_0")
    # rom_out_4: Variable = rom.rom(next_instr_4)
    # rom_out_4.set_as_output("rom_out_4")