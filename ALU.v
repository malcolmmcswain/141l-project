// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// 


	 
module ALU(InputA,InputB,OP,Out,Zero, LT);

	input [ 7:0] InputA;
	input [ 7:0] InputB;
	input OP;
	output reg [7:0] Out; // logic in SystemVerilog
	output reg Zero;
	output reg LT;

	always@* // always_comb in systemverilog
	begin 
		Out = 0;
		case (OP)
		'b0: Out = InputA + InputB; // ADD
		'b1: begin 
			
			if (InputA >= InputB)  
				Out = InputA - InputB; // SUB if inputA is larger or equal to InputB
			else 
				// Sub with a borrow, because there are always going to be a borrow
				Out = 9'b100000000 - InputB + InputA;
			
		end
		default: Out = 0;
	  endcase
	
	end 

	always@*							  // assign Zero = !Out;
	begin
		case(Out)
			'b0     : Zero = 1'b1;
			default : Zero = 1'b0;
      endcase
	end
	
	always@*							  // assign LT = InputA < InputB;
	begin
		if(InputA < InputB) begin
		LT = 1'b1;
		end else begin
		LT = 1'b0;
		end
	end

endmodule
