module ControlUnit(
    ir, nRst, clock,
    mb_select, minc_select, rf_write, my_select, mc_select, alu_control,
    ra_enable, rb_enable, rz0_enable, rz1_enable, rm_enable, ir_enable, ry_enable, rpc_enable, rpc_temp_enable, rlo_enable,
    zero, rz_b31
);
    input wire nRst, clock;
    input wire [31:0]ir;
    input wire zero, rz_b31;
    output wire ra_enable, rb_enable, rz0_enable, rz1_enable, rm_enable, ir_enable, ry_enable, rpc_enable, rpc_temp_enable, rlo_enable;    
    output wire mb_select, minc_select, mpc_select;
    output wire rf_write;
    output wire [1:0] my_select, mc_select;
    output wire [3:0] alu_control;
    
    reg cycle;

    // Counts cycles 1-5
    always @(posedge clock)
    begin
        case(cycle)
            1   :   cycle = 2;
            2   :   cycle = 3;
            3   :   cycle = 4;
            4   :   cycle = 5;
            5   :   cycle = 1;
        endcase
    end

    assign ir_enable = (cycle == 1) ? 1 : 0;
    assign rpc_enable = (cycle == 1) ? 1 : 0;
    assign rpc_temp_enable = 1;                 // idk yet

    assign mb_select = (ir[31:28] == 4'b0000) ? 1 : 0 | (ir[31:27] == 5'b00010) ? 1 : 0 | (ir[31:28] == 4'b0110) ? 1 : 0 | (ir[31:27] == 5'b01110) ? 1 : 0;
    assign minc_select = (ir[31:27] == 5'b10011) & ((~ir[22] & ~ir[21] & zero) | (ir[22] & ~ir[21] & ~zero) | (~ir[22] & ir[21] & ~rz_b31) | (ir[22] & ir[21] & rz_b31));

    assign rf_write = ~((ir[31:27] == 5'b00010) ? 1 : 0 | (ir[31:27] == 5'b10011) ? 1 : 0 | (ir[31:27] == 5'b10101) ? 1 : 0  | (ir[31:27] == 5'b10111) ? 1 : 0 | (ir[31:28] == 4'b1101) ? 1 : 0);
    
    /*
    0 default
    1 when reading hi
    2 mem in
    3 lo
    4 pc_temp reg - jal instruction saves return address
    */
    assign my_select =  (ir[31:27] == 5'b11001) ? 4'd1 :   // read hi
                        (ir[31:27] == 5'b11000) ? 4'd3 :   // read lo
                        (ir[31:27] == 5'b00000) ? 4'd2 :   // mem - load
                        (ir[31:27] == 5'b00001) ? 4'd2 :   // mem - load imm
                        (ir[31:27] == 5'b10100) ? 4'd4 :   // pc_temp register jal
                        4'd0;

    assign mpc_select = (ir[31:27] == 5'b10100) ? 1 :
                        (ir[31:27] == 5'b10101) ? 1 :
                        0;


    // assign mc_select = 
                                        //   op     |  alu_signal
    assign alu_control =    (ir[31:27] == 5'b00011) ? 4'b0000 :         // add
                            (ir[31:27] == 5'b00100) ? 4'b0001 :         // sub
                            (ir[31:27] == 5'b00101) ? 4'b0010 :         // and
                            (ir[31:27] == 5'b00110) ? 4'b0011 :         // or
                            (ir[31:27] == 5'b00111) ? 4'b0100 :         // rotr
                            (ir[31:27] == 5'b01000) ? 4'b0101 :         // rotl
                            (ir[31:27] == 5'b01001) ? 4'b0110 :         // shr
                            (ir[31:27] == 5'b01010) ? 4'b0111 :         // shra
                            (ir[31:27] == 5'b01011) ? 4'b1000 :         // shl
                            (ir[31:27] == 5'b01100) ? 4'b0000 ://       // addi
                            (ir[31:27] == 5'b01101) ? 4'b0010 ://       // andi
                            (ir[31:27] == 5'b01110) ? 4'b0011 ://       // ori
                            (ir[31:27] == 5'b01111) ? 4'b1001 :         // div
                            (ir[31:27] == 5'b10000) ? 4'b1010 :         // mul
                            (ir[31:27] == 5'b10001) ? 4'b1011 :         // neg
                            (ir[31:27] == 5'b10010) ? 4'b1100 :         // not
                            4'b0000;


    assign ra_enable = 1;
    assign rb_enable = 1;
    assign rz0_enable = 1;
    assign rz1_enable = 1;
    assign rm_enable = 1;
    assign ry_enable = 1;
    assign rlo_enable = 1;

endmodule