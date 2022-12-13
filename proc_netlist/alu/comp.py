from lib_carotte import *
from const import *

def is_null_step_n(a: Variable, n:int) -> Variable :
    assert(a.bus_size == n)
    tmp = 0
    if n == 32:
        tmp = EquationVariable(16)
    elif n == 16:
        tmp = EquationVariable(8)
    elif n == 8:
        tmp = EquationVariable(4)
    elif n == 4:
        tmp = EquationVariable(2)
    else:
        assert(False)

    for i in range(n//2):
        tmp[i] = (a[2*i] | a[2*i+1])

    return tmp


# is_null -> not(a[0] | a[1] | ... a[31])
def is_null(a: Variable) -> Variable :
    assert(a.bus_size == 32)
    tmp = is_null_step_n(a, 32)
    assert(tmp.bus_size == 16)
    tmp = is_null_step_n(tmp, 16)
    assert(tmp.bus_size == 8)
    tmp = is_null_step_n(tmp, 8)
    assert(tmp.bus_size == 4)
    tmp = is_null_step_n(tmp, 4)
    assert(tmp.bus_size == 2)
    ~(tmp[0] | tmp[1])
    
