module vga_interface(
    iClk_50,
    nRst,
    iCR,
    iAddr,
    iWrite,
    oVGA_R,
    oVGA_G,
    oVGA_B,
    oVGA_Clk,
    oVGA_Blank,
    oVGA_HSync,
    oVGA_VSync,
    oVGA_Sync
);

parameter MID_X = 16'd320;
parameter MID_Y = 16'd240;


input wire iClk_50, nRst, iWrite;
input wire [31:0] iCR, iAddr;
output wire [9:0] oVGA_R, oVGA_G, oVGA_B;
output wire oVGA_Clk, oVGA_Blank, oVGA_Sync, oVGA_HSync, oVGA_VSync;

wire TL_en, TR_en, BL_en, BR_en;
wire [31:0] TL_out, TR_out, BL_out, BR_out;
wire T, L;
wire [31:0] CR_out, CR_Addr;
wire [15:0] X, Y;


REG32 TL(.iClk(iClk_50), .nRst(nRst), .iEn(TL_en), .iD(iCR), .oQ(TL_out));
REG32 TR(.iClk(iClk_50), .nRst(nRst), .iEn(TR_en), .iD(iCR), .oQ(TR_out));
REG32 BL(.iClk(iClk_50), .nRst(nRst), .iEn(BL_en), .iD(iCR), .oQ(BL_out));
REG32 BR(.iClk(iClk_50), .nRst(nRst), .iEn(BR_en), .iD(iCR), .oQ(BR_out));

assign TL_en = (iAddr[1:0] == 2'b00) && iWrite;
assign TR_en = (iAddr[1:0] == 2'b01) && iWrite;
assign BL_en = (iAddr[1:0] == 2'b10) && iWrite;
assign BR_en = (iAddr[1:0] == 2'b11) && iWrite;

assign X = CR_Addr[15:0];
assign Y = CR_Addr[31:16];

assign T = (Y < MID_Y);
assign L = (X < MID_X);

assign CR_out = T ? (L ? TL_out : TR_out) : (L ? BL_out : BR_out);

module vga_controller(
    .iClk_50(iClk_50),
    .nRst(nRst),
    .iVGA_colorData(CR_out),
    .oVGA_colorAddress(CR_Addr),
    .oVGA_R(oVGA_R),
    .oVGA_G(oVGA_G),
    .oVGA_B(oVGA_B),
    .oVGA_Clk(oVGA_Clk),
    .oVGA_Blank(oVGA_Blank),
    .oVGA_HSync(oVGA_HSync),
    .oVGA_VSync(oVGA_VSync),
    .oVGA_Sync(oVGA_Sync)
);

endmodule
