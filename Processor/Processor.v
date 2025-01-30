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

// Register File
wire RF_nRst, RF_iWrite;
wire [3:0] RF_iAddrA, RF_iAddrB, RF_iAddrC;
wire [31:0] RF_oRegA, RF_oRegB, RF_iRegC;

// Control Unit

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

// Memory


endmodule