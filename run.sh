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

nb_step=${2:-0}

code="${1}";
[[ -f ${code} ]] || (echo "usage : $0 <file.x> <nb_step optional>" && exit 1);
./${assembler} ${code};
rom="${code%.x}.i";

if [[ ${nb_step} -gt 0 ]]; then
    ./${simu} -n ${nb_step} -rom ${rom} ${microproc}
else
    ./${simu} -rom ${rom} ${microproc}
fi

exit 0;