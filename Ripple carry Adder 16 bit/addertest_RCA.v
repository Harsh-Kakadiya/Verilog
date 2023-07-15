module testadder;
    reg [15:0]X, Y;
    wire [15:0]S;
    wire C,P,OV,ZR,Sn;

    adder16RCA DUT(.in1(X),.in2(Y),.sum(S),.carry(C), .parrity(P), .overflow(OV), .zero(ZR), .sign(Sn));

    initial begin
        $dumpfile("adderdata_RCA.vcd");
        $dumpvars(0,testadder);
        $monitor($time, "In1=%h, In2=%h, Sum=%h, Carry=%b, Zero=%b, Parrity=%b, Sign=%b, Overflow=%b",X,Y,S,C,ZR,P,Sn,OV);
        #5 X=16'h8FFF; Y=16'h8000;
        #5 X=16'hFFFE; Y=16'h0002;
        #5 X=16'hAAAA; Y=16'h5555;
        #5 $finish;
    end
endmodule