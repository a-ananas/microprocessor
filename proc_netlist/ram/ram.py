from lib_carotte import *
from global_utils import const

def ram(raddr_or_wdata: Variable, wenable: Variable, waddr: Variable) -> Variable:
    # test input sizes
    assert(raddr_or_wdata.bus_size == const.REG_SIZE)
    assert(waddr.bus_size == const.REG_SIZE)
    assert(wenable.bus_size == 1)

    r = RAM(const.MEMORY_ADDR_SIZE, 
            const.REG_SIZE, 
            raddr_or_wdata[0:const.MEMORY_ADDR_SIZE], 
            wenable, 
            waddr[0:const.MEMORY_ADDR_SIZE], 
            raddr_or_wdata)

    return r