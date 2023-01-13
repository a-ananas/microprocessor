# Registers for the microprocessor

## Descritpion

List of registers: Variable("x0", REG_SIZE), Variable("x1", REG_SIZE), ..., Variable("x1", REG_SIZE)

To read a value inside a register given an address `r`, we get the values for all 32 registers and then use
a multiplexor (as in the [ALU](../alu/README.md)) using `r` as the selector to get only the value we're looking for.

To write a value inside a register given an address `rd`, we actually replace the values in all the registers. 
To choose the new value to put inside a register `i`, we use two multiplexors, one using `rd` as a selector
and then another one using `wenable` as a selector so we only modify the value for the register which's address matches `rd` and only if `wenable` is set to true. The value we're actually writting is choosed
between the value from the [ALU](../alu/README.md) and the value from the [RAM](../ram/README.md) using
the instruction opcode as the multiplexor selector. 

Lasty, `reg` return 2 variable, `i1` (the value read inside the register of address `rs1`) and `i2`. `i2` can get two possible values, if the instruction is of type `I` then `i2` is the immediate given as a parameter for the `get` function, otherwise, `i2` is the value read inside the register of address `rs2`.

## Schematic

<!-- TODO -->