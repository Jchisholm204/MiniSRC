# Lab1 Demo Test Benches
The table below lists the the order in which the test benches are to be run for the lab1 demo.
| run order | verilog file      | test bench module | instruction to simulate   |
| --------- | ------------      | ----------------- | -----------------------   |
| 1         | `sim_datapath_and.v`  | `sim_DATAPATH_AND`    | `and R4, R3, R7`          | 
| 2         | `sim_datapath_or.v`   | `sim_DATAPATH_OR`     | `or R4, R3, R7`           |
| 3         | `sim_datapath_add.v`  | `sim_DATAPATH_ADD`    | `add R4, R3, R7`          |
| 4         | `sim_datapath_sub.v`  | `sim_DATAPATH_SUB`    | `sub R4, R3, R7`          |
| 5         | `sim_datapath_mul.v`  | `sim_DATAPATH_MUL`    | `mul R2, R6`              |
| 6         | `sim_datapath_div.v`  | `sim_DATAPATH_DIV`    | `div R2, R6`              |
| 7         | `sim_datapath_srl.v`  | `sim_DATAPATH_SRL`    | `shr R4, R3, R7`          |
| 8         | `sim_datapath_sra.v`  | `sim_DATAPATH_SRA`    | `shra R4, R3, R7`         |
| 9         | `sim_datapath_sll.v`  | `sim_DATAPATH_SLL`    | `shl R4, R3, R7`          |
| 10        | `sim_datapath_ror.v`  | `sim_DATAPATH_ROR`    | `ror R4, R3, R7`          |
| 11        | `sim_datapath_rol.v`  | `sim_DATAPATH_ROL`    | `rol R4, R3, R7`          |
| 12        | `sim_datapath_neg.v`  | `sim_DATAPATH_NEG`    | `neg R5, R0`              |
| 13        | `sim_datapath_not.v`  | `sim_DATAPATH_NOT`    | `not R5, R0`              |


