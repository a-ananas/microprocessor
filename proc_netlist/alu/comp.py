from lib_carotte import *
from . import logic

# intermediate function for the nulln function
def null_step(a: Variable) -> Variable :
    assert(a.bus_size > 2)
    assert(a.bus_size % 2 == 0)
    n = a.bus_size
    tmp = a[0] | a[1]
    for i in range(1,n//2):
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
    tmp = null_step(a)
    while tmp.bus_size > 2:
        tmp = null_step(tmp)
    assert(tmp.bus_size == 2)
    return ~(tmp[0] | tmp[1])

# a == b -> not( (a[0] xor b[0]) + (a[1] xor b[1]) + ... )) == 1
def eqn(a: Variable, b: Variable) -> Variable :
    assert(a.bus_size == b.bus_size)
    tmp = logic.xorn(a,b)
    # tmp.set_as_output()
    return nulln(tmp)


# intermediate function for the comparison function
def compn_step(p: Variable, g: Variable) -> tuple[Variable, Variable] :
    assert(p.bus_size == g.bus_size)
    assert(p.bus_size > 1)
    assert(p.bus_size % 2 == 0)
    n = p.bus_size

    # new_p = p[i]&p[i+1]
    # new_g = g[i+1]|(g[i]&p[i+1]) 
    new_p = p[0] & p[1]
    new_g = g[1] | (g[0] & p[1])
    # little endian
    for i in range(2,n,2):
        new_p = new_p + (p[i] & p[i+1])
        new_g = new_g + (g[i+1] | (g[i] & p[i+1]))
    assert(new_g.bus_size == new_p.bus_size)
    assert(new_g.bus_size == n//2)
    return (new_p, new_g)

# return a < b (<= if leq=1) where a and b naturals
def ltn_natural(a: Variable, b: Variable, leq: Variable) -> Variable:
    assert(a.bus_size == b.bus_size)
    assert(leq.bus_size == 1)
    l = a.bus_size
    # little endian
    (p,g) = (~a[0] ^ b[0], ~a[0] & b[0])
    # trivial case
    if l == 1:
        return g[0] | p[0] & leq # leq = 1 -> <= else <

    # init p and g
    # p[i] = ~a[i]^b[i]
    # g[i] = ~a[i]&b[i] 
    for i in range(1,l):
        p = p + (~a[i]^b[i])
        g = g + (~a[i]&b[i])

    # recursive call
    while p.bus_size > 1:
        (p,g) = compn_step(p, g)
    assert(p.bus_size == 1)
    return g | (p & leq) # leq = 1 -> <= else <

