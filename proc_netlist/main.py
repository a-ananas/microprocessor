from lib_carotte import *
import sys
sys.path.append("./alu")
from arith import *

def main() -> None:
    '''Entry point of this example'''
    a = Input(32)
    b = Input(32)
    result = adder32(a, b)
    result.set_as_output("r")