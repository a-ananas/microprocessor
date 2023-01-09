from lib_carotte import *
import arith
import logic

def two_complements_n(a: Variable) -> Variable:
    b = logic.notn(a)
    assert(b.bus_size == a.bus_size)
    assert(cst.bus_size == a.bus_size)
    (r,c) = arith.addn(b,cst)
    return r

# return the format of an operation from an opcode
def get_format(opcode: Variable) -> Variable:
    #             s0 s1
    # format R ->  0  0
    # format U ->  1  0
    # format I ->  0  1
    assert(opcode.bus_size == 5)
    s1 = (~opcode[3]) | (opcode[4] & opcode[2] & opcode[1] & opcode[0])
    s0 = opcode[4] & opcode[3] & (~opcode[2])
    format = s0 + s1
    assert(format.bus_size == 2)
    return s0+s1


# return the fields from an instruction of type U
def get_field_U(instr: Variable) -> Variable:
    assert(instr.bus_size == 32)
    imm = instr[10:32]
    return imm


# return the fields from an instruction of type I
def get_field_I(instr: Variable) -> Variable:
    assert(instr.bus_size == 32)
    rs = instr[10:15]
    imm = instr[15:32]
    return (rs, imm)


# return the fields from an instruction of type R
def get_field_R(instr: Variable) -> Variable:
    assert(instr.bus_size == 32)
    rs1 = instr[10:15]
    rs2 = instr[15:20]
    imm = instr[20:32]
    return (rs1, rs2, imm)

# 4:1 mux
def mux_4_to_1(l0: Variable, l1:Variable, l2: Variable, l3:Variable, select: Variable) -> Variable:
    assert(select.bus_size == 2)
    assert(l0.bus_size == l1.bus_size)
    assert(l1.bus_size == l2.bus_size)
    assert(l2.bus_size == l3.bus_size)

    tmp1 = Mux(select[0], l0, l1)
    tmp2 = Mux(select[0], l2, l3)
    
    return Mux(select[1], tmp1, tmp2)

# 16:1 mux
def mux_16_to_1(list_input, select: Variable) -> Variable:
    assert(len(list_input) == 16)
    n = list_input[0].bus_size
    for l in list_input:
        assert(l.bus_size == n)
    assert(select.bus_size == 4)

    tmp1 = mux_4_to_1(list_input[0],  list_input[1],  list_input[2],  list_input[3],  select[0:2])
    tmp2 = mux_4_to_1(list_input[4],  list_input[5],  list_input[6],  list_input[7],  select[0:2])
    tmp3 = mux_4_to_1(list_input[8],  list_input[9],  list_input[10], list_input[11], select[0:2])
    tmp4 = mux_4_to_1(list_input[12], list_input[13], list_input[14], list_input[15], select[0:2])

    return mux_4_to_1(tmp1, tmp2, tmp3, tmp4, select[2:4])


def is_0(input):
    n = 32
    assert input.bus_size == n
    s = Constant("0")
    for i in range(n):
        s = Or(s,input[i])
    return Not(s)
    

def is_neg(input):
    assert input.bus_size == n
    return input[31]
    #32 bit entry 1 bit output