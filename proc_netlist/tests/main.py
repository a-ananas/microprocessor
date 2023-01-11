# Example of a main to put inside proc_netlist that uses a file from the tests directory


# howto
# in proc_netlist tests:
#   cp main.py .. 

import os
import sys
sys.path.insert(0, os.getcwd())

from tests import test_alu

def main() -> None:

    '''Entry point of this example'''
    test_alu.test_alu()