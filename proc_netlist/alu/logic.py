from lib_carotte import *
import const


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

def notn(a: Variable) -> Variable:
    b = ~a[0]
    for i in range(1,a.bus_size):
        b = Concat(b,~a[i])
    # print(b, b.__class__)
    assert(b.bus_size == a.bus_size)
    return b