`timescale 1ms/1ps
module sim_DIV4();

reg [3:0] Q, D;
wire [3:0] rez, rmdr;


DIV4 divider(
    .iQ(Q),
    .iD(D),
    .oQ(rez),
    .oR(rmdr)
);

initial begin
    // #20 regnRst = 1'b1;
    // #20 regnRst = 1'b0;
    Q = 4'd7;
    D = 4'd3;
    #1
    Q = 4'd4;
    D = 4'd2;
    #1
    Q = 4'd3;
    D = 4'd3;
end


endmodule
