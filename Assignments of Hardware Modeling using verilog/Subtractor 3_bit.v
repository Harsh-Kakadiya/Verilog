//Write a Verilog module to implement a 3-bit subtractor by instantiating  half_sub module (defined in Week2: Programming Assignment 1) as many times as required. Other primitive gates may be used if required. The module will take the following arguments:
// Two 3-bit inputs A and B,
// An 1-bit borrow input BI,
// A 3-bit subtraction output Sub,
// An 1-bit borrow output BO
//Write both the half_sub and full_sub_3bit modules here
module full_sub_3bit (Sub, BO, A, B, BI);
  output [2:0] Sub;
  output BO;
  input [2:0] A, B;
  input	BI;
  wire w1, w2;
  
  full_sub M11 (Sub[0], w1, A[0], B[0], BI);
  full_sub M22 (Sub[1], w2, A[1], B[1], w1);
  full_sub M33 (Sub[2], BO, A[2], B[2], w2);
  
endmodule 


module full_sub (sub, bout, in1, in2, bin);
  output sub, bout;
  input in1, in2, bin;
  wire w1,w2,w3;
  half_sub M1 (w1, w2, in1, in2);
  half_sub M2 (sub, w3, w1, bin);
  or M3 (bout, w2, w3);
endmodule

module half_sub (sub, Bout, in1, in2);
  output sub, Bout;
  input in1, in2;
  wire w1;
  xor G1 (sub, in1,in2);
  not G2 (w1, in1);
  and G3 (Bout, w1, in2);
endmodule