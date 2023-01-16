from lib_carotte import *
from global_utils import const
from alu import arith

def get_one_part(cur_addr: Variable) -> tuple[Variable,Variable]:
    # test input size
    assert(cur_addr.bus_size == const.REG_SIZE)
    # cur_addr.set_as_output()
    # cur_addr[0:const.MEMORY_ADDR_SIZE].set_as_output()
    value = ROM(const.MEMORY_ADDR_SIZE, const.REG_SIZE, cur_addr[0:const.MEMORY_ADDR_SIZE])
    # value.set_as_output()
    assert(value.bus_size == const.REG_SIZE)
    value = value[0:const.ROM_WORD_SIZE]
    assert(value.bus_size == const.ROM_WORD_SIZE)
    return value

def get_all_parts(next_instr: Variable) -> list[Variable]:
    # test input size
    assert(next_instr.bus_size == const.REG_SIZE)

    # part1 of the rom instruction
    part1 = ROM(const.MEMORY_ADDR_SIZE, const.REG_SIZE, next_instr[0:const.MEMORY_ADDR_SIZE])
    assert(part1.bus_size == const.REG_SIZE)
    part1 = part1[0:const.ROM_WORD_SIZE]
    assert(part1.bus_size == const.ROM_WORD_SIZE)
    # part1.set_as_output("part1")

    nb_parts = const.REG_SIZE // const.ROM_WORD_SIZE
    l = [const.C32B_0()]*nb_parts
    l[0] = part1
    cur_addr = next_instr
    assert(cur_addr.bus_size == const.REG_SIZE)

    # get all the parts of the instruction
    for i in range(1,nb_parts):
        cur_addr = arith.addn(const.C32B_1(), cur_addr, const.C1B_0())[0]
        assert(cur_addr.bus_size == const.REG_SIZE)
        part_i = get_one_part(cur_addr)
        # part_i.set_as_output()
        l[i] = part_i

    assert(len(l) == nb_parts)

    return l

def merge_parts(endianness: int, part_list: list[Variable]) -> Variable:
    assert(endianness == const.LITTLE_ENDIAN or endianness == const.BIG_ENDIAN)
    nb_parts = len(part_list)
    assert(nb_parts == const.REG_SIZE // const.ROM_WORD_SIZE)
    if (endianness == const.LITTLE_ENDIAN):
        instruction = part_list[0]
        for i in range(1,nb_parts):
            instruction = instruction + part_list[i]
        # part_list[0].set_as_output("part_0")
        # part_list[1].set_as_output("part_1")
        # part_list[2].set_as_output("part_2")
        # part_list[3].set_as_output("part_3")
        return instruction
    elif (endianness == const.BIG_ENDIAN):
        instruction = part_list[nb_parts-1]
        for i in range(nb_parts-2,-1,-1):
            instruction = instruction + part_list[i]
        return instruction
    assert(false)
    return const.C32B_0()