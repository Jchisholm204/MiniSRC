module DIV_CELL(
    iA, iB, 
    iMode, oMode,
    iCarry, oCarry,
    oSum, oB
);

input wire iA, iB, iMode, iCarry;
output wire oMode, oCarry, oSum, oB;

wire B;
assign oMode = ~iMode;
assign B = iMode ^ iB;
assign oB = ~iB;

FA adder(
    .iB(B),
    .iA(iA),
    .iCarry(iCarry),
    .oCarry(oCarry),
    .oSum(oSum)
);


endmodule

