module PC #(
    parameter StartAddr = 32'h00000000
) (
    iClk,
    iEn, nRst,
    iLoadEn, iOffsetEn,
    iLoad, iOffset,
    oPC,
    oPC_tmp
);
`include "../constants.vh"

input wire iClk, iEn, nRst;
input wire iLoadEn, iOffsetEn;
input wire [31:0] iLoad, iOffset;
output wire [31:0] oPC, oPC_tmp;

wire [31:0] pc_out, pc_tmp_out, add_in, add_out, pc_in;

// PC Adder Selection
assign add_in = iOffsetEn ? iOffset : `PC_INCREMENT;

CLA pc_adder(
    .iX(add_in),
    .iY(pc_out),
    .iCarry(1'b0),
    .oS(add_out),
    // Intentionally leave these ports unconnected
    .oCarry(),
    .oOverflow(),
    .oZero(),
    .oNegative()
);

// PC Input Selection
assign pc_in  = iLoadEn ? iLoad : add_out;

REG32 #(.RESET(StartAddr)) pc(
    .iClk(iClk),
    .nRst(nRst),
    .iEn(iEn),
    .iD(pc_in),
    .oQ(pc_out)
);

REG32 pc_tmp(
    .iClk(iClk),
    .nRst(nRst),
    .iEn(iEn && (iLoadEn || iOffsetEn)),
    .iD(add_out),
    .oQ(pc_tmp_out)
);

assign oPC = pc_out;
assign oPC_tmp = pc_tmp_out;

endmodule