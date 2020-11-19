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


module InstFetch_tb;

	reg Clk; 
  reg Reset, Start, BranchEn, ALU_flag;
	reg[7:0] Target;
 
 wire [10:0] ProgCtr;
 reg [10:0] expected;

  always
  begin
		#1;
		Clk = 1'b1;
		#1;
		Clk = 1'b0;
	end
	
 
// CONNECTION
  InstFetch IF1 (
	.Reset       (Reset   ) , 
	.Start       (Start   ) ,  
	.Clk         (Clk     ) ,
	.BranchEn    (BranchEn) ,  // branch enable
	.ALU_flag	 (ALU_flag    ) ,  // zero flag from ALU
   .Target      (Target  ) ,  // for branch instructions
	.ProgCtr     (ProgCtr  )	   // program count = index to instruction memory
	);	
	 
initial begin


	Reset = 'b1;
	Start = 'b0;
	BranchEn = 'b0;
	ALU_flag = 'b0;
	Target = 8'b0;
	test_if_func; // void function call
	#3;
	
	Reset = 'b0;
	Start = 'b1;
	BranchEn = 'b0;
	ALU_flag = 'b0;
	Target = 8'b0;
	test_if_func; // void function call
	#3;
	
	Reset = 'b0;
	Start = 'b0;
	BranchEn = 'b1;
	ALU_flag = 'b1;
	Target = 8'b00000100;
	test_if_func; // void function call
	#3;
	
	Reset = 'b0;
	Start = 'b0;
	BranchEn = 'b1;
	ALU_flag = 'b0;
	Target = 8'b00000100;
	test_if_func; // void function call
	#3;
	
	Reset = 'b0;
	Start = 'b0;
	BranchEn = 'b0;
	ALU_flag = 'b1;
	Target = 8'b00000100;
	test_if_func; // void function call
	#3;
	
	Reset = 'b0;
	Start = 'b0;
	BranchEn = 'b0;
	ALU_flag = 'b0;
	Target = 8'b00000100;
	test_if_func; // void function call
	#3;
	
	Reset = 'b1;
	Start = 'b0;
	BranchEn = 'b0;
	ALU_flag = 'b0;
	Target = 8'b00000100;
	test_if_func; // void function call
	#3;
	

	Reset = 'b0;
	Start = 'b0;
	BranchEn = 'b0;
	ALU_flag = 'b0;
	Target = 8'b00000100;
	test_if_func; // void function call
	#2;	
	
	Reset = 'b0;
	Start = 'b0;
	BranchEn = 'b0;
	ALU_flag = 'b0;
	Target = 8'b00000100;
	test_if_func; // void function call
	#2;	
	
	Reset = 'b0;
	Start = 'b0;
	BranchEn = 'b0;
	ALU_flag = 'b0;
	Target = 8'b00000100;
	test_if_func; // void function call
	#2;	
	

end
	
	task test_if_func;
	begin
	  if (Reset == 1) expected = 10'b0;
	  else if (Start == 1) expected = ProgCtr;
	  else if (BranchEn && ALU_flag) expected = Target + ProgCtr;
	  else if (BranchEn && ~ALU_flag) expected = ProgCtr+'b1;
	  else if (~BranchEn && ALU_flag) expected = ProgCtr+'b1;
	  else expected = ProgCtr+'b1;
	  #2; if(expected == ProgCtr)
		begin
			$display("%t YAY!! inputs = %d %d %d %d %d %b, output = %b",$time, Reset, Start, Clk, BranchEn, ALU_flag, Target, ProgCtr);
		end
	    else begin $display("%t FAIL!! inputs = %d %d %d %d %d %b, output = %b",$time, Reset, Start, Clk, BranchEn, ALU_flag, Target, ProgCtr);
		end
	end
	endtask



endmodule
