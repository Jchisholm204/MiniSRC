module miniSRC(
    iCLK_50, iCLK_27,
    iSW, iKEY,
    oHEX0, oHEX1, oHEX2, oHEX3, oHEX4, oHEX5, oHEX6, oHEX7,
    oLEDR, oLEDG,
    oVGA_R,
    oVGA_G,
    oVGA_B,
    oVGA_Clk,
    oVGA_Blank,
    oVGA_HSync,
    oVGA_VSync,
    oVGA_Sync
);

input wire iCLK_50, iCLK_27;
input wire [17:0] iSW;
input wire [3:0] iKEY;
output wire [6:0] oHEX0, oHEX1, oHEX2, oHEX3, oHEX4, oHEX5, oHEX6, oHEX7;
output wire [17:0] oLEDR;
output wire [7:0] oLEDG;
output wire [9:0] oVGA_R, oVGA_G, oVGA_B;
output wire oVGA_Clk, oVGA_Blank, oVGA_Sync, oVGA_HSync, oVGA_VSync;

wire Clk, nRst;
wire [31:0] proc_mem_addr, proc_mem_out, proc_mem_in;
wire proc_mem_read, proc_mem_write;
wire [31:0] proc_port_out, proc_port_in;

assign oLEDR = proc_mem_addr[19:2];

assign proc_port_in = {14'd0, iSW};

clock_div cd_main(
    .iClk(iCLK_50),
    .nRst(nRst),
    .oClk(Clk)
);

// assign Clk = iCLK_50;

// clock_div #(.div(8'hFF)) cd_main(
//     .iClk(iCLK_50),
//     .nRst(nRst),
//     .oClk(Clk)
// );

debounce rst_db(
    .iClk(iCLK_50),
    .iBtn(iKEY[0]),
    .oBtn(nRst)
);

Processor proc(
    .iClk(Clk),
    .nRst(nRst),
    .oMemAddr(proc_mem_addr),
    .oMemData(proc_mem_out),
    .iMemData(proc_mem_in),
    .iMemRdy(1'b1),
    .oMemRead(proc_mem_read),
    .oMemWrite(proc_mem_write),
    .iPORT(proc_port_in),
    .oPORT(proc_port_out)
);

// Memory Select Wires
wire mems_dimem, mems_vga;

assign mems_dimem = proc_mem_addr[31:30] == 2'b00;
assign mems_vga = proc_mem_addr[31:30] == 2'b01;

memory mem(
    .iClk(Clk),
    .iRead(proc_mem_read & mems_dimem), 
    .iWrite(proc_mem_write & mems_dimem),
    .iData(proc_mem_out),
    .iAddr(proc_mem_addr),
    .oData(proc_mem_in)
);

vga_interface vga(
    .iClk_50(iClk_50),
    .nRst(nRst),
    .iCR(proc_mem_out),
    .iAddr(proc_mem_addr),
    .iWrite(proc_mem_write & mems_vga),
    .oVGA_R(oVGA_R),
    .oVGA_G(oVGA_G),
    .oVGA_B(oVGA_B),
    .oVGA_Clk(oVGA_Clk),
    .oVGA_Blank(oVGA_Blank),
    .oVGA_HSync(oVGA_HSync),
    .oVGA_VSync(oVGA_VSync),
    .oVGA_Sync(oVGA_Sync)
);

SevSegs hex_disp(
    .iNum(proc_port_out),
    .oSeg1(oHEX0),
    .oSeg2(oHEX1),
    .oSeg3(oHEX2),
    .oSeg4(oHEX3),
    .oSeg5(oHEX4),
    .oSeg6(oHEX5),
    .oSeg7(oHEX6),
    .oSeg8(oHEX7)
);


endmodule
