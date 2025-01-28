module DIV(
    iClk, nRst,
    iQ, iM,
    oQ, oR
);

input wire iClk, nRst;
input wire [3:0] iQ, iM;
output wire [3:0] oQ, oR;

reg [3:0] A = 4'd0, Q = 4'd0, q = 4'd0;
reg [3:0] step = 4'd0;

assign oQ = Q;
assign oR = A;

always @(posedge iClk or negedge nRst) begin
    if(!nRst) begin
        A = 4'd0;
        step = 4'd0;
        Q = 4'd0;
        q = iQ;
    end
    else if(step == 4'd0) begin
        if(A[3]) begin
            A = {A[2:0], q[3]};
            q = {q[2:0], 1'b0};
            A = A + iM;
            // Q = {Q[3:0], 1'b0};
        end
        else begin
            A = {A[2:0], q[3]};
            q = {q[2:0], 1'b0};
            A = A - iM;
            // Q = {Q[3:0], 1'b1};
        end
        step = step + 4'd1;
    end
    else if(step == 4'd1) begin
        if(A[3]) begin
            A = {A[2:0], q[3]};
            q = {q[2:0], 1'b0};

            A = A + iM;
            Q = {Q[3:0], 1'b0};
        end
        else begin
            A = {A[2:0], q[3]};
            q = {q[2:0], 1'b0};

            A = A - iM;
            Q = {Q[3:0], 1'b1};
        end
        step = step + 4'd1;
    end
    else if(step == 4'd2) begin
        if(A[3]) begin
            A = {A[2:0], q[3]};
            q = {q[2:0], 1'b0};

            A = A + iM;
            Q = {Q[3:0], 1'b0};
        end
        else begin
            A = {A[2:0], q[3]};
            q = {q[2:0], 1'b0};

            A = A - iM;
            Q = {Q[3:0], 1'b1};
        end
        step = step + 4'd1;
    end
    else if(step == 4'd3) begin
        if(A[3]) begin
            A = {A[2:0], q[3]};
            q = {q[2:0], 1'b0};

            A = A + iM;
            Q = {Q[3:0], 1'b0};
        end
        else begin
            A = {A[2:0], q[3]};
            q = {q[2:0], 1'b0};

            A = A - iM;
            Q = {Q[3:0], 1'b1};
        end
        step = step + 4'd1;
    end
    // else if(step == 4'd4) begin
    //     if(A[3]) begin
    //         A = {A[2:0], q[3]};
    //         q = {q[2:0], 1'b0};

    //         A = A + iM;
    //         Q = {Q[3:0], 1'b0};
    //     end
    //     else begin
    //         A = {A[2:0], q[3]};
    //         q = {q[2:0], 1'b0};

    //         A = A - iM;
    //         Q = {Q[3:0], 1'b1};
    //     end
    //     step = step + 4'd1;
    // end
    else if(step == 4'd4) begin
        if(A[3]) begin
            A = A + iM;
            Q = {Q[3:0], 1'b0};
        end
        else begin
            Q = {Q[3:0], 1'b1};
        end
        step = step + 4'd1;
    end
    // else begin

end


endmodule
