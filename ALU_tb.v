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


module ALU_tb;
reg [ 7:0] INPUTA;     	  // data inputs
reg [ 7:0] INPUTB;
reg  op;		// ALU opcode, part of microcode
wire[ 7:0] OUT;		  

  wire Zero, LT;    
 
 reg [ 7:0] expected;
 
// CONNECTION
ALU uut(
  .InputA(INPUTA),      	  
  .InputB(INPUTB),
  .OP(op),				  
  .Out(OUT),		  			
  .Zero(Zero),
  .LT(LT)
  );
	 
initial begin


	INPUTA = 1;
	INPUTB = 2; 
	op= 'b0; // ADD
	test_alu_func; // void function call
	#3;
	
	
	INPUTA = 2;
	INPUTB = 1;
	op= 'b1; // SUB
	test_alu_func; // void function call
	#1;
	
	INPUTA = 8'b00000001;
	INPUTB = 8'b11111111;
	op = 'b1;
	expected = 8'b00000010;
	#1
	if (expected == OUT)
	begin
			$display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
		end
	    else begin $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);end

	
	INPUTA = 8'b00000010;
	INPUTB = 8'b11111100;
	op = 'b1;
	expected = 8'b00000110;
	#1
	if (expected == OUT)
	begin
			$display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
		end
	    else begin $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);end

	end
	
	task test_alu_func;
	begin
	  case (op)
		0: expected = INPUTA + INPUTB;
		1: expected = INPUTA - INPUTB;
	  endcase
	  #1; if(expected == OUT)
		begin
			$display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
		end
	    else begin $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);end
		
	end
	endtask



endmodule