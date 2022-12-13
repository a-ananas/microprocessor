from lib_carotte import *
import sys
sys.path.append("./alu")
import arith 
import logic
import utils
import shift
import const

def main() -> None:
    '''Entry point of this example'''
    a = Input(4)
    b = Input(4)
    (r,c) = arith.subn(a, b)
    r.set_as_output("r")
    # c = utils.two_complements_n(a)
    c.set_as_output("c")