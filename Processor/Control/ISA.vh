// ELEC 374 Instruction Set Architecture
// Opcode Signatures

// Opcode Signatures
// R Format Instructions
`define ISA_LD   5'b00000
`define ISA_LI   5'b00001
`define ISA_ST   5'b00010
`define ISA_ADD  5'b00011
`define ISA_SUB  5'b00100
`define ISA_AND  5'b00101
`define ISA_OR   5'b00110
`define ISA_ROR  5'b00111
`define ISA_ROL  5'b01000
`define ISA_SRL  5'b01001
`define ISA_SRA  5'b01010
`define ISA_SLL  5'b01011
// I Format Instructions
`define ISA_ADDI 5'b01100
`define ISA_ANDI 5'b01101
`define ISA_ORI  5'b01110
`define ISA_DIV  5'b01111
`define ISA_MUL  5'b10000
`define ISA_NEG  5'b10001
`define ISA_NOT  5'b10010
// B Format Instructions
`define ISA_BRx  5'b10011
// J Format Instructions
`define ISA_JAL  5'b10100
`define ISA_JFR  5'b10101
`define ISA_IN   5'b10110
`define ISA_OUT  5'b10111
`define ISA_MFL  5'b11000
`define ISA_MFH  5'b11001
// M Format Instructions
`define ISA_NOP  5'b11010
`define ISA_HLT  5'b11011

// Branch Codes
// Branch if Zero
`define ISA_BR_ZERO 2'b00
// Branch if NonZero
`define ISA_BR_NZRO 2'b01
// Branch if Positive
`define ISA_BR_POSI 2'b10
// Branch if negative
`define ISA_BR_NEGA 2'b11