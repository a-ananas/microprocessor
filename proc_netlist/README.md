# Microprocessor

The design of our microprocessor is similar to the one we've seen in class.

We've divided it into 6 major blocks:

- The [rdi](rdi/README.md): which is used to calculate the address of the next instruction in ROM.

- The [rom](rom/README.md): which is a read only memory that contains the program we want to run.

- The [di](decoder/README.md): which get all the informations encoded in the instructions comming from the ROM.

- The [reg](reg/README.md): which represents our registers logic.

- The [alu](alu/README.md): which is our main arithmetic and logic unit.

- The [ram](ram/README.md): which is our mutable memory.

# Schematic

<!-- TODO Insert microprocessor schema -->