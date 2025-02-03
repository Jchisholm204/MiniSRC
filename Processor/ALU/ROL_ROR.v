module ROL(
    iD, iShamt,
    oD
);

input wire [31:0] iD;
input wire [4:0]  iShamt;
output wire [31:0] oD;

wire [31:0] S1, S2, S3, S4, S5;

assign S1 = iShamt[0] ? {iD[30:0],  iD[31]}    : iD;
assign S2 = iShamt[1] ? {S1[29:0],  S1[31:30]} : S1;
assign S3 = iShamt[2] ? {S2[27:0],  S2[31:28]} : S2;
assign S4 = iShamt[3] ? {S3[23:0],  S3[31:24]} : S3;
assign S5 = iShamt[4] ? {S4[15:0],  S4[31:16]} : S4;

assign oD = S5;

endmodule

module ROR(
    iD, iShamt,
    oD
);

input wire [31:0] iD;
input wire [4:0]  iShamt;
output wire [31:0] oD;

wire [31:0] S1, S2, S3, S4, S5;

assign S1 = iShamt[0] ? {iD[0],     iD[31:1]}  : iD;
assign S2 = iShamt[1] ? {S1[1:0],   S1[31:2]}  : S1;
assign S3 = iShamt[2] ? {S2[3:0],   S2[31:4]}  : S2;
assign S4 = iShamt[3] ? {S3[7:0],   S3[31:8]}  : S3;
assign S5 = iShamt[4] ? {S4[15:0],  S4[31:16]} : S4;

assign oD = S5;

endmodule
