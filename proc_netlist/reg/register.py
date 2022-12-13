from lib_carotte import *

#register as seen in class
def reg_1(write_data: Variable, write_enable: Variable):
    o = Reg(Defer(1, lambda: c))
    c = Mux(write_enable, write_data, o)
    return o

#register 8 bits not optimized (recursive function on concat)
def reg_8(write_data: Variable, write_enable: Variable):
    n = 8
    assert(write_data.bus_size == n)
    o = reg_1(write_data[0], write_enable)
    for i in range(1, n):
        o = Concat(o, reg_1(write_data[i], write_enable))

    return o

