from lib_carotte import *
from global_utils import const

def rom(next_instr: Variable) -> Variable:
    # test input sizes
    assert(next_instr.bus_size == const.REG_SIZE)

    r = ROM(const.MEMORY_ADDR_SIZE, const.REG_SIZE, next_instr[0:const.MEMORY_ADDR_SIZE])
    
    return r