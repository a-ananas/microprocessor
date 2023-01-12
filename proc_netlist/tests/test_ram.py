from lib_carotte import *
from ram import ram
from global_utils import const

def test_ram() -> None:
    raddr_or_wdata = const.C32B_1()
    wenable = const.C1B_1()
    waddr = const.C32B_1()
    ram_out: Variable = ram.ram(raddr_or_wdata, wenable, waddr)
    ram_out.set_as_output("ram_out")
    tmp = Input(1)