from lib_carotte import *


def sll1(a):
    assert(a.bus_size == 32)
    b = Constant("0")
    for i in range(31):
        b = concat(b,a[i])
    return b

def sll2(a):
    assert(a.bus_size == 32)
    b = Constant("00")
    for i in range(30):
        b = concat(b,a[i])
    return b

def sll4(a):
    assert(a.bus_size == 32)
    b = Constant("0000")
    for i in range(28):
        b = concat(b,a[i])
    return b

def sll8(a):
    assert(a.bus_size == 32)
    b = Constant("00000000")
    for i in range(32 - 8):
        b = concat(b,a[i])
    return b

def sll16(a):
    assert(a.bus_size == 32)
    b = Constant("0000000000000000")
    for i in range(32 - 16):
        b = concat(b,a[i])
    return b