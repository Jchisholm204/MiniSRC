module Processor(
    iClk,
    nRst,
    mem_data_out,
    mem_data_in,
    mem_addr,
    mem_read,
    mem_write,
    instruction_mem_in,
    instruction_mem_addr,
    instruction_mem_read
);
    // Signels to external things
    input wire iClk, nRst;
    input wire [31:0] mem_data_in, instruction_mem_in;
    output wire mem_read, mem_write, instruction_mem_read;
    output wire [31:0] mem_data_out, mem_addr, instruction_mem_addr;

    // For control unit
    wire ra_enable, rb_enable, rz0_enable, rl0_enable, rm_enable, ir_enable, ry_enable, rpc_enable, rpc_temp_enable, rlo_enable;

    wire rf_write;
    wire [2:0] my_select;
    wire mb_select, minc_select, mpc_select, msrc2_select, mdst_select;

    wire [3:0] alu_control;
    wire alu_zero_flag, rz_b31;

    // For connection between modules
    wire [31:0] rfa_out, rfb_out, ra_out, mb_out, aluc0_out, aluc1_out, rz0_out, rl0_out, my_out, ry_out, rb_out, mc_out, ir_out;
    wire [31:0] mpc_out, rpc_out, rpc_temp_out, pcadderc_out, minc_out, rlo_out, msrc2_out, mdst_out;

    assign rz_b31 = rz0_out[31];

    ControlUnit cu(
        ir_out, nRst, iClk,
        mb_select, minc_select, rf_write, my_select, alu_control, mpc_select, msrc2_select, mdst_select,
        ra_enable, rb_enable, rz0_enable, rl0_enable, rm_enable, ir_enable, ry_enable, rpc_enable, rpc_temp_enable, rlo_enable,
        alu_zero_flag, rz_b31
    );

    REG32 ir(
        .iClk(iClk),
        .iEn(ir_enable),
        .nRst(nRst),                // idk where to connect this
        .iD(instruction_mem_in),   // output of instruction memory
        .oQ(ir_out)                       // into many things
    );

    registers rf(
        .iClk(iClk), 
        .nRst(nRst), 
        .iWrite(rf_write),
        .iAddrA(ir_out[22:19]),         // RB
        .iAddrB(msrc2_out),             // RC or RA - on imm val path
        .iAddrC(mdst_out),              // RA or R15
        .oRegA(rfa_out), 
        .oRegB(rfb_out), 
        .iRegC(ry_out)
    );

    Mux2_1_4b msrc2(
        .in0(ir_out[18:15]),    // RC
        .in1(ir_out[26:23]),    // RA
        .out(msrc2_out),
        .sel(msrc2_select)
    );

    Mux2_1_4b mdst(
        .in0(ir_out[26:23]),    // RA
        .in1(4'b1111),          // R15
        .out(mdst_out),
        .sel(mdst_select)
    );

    REG32 ra(
        .iClk(iClk),
        .iEn(ra_enable),
        .nRst(nRst),               // idk where to connect this
        .iD(rfa_out),                  // output of register file port A
        .oQ(ra_out)                   // input to ALU port A
    );

    REG32 rb(
        .iClk(iClk),
        .iEn(rb_enable),
        .nRst(nRst),               // idk where to connect this
        .iD(rfb_out),                  // output of register file port A
        .oQ(rb_out)                   // input 0 of Mux b 
    );

    REG32 rm(
        .iClk(iClk),
        .iEn(rm_enable),
        .nRst(nRst),              // idk where to connect this
        .iD(rb_out),
        .oQ(mem_data_out)       // input 0 of Mux b 
    );

    Mux2_1_32b mb(
        .in0(rb_out),
        .in1(32'd0),                 // immediate value
        .sel(mb_select),
        .out(mb_out)                  // input B of ALU
    );

    ALU alu(
        .A(ra_out), 
        .B(mb_out), 
        .C0(aluc0_out),                  // input to rz0
        .C1(aluc1_out),                  // input to rl0 
        .control(alu_control),              // 0000 add, 0001, subtract, 0010 or, 0011 and , 0100 divide, 0101 multiply
        .zero(alu_zero_flag)          // output for branch instructions
    );

    REG32 rz0(
        .iClk(iClk),
        .iEn(rz0_enable),
        .nRst(nRst),               // idk where to connect this
        .iD(aluc0_out),            // output of register file port A
        .oQ(rz0_out)                   // input 0 of Mux y
    );
    REG32 rl0(
        .iClk(iClk),
        .iEn(rl0_enable),
        .nRst(nRst),               // idk where to connect this
        .iD(aluc1_out),            // output of register file port A
        .oQ(rl0_out)                   // input 0 of Mux b 
    );
    REG32 rlo(
        .iClk(iClk),
        .iEn(rlo_enable),
        .nRst(nRst),                    // idk where to connect this
        .iD(aluc1_out),              // output of register file port A
        .oQ(rlo_out)                  // input 0 of Mux b 
    );

    Mux5_1_32b my(
        .in0(rz0_out),                      // rz
        .in1(rl0_out),                    // HI
        .in2(mem_data_in),                  // memory in
        .in3(rlo_out),                    // LO
        .in4(rpc_temp_out),                        // link register/ pc_temp
        .sel(my_select),                    // mux y select control signal
        .out(my_out)                      // register y
    );

    REG32 ry(
        .iClk(iClk),
        .iEn(ry_enable),
        .nRst(nRst),                // idk where to connect this
        .iD(my_out),              // output of mux y
        .oQ(ry_out)              // input of register file
    );

    REG32 rpc(
        .iClk(iClk),
        .iEn(rpc_enable),
        .nRst(nRst),
        .iD(mpc_out),
        .oQ(rpc_out)
    );

    REG32 rpc_temp(
        .iClk(iClk),
        .iEn(rpc_temp_enable),
        .nRst(nRst),
        .iD(rpc_out),
        .oQ(rpc_temp_out)
    );

    Mux2_1_32b mpc(
        .in0(ra_out),           // RA
        .in1(pcadderc_out),      // PcAdder
        .sel(mpc_select),
        .out(mpc_out) 
    );

    Mux2_1_32b minc(
        .in0(32'd4),                // 4
        .in1(ir_out[18:0]),         // sign extend?
        .sel(minc_select),
        .out(minc_out) 
    );

    FastAdder pcadder(
        .x_in(rpc_out), 
        .y_in(minc_out), 
        .sum_out(pcadderc_out), 
        .c_in(32'd0), 
        .c_out()                    // idk what to connect this to?
    );

endmodule


`timescale 1ns/10ps
module Processor_tb();
    wire clock, nRst;
    wire [31:0] mem_data_out, mem_data_in, mem_addr, instruction_mem_in, instruction_mem_addr;
    wire mem_read, mem_write, instruction_mem_read;
    Processor p(
        .iClk(clock),
        .nRst(nRst),
        .mem_data_out(mem_data_out),
        .mem_data_in(mem_data_in),
        .mem_addr(mem_addr),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .instruction_mem_in(instruction_mem_in),
        .instruction_mem_addr(instruction_mem_addr),
        .instruction_mem_read(instruction_mem_read)
    );

    reg [3:0] p_state = 5;

    reg clock_reg, nRst_reg;
    reg [31:0] mem_data_out_reg, mem_data_in_reg, mem_addr_reg, instruction_mem_in_reg, instruction_mem_addr_reg;
    reg mem_read_reg, mem_write_reg, instruction_mem_read_reg;


    // For connection between modules

    assign clock = clock_reg;
    assign nRst = nRst_reg;
    assign mem_data_out = mem_data_out_reg;
    assign mem_data_in = mem_data_in_reg;
    assign mem_addr = mem_addr_reg;
    assign instruction_mem_in = instruction_mem_in_reg;
    assign instruction_mem_addr = instruction_mem_addr_reg;
    assign mem_read = mem_read_reg;
    assign mem_write = mem_write_reg;
    assign instruction_mem_read = instruction_mem_read_reg;


    // Generates clock signal

    initial
        begin
            clock_reg = 0;
            forever #10 clock_reg = ~ clock_reg;
        end

    // Cycles through 0-4 for a 5 cycle processor
    always @(posedge clock)
        begin
            case(p_state)
                5           :   p_state = 0;
                0           :   p_state = 1;
                1           :   p_state = 2;
                2           :   p_state = 3;
                3           :   p_state = 4;
                4           :   p_state = 0;
            endcase
        end 

    // Simulates control signals
    initial begin
        // Initialize inputs
        nRst_reg = 0; // Active low reset
        // tb_mem_data_in = 0;
        instruction_mem_in_reg = 0;

        #5 nRst_reg = 1;
        
        // Cycle 1: Fetch instruction
        #15 begin
        instruction_mem_in_reg = 32'b00011000100100011000000000000000;
        // R1 <= R2 + R3
        end

        #100 begin 
        instruction_mem_in_reg = 32'b00011000100010010000000000000000;
        // R1 <= R1 + R2
        end

        #100 begin
        instruction_mem_in_reg = 32'b10000000100010000000000000000000;
        // LO and HI <= R1 * R1
        end

        #100 begin
        instruction_mem_in_reg = 32'b11000000100000000000000000000000;
        // RA <= LO
        end
        // End of simulation
        #120 $finish;
    end


endmodule