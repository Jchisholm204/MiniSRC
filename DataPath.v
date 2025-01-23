module Processor(
    clock_in,
    reset,
    mem_data_out,
    mem_data_in,
    mem_addr,
    instrucition_mem_in
);
    input wire clock_in, reset;
    input wire [31:0] mem_data_in, instrucition_mem_in;
    output wire [31:0] mem_data_out, mem_addr;

    wire ra_enable, rb_enable, rz0_enable, rz1_enable, rm_enable, ir_enable, ry_enable;
    wire mb_select;
    wire [1:0] my_select;
    wire [3:0] alu_control;

    REG32 ir(
        .iClk(clock_in),
        .iEn(ir_enable),
        .nRst(1'b0),               // idk where to connect this
        .iD(32'd0),                  // output of instruction memory
        .oQ()                   // into many things
    );

    REG32 ra(
        .iClk(clock_in),
        .iEn(ra_enable),
        .nRst(1'b0),               // idk where to connect this
        .iD(),                  // output of register file port A
        .oQ()                   // input to ALU port A
    );

    REG32 rb(
        .iClk(clock_in),
        .iEn(rb_enable),
        .nRst(1'b0),               // idk where to connect this
        .iD(),                  // output of register file port A
        .oQ()                   // input 0 of Mux b 
    );

    REG32 rm(
        .iClk(clock_in),
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
        .C1(),                  // input to rz0
        // .C2(),                  // input to rz1 
        .control(alu_control),  // 0000 add, 0001, subtract, 0010 or, 0011 and , 0100 divide, 0101 multiply
        .conditions()           // output for branch instructions
    );

    REG32 rz0(
        .iClk(clock_in),
        .iEn(rz0_enable),
        .nRst(1'b0),               // idk where to connect this
        .iD(alu.C0),            // output of register file port A
        .oQ()                   // input 0 of Mux b 
    );
    REG32 rz1(
        .iClk(clock_in),
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
        .iClk(clock_in),
        .iEn(ry_enable),
        .nRst(1'b0),               // idk where to connect this
        .iD(my.out),            // output of mux y
        .oQ()                   // input of register file
    );

endmodule


`timescale 1ns / 1ps

module Processor_tb();

    // Declare inputs as reg and outputs as wire
    reg clock_in, reset;
    reg [31:0] mem_data_in, instrucition_mem_in;
    wire [31:0] mem_data_out, mem_addr;

    // Instantiate the Processor module
    Processor uut (
        .clock_in(clock_in),
        .reset(reset),
        .mem_data_out(mem_data_out),
        .mem_data_in(mem_data_in),
        .mem_addr(mem_addr),
        .instrucition_mem_in(instrucition_mem_in)
    );

    // Clock generation
    always #5 clock_in = ~clock_in; // 100 MHz clock

    initial begin
        // Initialize inputs
        clock_in = 0;
        reset = 1;
        mem_data_in = 32'h00000000;
        instrucition_mem_in = 32'h00000000;

        // Apply reset
        #10;
        reset = 0;

        // Test case 1: Load instruction into instruction memory
        #10;
        instrucition_mem_in = 32'h12345678; // Example instruction
        mem_data_in = 32'hABCDEF01;        // Example data

        // Test case 2: Verify data transfer through memory
        #20;
        instrucition_mem_in = 32'h87654321; // Another instruction
        mem_data_in = 32'h10203040;        // Another data

        // Add more test cases as needed

        // End simulation
        #100;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0d, reset: %b, mem_data_in: %h, mem_data_out: %h, mem_addr: %h, instrucition_mem_in: %h",
                 $time, reset, mem_data_in, mem_data_out, mem_addr, instrucition_mem_in);
    end

endmodule
