// Write a Verilog module to implement a 16-bit majority function using behavioral description. The module will take as input a 16-bit data, Data and provide a single-bit output, Out, indicating the logic state of the most number of input bits, i.e. if at least 9 out of 16 input signals are at logic 1, the logic state of Out will be 1; otherwise Out will remain at  logic 0. The template of the function will be as follows :

//        module majority16 (Out, Data);

//Write the Verilog module here
module majority16 (Out, Data);
  output reg Out;
  input [15:0] Data;
  integer i;
  integer count;
  //count=5'b0;
  reg flag=0;

  initial
    begin
      count=0;

    
    end
  always @(*)
     begin
     for (i=0; i<16; i++)
      if (Data[i]==1) begin count=count+1; end
   
       if (count>8) 
    begin 
     Out=1; 
    end
   else 
     begin 
      Out=0; 
     end
    end

endmodule