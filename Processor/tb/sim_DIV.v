`timescale 1ms/1ps
module sim_DIV();

reg [3:0] Q, D;
wire [3:0] rez, rmdr;

wire Clk;
wire nRst;
reg regnRst = 1'b1;
reg divrst = 1'b0;

assign nRst = regnRst;

ClockGenerator #( // Generic Constants
    .ClockFrequency(200e3)) 
     cg1 ( // Port Assignments
    .nRst(nRst), 
    .oClk(Clk)
);

DIV divider(
    .iClk(Clk),
    .nRst(divrst),
    .iQ(Q),
    .iM(D),
    .oQ(rez),
    .oR(rmdr)
);

initial begin
    // #20 regnRst = 1'b1;
    // #20 regnRst = 1'b0;
    divrst = 1'b0;
    Q = 4'd7;
    D = 4'd3;
    #1
    divrst = 1'b1;
    #1
    Q = 4'd4;
    D = 4'd2;
    #1
    divrst = 1'b0;
    #1
    divrst = 1'b1;
    #1
    divrst = 1'b0;
    Q = 4'd3;
    D = 4'd3;
    #1
    divrst = 1'b1;
    #100
    divrst = 1'b1;
end


endmodule