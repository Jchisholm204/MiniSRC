# Lab1 Demo Test Benches
The table below lists the the order in which the test benches are to be run for the lab1 demo.

In all tests, prior to the instruction execution
- R-type instructions: R4=0x28, R3=0x22, R7=0x24 
- for mul and div instructions: R2=0x22, R6=0x24
- for neg and not instructions: R5=0x22, and R0=0x0 of course

| ready? | run order | instruction to simulate | test bench module | simulations/lab1demo | tb/lab1demo |
| ------ | --------- | ----------------------- | ----------------- | -------------------- | ----------- |
| ✅ | 1  | `and R4, R3, R7` | `sim_DATAPATH_AND` | `sim_datapath_and.do` | `sim_datapath_and.v` | 
| ✅ | 2  | `or R4, R3, R7`  | `sim_DATAPATH_OR`  | `sim_datapath_or.do`  | `sim_datapath_or.v`  |
| ✅ | 3  | `add R4, R3, R7` | `sim_DATAPATH_ADD` | `sim_datapath_add.do` | `sim_datapath_add.v` |
| ✅ | 4  | `sub R4, R3, R7` | `sim_DATAPATH_SUB` | `sim_datapath_sub.do` | `sim_datapath_sub.v` |
| ✅ | 5  | `mul R2, R6`     | `sim_DATAPATH_MUL` | `sim_datapath_mul.do` | `sim_datapath_mul.v` |
| ✅ | 6  | `div R2, R6`     | `sim_DATAPATH_DIV` | `sim_datapath_div.do` | `sim_datapath_div.v` |
| ✅ | 7  | `shr R4, R3, R7` | `sim_DATAPATH_SRL` | `sim_datapath_srl.do` | `sim_datapath_srl.v` |
| ✅ | 8  | `shra R4, R3, R7`| `sim_DATAPATH_SRA` | `sim_datapath_sra.do` | `sim_datapath_sra.v` |
| ✅ | 9  | `shl R4, R3, R7` | `sim_DATAPATH_SLL` | `sim_datapath_sll.do` | `sim_datapath_sll.v` |
| ✅ | 10 | `ror R4, R3, R7` | `sim_DATAPATH_ROR` | `sim_datapath_ror.do` | `sim_datapath_ror.v` |
| ✅ | 11 | `rol R4, R3, R7` | `sim_DATAPATH_ROL` | `sim_datapath_rol.do` | `sim_datapath_rol.v` |
| ✅ | 12 | `neg R5, R0`     | `sim_DATAPATH_NEG` | `sim_datapath_neg.do` | `sim_datapath_neg.v` |
| ✅ | 13 | `not R5, R0`     | `sim_DATAPATH_NOT` | `sim_datapath_not.do` | `sim_datapath_not.v` |

# Note about shift instructions
- the shift instructions (shr, shra, shl) only consider the lower 5 bits of the R7 (RB) register in the instruction (shifts by at most 31, only considering bits 4, 3, 2, 1, 0)
- shifting tester: https://onlinetoolz.net/bitshift
