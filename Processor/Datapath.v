module Datapath(
    // Clock and reset signals (reset is active low)
    iClk, nRst,
    // Memory Signals
    iMemData,
    oMemAddr, oMemData,
    // Program Counter Control
    iPC_nRst, iPC_en, iPC_jmp, iPC_loadRA, iPC_loadImm,
    // Register File Control
    iRF_Write,
    iRF_AddrA, iRF_AddrB, iRF_AddrC,
    // Write Back Register Control
    iRWB_en,
    // ALU Control
    iALU_Ctrl, iRA_en, iRB_en,
    iRZH_en, iRZL_en, iRAS_en,
    // Jump Feedback
    oJ_zero, oJ_nZero, oJ_pos, oJ_neg,
    // ALU Results
    oALU_neg, oALU_zero,
    // Memory Control
    iRMA_en, iRMD_en,
    // Multiplexers
    iMUX_BIS, // ALU B Input/Immediate Select
    iMUX_RZHS, // ALU Result High Select
    iMUX_WBM, // Write back in Memory Select
    iMUX_MAP, // Memory Address out PC Select
    iMUX_ASS, // ALU Storage Select
    iMUX_WBP, // Write back Program Counter Select
    // Imm32 Output
    iImm32
);

`include "constants.vh"

input wire iClk, nRst;
// Memory Signals
input wire [31:0] iMemData;
output wire [31:0] oMemData, oMemAddr;
// Program Counter Control
input wire iPC_nRst, iPC_en, iPC_jmp, iPC_loadRA, iPC_loadImm;
// Register File Control
input wire iRF_Write;
input wire [3:0] iRF_AddrA, iRF_AddrB, iRF_AddrC;
// Write Back Register Control
input wire iRWB_en;
// ALU Control
input wire [3:0] iALU_Ctrl;
input wire iRA_en, iRB_en;
input wire iRZH_en, iRZL_en, iRAS_en;
output wire oALU_neg, oALU_zero;
// Jump Feedback
output wire oJ_zero, oJ_nZero, oJ_pos, oJ_neg,
// Memory Control
input wire iRMA_en, iRMD_en;
// Multiplexers
input wire iMUX_BIS, iMUX_RZHS, iMUX_WBM, iMUX_MAP, iMUX_ASS, iMUX_WBP;
// Imm32 Output
input wire [31:0] iImm32;

// Internal Clock Signal
wire Clk;
assign Clk = iClk & nRst;

// Program Counter Signals
wire [31:0] PC_out, PC_tOut;

// Register File IO
wire [31:0] RF_oRegA, RF_oRegB, RF_iRegC;
wire [31:0] RWB_in;

// ALU IO
wire [31:0] ALU_iA, ALU_iB, ALU_oC_hi, ALU_oC_lo;

// ALU Immediate Registers
wire [31:0] RA_out, RB_out;
wire [31:0] RZH_out, RZL_out, RZ_out;
// ALU Storage Registers
wire [31:0] RASH_out, RASL_out, RAS_out;
// ALU Output
wire [31:0] RZX_out;

// Program Counter
PC #(.StartAddr(`START_PC_ADDRESS)) pc(
    .iClk(Clk),
    .iEn(iPC_en),
    .nRst(iPC_nRst),
    .iJmpEn(iPC_jmp),
    .iLoadRA(iPC_loadRA),
    .iLoadImm(iPC_loadImm),
    .iRA(RA_out),
    .iImm32(iImm32),
    .oPC(PC_out),
    .oPC_tmp(PC_tOut)
);


// Register File
RegFile RF(
    .iClk(Clk),
    .nRst(nRst),
    .iWrite(iRF_Write),
    .iAddrA(iRF_AddrA),
    .iAddrB(iRF_AddrB),
    .iAddrC(iRF_AddrC),
    .oRegA(RF_oRegA),
    .oRegB(RF_oRegB),
    .iRegC(RF_iRegC)
);

// Jump Outputs
// RB is linked to RA in the ISA
assign oJ_zero = (RF_oRegB == 32'd0);
assign oJ_nZero = |RF_oRegB;
assign oJ_pos   = ~RF_oRegB[31] && oJ_nZero;
assign oJ_neg   = RF_oRegB[31] && oJ_nZero;

// RF stationary/buffer registers
REG32 RA(.iClk(Clk), .nRst(nRst), .iEn(iRA_en), .iD(RF_oRegA), .oQ(RA_out));
REG32 RB(.iClk(Clk), .nRst(nRst), .iEn(iRB_en), .iD(RF_oRegB), .oQ(RB_out));

// ALU Input Multiplexers

assign ALU_iA = RA_out;
assign ALU_iB = iMUX_BIS ? iImm32 : RB_out;

// ALU
ALU alu(
    .iA(ALU_iA),
    .iB(ALU_iB),
    .iCtrl(iALU_Ctrl),
    .oC_hi(ALU_oC_hi),
    .oC_lo(ALU_oC_lo),
    .oZero(oALU_zero),
    .oNeg(oALU_neg)
);

// ALU Result Registers
REG32 RZH(.iClk(Clk), .nRst(nRst), .iEn(iRZH_en), .iD(ALU_oC_hi), .oQ(RZH_out));
REG32 RZL(.iClk(Clk), .nRst(nRst), .iEn(iRZL_en), .iD(ALU_oC_lo), .oQ(RZL_out));

// ALU Storage Registers - Persist data until reset or next H/L transaction
REG32 RASH(.iClk(Clk), .nRst(nRst), .iEn(iRAS_en), .iD(ALU_oC_hi), .oQ(RASH_out));
REG32 RASL(.iClk(Clk), .nRst(nRst), .iEn(iRAS_en), .iD(ALU_oC_lo), .oQ(RASL_out));

// 32 bit ALU result selection
assign RAS_out = iMUX_RZHS ? RASH_out : RASL_out;
assign RZ_out  = iMUX_RZHS ? RZH_out : RZL_out;
// Select between storage or current registers
assign RZX_out = iMUX_ASS ? RAS_out : RZ_out;

// Memory
assign oMemAddr = iMUX_MAP ? PC_out : RZX_out ;
assign oMemData = RB_out;

// Write Back
// Select Memory input on WBM, Select PC for JAL, otherwise use ALU result
assign RWB_in = iMUX_WBM ? iMemData :
                iMUX_WBP ? PC_out   : RZX_out;

// Write back buffer register
REG32 RWB(.iClk(iClk), .nRst(pipe_rst), .iEn(iRWB_en), .iD(RWB_in), .oQ(RF_iRegC));

endmodule
