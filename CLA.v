// Carry Lookahead Adder
module CLA(
    iX,
    iY,
    iCarry,
    oS,
    oCarry,
    oOverflow,
    oZero,
    oNegative
);

input wire iCarry;
input wire [31:0] iX, iY;
output wire [31:0] oS;
output wire oCarry, oOverflow, oZero, oNegative;

wire [31:0] G, P;
wire [32:0] C;

assign G = iX & iY;
assign P = iX | iY;
assign C = {G | (P & C[31:0]), iCarry};
assign oS = iX ^ iY ^ C[31:0];

assign oCarry = C[32];
assign oOverflow = C[32] ^ C[31];
assign oZero = ~|oS;
assign oNegative = oS[31];

endmodule

input wire iCarry;
input wire [31:0] iX, iY;
output wire [31:0] oS;
output wire oCarry, oOverflow, oZero, oNegative;

wire [31:0] G, P;
wire [32:0] C;

assign G = iX & iY;
assign P = iX | iY;
assign C = {G | (P & C[31:0]), iCarry};
assign oS = iX ^ iY ^ C[31:0];

assign oCarry = C[32];
assign oOverflow = C[32] ^ C[31];
assign oZero = ~|oS;
assign oNegative = oS[31];
