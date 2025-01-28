module DIV4(
    oQ, oR,
    iQ, iD
);

output wire [3:0] oQ, oR;
input wire [3:0] iQ, iD;

wire [3:0] s1, s2, s3, s4, s5;
wire [3:0] A1, A2, A3, A4, A5;

assign s1 = {3'd0, iQ[3]};
assign A1 = s1[3] ? s1 + iD : s1 - iD;

assign s2 = {A1[2:0], iQ[2]};
assign A2 = s2[3] ? s2 + iD : s2 - iD;

assign s3 = {A2[2:0], iQ[1]};
assign A3 = s3[3] ? s3 + iD : s3 - iD;

assign s4 = {A3[2:0], iQ[0]};
assign A4 = s4[3] ? s4 + iD : s4 - iD;

// Final Restore
assign A5 = s4[3] ? s4 + iD : s4;

// Remainder bits are in the A register
assign oR = A5;
// Addition or subtraction feeds the result
assign oQ = {~A1[3], ~A2[3], ~A3[3], ~A4[3]};

endmodule

