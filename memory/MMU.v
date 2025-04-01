module MMU(
    iClk, iRead, iWrite,
    iData, iAddr,
    oData
);

input wire iClk, iRead, iWrite;
input wire [31:0] iData, iAddr;
output wire [31:0] oData;


memory mem(
    .iClk(iClk),
    .iRead(iRead), 
    .iWrite(iWrite),
    .iData(iData),
    .iAddr(iAddr),
    .oData(oData)
);

endmodule