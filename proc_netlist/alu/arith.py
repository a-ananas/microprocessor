from lib_carotte import *

def full_adder(a: Variable, b: Variable, c: Variable) -> typing.Tuple[Variable, Variable]:
    tmp = a^b
    return (tmp ^ c, (tmp & c) | (a & b))

def adder32(a,b):
    assert(a.bus.size == 32)
    assert(b.bus.size == 32)
    r = Constant("0")
    (s,r) = full_adder(a[0],b[0],r)
    ##Bit de poids faible devant
    for i in range(1, 32):
        (s_i, c) = full_adder(a[i],b[i],c)
        s = concat(s,s_i)
    return (s,c)

C1 = Constant("1000000000000000000000000000000")

def sub32(a,b): #a - b
    assert(a.bus.size == 32)
    assert(b.bus.size == 32)
    
    return adder32(a,adder32(~b,C1))