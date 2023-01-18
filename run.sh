#!/bin/bash

# export PS4="\$LINENO: "
# set -xv

microproc="proc_netlist/net/main.net"

simu="netlist_simulator/bin/netlist_simulator.byte"

assembler="assembler/asm"

exists(){
    if [ ! -f ${microproc} ]; then
        echo "Need to build : ${1}"
        echo "Try using 'make'"
        exit 1
    fi
}

exists ${microproc};
exists ${simu};
exists ${assembler};

nb_step=0
clk_format=""

show_help(){
    echo "Usage: ./${0##*/} [OPTION]... [FILE]..."
    echo "Run a program written in our assembly language on our microprocessor"
    echo ""
    printf "\t-h, -?, --help \t\tdisplay this help and exit\n"
    printf "\t-n, --nb-step \t\tthe number of steps to run the simulator\n"
    printf "\t-c, --clk, --clock \tthe format the output as a formated 7-segment using values from registers x0 to x13\n\n"
    echo "Examples"
    printf "\t./run.sh ./assembler/tests/test_ram.x \t\t Run the program ./assembler/tests/test_ram.x infinitely\n"
    printf "\t./run.sh -n 11 ./assembler/tests/test_ram.x \t Run the program ./assembler/tests/test_ram.x during 11 simulator steps\n"
    printf "\t./run.sh --clk ./assembler/tests/test_7seg.x \t Run the program ./assembler/tests/test_7seg.x infinitely and format it as a 7-segment clock\n"
}

# get args
while :; do
    case $1 in
        -h|-\?|--help)
            show_help   # Display a usage synopsis.
            exit
            ;;
        -n|--nb-step)
            if [ "$2" ]; then
                nb_step=$2
                shift
            else
                die 'ERROR: "--nb-step" or "-n" require a non-empty option argument.'
            fi
            ;;
        --nb-step=?*)
            nb_step=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --nb-step=) # Handle the case of an empty --nb_step=
            die 'ERROR: "--nb-step" requires a non-empty option argument.'
            ;;
        -c|--clk|--clock)
            clk_format="--clk"
            ;;
        --) # End of all options
            shift
            break
            ;;
        -?*)
            printf 'WARN:Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *) # Default case: No more options, so break out of the loop.
        break
    esac 
    shift
done

code="$1"

if [[ ! -f ${code} ]]; then
    show_help 
    exit 1
fi
./${assembler} ${code};
rom="${code%.x}.i";

if [[ ${nb_step} -gt 0 ]]; then
    ./${simu} -n ${nb_step} -rom ${rom} ${clk_format} ${microproc}
else
    ./${simu} -rom ${rom} ${clk_format} ${microproc}
fi

exit 0;