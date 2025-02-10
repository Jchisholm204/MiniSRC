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

wire [3:0] C, O;

// wire [31:0] G, P;
// wire [32:0] C;

// // Generate the Generate and Propagate Signals
// assign G = iX & iY;
// assign P = iX | iY;
// assign C = {G | (P & C[31:0]), iCarry};
// assign oS = iX ^ iY ^ C[31:0];

generate
    genvar i;
    localparam n = 8;
    for(i = 0; i < 31; i = i + n) begin
        CLA8 add(
            .iX(iX[(i+n-1):i]),
            .iY(iY[(i+n-1):i]),
            .iCarry(iCarry),
            .oCarry(C[i/n]),
            .oS(oS[(i+n-1):i]),
            .oOverflow(O[i/n])
        );
    end
endgenerate


assign oZero = ~|oS;
assign oNegative = oS[31];
assign oOverflow = O[3];
assign oCarry = C[3];

endmodule

module CLA8(iX, iY, iCarry, oCarry, oS, oOverflow);
input wire [7:0] iX, iY;
input wire iCarry;
output wire oCarry, oOverflow;
output wire [7:0] oS;

wire [7:0] G, P;
wire [7:0] C;

// Generate the Generate and Propagate Signals
assign G = iX & iY;
assign P = iX | iY;

// Assign the Carry Signals
assign C[0] = iCarry;
// assign C[1] = G[0] | (P[0] & C[0]);
// assign C[2] = G[1] | (P[1] & G[0]) | (&P[1:0] & C[0]);
// assign C[3] = G[2] | (P[2] & G[1]) | (&P[2:1] & G[0]) | (&P[2:0] & C[0]);
// assign C[4] = G[3] | (P[3] & G[2]) | (&P[3:2] & G[1]) | (&P[3:1] & G[0]) | (&P[3:0] & C[0]);
// assign C[5] = G[4] | (P[4] & G[3]) | (&P[4:3] & G[2]) | (&P[4:2] & G[1]) | (&P[4:1] & G[0]) | (&P[4:0] & C[0]);
// assign C[6] = G[5] | (P[5] & G[4]) | (&P[5:4] & G[3]) | (&P[5:3] & G[2]) | (&P[5:2] & G[1]) | (&P[5:1] & G[0]) | (&P[5:0] & C[0]);
// assign C[7] = G[6] | (P[6] & G[5]) | (&P[6:5] & G[4]) | (&P[6:4] & G[3]) | (&P[6:3] & G[2]) | (&P[6:2] & G[1]) | (&P[6:1] & G[0]) | (&P[6:0] & C[0]);
assign oCarry = C[7];

assign C = {G | (P & C[6:0]), iCarry};

// Assign the Sum
assign oS = iX ^ iY ^ C;

// Assign the Overflow
assign oOverflow = C[7] ^ C[6];

endmodule