`timescale 1ns/1ns

module ClockGeneratorTB();

wire Clk;
wire nRst;
reg regnRst = 1'b0;

assign nRst = regnRst;

// Example instantiation of a module
ClockGenerator #( // Generic Constants
    .ClockFrequency(200e6)) 
     cg1 ( // Port Assignments
    .nRst(nRst), 
    .oClk(Clk)
);

always begin
    #20 regnRst = 1'b1;
    #20 regnRst = 1'b0;
end
endmodule