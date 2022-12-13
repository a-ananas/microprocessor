from lib_carotte import *

bs = 8
bsize = 5

def sllk(a,k): 
    assert(a.bus_size == bs)
    s = k * "0"
    b = Concat(a[k:bs],Constant(s))
    return b


def sll(a,b):
    assert(b.bus_size == bsize)
    for i in range(bsize):
        if b[bsize - 1 - i]:
            a = sllk(a,2**i)
    return a
