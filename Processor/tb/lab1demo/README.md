# Lab1 Demo Test Benches
The table below lists the the order in which the test benches are to be run for the lab1 demo.
| run order | verilog file      | test bench module | instruction to simulate   |
| --------- | ------------      | ----------------- | -----------------------   |
| 1         | `sim_proc_and.v`  | `sim_PROC_AND`    | `and R4, R3, R7`          | 
| 2         | `sim_proc_or.v`   | `sim_PROC_OR`     | `or R4, R3, R7`           |
| 3         | `sim_proc_add.v`  | `sim_PROC_ADD`    | `add R4, R3, R7`          |
| 4         | `sim_proc_sub.v`  | `sim_PROC_SUB`    | `sub R4, R3, R7`          |
| 5         | `sim_proc_mul.v`  | `sim_PROC_MUL`    | `mul R2, R6`              |
| 6         | `sim_proc_div.v`  | `sim_PROC_DIV`    | `div R2, R6`              |
| 7         | `sim_proc_srl.v`  | `sim_PROC_SRL`    | `shr R4, R3, R7`          |
| 8         | `sim_proc_sra.v`  | `sim_PROC_SRA`    | `shra R4, R3, R7`         |
| 9         | `sim_proc_sll.v`  | `sim_PROC_SLL`    | `shl R4, R3, R7`          |
| 10        | `sim_proc_ror.v`  | `sim_PROC_ROR`    | `ror R4, R3, R7`          |
| 11        | `sim_proc_rol.v`  | `sim_PROC_ROL`    | `rol R4, R3, R7`          |
| 12        | `sim_proc_neg.v`  | `sim_PROC_NEG`    | `neg R5, R0`              |
| 13        | `sim_proc_not.v`  | `sim_PROC_NOT`    | `not R5, R0`              |


