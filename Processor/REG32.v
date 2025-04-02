module REG32 #(parameter RESET = 32'd0)(
    iClk,
    nRst, iEn,
    iD, oQ
);

input wire iClk, nRst, iEn;
input wire [31:0] iD;
output reg [31:0] oQ;

always@(posedge iClk or negedge nRst)
begin
    if(!nRst)
        oQ <= RESET;
    else begin
        if(iEn) oQ <= iD;
    end
end

endmodule

