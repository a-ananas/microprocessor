from lib_carotte import *
from . import const
from . import logic
from . import utils

def full_adder(a: Variable, b: Variable, c: Variable) -> typing.Tuple[Variable, Variable]:
    tmp = a^b
    return (tmp ^ c, (tmp & c) | (a & b))

# sub = 1 if substraction
def addn(a: Variable, b: Variable, sub: Variable) -> typing.Tuple[Variable, Variable]:
    assert(a.bus_size == b.bus_size)
    assert(sub.bus_size == 1)
    l = a.bus_size
    (s,c) = full_adder(a[0],(b[0]^sub),sub)
    # Bit de poids faible à la fin
    for i in range(1,l):
        (s_i, c) = full_adder(a[i],(b[i]^sub),c)
        s = s + s_i
    return (s,c)