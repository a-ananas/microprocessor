# HOW TO USE THE SIMULATOR

# BUILDING

A list of possible build can be obtained using ```make``` or ```make help```

You can build both the tests and the netlist simulator.
To build the tests you can use the following command:
```sh
make test
```
This will build the tests and run them.
Alternatively you can separately build ```bin/graph_test.byte``` and ```bin/scheduler_test.byte``` and run different tests by hand.
Example:
```sh
# to test the graph
make graphTest
./bin/graph_test.byte

#to test the scheduler
make schedulerTest
./bin/scheduler_test.byte test/fulladder.net # this will launch a simulation
^C
./bin/scheduler_test.byte -print test/fulladder.net # this will create a test/fulladder_sch.net file representing the netlist after scheduling
```

To build the simulator you can use the following command:
```sh
make simulator
```

# USAGE

To try the simulater you give it a `.net` file as an argument.
```sh
# build the simulator
make simulator
# run the simulator on a test file for an infinite amount of steps
./bin/netlist_simulator.byte test/fulladder.net
```

You can also fix the number of steps for the simulation by adding the `-n nbSteps` option 
or show the running netlist with the `--print` option.
```sh
# run the simulator on a test file for 10 steps
./bin/netlist_simulator.byte -n 10 test/fulladder.net

# do not run the simulator but just print the running netlist
./bin/netlist_simulator.byte --print test/fulladder.net
```

To initialize the ROM given an input files you have to add another otptional argument `-rom file`
```sh
# initialize the rom inside the simulator using the given file and run the simulator on the test file
./bin/netlist_simulator.byte -rom init_rom.i test/fulladder.net
```

To print the result using 7 segments build with the 14 first registers, you can use the option `--clk`
```sh
# initialize the rom inside the simulator using the given file 
# and run the simulator on the test file while outputting the result 
# in a clock format using values in registers from x0 to x13
./bin/netlist_simulator.byte --clk -rom init_rom.i test/fulladder.net
```