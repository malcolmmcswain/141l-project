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
		'b0: begin
			Out = InputA + InputB; // ADD
			$display("Sum: %d",Out);
			end
		'b1: Out = InputA - InputB; // SUB
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
