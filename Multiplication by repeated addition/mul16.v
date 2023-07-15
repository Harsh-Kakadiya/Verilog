//datapath

module mul_datapath ( ldA, ldP, clrP, data_in, ldB, decB, eqz, clk);
    output eqz;
    input [15:0] data_in;
    input ldA, ldB, ldP, clk, clrP, decB;
    wire [15:0] X, Y, Z, Bout;

    PIPO1 A (X, data_in, ldA, clk);
    PIPO2 P (Y, Z, ldP, clk, clrP);
    counter B (Bout, data_in, ldB, decB, clk);
    adder add (Z, X, Y);
    equal eq (eqz, Bout); 
endmodule

module PIPO1(out, in, load, clk);
    output reg [15:0] out;
    input [15:0] in;
    input load, clk;
    always @(posedge clk ) begin
        if(load) out<=in;
    end
endmodule

module PIPO2(out, in, load, clk, clear);
    output reg [15:0] out;
    input [15:0] in;
    input load, clk, clear;
    always @(posedge clk ) begin
        if(clear) out<= 16'b0;
        else if(load) out<=in;
    end
endmodule

module adder(out, in1, in2);
    output reg [15:0] out;
    input [15:0] in1, in2;
    always @(*)
    begin
        out=in1+in2;
    end
endmodule

module counter(out, in, load, dec, clk);
    output reg [15:0] out;
    input [15:0] in;
    input clk, dec, load;
    always @(posedge clk )
        if(load) out<=in;
        else if(dec) out<=out-1;
    
endmodule

module equal(out, in);
    output out;
    input [15:0] in;
    assign out=(in==0);
endmodule

module mul_controlpath (ldA, ldB, ldP, clrP, decB, done, start, eqz, clk);
    output reg ldA, ldB, ldP, clrP, decB, done;
    input eqz, clk, start;
    reg [2:0] state;
    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;

    always @(posedge clk ) 
    begin
        case (state)
            S0: if(start) state<=S1;
            S1: state<=S2;
            S2: state<=S3;
            S3: #2 if(eqz) state<=S4;
            S4: state<=S4;
            default: state<=S0;
        endcase
    end

    always @(state)
    begin
        case (state)
            S0: begin
                   #1 ldA=0; ldB=0; ldP=0; clrP=0; decB=0;done=0;
                end
            S1: begin
               #1 ldA=1;
            end
            S2: begin
                #1 ldA=0; ldB=1; clrP=1; 
            end
            S3: begin
                #1 ldB=0; ldP=1; clrP=0;  decB=1;
            end
            S4: begin
                #1 done=1; ldB=0; ldP=0; decB=0;
            end
            default: begin
                   #1 ldA=0; ldB=0; ldP=0; clrP=0; decB=0;
                end
        endcase
    end
endmodule