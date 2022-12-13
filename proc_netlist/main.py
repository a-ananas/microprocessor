from lib_carotte import *
import sys
sys.path.append("./alu")

import shift
import arith

def main() -> None:
    '''Entry point of this example'''
    a = Input(4)
    b = Input(4)
    (r,c) = arith.addn(a,b)
    r.set_as_output("r")
    c.set_as_output("c")