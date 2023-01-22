# Tests


## Description

Folder containing some tests for the microprocessor different blocks.

---

## Howto

Example of a main to put inside proc_netlist that uses a file from the tests directory.

```python
# inside proc_netlist/main.py

import os
import sys
sys.path.insert(0, os.getcwd())

# example for test_alu
from tests import test_alu

def main() -> None:
    test_alu.test_alu()

```