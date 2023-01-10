# Assembler RISC-V 
## Syntax :
* R : `instr rs1 rs2 rd`
* I : `instr rs imm rd`
* R : `instr imm rd`
    > Comments starting by `#`

## Compilation: 
Run `make compiler` to create an executable named `asm`. It runs then on files with name of the format `file.x` (because its cool :sunglasses:).
A `tests` directory is provided but we need more automatization. For the moment, the assembler takes care of immediates on 16 bits in two's complement. It's not optimal we might want to extend the range of immediates with different types of instructions.
