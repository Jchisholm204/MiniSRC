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
wire INS_R, INS_I, INS_B, INS_J, INS_M;
wire INS_MEM, INS_ADD, INS_SUB, INS_AND,
     INS_DEV, INS_MUL, INS_NOT, INS_OR,
     INS_SRL, INS_SRA, INS_SLL, INS_ROR,
     INS_ROL, INS_MFx, INS_BRx, INS_Jxx;

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