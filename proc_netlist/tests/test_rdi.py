from lib_carotte import *
from rdi import *

def test_rdi() -> None:
    old_rdi = Constant(32*"0")
    opcode = Input(5)
    value_from_alu = Input(32)
    new_rdi = Input(32)

    next_rdi = rdi.next_instr(old_rdi, opcode, value_from_alu, new_rdi)
    next_rdi.set_as_output("next")