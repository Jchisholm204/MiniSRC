module DIV(
    iA, iB, oQ, oR
);

input wire [3:0] iA, iB;
output wire [3:0] oQ, oR;


wire [6:0] div = {iA, 3'b000};
wire [3:0] res;

wire [3:0] bout1, bout2, bout3, bout4;
wire [3:0] sum1, sum2, sum3, sum4;

assign oQ = res;
assign oR = res[0] ? sum4 : sum4 + bout4;

DIV_LEVEL l1(
    .iA(div[6:3]),
    .iB(iB),
    .iMode(1'b1),
    .oQ(res[3]),
    .oR(sum1),
    .oB(bout1)
);

DIV_LEVEL l2(
    .iA({sum1[3:1], div[2]}),
    .iB(bout1),
    .iMode(res[3]),
    .oQ(res[2]),
    .oR(sum2),
    .oB(bout2)
);

DIV_LEVEL l3(
    .iA({sum2[3:1], div[1]}),
    .iB(bout2),
    .iMode(res[2]),
    .oQ(res[1]),
    .oR(sum3),
    .oB(bout3)
);

DIV_LEVEL l4(
    .iA({sum3[3:1], div[0]}),
    .iB(bout2),
    .iMode(res[1]),
    .oQ(res[0]),
    .oR(sum4),
    .oB(bout4)
);


endmodule

module DIV_LEVEL(
    iA, iB,
    iMode,
    oQ, oR, oB
);

input wire [3:0] iA, iB;
input wire iMode;
output wire [3:0] oR;
output wire oQ;
output wire [3:0] oB;

wire [4:0] mode;
assign mode[0] = iMode;
wire [3:0] cout;

DIV_CELL i1(
    .iA(iA[3]),
    .iB(iB[3]),
    .iMode(mode[0]),
    .oMode(mode[1]),
    .iCarry(cout[1]),
    .oCarry(cout[0]),
    .oSum(oR[0]),
    .oB(oB[0])
);

DIV_CELL i2(
    .iA(iA[2]),
    .iB(iB[2]),
    .iMode(mode[1]),
    .oMode(mode[2]),
    .iCarry(cout[2]),
    .oCarry(cout[1]),
    .oSum(oR[1]),
    .oB(oB[1])
);

DIV_CELL i3(
    .iA(iA[1]),
    .iB(iB[1]),
    .iMode(mode[2]),
    .oMode(mode[3]),
    .iCarry(cout[3]),
    .oCarry(cout[2]),
    .oSum(oR[2]),
    .oB(oB[2])
);

DIV_CELL i4(
    .iA(iA[0]),
    .iB(iB[0]),
    .iMode(mode[3]),
    .oMode(mode[4]),
    .iCarry(mode[4]),
    .oCarry(cout[3]),
    .oSum(oR[3]),
    .oB(oB[3])
);

endmodule