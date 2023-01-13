from lib_carotte import *
from global_utils import const

from . import utils

def rom(next_instr: Variable) -> Variable:
    # test input sizes
    assert(next_instr.bus_size == const.REG_SIZE)

    part_list = utils.get_all_parts(next_instr)
    real_value = utils.merge_parts(const.LITTLE_ENDIAN, part_list)
    
    return real_value