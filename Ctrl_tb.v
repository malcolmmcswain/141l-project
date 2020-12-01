`timescale 1ns/ 1ps

// Test bench for Control Unit
module Ctrl_tb;
reg [2:0] Op;
wire [1:0] WriteSrc;
wire ALUOp, MemWrite, BranchEn;

// CONNECTION
Ctrl uut(
  .Op(Op),      	  
  .WriteSrc(WriteSrc),
  .ALUOp(ALUOp),				  
  .MemWrite(MemWrite),		  			
  .BranchEn(BranchEn)
 );
 
 initial begin
	
	Op = 3'b000;
	#1
	if (WriteSrc == 2'b00 && ALUOp == 1'b0
		&& MemWrite == 1'b0 && BranchEn == 1'b0) begin
		$display("YAY!! add passed!");
	end else begin 
		$display("Add failed!");
	end
	
	
	Op = 3'b001;
	#1
	if (WriteSrc == 2'b00 && ALUOp == 1'b1
		&& MemWrite == 1'b0 && BranchEn == 1'b0) begin
		$display("YAY!! sub passed!");
	end else begin 
		$display("Sub failed!");
	end
	
	Op = 3'b010;
	#1
	if (WriteSrc == 2'b01 && ALUOp == 1'b0
		&& MemWrite == 1'b0 && BranchEn == 1'b0) begin
		$display("YAY!! lwd passed!");
	end else begin 
		$display("Lwd failed!");
	end
	
	Op = 3'b011;
	#1
	if (WriteSrc == 2'b11 && ALUOp == 1'b0
		&& MemWrite == 1'b1 && BranchEn == 1'b0) begin
		$display("YAY!! swd passed!");
	end else begin 
		$display("Swd failed!");
	end

	
	Op = 3'b100;
	#1
	if (WriteSrc == 2'b10 && ALUOp == 1'b0
		&& MemWrite == 1'b0 && BranchEn == 1'b0) begin
		$display("YAY!! slt passed!");
	end else begin 
		$display("Slt failed!");
	end
	
	Op = 3'b101;
	#1
	if (WriteSrc == 2'b11 && ALUOp == 1'b1
		&& MemWrite == 1'b0 && BranchEn == 1'b1) begin
		$display("YAY!! beq passed!");
	end else begin 
		$display("Beq failed!");
	end
	
	Op = 3'b110;
	#1
	if (WriteSrc == 2'b11 && ALUOp == 1'b0
		&& MemWrite == 1'b0 && BranchEn == 1'b0) begin
		$display("YAY!! swp passed!");
	end else begin 
		$display("Swp failed!");
	end
	
	Op = 3'b111;
	#1
	if (WriteSrc == 2'b11 && ALUOp == 1'b0
		&& MemWrite == 1'b0 && BranchEn == 1'b0) begin
		$display("YAY!! lim passed!");
	end else begin 
		$display("Lim failed!");
	end
	
	
 end
 endmodule
 