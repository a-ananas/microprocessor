# ALU

This is the main Arithmetic and Logic unit.

It takes as input two variables (in 32 bits), and the instruction opcode
to return the wanted value.

To do so, it calculates in parallel all the different possible outcomes for all
the possible instructions using the two variables inputs and then use a multiplexor
to choose the wanted outcome using the opcode as the selector.

The ALU can perform arithmetical operations, shift operations, logic operations, ram manipulation 
and branching.
For branching, if the condition is resepected then the output would be a 1 extended to 32 bits otherwise
it will be a 0 exetended as well.