module muxtest;
reg [15:0]A; 
reg [3:0]S;
wire out;

mux16 DUT (.in(A), .sel(S),.out(out));
initial begin
    $dumpfile("mux16t.vcd");
    $dumpvars(0,muxtest);
    $monitor($time,"A=%h, S=%h, F=%b",A,S,out);
    #5 A=16'h3F0A; S=4'h0;
    #5 S=4'h1;
    #5 S=4'h6;
    #5 S=4'hC;
    #5 $finish;
end
endmodule