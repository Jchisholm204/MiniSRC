module SevSegs(
    iNum,
    oSeg1,
    oSeg2,
    oSeg3,
    oSeg4,
    oSeg5,
    oSeg6,
    oSeg7,
    oSeg8
);

input wire [31:0] iNum;
output wire [6:0] oSeg1, oSeg2, oSeg3, oSeg4, oSeg5, oSeg6, oSeg7, oSeg8;

SevenSeg s1(
    .iNum(iNum[3:0]),
    .oSeg(oSeg1)
);
SevenSeg s2(
    .iNum(iNum[7:4]),
    .oSeg(oSeg2)
);
SevenSeg s3(
    .iNum(iNum[11:8]),
    .oSeg(oSeg3)
);
SevenSeg s4(
    .iNum(iNum[15:12]),
    .oSeg(oSeg4)
);
SevenSeg s5(
    .iNum(iNum[19:16]),
    .oSeg(oSeg5)
);
SevenSeg s6(
    .iNum(iNum[23:20]),
    .oSeg(oSeg6)
);
SevenSeg s7(
    .iNum(iNum[27:24]),
    .oSeg(oSeg7)
);
SevenSeg s8(
    .iNum(iNum[31:28]),
    .oSeg(oSeg8)
);

endmodule