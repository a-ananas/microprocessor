# Project microprocessor

[git hub link](https://github.com/a-ananas/microprocessor)

## Global architecture

The global architecture and designs for this entire project is presented [here](#report-architechture).

## Simulator

Explanations for our simulator can be found [here](#a-netlist-simulator).

## Assembler

Explanations for the assembly part is [here](#assembler).

## Microprocessor

Our microprocessor is build using the Minijazz netlist format (more info about its insides [here](#microprocessor-1)

## Clock

The clock is initialized putting current unix time in ram separated in seconds, minutes, hours, day, month and year. Then, using a double dabble algorithm, we place the 14 values (yyyy/dd/mm hh:mm:ss) inside 14 regiters from x0 to x13. We also put in ram a value updated each time a second has passed. The main algorithm works as follow, everytime this value is set to 1, we update the global second counter and do a serie of check to update the 14 registers. To print the values, we use a 7-segment logic built in the [simulator](#clock-logic).

# Report architechture

## Architecture choice

We’ve chosen to make our project using the 32 bits RISC-’s architecture.
We’ll use 32 registers.


## Instruction Set

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


## Opcodes

Our instructions will have the following opcodes:

|     | 000  | 001   | 010  | 011  | 100  | 101  | 110  | 111  |     |
|:----|:----:|:------|:-----|:-----|:-----|:-----|:-----|:-----|:----|
| 00  | Addi |       | Srli | Srai | Slli | Andi | Ori  | Xori |     |
| 01  | Add  | Sub   | Srl  | Sra  | Sll  | And  | Or   | Xor  |     |
| 10  |  Lw  | Sw    |      | Beq  | Bne  | Blt  | Blti | Bge  |     |
| 11  | Lui  | Auipc | Jal  | Jalr |      |      | Slt  | Slti |     |


## TLDR

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
|     Sub     |   R    | 01001  | sub x0 x1 x2 1 |             x0 = x1 − x2             |
|     Srl     |   R    | 01010  | srl x0 x1 x2 1 |    x0 = x1 \>\> x2 (0 extended)    |
|     Sra     |   R    | 01011  | sra x0 x1 x2 1 |  x0 = x1 \>\> x2 (sign extended)   |
|     Sll     |   R    | 01100  | sll x0 x1 x2 1 |          x0 = x1 \<\< x2           |
|     And     |   R    | 01101  | and x0 x1 x2 1 |             x0 = x1 & x2             |
|     Or      |   R    | 01110  | or x0 x1 x2 1  |            x0 = x1 \| x2             |
|     Xor     |   R    | 01111  | xor x0 x1 x2 1 |             x0 = x1 ⊕ x2             |
|     Lw      |   I    | 10000  |   lw x0 x1 1   |             x0 = Ram(x1)             |
|     Sw      |   R    | 10001  | sw x0 x1 x2 1  |             Ram(x2) = x1             |
|     Beq     |   R    | 10011  | beq x0 x1 x2 1 | rdi = (x1 == x2) ? rdi + 1 : rdi + 4 |
|     Bne     |   R    | 10100  | bne x0 x1 x2 1 | rdi = (x1 != x2) ? rdi + 1 : rdi + 4 |
|     Blt     |   R    | 10101  | blt x0 x1 x2 1 | rdi = (x1 \< x2) ? rdi + 1 : rdi + 4 |
|     Bge     |   R    | 10111  | bge x0 x1 x2 1 | rdi = (x1 ≥ x2) ? rdi + 1 : rdi + 4  |
|     Jal     |   U    | 11010  |    jal x0 1    |               rdi = 1                |
|     Slt     |   R    | 11110  | slt x0 x1 x2 3 |       x0 = (x1 \< x2) ? 1 : 0        |
|    Slti     |   I    | 11111  |  slti x0 x1 3  |        x0 = (x1 \< 3) ? 1 : 0        |

# A netlist simulator

(You can check the [github repository](https://github.com/MrBigoudi/ProjetSysNumENS.git))


## Howto

---

To see how to run and try the simulator, chek the [HOWTO.md](netlist_simulator/HOWTO.md) file


## Behaviour


---

Behavior for global variables and registers:

<ul>

<li>The simulator is interpreting every equations from the netlist at each steps (or infinitely if no number of steps was specified) using environments to spread infos between loops.</li>


<li>The environments are tables mapping identifiers to their current value (a Vbit or a VBitArray).</li>

<li>We're using two different environments, one current and one representing the environment state in the last step. Doing so we can manage the registers' one step delay by reading the register value from the previous environment.</li>

<li>To interpret each equations we devide it into its identifier and its expression.</li>

<li>We then interpret the so call expression using the <code>calculExp</code> function which, given an expression, call the corresponding function that interprets that kind of expression and update the given environment.

</ul>

Behavior for memories:

<ul>

<li>We've chosen to give a fixed <code>address size</code> of 16 bits for both the RAM's and the ROM's addresses.</li>
<li>We've chosen to give a fixed <code>word size</code> of 32 bits for both the RAM's and the ROM's values.</li>

<li>Like the two others environments, memories will be repesent by tables mapping addresses (represented as strings) to their correesponding value.</li>

<li>At the begining of the simulator, we create an empty ROM and an empty RAM. By 'empty' we mean that it contains 2^(<code>address size</code>) keys, all having an empty VBitArray of size <code>word size</code>.</li>

<li>Since the ROM is a read only memory, we only need one environment to represent it.</li>
<li>For the RAM, we're using the same trick as for the registers which mean having a second environment representing the state of the RAM during the last step. When reading from the RAM we're reading the value corresponding to the address in the previous environment while when we're writting to it, we're doing it in the  current environment.</li>

</ul>


## Clock logic

To represent the clock we use 14 7-segments: $$y_1y_2y_3y_4/d_1d_2/mth_1mth_2 \text{ } \text{ } \text{ } h_1h_2:m_1m_2:s_1s_2$$
These 7-segments are build using the 4 first bits of registers from x0 to x13 in that order:

$$
x0 = y_1
$$
$$
x1 = y_2
$$
$$
x2 = y_3
$$
$$
x3 = y_4
$$

$$
x4 = d_1
$$
$$
x5 = d_2
$$

$$
x6 = mth_1
$$
$$
x7 = mth_2
$$

$$
x8 = h_1
$$
$$
x9 = h_2
$$

$$
x10 = m_1
$$
$$
x11 = m_2
$$

$$
x12 = s_1
$$
$$
x13 = s_2
$$

# Assembler RISC-V 

## Syntax :
* R : `instr rd rs1 rs2`
* R : `instr rd rs1 rs2 imm`
* R : `instr rd rs1 rs2 lab`
* I : `instr rd rs imm`
* I : `instr rd rs lab`
* U : `instr rd imm`
* U : `instr rd lab`
    > Comments starting by `#`
    > Labels are strings of chars and digits followed by a `:`
    > R types with labels are the conditionnal branching, just need to append the label (or immediate) to the instruction.

So the syntax is first the register output, then the two registers or register immediate or immediate/label.

## Compilation: 
Run `make compiler` to create an executable named `asm`. It runs then on files with name of the format `file.x` (because its cool :sunglasses:).
A `tests` directory is provided but we need more automatization. For the moment, the assembler takes care of immediates on 16 bits in two's complement. It's not optimal we might want to extend the range of immediates with different types of instructions.
The instructions are coded in little endian and the format is the one from our report so on the string in reading order we have opcode then output register, immediate and input registers.

# Microprocessor

## Overall design

The design of our microprocessor is similar to the one we've seen in class.

We've divided it into 6 major blocks:

- The [rdi](#rdi): which is used to calculate the address of the next instruction in ROM.

- The [rom](#rom): which is a read only memory that contains the program we want to run.

- The di: which get all the informations encoded in the instructions comming from the ROM.

- The [reg](#reg): which represents our registers logic.

- The [alu](#alu): which is our main arithmetic and logic unit.

- The [ram](#ram): which is our mutable memory.

## RDI

### Description

Module to get the address in rom of the next instruction to read.

If the current instruction in not a branchment, we set our first selector (instr_is_jmp) to 0.

Otherwise, we have two situations:

- Inconditional jump (jal)

-> The [ALU](#alu) return 1 (extended to 32 bits)

- Conditional jump (beq, bne, ...)

-> The [ALU](#alu) return 1 if the condition is valid, 0 if not


For both cases we start by putting the selector instr_is_jmp to 1.
Then, if the [ALU](#alu) returned value is 1, we set another selector (jmp_cond_fullfiled) to 1.

We then get two possible addresses for the next instruction to read: 
- add1 =  last address + 4 (if we do not want to jump)
- add2 = immediate extended to 32 bits + old address, immediate comming from the branching instruction which represents the label where we want to jump (i.e. the offset from the current address to the one we want to jump to)

Afterward, we use two multiplexor:

add3 = jmp_cond_fullfiled as the selector, add1 as the first value, add2 as the second value

add4 = instr_is_jmp as the selector, add1 as the first value, add3 as the second value

finally we return add4

## ROM

### Description

It takes as input an address `next_instr` from [rdi](#rdi) and returns the concatenate value of the four values inside the ROM at this `next_instr`, `next_instr + 1`, `next_instr + 2`, `next_instr + 3`.

Addresses on 16 bits (so the netlist can be simulated in a decent amount of time).

## REG

### Descritpion

List of registers: Variable("x0", REG_SIZE), Variable("x1", REG_SIZE), ..., Variable("x1", REG_SIZE)

To read a value inside a register given an address `r`, we get the values for all 32 registers and then use
a multiplexor (as in the [ALU](#alu)) using `r` as the selector to get only the value we're looking for.

To write a value inside a register given an address `rd`, we actually replace the values in all the registers. 
To choose the new value to put inside a register `i`, we use two multiplexors, one using `rd` as a selector
and then another one using `wenable` as a selector so we only modify the value for the register which's address matches `rd` and only if `wenable` is set to true. The value we're actually writting is choosed
between the value from the [ALU](#alu) and the value from the [RAM](#ram) using
the instruction opcode as the multiplexor selector. 

Lasty, `reg` return 2 variable, `i1` (the value read inside the register of address `rs1`) and `i2`. `i2` can get two possible values, if the instruction is of type `I` then `i2` is the immediate given as a parameter for the `get` function, otherwise, `i2` is the value read inside the register of address `rs2`.

## ALU

### Description

This is the main Arithmetic and Logic unit.

It takes as input two variables (in 32 bits), and the instruction opcode
to return the wanted value.

To do so, it calculates in parallel all the different possible outcomes for all
the possible instructions using the two variables inputs. Then, with a multiplexor
it chooses the wanted outcome using the opcode as the selector.

The ALU can perform arithmetical operations, shift operations, logic operations, ram manipulations
and branching.
For branching, if the condition is respected then the output would be a 1 extended to 32 bits otherwise
it will be a 0 extended as well.

We have three diferent shifts, logical left shift (multiplies by 2), logcial right shift (only 0 for replacing, divides by 2) and arithmetical right shift (divides by 2 conserving the sign).

## RAM

## Description

Uses only 3 inputs, the first input is used as the read address or a write data depending on the instruction,
the second decides if we should write in the RAM or not and the last one is the write address.

All addresses are on 16 bits (so the netlist can be simulated in a decent amount of time)