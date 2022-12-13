from lib_carotte import *
import sys
sys.path.append("./reg")
from register import *

def main() -> None:
    '''Entry point of this example'''
    wd = Input(8)
    we = Input(1)
    o = reg_8(wd, we)
    o.set_as_output("r")
