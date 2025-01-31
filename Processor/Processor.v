module Processor(
    iClk, nRst,
    oMemAddr, oMemData,
    iMemData, iMemRdy,
    oMemRead, oMemWrite
);

input wire iClk, nRst, iMemRdy;
output wire oMemRead, oMemWrite;
input wire [31:0] iMemData;
output wire [31:0] oMemData, oMemAddr;

wire Clk;
assign Clk = iClk & ~nRst;

// Register File IO
wire RF_nRst, RF_iWrite;
wire [3:0] RF_iAddrA, RF_iAddrB, RF_iAddrC;
wire [31:0] RF_oRegA, RF_oRegB, RF_iRegC;

// ALU IO
wire [31:0] ALU_iA, ALU_iB, ALU_oC_hi, ALU_oC_lo;
wire [4:0]  ALU_iCtrl;
wire ALU_oZero, ALU_oNeg;

// Program Counter


// Register File
RegFile RF(
    .iClk(Clk),
    .nRst(RF_nRst),
    .iWrite(RF_iWrite),
    .iAddrA(RF_iAddrA),
    .iAddrB(RF_iAddrB),
    .iAddrC(RF_iAddrC),
    .oRegA(RF_oRegA),
    .oRegB(RF_oRegB),
    .iRegC(RF_iRegC)
);

// ALU
ALU alu(
    .iA(ALU_iA),
    .iB(ALU_iB),
    .iCtrl(ALU_iCtrl),
    .oC_hi(ALU_oC_hi),
    .oC_lo(ALU_oC_lo),
    .oZero(ALU_oZero),
    .oNeg(ALU_oNeg)
);

// Memory


endmodule