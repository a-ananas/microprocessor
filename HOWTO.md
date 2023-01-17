# Howto use this project

## Build everything

To build everything you can either enter each subfolders and build anything particular part of the project you want or you can use the command `make` which will build the [assembler](assembler/), the [simulator](netlist_simulator/) and the netlist corresponding to the [microprocessor](proc_netlist/).

## Run a program

To run a program written in our assembly language, you can do the following:

```sh
# ./run.sh <file.x>
#
# This example will run the program ./assembler/tests/test_ram.x infinitely
./run.sh ./assembler/tests/test_ram.x
```

Or, if you want the programm to run only for a given amount of step, you can add an option at the end of the command:

```sh
# ./run.sh <file.x> <nb_step>
#
# This example will run the program ./assembler/tests/test_ram.x during 10 simulator steps
./run.sh ./assembler/tests/test_ram.x 10
```