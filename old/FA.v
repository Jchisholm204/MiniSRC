module FA (
    iA, iB,
    iCarry, oCarry,
    oSum
);

input wire iA, iB, iCarry;
output wire oCarry, oSum;

wire prop;

assign prop = iA ^ iB;
assign oSum = prop ^ iCarry;
assign oCarry = (iA & iB) | (prop & iCarry);

endmodule
