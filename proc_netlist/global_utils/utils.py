# global utils file
from lib_carotte import *

from . import const

def And5(a,b,c,d,e):
    return And(a,And(b,And(c,And(d,e))))


# test if an opcode is equal to a given variable
def test_eq(a: Variable, b: Variable) -> Variable:
    assert(a.bus_size == b.bus_size)
    assert(a.bus_size >= 1)
    res = (~(a[0]^b[0]))
    for i in range(1, a.bus_size):
        res = res & (~(a[i]^b[i]))
    return res


# 4:1 mux
def mux_4_to_1(l0: Variable, l1:Variable, l2: Variable, l3:Variable, select: Variable) -> Variable:
    assert(select.bus_size == 2)
    assert(l0.bus_size == l1.bus_size)
    assert(l1.bus_size == l2.bus_size)
    assert(l2.bus_size == l3.bus_size)

    tmp1 = Mux(select[0], l0, l1)
    tmp2 = Mux(select[0], l2, l3)
    
    return Mux(select[1], tmp1, tmp2)

# 16:1 mux
def mux_16_to_1(list_input, select: Variable) -> Variable:
    assert(len(list_input) == 16)
    n = list_input[0].bus_size
    for l in list_input:
        assert(l.bus_size == n)
    assert(select.bus_size == 4)

    tmp1 = mux_4_to_1(list_input[0],  list_input[1],  list_input[2],  list_input[3],  select[0:2])
    tmp2 = mux_4_to_1(list_input[4],  list_input[5],  list_input[6],  list_input[7],  select[0:2])
    tmp3 = mux_4_to_1(list_input[8],  list_input[9],  list_input[10], list_input[11], select[0:2])
    tmp4 = mux_4_to_1(list_input[12], list_input[13], list_input[14], list_input[15], select[0:2])

    return mux_4_to_1(tmp1, tmp2, tmp3, tmp4, select[2:4])


# 32:1 mux with 5 bits selector
def mux_32_to_1_5b_selector(list_input, select: Variable) -> Variable:
    assert(len(list_input) == 32)
    assert(select.bus_size == 5)
    tmp1 = mux_16_to_1(list_input[0:16],  select[0:4])
    tmp2 = mux_16_to_1(list_input[16:32], select[0:4])
    res = Mux(select[4], tmp1, tmp2)
    return res