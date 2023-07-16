module gcd_datapath (lt, gt, eq, clk, ldA, ldB, sel1, sel2, sel_in, data_in);
    output gt, lt, eq;
    input ldA, ldB, sel1, sel2, sel_in, clk;
    input [15:0] data_in;
    wire [15:0] bus, Aout, Bout, X, Y, Subout;

    PIPO A (Aout, clk, bus, ldA);
    PIPO B (Bout, clk, bus, ldB);

    mux M1 (bus, sel_in, Subout, data_in);
    mux M2 (X, sel1, Aout, Bout);
    mux M3 (Y, sel2, Aout, Bout);

    comp C1 (lt, gt, eq, Aout, Bout);
    sub S (Subout, X, Y);

endmodule

module mux (out, sel, in1, in2);
    output [15:0] out;
    input sel;
    input [15:0] in1, in2;
    assign out = sel ? in2 : in1;
endmodule

module comp (lt, gt, eq, in1, in2);
    output lt, gt, eq;
    input [15:0] in1, in2;
    assign lt = (in1<in2);
    assign gt = (in1>in2);
    assign eq = (in1==in2);
endmodule

module sub (out, in1, in2);
    output reg [15:0] out;
    input [15:0] in1, in2;
    always @(*)
    begin
    out<=in1-in2;
    end
endmodule

module PIPO (out, clk, in, load);
    output reg [15:0] out;
    input clk, load;
    input [15:0] in;

    always @(posedge clk ) begin
        if (load) out<=in;
    end
endmodule

module gcd_control (done, ldA, ldB, sel1, sel2, sel_in, clk, data_in, start, lt, gt, eq);
    output reg done, ldA, ldB, sel1, sel2, sel_in;
    input clk, start, lt, gt, eq;
    input [15:0] data_in;
    reg [2:0] state, next_state;

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;

    always @(posedge clk ) begin
        case (state)
                S0:     if (start) state <= S1;
                S1:     state <= S2;
                S2:     #2 if (eq) state <= S5;
                            else if (lt) state <= S3;
                            else if (gt) state <= S4;
                S3:     #2 if (eq) state <= S5;
                            else if (lt) state <= S3;
                            else if (gt) state <= S4;
                S4:    #2 if (eq) state <= S5;
                            else if (lt) state <= S3;
                            else if (gt) state <= S4;
                S5:         state <= S5;
                default:    state <= S0;
        endcase
        
        //state<=next_state;
    end

    always @(state)
    begin
        case (state)
            S0: begin
                    sel_in=1;
                    ldA=1;
                   // next_state=S1;
                    done=0;
                end

            S1: begin
                ldA=0; ldB=1; 
               // next_state=S2;
            end

            S2: begin
                ldB=0;
                sel_in=0;
                if (eq) begin
                    //next_state=S5;
                end
                else if (lt) begin
                    sel1=1; sel2=0; //next_state=S3;
                    #1 ldA=0; ldB=1;
                end
                else if (gt) begin
                    sel1=0; sel2=1; //next_state=S4;
                    #1 ldA=1; ldB=0;
                end
            end

            S3: begin
                ldA=0; ldB=0; sel_in=0;
                if (eq) begin
                    //next_state=S5;
                end
                else if (lt) begin
                    sel1=1; sel2=0; //next_state=S3;
                    #1 ldA=0; ldB=1;
                end
                else if (gt) begin
                    sel1=0; sel2=1; //next_state=S4;
                    #1 ldA=1; ldB=0;
                end
            end

            S4: begin
                ldA=0; ldB=0; sel_in=0;
                if (eq) begin
                   // next_state=S5;
                end
                else if (lt) begin
                    sel1=1; sel2=0; //next_state=S3;
                    #1 ldA=0; ldB=1;
                end
                else if (gt) begin
                    sel1=0; sel2=1; //next_state=S4;
                    #1 ldA=1; ldB=0;
                end
            end
            S5: begin
                
                ldA=0; ldB=0;
                done=1;
                // next_state=S5;
            end

            default: begin
                // next_state=S0;
                ldA=0; ldB=0;
                
            end
        endcase
    end
endmodule