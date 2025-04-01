module clock_div #(parameter div = 1)(
    iClk, nRst,
    oClk
);

input wire iClk, nRst;
output reg oClk;

reg [7:0] count;

always @(posedge iClk, negedge nRst) begin
    if(~nRst) begin 
        oClk = 1'b0;
        count = 8'h00;
    end
    else begin
        count = count + 8'h01;
        if(count == div) begin
            count = 8'h00;
            oClk = ~oClk;
        end
    end
end

endmodule