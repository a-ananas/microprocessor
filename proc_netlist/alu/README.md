# ALU explication

## shift: Oscar

Trois fonctions de shift, shift left logical : multiplication par 2,
puis shift right logical (seulement des 0 de remplacement), division par 2
shift right arithmetical, division par 2 en conservant le signe


les methodes sont sll, srl, sra, et elles existent toutes en version *k, qui presise directement le k de decalage.
Telles quelles, les methodes prennent b, un bus de taille 5, qui code le decalage sur 5 bits.

# ALU : Yannis

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
