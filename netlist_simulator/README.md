# A NETLIST SIMULATOR

(You can check the [github repository](https://github.com/MrBigoudi/ProjetSysNumENS.git))


## HOWTO

---

To see how to run and try the simulator, chek the [HOWTO.md](HOWTO.md) file


## BEHAVIOUR


---

Behavior for global variables and registers:

<ul>

<li>The simulator is interpreting every equations from the netlist at each steps (or infinitely if no number of steps was specified) using environments to spread infos between loops.</li>


<li>The environments are tables mapping identifiers to their current value (a Vbit or a VBitArray).</li>

<li>We're using two different environments, one current and one representing the environment state in the last step. Doing so we can manage the registers' one step delay by reading the register value from the previous environment.</li>

<li>To interpret each equations we devide it into its identifier and its expression.</li>

<li>We then interpret the so call expression using the <code>calculExp</code> function which, given an expression, call the corresponding function that interprets that kind of expression and update the given environment.

</ul>

Behavior for memories:

<ul>

<li>We've chosen to give a fixed <code>address size</code> of 16 bits for both the RAM's and the ROM's addresses.</li>
<li>We've chosen to give a fixed <code>word size</code> of 32 bits for both the RAM's and the ROM's values.</li>

<li>Like the two others environments, memories will be repesent by tables mapping addresses (represented as strings) to their correesponding value.</li>

<li>At the begining of the simulator, we create an empty ROM and an empty RAM. By 'empty' we mean that it contains 2^(<code>address size</code>) keys, all having an empty VBitArray of size <code>word size</code>.</li>

<li>Since the ROM is a read only memory, we only need one environment to represent it.</li>
<li>For the RAM, we're using the same trick as for the registers which mean having a second environment representing the state of the RAM during the last step. When reading from the RAM we're reading the value corresponding to the address in the previous environment while when we're writting to it, we're doing it in the  current environment.</li>

</ul>


## CLOCK

To represent the clock we use 14 7-segments: $$y_1y_2y_3y_4/d_1d_2/mth_1mth_2 \text{ } \text{ } \text{ } h_1h_2:m_1m_2:s_1s_2$$
These 7-segments are build using the 4 first bits of registers from x0 to x13 in that order:

$$
x0 = y_1
$$
$$
x1 = y_2
$$
$$
x2 = y_3
$$
$$
x3 = y_4
$$

$$
x4 = d_1
$$
$$
x5 = d_2
$$

$$
x6 = mth_1
$$
$$
x7 = mth_2
$$

$$
x8 = h_1
$$
$$
x9 = h_2
$$

$$
x10 = m_1
$$
$$
x11 = m_2
$$

$$
x12 = s_1
$$
$$
x13 = s_2
$$