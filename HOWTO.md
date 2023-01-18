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
# ./run.sh -n <nb_step> <file.x>
#
# This example will run the program ./assembler/tests/test_ram.x during 11 simulator steps
./run.sh -n 11 ./assembler/tests/test_ram.x
```

You can also add an option to choose if you want to print the registers at each step or to print a 
7-segment formated output to represent a clock (using registers from x0 to x13).

```sh
# ./run.sh -n <nb_step> --clk <file.x>
#
# This example will run the program ./assembler/tests/test_7seg.x during 11 simulator steps and output it as a clock
./run.sh -n 11 --clk ./assembler/tests/test_7seg.x
```