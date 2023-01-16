# Microprocessor

The design of our microprocessor is similar to the one we've seen in class.

We've divided it into 6 major blocks:

- The [rdi](rdi): which is used to calculate the address of the next instruction in ROM.

- The [rom](rom): which is a read only memory that contains the program we want to run.

- The [di](decoder): which get all the informations encoded in the instructions comming from the ROM.

- The [reg](reg): which represents our registers logic.

- The [alu](alu): which is our main arithmetic and logic unit.

- The [ram](ram): which is our mutable memory.

# Schematic

<!-- TODO Insert microprocessor schema -->