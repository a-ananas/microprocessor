#!/bin/bash

echo "cd ../netlist_simulator ; make dir=\"$1\" file=\"$2\""
cd ../netlist_simulator ; make dir="$1" file="$2"
