module mux16 (in, sel, out);
    input [15:0]in;
    input [3:0] sel;
    output out;
    wire [3:0]t;
    mux4 M0 (in[3:0],sel[1:0],t[0]);
    mux4 M1 (in[7:4],sel[1:0],t[1]);
    mux4 M2 (in[11:8],sel[1:0],t[2]);
    mux4 M3 (in[15:12],sel[1:0],t[3]);
    mux4 M4 (t[3:0], sel[3:2], out);

endmodule

module mux4(in, sel, out);
    input [3:0] in;
    input [1:0] sel;
    output out;
    wire [1:0]t;
    mux2 M0 (in[1:0],sel[0],t[0]);
    mux2 M1 (in[3:2], sel[0],t[1]);
    mux2 M2 (t[1:0],sel[1],out);
    
endmodule

module mux2(in,sel,out);
    input [1:0] in;
    input sel;
    output out;

    wire v1,v2,v3;
    not G1(v1, sel);
    and G2(v2,v1,in[0]);
    and G3(v3,sel,in[1]);
    or G4(out,v2,v3);
    //assign out=in[sel];
endmodule