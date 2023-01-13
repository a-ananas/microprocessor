# RDI

## Description

Module to get the address in rom of the next instruction to read.

If the current instruction in not a branchment, we set our first selector (instr_is_jmp) to 0.

Otherwise, we have two situations:

- Inconditional jump (jal)

-> The [ALU](../alu) return 1 (extended to 32 bits)

- Conditional jump (beq, bne, ...)

-> The [ALU](../alu) return 1 if the condition is valid, 0 if not


For both cases we start by putting the selector instr_is_jmp to 1.
Then, if the [ALU](../alu) returned value is 1, we set another selector (jmp_cond_fullfiled) to 1.

We then get two possible addresses for the next instruction to read: 
- add1 =  last address + 4 (if we do not want to jump)
- add2 = immediate extended to 32 bits + old address, immediate comming from the branching instruction which represents the label where we want to jump (i.e. the offset from the current address to the one we want to jump to)

Afterward, we use two multiplexor:

add3 = jmp_cond_fullfiled as the selector, add1 as the first value, add2 as the second value

add4 = instr_is_jmp as the selector, add1 as the first value, add3 as the second value

finally we return add4

## Schematic

<!-- TODO -->