from lib_carotte import *
from adder import adder32

C1 = Constant("1000000000000000000000000000000")

def sub32(a,b): #a - b
    assert(a.bus.size == 32)
    assert(b.bus.size == 32)
    
    return adder32(a,adder32(~b,C1))



 