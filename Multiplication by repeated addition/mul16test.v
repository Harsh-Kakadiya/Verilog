module mul16_test ();
    reg [15:0] data_in;
    reg clk, start;

    wire done;
    mul_datapath DP(ldA, ldP, clrP, data_in, ldB, decB, eqz, clk);
    mul_controlpath CN (ldA, ldB, ldP, clrP, decB, done, start, eqz, clk);

    initial begin
        clk=1'b0;
        #3 start=1'b1;
        #500 $finish;
    end
    always #5 clk= ~clk;
    initial begin
        #17 data_in=17;
        #10 data_in=5;
    end
    initial begin
        $monitor ($time, "%d %b", DP.Y, done);
        $dumpfile("mul.vcd");
        $dumpvars(0, mul16_test);
    end
    
endmodule