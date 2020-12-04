`timescale 1ns/ 1ps



//Test bench
//Arithmetic Logic Unit
/*
* INPUT: A, B
* op: 00, A PLUS B
* op: 01, A AND B
* op: 10, A OR B
* op: 11, A XOR B
* OUTPUT A op B
* equal: is A == B?
* even: is the output even?
*/


module CPU_tb;
reg Reset;     	  // data inputs
reg Start;
reg Clk;
wire Ack;
 
always
begin
		
		Clk = 1'b1;
		#1;
		Clk = 1'b0;
		#1;
end
 
// CONNECTION
CPU uut(
  .Reset(Reset),      	  
  .Start(Start),
  .Clk(Clk),				  
  .Ack(Ack)
);
	 
initial begin


	Reset = 1;
	Start = 0;
	#2;
	
	Reset = 0;
	Start = 0;
	#2;
	

end

endmodule
