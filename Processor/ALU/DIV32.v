module DIV32(
    iQ, iD,
    oQ, oR
);

input wire [31:0] iQ, iD;
output wire [31:0] oQ, oR;

wire [31:0] Q;
wire [31:0] A[31:0];

// Initialize the first partial remainder as 0
assign A[0] = 32'd0;

// Create 31 divisor levels
generate
    genvar i;
    for(i = 0; i < 31; i = i + 1) begin
        DIV_LEVEL divlvl (
            .iA(A[i]),
            .iQ(iQ[31-i]),
            .iD(iD),
            .oA(A[i+1]),
            .oQ(Q[31-i])
        );
    end
endgenerate

// Final divisor Level
wire [31:0] shift, X;

assign shift = {A[31][30:0], iQ[0]};
assign X = shift[31] ? shift + iD : shift - iD;
assign Q[0] = ~X[31];

// Remainder and output assignments
assign oR = X[31] ? X + iD : X;
assign oQ = Q;

endmodule

module DIV_LEVEL(
    iA, iQ, iD,
    oA, oQ
);

input wire [31:0] iA, iD;
input wire iQ;
output wire [31:0] oA;
output wire oQ;

wire [31:0] shift;

// Shift in the next bit of the quotient
assign shift = {iA[30:0], iQ};
// Add or subtract the divisor
assign oA = shift[31] ? shift + iD : shift - iD;
// Output 1 to result if the add/sub result was positive
assign oQ = ~oA[31];

endmodule