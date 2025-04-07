# MiniSRC
ELEC 374 MiniSRC Processor

## Description
This is the miniSRC processor built for the Queen's ELEC374 Course.
This GitHub repository was made public so that it could be referenced in the final report.


This processor was based off of the miniSRC architecture, a MIPS based ISA.
The processor features integer division and multiplication in addition to standard features.


Some adaptations have been made from the original miniSRC design:
- Changed bus to a 5-stage pipeline
- Changed word based addressing to byte based
- Added memory bus with VGA


## Usage
The current project is set up for a Cyclone II DE2.
To change boards, please modify the `/pins/miniSRC_pins.csv` and re-import the pin assignments in Quartus.

## Testing
Processor test benches are located under `./Processor/tb`.
Lab test benches are located under `./Processor/tb/lab*demo`.
Please note that many of these test benches do not match the lab test bench requirements.
This is due to the adaptations to the processor listed above.

## Authors
- Jacob Chisholm
    - ALU
        - Divisor
        - Adder
        - Bit Manipulation Logic (Shift, Roll, ...)
    - Data Path
        - Register File
        - Processor Module
    - Control Unit
- Hendrix Gryspeerdt
    - ALU
        - Multiplier
    - Lab Test Benches
        - Lab 1
        - Lab 3
        - Lab 4 (Simulation)
- Luke Strickland
    - Data Path Design
    - Pipeline Design
    - Control Unit

