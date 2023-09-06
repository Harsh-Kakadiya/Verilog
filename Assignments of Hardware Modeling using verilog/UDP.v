// Write a Verilog module using user-defined primitive to implement the function Y = A.B’.D + B.C.D’ + A.C, where dot (.) indicates AND operation, plus (+) indicates OR operation and X’ indicates complement (NOT) of X, as per the following template:

//      primitive udpY (Y, A, B, C, D);
//Write the Verilog module here
primitive udpY (Y, A, B, C, D);
output Y;
input A, B, C, D;
table
//A B C D : Y
  1 0 ? 1 : 1;
  ? 1 1 0 : 1;
  1 ? 1 ? : 1;
  0 0 ? ? : 0;
  0 1 0 ? : 0;
  0 1 1 1 : 0;
  1 0 0 0 : 0;
  1 1 0 ? : 0; 
endtable
endprimitive