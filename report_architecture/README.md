# Architecture choice

We’ve chosen to make our project using the 32 bits RISC-’s architecture.
We’ll use 32 registers.


# Instruction Set

We’ll use a total of 28 instructions to make operations between unsigned
integers. We’ll encode our instructions in different ways according to
the instruction’s format (operation with immediates I, with jumps U,
only on registers R). The different operations we’ll use are:

-   *add*, *sub* (type R) and *addi* (type I). Our arithmetical
    instructions.

-   *sll*, *srl*, *sra* Of type R and their equivalent of type I to make
    bitwise shifts.

-   logical operations *and*, *or* and *xor* of type R and their
    equivalent of type I.

-   tests operations *slt* and *slti*.

-   *lui* and *auipc* are special instructions of type U, used to move
    in the stack.

-   *beq*, *bne*, *blt*, *blti* (type I) and *bge* for conditional
    branching. Except for *blti*, they’re of type R.

-   *jal* and *jalr* of type U for unconditional jumps.

-   *lw* (type I) and *sw* (type R) load and store datas from and to
    memory.

Here are the different encoding for the different instruction formats.
These formats help us manipulate immediates of big size. It’s probably
not mandatory but it can come handy in some particular cases.

*rd* represents the destination register and *rsX* the sources ones.

|     | 31 &emsp;&emsp;&emsp; 20 | 19 &emsp;&emsp;&emsp; 15 | 14 &emsp;&emsp;&emsp; 10 | 9 &emsp;&emsp;&emsp; 5 | 4 &emsp;&emsp;&emsp; 0 |
|:---:|:---------|:----|:----|:----|:-------|
|  <p style="text-align: center;">R</p>  | <p style="text-align: center;">immédiat</p> | <p style="text-align: center;">rs2</p> | <p style="text-align: center;">rs1</p> | <p style="text-align: center;">rd</p>  | <p style="text-align: center;">opcode</p> |
|  <p style="text-align: center;">I</p>  | <p style="text-align: center;">immédiat</p> |     | <p style="text-align: center;">rs</p>  | <p style="text-align: center;">rd</p>  | <p style="text-align: center;">opcode</p> |
|  <p style="text-align: center;">U</p>  | <p style="text-align: center;">immédiat</p> |     |     | <p style="text-align: center;">rd</p>  | <p style="text-align: center;">opcode</p> |


# Opcodes

Our instructions will have the following opcodes:

|     | 000  | 001   | 010  | 011  | 100  | 101  | 110  | 111  |     |
|:----|:----:|:------|:-----|:-----|:-----|:-----|:-----|:-----|:----|
| 00  | Addi |       | Srli | Srai | Slli | Andi | Ori  | Xori |     |
| 01  | Add  | Sub   | Srl  | Sra  | Sll  | And  | Or   | Xor  |     |
| 10  |  Lw  | Sw    |      | Beq  | Bne  | Blt  | Blti | Bge  |     |
| 11  | Lui  | Auipc | Jal  | Jalr |      |      | Slt  | Slti |     |


# TLDR

| instruction | format | opcode |     usage      |                result                |
|:-----------:|:------:|:------:|:--------------:|:------------------------------------:|
|    Addi     |   I    | 00000  |  addi x0 x1 1  |             x0 = x1 + 1              |
|    Srli     |   I    | 00010  |  srli x0 x1 1  |    x0 = x1 \>\> 1 (0 extended)     |
|    Srai     |   I    | 00011  |  srai x0 x1 1  |   x0 = x1 \>\> 1 (sign extended)   |
|    Slli     |   I    | 00100  |  slli x0 x1 1  |           x0 = x1  \<\< 1           |
|    Andi     |   I    | 00101  |  andi x0 x1 1  |             x0 = x1 & 1              |
|     Ori     |   I    | 00110  |  ori x0 x1 1   |             x0 = x1 \| 1             |
|    Xori     |   I    | 00111  |  xori x0 x1 1  |             x0 = x1 ⊕ 1              |
|     Add     |   R    | 01000  | add x0 x1 x2 1 |             x0 = x1 + x2             |
|     Sub     |   I    | 01001  | sub x0 x1 x2 1 |             x0 = x1 − x2             |
|     Srl     |   R    | 01010  | srl x0 x1 x2 1 |    x0 = x1 \>\> x2 (0 extended)    |
|     Sra     |   R    | 01011  | sra x0 x1 x2 1 |  x0 = x1 \>\> x2 (sign extended)   |
|     Sll     |   R    | 01100  | sll x0 x1 x2 1 |          x0 = x1 \<\< x2           |
|     And     |   R    | 01101  | and x0 x1 x2 1 |             x0 = x1 & x2             |
|     Or      |   R    | 01110  | or x0 x1 x2 1  |            x0 = x1 \| x2             |
|     Xor     |   R    | 01111  | xor x0 x1 x2 1 |             x0 = x1 ⊕ x2             |
|     Lw      |   I    | 10000  |   lw x0 x1 1   |             x0 = Ram(x1)             |
|     Sw      |   R    | 10001  | sw x0 x1 x2 1  |             Ram(x1) = x2             |
|     Beq     |   R    | 10011  | beq x0 x1 x2 1 | rdi = (x1 == x2) ? rdi + 1 : rdi + 4 |
|     Bne     |   R    | 10100  | bne x0 x1 x2 1 | rdi = (x1 != x2) ? rdi + 1 : rdi + 4 |
|     Blt     |   R    | 10101  | blt x0 x1 x2 1 | rdi = (x1 \< x2) ? rdi + 1 : rdi + 4 |
|     Bge     |   R    | 10111  | bge x0 x1 x2 1 | rdi = (x1 ≥ x2) ? rdi + 1 : rdi + 4  |
|     Jal     |   U    | 11010  |    jal x0 1    |               rdi = 1                |
|     Slt     |   R    | 11110  | slt x0 x1 x2 3 |       x0 = (x1 \< x2) ? 1 : 0        |
|    Slti     |   I    | 11111  |  slti x0 x1 3  |        x0 = (x1 \< 3) ? 1 : 0        |
