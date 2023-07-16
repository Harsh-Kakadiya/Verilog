module gcd_testbench ();
    reg [15:0] data_in;
    reg clk, start;
    wire done;
    reg [15:0] A, B ;

    gcd_datapath DP (lt, gt, eq, clk, ldA, ldB, sel1, sel2, sel_in, data_in);
    gcd_control  CN (done, ldA, ldB, sel1, sel2, sel_in, clk, data_in, start, lt, gt, eq);

    initial begin
        clk=1'b0;
        #3 start = 1'b1;
        #1000 $finish;
    end

    always #5 clk=~clk;

    initial begin
        #12 data_in=143;
        #10 data_in=78;
    end

    initial begin
        $dumpfile("gcd.vcd");
        $dumpvars (0,gcd_testbench);
        $monitor ($time , "%d %b", DP.Aout, done);
    end
endmodule