from lib_carotte import *
from logic import xorn 

def is_null_step(a: Variable) -> Variable :
    assert(a.bus_size > 2)
    assert(a.bus_size % 2 == 0)
    n = a.bus_size
    tmp = a[0] | a[1]
    for i in range(1,n//2):
        print(i)
        tmp = tmp + (a[2*i] | a[2*i+1])
    assert(tmp.bus_size == (n//2))
    return tmp


# null -> not(a[0] | a[1] | ... a[31])
def nulln(a: Variable) -> Variable :
    n = a.bus_size
    if n == 1:
        return ~a
    if n == 2:
        return ~(a[0] | a[1])
    assert(a.bus_size%2 == 0)
    tmp = is_null_step(a)
    while tmp.bus_size > 2:
        tmp = is_null_step(tmp)
    assert(tmp.bus_size == 2)
    return ~(tmp[0] | tmp[1])


# a == b -> not( (a[0] xor b[0]) + (a[1] xor b[1]) + ... )) == 1
def eqn(a: Variable, b: Variable) -> Variable :
    assert(a.bus_size == b.bus_size)
    return nulln(xorn(a, b))