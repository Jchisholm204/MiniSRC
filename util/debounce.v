module debounce(
    iClk,
    iBtn,
    oBtn
);

input wire iClk, iBtn;
output reg oBtn;

reg [7:0] count;

always @(posedge iClk) begin
    if(iBtn)
        if(count != 8'hFF)
            count = count + 8'h01;
        else oBtn = 1'b1;
    if(~iBtn) begin
        count = 8'h00;
        oBtn = 1'b0;
    end
end

endmodule