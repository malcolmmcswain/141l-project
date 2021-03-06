// Module Name:    RegFile 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// This module is your register file.
// If you have more or less bits for your registers, update the value of D.
// Ex. If you only supports 8 registers. Set D = 3

/* parameters are compile time directives 
       this can be an any-size reg_file: just override the params!
*/
module RegFile (Clk,DataIn,Instruction,DataOutA,DataOutB,DataOutC);
	parameter W=8, D=4;  // W = data path width (Do not change); D = pointer width (You may change)
	input                Clk;
	input        [W-1:0] DataIn;
	input        [8:0] Instruction;
	output reg    [W-1:0] DataOutA;			  
	output reg   [W-1:0] DataOutB;				
	output reg signed  [W-1:0] DataOutC;
	
	// W bits wide [W-1:0] and 2**4 registers deep 	 
	reg [W-1:0] Registers[16-1:0];
	
	assign Registers[0] = 0;
	assign Registers[1] = 0;
	assign Registers[2] = 0;
	assign Registers[3] = 0;
	assign Registers[4] = 0;
	assign Registers[5] = 0;
	assign Registers[6] = 0;
	assign Registers[7] = 0;
	assign Registers[8] = 0;
	assign Registers[9] = 0;
	assign Registers[10] = 0;
	assign Registers[11] = 0;
	assign Registers[12] = 0;
	assign Registers[13] = 0;
	assign Registers[14] = 0;
	assign Registers[15] = 0;

	always@*
	begin
		case(Instruction[8:6]) // read registers
		3'b101  : begin // beq
					DataOutA = Registers[Instruction[3:2]];
					DataOutB = Registers[Instruction[1:0]];
					DataOutC = Registers[Instruction[5:4]]; 
					end
		3'b010  : DataOutA = Registers[Instruction[5:4]]; //lwd
		3'b011  : begin
					 DataOutA = Registers[Instruction[5:4]]; //swd
					 DataOutB = Registers[Instruction[3:0]];
					 end
		default : begin
					DataOutA = Registers[Instruction[3:2]]; //all other cases
					DataOutB = Registers[Instruction[1:0]];
					end
		endcase
	end
					
	always @ (posedge Clk)
	begin
		case(Instruction[8:6]) // write registers
		3'b010   : begin
						Registers[Instruction[3:0]] <= DataIn; // lwd
						$display("Register %b contains value %d", Instruction[3:0], DataIn);
						end
		3'b101   : Registers[Instruction[3:0]] <= Registers[Instruction[3:0]]; // beq
		3'b011   : Registers[Instruction[3:0]] <= Registers[Instruction[3:0]]; // swd
		3'b111   : Registers[4'b0000] <= Instruction[5:0]; // lim
		3'b110  : begin // swp
			 Registers[4'b1111] = Registers[Instruction[5:4]];
			 Registers[Instruction[5:4]] = Registers[Instruction[3:0]];
			 Registers[Instruction[3:0]] = Registers[4'b1111];
			 $display("Reg: %b has value: %d",Instruction[5:4],Registers[Instruction[5:4]]);
			 $display("Reg: %b has value: %d",Instruction[3:0],Registers[Instruction[3:0]]);
			 end
		default  : Registers[Instruction[5:4]] <= DataIn;
		endcase
	end

endmodule
