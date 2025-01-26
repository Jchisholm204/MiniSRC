module Mux2_1_32b(in0, in1, sel, out);

input wire [31:0] in0, in1;
input wire sel;
output wire [31:0] out;

assign out = ({32{~sel}} & in0) | ({32{sel}} & in1);

endmodule

module Mux2_1_4b(in0, in1, sel, out);

input wire [3:0] in0, in1;
input wire sel;
output wire [3:0] out;

assign out = (sel == 0) ? in0 : in1;

endmodule

module Mux4_1_32b (
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire [31:0] in3,
    input wire [1:0] sel, 
    output wire [31:0] out
);

assign out =    (sel == 2'b00) ? in0 :
                (sel == 2'b01) ? in1 :
                (sel == 2'b10) ? in2 :
                (sel == 2'b11) ? in3 :
                32'd0; // Default output 
endmodule

module Mux4_1_4b (
    input wire [3:0] in0,
    input wire [3:0] in1,
    input wire [3:0] in2,
    input wire [3:0] in3,
    input wire [1:0] sel, 
    output wire [3:0] out
);

assign out =    (sel == 2'b00) ? in0 :
                (sel == 2'b01) ? in1 :
                (sel == 2'b10) ? in2 :
                (sel == 2'b11) ? in3 :
                4'd0; // Default output 
endmodule

module Mux5_1_32b (
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire [31:0] in3,
    input wire [31:0] in4,
    input wire [31:0] in5,
    input wire [2:0] sel, 
    output wire [31:0] out
);

assign out =    (sel == 3'b000) ? in0 :
                (sel == 3'b001) ? in1 :
                (sel == 3'b010) ? in2 :
                (sel == 3'b011) ? in3 :
                (sel == 3'b100) ? in4 :
                (sel == 3'b101) ? in5 :
                32'd0; // Default output 
endmodule

module Mux16_1_32b (
    input wire [31:0] in0,  // Input 0
    input wire [31:0] in1,  // Input 1
    input wire [31:0] in2,  // Input 2
    input wire [31:0] in3,  // Input 3
    input wire [31:0] in4,  // Input 4
    input wire [31:0] in5,  // Input 5
    input wire [31:0] in6,  // Input 6
    input wire [31:0] in7,  // Input 7
    input wire [31:0] in8,  // Input 8
    input wire [31:0] in9,  // Input 9
    input wire [31:0] in10, // Input 10
    input wire [31:0] in11, // Input 11
    input wire [31:0] in12, // Input 12
    input wire [31:0] in13, // Input 13
    input wire [31:0] in14, // Input 14
    input wire [31:0] in15, // Input 15
    input wire [3:0] sel,   // 4-bit selector
    output wire [31:0] out // 32-bit output
);

    // Wire-based logic for combinational 32-bit MUX
    assign out = (sel == 4'b0000) ? in0  :
                 (sel == 4'b0001) ? in1  :
                 (sel == 4'b0010) ? in2  :
                 (sel == 4'b0011) ? in3  :
                 (sel == 4'b0100) ? in4  :
                 (sel == 4'b0101) ? in5  :
                 (sel == 4'b0110) ? in6  :
                 (sel == 4'b0111) ? in7  :
                 (sel == 4'b1000) ? in8  :
                 (sel == 4'b1001) ? in9  :
                 (sel == 4'b1010) ? in10 :
                 (sel == 4'b1011) ? in11 :
                 (sel == 4'b1100) ? in12 :
                 (sel == 4'b1101) ? in13 :
                 (sel == 4'b1110) ? in14 :
                 (sel == 4'b1111) ? in15 :
                 32'd0; // Default output

endmodule
