# Project microprocessor

[git hub link](https://github.com/a-ananas/microprocessor)

## Global architecture

The global architecture and designs for this entire project is [here](report_architecture/).

## Simulator

Explanations for our simulator can be found [here](netlist_simulator/).

## Assembler

Explanations for the assembly part is [here](assembler/).

## Microprocessor

Our microprocessor is build using the Minijazz netlist format (more info about its insides [here](proc_netlist/))

## Clock

The clock is initialized putting current unix time in ram separated in seconds, minutes, hours, day, month and year. Then, using a double dabble algorithm, we place the 14 values (yyyy/dd/mm hh:mm:ss) inside 14 regiters from x0 to x13. We also put in ram a value updated each time a second has passed. The main algorithm works as follow, everytime this value is set to 1, we update the global second counter and do a serie of check to update the 14 registers. To print the values, we use a 7-segment logic built in the [simulator](netlist_simulator/).