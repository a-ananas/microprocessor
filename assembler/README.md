# Assembler RISC-V 
## Syntax :
* R : `instr rd rs1 rs2`
* R : `instr rd lab rs1 rs2`
* I : `instr rd rs imm`
* I : `instr rd rs lab`
* U : `instr rd imm`
* U : `instr rd lab`
    > Comments starting by `#`
    > Labels are strings of chars and digits followed by a `:`
    > R types with labels are the conditionnal branching, their syntax is a bit different because of conflicts risen in the parser : TO FIX.

So the syntax is first the register output, then the two registers or register immediate or immediate/label.

## Compilation: 
Run `make compiler` to create an executable named `asm`. It runs then on files with name of the format `file.x` (because its cool :sunglasses:).
A `tests` directory is provided but we need more automatization. For the moment, the assembler takes care of immediates on 16 bits in two's complement. It's not optimal we might want to extend the range of immediates with different types of instructions.
The instructions are coded in little endian and the format is the one from our report so on the string in reading order we have opcode then output register, immediate and input registers.
