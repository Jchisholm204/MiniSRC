module Processor(
    iClk,
    nRst,
    mem_data_out,
    mem_data_in,
    mem_addr,
    instrucition_mem_in
);
    input wire iClk, nRst;
    input wire [31:0] mem_data_in, instrucition_mem_in;
    output wire [31:0] mem_data_out, mem_addr;

    wire ra_enable, rb_enable, rz0_enable, rz1_enable, rm_enable, ir_enable, ry_enable;
    wire mb_select;
    wire rf_write;
    wire [1:0] my_select, mc_select;
    wire [3:0] alu_control;

    assign nRst = 1;

    REG32 ir(
        .iClk(iClk),
        .iEn(ir_enable),
        .nRst(1'b0),                // idk where to connect this
        .iD(),                      // output of instruction memory
        .oQ()                       // into many things
    );

    registers rf(
        .iClk(iClk), 
        .nRst(nRst), 
        .iWrite(rf_write),
        .iAddrA(ir.oQ[26:23]), 
        .iAddrB(ir.oQ[22:19]),
        .iAddrC(mc.out), // mux rf 
        .oRegA(ra.iD), 
        .oRegB(rb.iD), 
        .iRegC(ry.oQ)
    );

    Mux4_1_32b mc(
        .in0(ir.oQ[23:19]),
        .in1(ir.oq[18:15]),
        .in2(),     // link reg
        .in3(32'd0),     // 0's
        .sel(mc_select),
        .out()
    );

    REG32 ra(
        .iClk(iClk),
        .iEn(ra_enable),
        .nRst(1'b0),               // idk where to connect this
        .iD(),                  // output of register file port A
        .oQ()                   // input to ALU port A
    );

    REG32 rb(
        .iClk(iClk),
        .iEn(rb_enable),
        .nRst(1'b0),               // idk where to connect this
        .iD(),                  // output of register file port A
        .oQ()                   // input 0 of Mux b 
    );

    REG32 rm(
        .iClk(iClk),
        .iEn(rm_enable),
        .nRst(1'b0),              // idk where to connect this
        .iD(rb.oQ),
        .oQ(mem_data_out)       // input 0 of Mux b 
    );

    Mux2_1_32b mb(
        .in0(rb.oQ),
        .in1(),                 // immediate value
        .sel(mb_select),
        .out()                  // input B of ALU
    );

    ALU alu(
        .A(ra.oQ), 
        .B(mb.out), 
        .C0(),                  // input to rz0
        .C1(),                  // input to rz1 
        .control(alu_control),  // 0000 add, 0001, subtract, 0010 or, 0011 and , 0100 divide, 0101 multiply
        .conditions()           // output for branch instructions
    );

    REG32 rz0(
        .iClk(iClk),
        .iEn(rz0_enable),
        .nRst(1'b0),               // idk where to connect this
        .iD(alu.C0),            // output of register file port A
        .oQ()                   // input 0 of Mux b 
    );
    REG32 rz1(
        .iClk(iClk),
        .iEn(rz1_enable),
        .nRst(1'b0),               // idk where to connect this
        .iD(alu.C1),            // output of register file port A
        .oQ()                   // input 0 of Mux b 
    );

    Mux4_1_32b my(
        .in0(rz1.oQ),
        .in1(rz0.oQ),
        .in2(32'd0),                 // memory out
        .in3(32'd0),                 // return address
        .sel(my_select),        // mux y select control signal
        .out()                  // register y
    );

    REG32 ry(
        .iClk(iClk),
        .iEn(ry_enable),
        .nRst(1'b0),               // idk where to connect this
        .iD(my.out),            // output of mux y
        .oQ()                   // input of register file
    );

endmodule
