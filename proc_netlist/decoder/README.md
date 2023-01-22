# The instruction decoder


## Description

The decoder takes as inputs an instruction comming from the [ROM](../rom/) and interprets it to produced 6 values:

- an `opcode`, which represents the opcode encoded in the instruction. 
- an `imm`, which represents the immediate encoded in the instruction.
- a `rs1`, which represents the first register address encoded in the instruction (for format `U`, this value will not be taken into account later in the netlist).
- a `rs2`, which represents the second register address encoded in the instruction (for formats `U` and `I`, this value will not be taken into account later in the netlist).
- a `rd`, which represents the register address of the destination encoded in the instruction.
- a `wenableReg`, which is a single bit telling us if we should write the last result in a register.
- and a `wenableRAM`, which is a single bit telling us if we should write the last result in the [RAM](../ram/).

---

## Schematic

<!-- TODO -->