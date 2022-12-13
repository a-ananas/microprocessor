from lib_carotte import *

bs = 8

def sllk(a,k):
    
    assert(a.bus_size == bs)
    s = k * "0"
    b = Concat(a[k:bs],Constant(s))
    return b



def sll(a,b):
    if b[4]:
        a1 = sll1(a)
    else:
        a1 = a
    if b[3]:
        a2 = sll2(a1)
    else:
        a2 = a1   
    if b[2]:
        a3 = sll4(a2)
    else:
        a3 = a2

    if b[1]:
        a4 = sll8(a3)
    else:
        a4 = a3

    if b[0]:
        a5 = sll16(a4)
    else:
        a5 = a4
    return a5

