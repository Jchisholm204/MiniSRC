`timescale 1ns/1ps
module sim_SHIFT();

reg [31:0] IN;
reg [4:0] sham = 5'd0;
reg nArith = 1'b1;
reg nLeft = 1'b1;
wire [31:0] RESULT;

SHIFT shifter(
    .iD(IN),
    .iShamt(sham),
    .nArith(nArith),
    .nLeft(nLeft),
    .oD(RESULT)
);

initial begin
    IN = 32'd3;
    #1
    sham = 5'd1;
    #1
    sham = 5'd2;
    #1
    sham = 5'd3;
    #1
    IN = 32'hF000;
    nLeft = 1'b0;
    #1
    nLeft = 1'b1;
    nArith = 1'b0;
    IN = 32'hFFFFFF11;
    #10
    IN = 32'hFFFFFF11;
end

endmodule