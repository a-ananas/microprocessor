from lib_carotte import *
from const import *
from logic import not32

def full_adder(a: Variable, b: Variable, c: Variable) -> typing.Tuple[Variable, Variable]:
    tmp = a^b
    return (tmp ^ c, (tmp & c) | (a & b))

def adder32(a: Variable, b: Variable) -> typing.Tuple[Variable, Variable]:
    assert(a.bus_size == 32)
    assert(b.bus_size == 32)
    r = c1b_0
    (s,r) = full_adder(a[0],b[0],r)
    ##Bit de poids faible devant
    for i in range(1, 32):
        (s_i, r) = full_adder(a[i],b[i],r)
        s = Concat(s,s_i)
    return (s,r)

def sub32(a: Variable, b: Variable) -> typing.Tuple[Variable, Variable]: #a - b
    assert(a.bus_size == 32)
    assert(b.bus_size == 32)
    return adder32(a,adder32(not32(b),c32b_1))