from lib_carotte import *
import sys
sys.path.append("./alu")
<<<<<<< HEAD
from shift import *
=======
import shift
>>>>>>> 967170e014093dc4424652df054c89d4c4cfc20a

def main() -> None:
    '''Entry point of this example'''
    a = Input(8)
<<<<<<< HEAD
#    b = Input(5)
    r = sllk(a,2)
    r.set_as_output("r")
=======
    r = shift.sllk(a, 2)
    r.set_as_output("r")
>>>>>>> 967170e014093dc4424652df054c89d4c4cfc20a
