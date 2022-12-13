from lib_carotte import *
import sys
sys.path.append("./alu")
from shift import *

def main() -> None:
    '''Entry point of this example'''
    a = Input(8)
#    b = Input(5)
    r = sllk(a,2)
    r.set_as_output("r")
