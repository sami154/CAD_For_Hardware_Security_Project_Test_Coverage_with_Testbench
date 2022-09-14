
**Overview:**

In this project, RTL implementation of an AES cryptographic module is given. A simulation based validation of the design is performed. A testbench is written to simulate the AES design and dump all outputs in a seperate directory. A Stimuli generator, Coverage monitor and a Threshold checker are implemented in the testbench as a modular form. 

**Stimuli Generator:** This component will be used to generate the stimuli that will be fed to Synopsys VCS.

**Coverage Monitor:** The Coverage monitor extracts the following coverage.

	1. Line Coverage
	2. Condition Coverage
	3. Toggle Coverage
	4. Branch Coverage
	5. FSM Coverage

**Threshold Checker:** This component will take the "Target coverage" as input and compare the extracted coverage with the target coverage. It will trigger the simulation engine to continue until the threshold is not met.

**Steps:**

1. In the home directory, "goldedAES_RTL" directory contains AES RTL codes.
3. Copy the "tb_aes.sv" and the "run_1a.sh" scripts in the home directory.
4. Run the "run_1a.sh" script.


**Note:**

VCS built in commands are used to determine the coverages. This is a iterative process. For each iteration, the test bench generates
10 random keys and plain text and the corresponding output is generated. Then VCS determines the achieved coverage for the 10 random patterns. 
This process is done iteratively until 70% targeted coverage is achieved.

**Outputs:**

The script will generate the following txt files.

	1. vcs_aes_output.txt -->  This file contains the random keys (1st column), plain texts (2nd column) and the corresponding encrypted text (3rd column).
	2. coverage_each_iter.txt --> This file contains the line, condition, toggle and branch coverage respectively for each iteration for checking the coverage.
	3. coverage.txt --> This is intermediate file used for calculating the minimum coverage at any iteration. 

