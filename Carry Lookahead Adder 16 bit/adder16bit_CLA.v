module adder16LCA (in1,in2,sum,carry,sign,zero,parrity,overflow);
    input [15:0]in1;
    input [15:0]in2;
    output [15:0]sum;
    output carry, sign, zero, parrity, overflow;
    wire [2:0]C;
    LCA A1(in1[3:0], in2[3:0], 1'b0, sum[3:0], C[0]);
    LCA A2(in1[7:4], in2[7:4], C[0], sum[7:4], C[1]);
    LCA A3(in1[11:8], in2[11:8], C[1], sum[11:8], C[2]);
    LCA A4(in1[15:12], in2[15:12], C[2], sum[15:12], carry);

    //assign {carry,sum}=in1+in2;
    assign sign=sum[15];
    assign zero= ~|sum;
    assign parrity= ~^sum;
    assign overflow=(in1[15]&in2[15]& ~sum[15])|(~in1[15]&~in2[15]&sum[15]);
    
endmodule


/*
module adder4 (in1,in2,cin,sum,cout);
    input [3:0] in1, in2;
    output [3:0] sum;
    input cin;
    output cout;
    wire c1,c2,c3;
    fulladder F1(sum[0],c1,in1[0],in2[0],cin);
    fulladder F2(sum[1],c2,in1[1],in2[1],c1);
    fulladder F3(sum[2],c3,in1[2],in2[2],c2);
    fulladder F4(sum[3],cout,in1[3],in2[3],c3);


    //assign {cout,sum}=in1+in2+cin;
endmodule

module fulladder(sum,cout,in1,in2,cin);
    input in1,in2,cin;
    output cout,sum;
    wire w1,w2,w3;

    xor G1 (w1,in1,in2), G2(sum,cin,w1), G3(cout,w2,w3);
    and G4 (w2,in1, in2), G5(w3,cin,w1);
endmodule
*/

module LCA(in1,in2,cin,sum,cout);
    input [3:0]in1, in2;
    output [3:0]sum;
    output cout;
    input cin;
    wire g1,g2,g3,g0;
    wire p1,p2,p3,p0;
    wire c1,c2,c3;

    xor G1(p0,in1[0],in2[0]), G2(p1,in1[1],in2[1]), G3(p2,in1[2],in2[2]), G4(p3,in1[3],in2[3]), G5(sum[1],p1,c1), G6(sum[0],p0,cin), G7(sum[2],p2,c2), G8(sum[3],p3,c3);

    // assign p0=(in1[0])^(in2[0]);
    // assign p1=in1[1]^in2[1];
    // p2=in1[2]^in2[2];
    // p3=in1[3]^in2[3];
    
    assign g0=in1[0]&in2[0];
    assign g1=in1[1]&in2[1];
    assign g2=in1[2]&in2[2];
    assign g3=in1[3]&in2[3];
    
    assign c1=g0|(p0&cin);
    assign c2=g1|(p1&c1);
    assign c3=g2|(p2&c2);
    assign cout=g3|(p3&c3);

    // sum[0]=p0^cin;
    // sum[1]=p1^c1;
    // sum[2]=p2^c2;
    // sum[3]=p3^c3;

endmodule