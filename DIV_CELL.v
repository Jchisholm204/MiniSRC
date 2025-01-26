module DIV_CELL(
    iA, iB, 
    iMode, oMode,
    iCarry, oCarry,
    oSum, oB,
);

input wire iA, iB, iMode, iCarry;
output wire oMode, oCarry, oSum, oB;

wire B;
assign oMode = ~iMode;
assign B = iB;
assign oB = ~B;

FA adder(
    .iB(iMode ^ B),
    .iB(iA),
    .iCarry(iCarry),
    .oCarry(oCarry),
    .oSum(oSum)
);


endmodule

