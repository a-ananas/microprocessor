# ALU

## Description

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

## Schematic

<!-- TODO -->