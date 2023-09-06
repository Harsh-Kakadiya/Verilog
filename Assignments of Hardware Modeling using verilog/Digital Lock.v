// Digital Lock: 
// It is required to implement a digital lock that will accept a specific bit sequence  “101100” through an input button “b_in” serially in synchronism with the negative edge of an input clock, and will generate an “unlock” signal “1” as output; for any other bit sequence the “unlock” signal will remain at logic “0”.  An active low “clear” signal is used to asynchronously reset the lock in its initial/default state.
//Write the Verilog module here
module dlock (unlock, b_in, clear, clk);
  input b_in, clk, clear;
  output reg unlock;
  parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5;
  reg [2:0] PS, NS;

  always @(negedge clk or negedge clear) 
    begin
      if(clear) 
        begin
          case (PS) 
            S0: begin 
            unlock <= b_in ? 0 : 0;
            PS <= b_in ? S1 : S0; 
            end
            S1: begin 
            unlock <= b_in ? 0 : 0;  
            PS <= b_in ? S1: S2; 
            end 
            S2: begin 
            unlock <= b_in ? 0 : 0;
            PS <= b_in ? S3 : S0; 
            end 
            S3: begin 
            unlock <= b_in ? 0 : 0; 
            PS <= b_in ? S4 : S2; 
            end 
                S4: begin 
            unlock <= b_in ? 0 : 0;
            PS <= b_in ? S1 : S5; 
            end
                S5: begin 
            unlock <= b_in ? 0 : 1;
            PS <= b_in ? S3 : S0; 
            end
            default: PS<=S0;
        endcase
        end
      else 
        begin
          PS<=S0;
      	unlock<=0;
        end
    end 
endmodule