from lib_carotte import *


def or32(a,b):
    assert(a.bus_size == 32)
    assert(b.bus_size == 32)
    return Or(a,b)

def and32(a,b):
    assert(a.bus_size == 32)
    assert(b.bus_size == 32)
    return And(a,b)

def xor32(a,b):
    assert(a.bus_size == 32)
    assert(b.bus_size == 32)
    return Xor(a,b)

def not32(a: Variable) -> Variable:
    assert(a.bus_size == 32)
    b = EquationVariable(32)
    for i in range(32):
        b[i] = ~a[i]
    assert(b.bus_size == 32)
    return b