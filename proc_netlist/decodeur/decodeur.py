# Decodeur d'instructions, en premiere approximation, 
#cest jusytre une hrosse fonction avec une entree de traille 32
#et une sortie avec absolument tout, a voir
from lib_carotte import *

import utils


def decodeur_dinstructions(instr: Variable):
    #verification que c'est bien le format d'une instruction
    assert instr.bus_size == 32
    opcode = instr[0:5]
    isR = get_isR(opcode)
    isI = get_isI(opcode)
    isU = get_isU(opcode)
    #set defaults
    immD = Constant(32 * '0') #immediat saur 32 bits
    Wenable = Constant('0')

    rd = instr[5:10]
    rs1 = instr[10:15]
    rs2 = instr[15:20]
 
    #get for R
    
    immR,WenableR = get_field_R(opcode)
    immI,WenableI = get_field_I(opcode)
    immU,WenableU = get_field_U(opcode)

    imm = Mux(isU,Mux(isI,Mux(isR,immD,immR),immI),immU)
    Wenable = Mux(isU,Mux(isI,Mux(isR,WenableD,WenableR),WenableI),WenableU)

    return opcode,imm,rs1,rs2,rd,Wenable

#Note that the optcode table is written  in human!  The first number read is
#the heavy digit, so it corresponds to optcode[4]

#renvoi un fil portant 1 ssi linstruction est de type R
def get_isI(o: Variable):
    a = Not(o[3] | o[4]) #les debuts de codes 00 sont des R donc si le deuxieme terme est un 0, c'est bien R
    #le code 10000 et 10 110
    c = o[4] & ~(o[3] | o[2] | o[1] | o[0])
    d = o[4] & o[2] & o[1] & ~o[3] & ~o[0]
    #le code 11111 est de type I aiussi
    b = And5(o[0],o[1],o[2],o[3],o[4])
    return a | b | c | d

def get_isR(o: Variable):
    assert o.bus_size == 5
    #les codes commencant par 01
    a = And(Not(o[4]),o[3])
    #le code 11110
    b = o[4] & o[3] & o[2] & o[1] & ~o[0]
    #les codes 10 + tout sauf 000 et 110 
    c = ~o[4] & o[3] & ((o[2] | o[1] | o[0]) & (~o[2] | ~o[1] | o[0]))  

    return a | b | c

def get_isU(o: Variable):
    #110
    return o[4] & o[3] & ~o[2]



def get_field_U(instr: Variable) -> Variable:
    assert(instr.bus_size == 32)
    imm0 = instr[10:32] + Constant(10 * '0')
    imm1 = instr[10:32] + Constant(10 * '1')
    imm = Mux(instr[31],imm0,imm1)
    #normalement wenable = 1 pour 11000 et 11001 et 0 sinon (aka 11010 11011)
    Wenable = ~instr[1]
    return (imm,Wenable)


# return the fields from an instruction of type I
def get_field_I(instr: Variable) -> Variable:
    assert(instr.bus_size == 32)
    imm1 = instr[15:32] + Constant(15 * '1')
    imm0 = instr[15:32] + Constant(15 * '0')
    imm = Mux(instr[31], imm0, imm1)
    #pour completer comme il faut
    o = instr[0:5]
    #doit etre egal a 0 seulement si c'est 01 + (nimporte quoi sauf 000)
    Wenable = Not(~o[4] & o[3] & (o[2] | o[1] | o[0]))
    return (imm, Wenable)


# return the fields from an instruction of type R
def get_field_R(instr: Variable) -> Variable:
    assert(instr.bus_size == 32)
    imm = Constant(32 * '0')
    Wenable = 1 #all the R instruction are yes on wenable
    return (imm, Wenable)

    
def test(instr: Variable):
    doit = Constant('0')
    if Variable == Constant('00'):
        doit = Constant('1')

    return doit