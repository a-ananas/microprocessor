from lib_carotte import *
import arith
import logic

def two_complements_n(a: Variable) -> Variable:
    b = logic.notn(a)
    assert(b.bus_size == a.bus_size)
    cst = Constant((a.bus_size-1)*"0")
    cst = cst + Constant("1")
    assert(cst.bus_size == a.bus_size)
    (r,c) = arith.addn(b,cst)
    return r