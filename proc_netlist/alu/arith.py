from lib_carotte import *
import const
import logic
import utils

def full_adder(a: Variable, b: Variable, c: Variable) -> typing.Tuple[Variable, Variable]:
    tmp = a^b
    return (tmp ^ c, (tmp & c) | (a & b))

# sub = 1 if substraction
def addn(a: Variable, b: Variable, sub: Variable) -> typing.Tuple[Variable, Variable]:
    assert(a.bus_size == b.bus_size)
    l = a.bus_size
    (s,c) = full_adder(a[l-1],(b[l-1]^sub),sub)
    # Bit de poids faible à la fin
    for i in range(l-2,-1,-1):
        (s_i, c) = full_adder(a[i],(b[i]^sub),c)
        s = s_i + s
    return (s,c)