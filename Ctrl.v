// Module Name:    Ctrl 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// This module is the control decoder (combinational, not clocked)
// Out of all the files, you'll probably write the most lines of code here
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
// There may be more outputs going to other modules

module Ctrl (Op, WriteSrc, ALUOp, MemWrite, BranchEn);


  input[ 2:0] Op;	   // opcode
  output reg [1:0] WriteSrc; // regwrite mux selector
  output reg [1:0] ALUOp;
  output reg MemWrite, // control input to DataMem
             BranchEn; // branch toggler
				 
	always@*
	begin
		case(Op)
		3'b000: begin // add
				  WriteSrc = 2'b00; //r1 case
				  ALUOp = 2'b00; // add
				  MemWrite = 1'b0;
				  BranchEn = 1'b0;
				  end
		3'b001: begin // sub
				  WriteSrc = 2'b00; //r1 case
				  ALUOp = 2'b01; // sub
				  MemWrite = 1'b0;
				  BranchEn = 1'b0;
				  end
		3'b010: begin // lwd
				  WriteSrc = 2'b01; //lwd case
				  ALUOp = 2'b10;
				  MemWrite = 1'b0;
				  BranchEn = 1'b0;
				  end
		3'b011: begin // swd
				  WriteSrc = 2'b11; //no case
				  ALUOp = 2'b10;
				  MemWrite = 1'b1; // memory write back
				  BranchEn = 1'b0;
				  end
		3'b100: begin // slt
				  WriteSrc = 2'b10; //slt case
				  ALUOp = 2'b10;
				  MemWrite = 1'b0;
				  BranchEn = 1'b0;
				  end
		3'b101: begin // beq
				  WriteSrc = 2'b11; //no case
				  ALUOp = 2'b01; // sub
				  MemWrite = 1'b0;
				  BranchEn = 1'b1; // branch toggled
				  end
		3'b110: begin // swp
				  WriteSrc = 2'b11; //no case
				  ALUOp = 2'b10;
				  MemWrite = 1'b0;
				  BranchEn = 1'b0;
				  end
		3'b111: begin // lim
				  WriteSrc = 2'b11; //no case
				  ALUOp = 2'b10;
				  MemWrite = 1'b0;
				  BranchEn = 1'b0;
				  end
		 endcase
	end


endmodule
