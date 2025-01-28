module DIV32(
    iQ, iD,
    oQ, oR
);

input wire [31:0] iQ, iD;
output wire [31:0] oQ, oR;

wire [31:0] Q;
wire [31:0] A[31:0];

assign A[0] = 32'd0;

generate
    genvar i;
    for(i = 0; i < 32; i = i + 1) begin
        DIV_LEVEL divlvl (
            .iA(A[i]),
            .iQ(iQ[31-i]),
            .iD(iD),
            .oA(A[i+1]),
            .oQ(Q[31-i])
        );
    end
endgenerate


assign oR = A[30][31] ? A[30] + iD : A[30];
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

assign shift = {iA[30:0], iQ};
assign oA = shift[31] ? shift + iD : shift - iD;

assign oQ = ~oA[31];

endmodule