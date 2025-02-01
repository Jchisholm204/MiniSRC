module PC #(
    parameter StartAddr = 32'h00000000
) (
    iClk,
    iEn, nRst,
    iJmpEn, iLoadRA, iLoadImm,
    iRA, iImm32,
    oPC,
    oPC_tmp,
);

input wire iClk, iEn, nRst;
input wire iJmpEn, iLoadRA, iLoadImm;
input wire [31:0] iRA, iImm32;
output wire [31:0] oPC, oPC_tmp;

wire [31:0] pc_out, pc_tmp_out, add_in, add_out, pc_in;

// PC Adder Selection
assign add_in = iJmpEn ? iImm32 : 32'h00000004;

CLA pc_adder(
    .iX(add_in),
    .iY(pc_cur),
    .iCarry(1'b0),
    .oS(add_out),
    // Intentionally leave these ports unconnected
    .oCarry(),
    .oOverflow(),
    .oZero(),
    .oNegative()
);

// PC Input Selection
assign pc_in  = iLoadImm ? iImm32 :
                iLoadRA  ? iRA    :
                add_out;

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
    .iEn(iEn && (iLoadImm || iLoadRA)),
    .iD(pc_out),
    .oQ(pc_tmp_out)
);

assign oPC = pc_out;
assign oPC_tmp = pc_tmp_out;

endmodule