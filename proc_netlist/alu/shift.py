from lib_carotte import *

from global_utils import const

bs = const.REG_SIZE


def sllk(a,k): 
    assert(a.bus_size == bs)
    s = k * "0"
    b = Concat(Constant(s),a[0:bs - k])
    return b


def slln(a,b):
    assert(b.bus_size == a.bus_size)
    s1 = sllk(a,1)
    a1 = Mux(b[0],a,s1)
    s2 = sllk(a1,2)
    a2 = Mux(b[1],a1,s2)
    s3 = sllk(a2,4)
    a3 = Mux(b[2],a2,s3)
    s4 = sllk(a3,8)
    a4 = Mux(b[3],a3,s4)
    s5 = sllk(a4,16)
    a5 = Mux(b[4],a4,s5)
    return a5


def srlk(a,k):
    assert(a.bus_size == bs)
    s = k * "0"
    b = Concat(a[k:bs],Constant(s))
    return b


def srln(a,b):
    assert(b.bus_size == a.bus_size)
    s1 = srlk(a,1)
    a1 = Mux(b[0],a,s1)
    s2 = srlk(a1,2)
    a2 = Mux(b[1],a1,s2)
    s3 = srlk(a2,4)
    a3 = Mux(b[2],a2,s3)
    s4 = srlk(a3,8)
    a4 = Mux(b[3],a3,s4)
    s5 = srlk(a4,16)
    a5 = Mux(b[4],a4,s5)
    return a5


def srak(a,k):
    assert(a.bus_size == bs)
    s0 = Constant(k * "0")
    s1 = Constant(k * "1")
    s = Mux(a[31],s0,s1)
    b = Concat(a[k:bs],s)
    return b


def sran(a,b):
    assert(b.bus_size == a.bus_size)
    s1 = srak(a,1)
    a1 = Mux(b[0],a,s1)
    s2 = srak(a1,2)
    a2 = Mux(b[1],a1,s2)
    s3 = srak(a2,4)
    a3 = Mux(b[2],a2,s3)
    s4 = srak(a3,8)
    a4 = Mux(b[3],a3,s4)
    s5 = srak(a4,16)
    a5 = Mux(b[4],a4,s5)
    return a5