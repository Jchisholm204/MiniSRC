module SevenSeg(
    iNum,
    oSeg
);
input wire [3:0] iNum;
output reg [6:0] oSeg;

always @(iNum) begin
    case(iNum)
        4'h0: oSeg = 7'b1000000;
        4'h1: oSeg = 7'b1111001;
        4'h2: oSeg = 7'b0100100;
        4'h3: oSeg = 7'b0110000;
        4'h4: oSeg = 7'b0011001;
        4'h5: oSeg = 7'b0010010;
        4'h6: oSeg = 7'b0000010;
        4'h7: oSeg = 7'b1111000;
        4'h8: oSeg = 7'b0000000;
        4'h9: oSeg = 7'b0010000;
        4'hA: oSeg = 7'b0001000;
        4'hB: oSeg = 7'b0000011;
        4'hC: oSeg = 7'b1000110;
        4'hD: oSeg = 7'b0100001;
        4'hE: oSeg = 7'b0000110;
        4'hF: oSeg = 7'b0001110;
    endcase
end

