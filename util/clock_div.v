module clock_div #(parameter div = 32'd5)(
    iClk, nRst,
    oClk
);

input wire iClk, nRst;
output reg oClk;

reg [31:0] count;

always @(posedge iClk, negedge nRst) begin
    if(~nRst) begin 
        oClk = 1'b0;
        count = 32'd0;
    end
    else begin
        count = count + 32'd1;
        if(count == div) begin
            count = 32'd0;
            oClk = ~oClk;
        end
    end
end

endmodule