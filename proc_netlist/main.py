from lib_carotte import *
import sys
sys.path.append("./alu")
import shift

def main() -> None:
    '''Entry point of this example'''
    a = Input(8)
    r = shift.sllk(a, 2)
    r.set_as_output("r")