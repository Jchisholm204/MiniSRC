module Control (
    // Clock, reset and ready signals
    // Ready is an active high that allows the next step to continue
    iClk, nRst, iRdy,
    iMemData,
    // Pipe Control
    oPipe_nRst,
    // Program Counter Control
    oPC_nRst, oPC_en, oPC_jmp, oPC_loadRA, oPC_loadImm,
    // Register File Control
    oRF_Write,
    oRF_AddrA, oRF_AddrB, oRF_AddrC,
    // ALU Control
    oALU_Ctrl, oRA_en, oRB_en,
    oRZH_en, oRZL_en, oRAS_en,
    // Memory Control
    oRMA_en, oRMD_en,
    // Multiplexers
    oMUX_B, oMUX_RZHS, oMUX_WB, oMUX_MA, oMUX_AS,
    // Imm32 Output
    oImm32
);

input wire iClk, nRst, iRdy;
input wire [31:0] iMemData;
output wire oPipe_nRst;
output wire oPC_nRst, oPC_en, oPC_jmp, oPC_loadRA, oPC_loadImm;
output wire oRF_Write, oRF_AddrA, oRF_AddrB, oRF_AddrC;
output wire oALU_Ctrl, oRA_en, oRB_en;
output wire oRZH_en, oRZL_en, oRAS_en,
output wire oRMA_en, oRMD_en;
output wire oMUX_B, oMUX_RZHS, oMUX_WB, oMUX_MA, oMUX_AS;
output wire [31:0] oImm32;

// IR
wire IR_en;
wire [31:0] IR_out;
REG32 IR(.iClk(iClk), .nRst(nRst), .iEn(IR_en), .iD(iMemData), .oQ(IR_out));

// Decoder IO
wire [3:0] ID_RA, ID_RB, ID_RC;
wire [4:0] ID_CODE;
wire [31:0] ID_imm32, ID_JFR, ID_JMP;

// Opcode Signatures
// R Format Instructions
localparam INS_LD  = 5'b00000;
localparam INS_LI  = 5'b00001;
localparam INS_ST  = 5'b00010;
localparam INS_ADD = 5'b00011;
localparam INS_SUB = 5'b00100;
localparam INS_AND = 5'b00101;
localparam INS_OR  = 5'b00110;
localparam INS_ROR = 5'b00111;
localparam INS_ROL = 5'b01000;
localparam INS_SRL = 5'b01001;
localparam INS_SRA = 5'b01010;
localparam INS_SLL = 5'b01011;
// I Format Instructions
localparam INS_ADDI = 5'b01100;
localparam INS_ANDI = 5'b01101;
localparam INS_ORI  = 5'b01110;
localparam INS_DIV = 5'b01111;
localparam INS_MUL = 5'b10000;
localparam INS_NEG = 5'b10001;
localparam INS_NOT = 5'b10010;
// B Format Instructions
localparam INS_BRx = 5'b10011;
// J Format Instructions
localparam INS_JAL = 5'b10100;
localparam INS_JR  = 5'b10101;
localparam INS_MFL = 5'b11000;
localparam INS_MFH = 5'b11001;
// M Format Instructions
localparam INS_NOP = 5'b11010;
localparam INS_HLT = 5'b11011;

// OpCode Wires

// Opcode Signatures
wire OPR_LD, OPR_ST;

// Load/Store Instructions


// Decoder
Decode decoder(
    .iINS(IR_out),
    .oImm32(ID_imm32),
    .oRa(ID_RA),
    .oRb(ID_RB),
    .oRc(ID_RC),
    .oJFR(ID_JFR),
    .oJMP(ID_JMP),
);

endmodule