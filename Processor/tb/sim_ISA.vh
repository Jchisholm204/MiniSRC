`ifndef _sim_ISA_vh_
`define _sim_ISA_vh_

// R Type instruction macro
`define INS_R(code, ra, rb, rc) {code, ra, rb, rc, 15'd0}

// I Type instruction macro
// 19 bit constant C
`define INS_I(code, ra, rb, c) {code, ra, rb, c}

// B Type instruction macro
// 19 bit constant C
// 4 bit constant c2
`define INS_B(code, ra, c2, c) {code, ra, 2'b00, c2, c}

// J Type instruction macro
`define INS_J(code, ra) {code, ra, 23'd0}

// M Type instruction macro
`define INS_M(code) {code, 27'd0}

`endif