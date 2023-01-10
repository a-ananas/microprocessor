# Assembler RISC-V 
## Syntax :
* R : `instr rs1 rs2 rd`
* I : `instr rs imm rd`
* U : `instr imm rd`
    > Comments starting by `#`
    > Labels are strings of chars and digits followed by a `:`

## Compilation: 
Run `make compiler` to create an executable named `asm`. It runs then on files with name of the format `file.x` (because its cool :sunglasses:).
A `tests` directory is provided but we need more automatization. For the moment, the assembler takes care of immediates on 16 bits in two's complement. It's not optimal we might want to extend the range of immediates with different types of instructions.
The instructions are coded in little endian and the format is the one from our report so on the string in reading order we have opcode then output register, immediate and input registers.
