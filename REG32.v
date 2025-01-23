module REG32(
    iClk,
    nRst, iEn,
    iD, oQ
);

input wire iClk, nRst, iEn;
input wire [31:0] iD;
output reg [31:0] oQ;

always@(posedge iClk or negedge nRst)
begin
    if(!nRst) oQ = 32'd0;
    else begin
        if(iEn) oQ = iD;
    end
end

endmodule

