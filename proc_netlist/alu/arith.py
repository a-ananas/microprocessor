from lib_carotte import *
import const
import logic
import utils

def full_adder(a: Variable, b: Variable, c: Variable) -> typing.Tuple[Variable, Variable]:
    tmp = a^b
    return (tmp ^ c, (tmp & c) | (a & b))

def addn(a: Variable, b: Variable) -> typing.Tuple[Variable, Variable]:
    assert(a.bus_size == b.bus_size)
    r = const.c1b_0()
    (s,r) = full_adder(a[0],b[0],r)
    # Bit de poids faible à la fin
    for i in range(1,a.bus_size):
        (s_i, r) = full_adder(a[i],b[i],r)
        s = Concat(s,s_i)
    return (s,r)


def subn(a: Variable, b: Variable) -> typing.Tuple[Variable, Variable]: #a - b
    assert(a.bus_size == b.bus_size)
    d = utils.two_complements_n(b)
    return addn(a,d)