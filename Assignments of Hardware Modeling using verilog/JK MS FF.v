// Write a Verilog module to implement a J-K master-slave flip-flop with asynchronous set and reset at the gate level. The module will take as arguments the following:
// 1-bit data input “J”
// 1-bit data input “K”
// 1-bit clock input “Clk”
// 1-bit data input “Set”
// 1-bit data input “Rst”
// 1-bit output “Q”
// 1-bit output “Qb”

module jk_ms_ff (Q, Qb, J, K, Clk, Set, Rst);
  output Q, Qb;
  input J, K, Clk, Set, Rst;
  wire w1, w2, w3, w4, w5, w6, w7;
 // reg i1, i2, i3, i4;
  
  nand G1 (w1, J, Clk, Qb);
  nand G2 (w2, K, Clk, Q);
  nand G3 (w3, w1, Set, w4);
  nand G4 (w4, w2, w3, Rst);
  not G5 (w5, Clk);
  nand G6 (w6, w3, w5);
  nand G7 (w7, w4, w5);
  nand G8 (Q, w6, Qb);
  nand G9 (Qb, w7, Q);
endmodule