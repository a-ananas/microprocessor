from lib_carotte import *
from . import const

def orn(a: Variable, b: Variable) -> Variable:
    assert(a.bus_size == b.bus_size)
    r = a[0] | b[0]
    for i in range(1, a.bus_size):
        r = r + (a[i] | b[i])
    return r

def andn(a,b):
    assert(a.bus_size == b.bus_size)
    r = a[0] & b[0]
    for i in range(1, a.bus_size):
        r = r + (a[i] & b[i])
    return r

def xorn(a,b):
    assert(a.bus_size == b.bus_size)
    r = a[0] ^ b[0]
    for i in range(1, a.bus_size):
        r = r + (a[i] ^ b[i])
    return r

def notn(a: Variable) -> Variable:
    b = ~a[0]
    for i in range(1,a.bus_size):
        b = Concat(b,~a[i])
    # print(b, b.__class__)
    assert(b.bus_size == a.bus_size)
    return b