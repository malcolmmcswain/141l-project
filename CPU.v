// Module Name:    CPU 
// Project Name:   CSE141L
//
// Revision Fall 2020
// Based on SystemVerilog source code provided by John Eldon
// Comment:
// This is the TopLevel of your project
// Testbench will create an instance of your CPU and test it
// You may add a LUT if needed
// Set Ack to 1 to alert testbench that your CPU finishes doing a program or all 3 programs



	 
module CPU(Reset, Start, Clk,Ack);

	input Reset;		// init/reset, active high
	input Start;		// start next program
	input Clk;			// clock -- posedge used inside design
	output reg Ack;   // done flag from DUT

	
	
	wire [ 10:0] PgmCtr;        // program counter
	wire [ 7:0] PCTarg;        // PC Target (for relative shifts of PC)
	wire [ 8:0] Instruction;   // our 9-bit instruction
	wire [ 7:0] ReadA, ReadB;  // reg_file outputs
	wire [ 7:0] InA, InB, 	   // ALU operand inputs
					ALU_out;       // ALU result
	wire [ 7:0] RegWriteValue, // data in to reg file
	            MemReadValue;  // data out from data_memory
	wire        MemWrite,	   // data_memory write enable
					LT,				// ALU Less Than flag
				   Zero,		      // ALU output = 0 flag
					ALUOp,	      // to program counter: jump 
					BranchEn;	   // to program counter: branch enable
	wire [1:0]  WriteSrc;      // select line for 4:1 RegWrite mux
	reg  [15:0] CycleCt;	      // standalone; NOT PC!

	// Fetch = Program Counter + Instruction ROM
	// Program Counter
  InstFetch IF1 (
	.Reset       (Reset   ) , 
	.Start       (Start   ) ,  
	.Clk         (Clk     ) ,
	.BranchEn    (BranchEn) ,  // branch enable
	.ALU_flag	 (Zero    ) ,  // zero flag from ALU
   .Target      (PCTarg  ) ,  // for branch instructions
	.ProgCtr     (PgmCtr  )	   // program count = index to instruction memory
	);	

	// Control decoder
  Ctrl Ctrl1 (
	.Op  (Instruction[8:6]),    // from instr_ROM
	.WriteSrc    (WriteSrc),		     // to PC
	.ALUOp       (ALUOp),          // 1 or 0 for add or sub
	.MemWrite    (MemWrite),       // control input for datamem
	.BranchEn     (BranchEn)		  // to PC
  );
  
  
	// instruction ROM
  InstROM IR1(
	.InstAddress   (PgmCtr), 
	.InstOut       (Instruction)
	);
	
	always@*							  
	begin
		Ack = Instruction[0];  // Update this to the condition you want to set done to true
	end

	// Mux to select regwrite input
	Mux M1 (
		.in0 (ALU_out),       // ALU output
		.in1 (MemReadValue),  // value from memread - for swd
		.in2 (LT[7:0]),            // LT value - for slt
		.in3 (8'b00000000),   // garbage case
		.sel (WriteSrc),      // 2-bit select wire
		.out (RegWriteValue)  // register write DataIn
	);
	
	
	//Reg file
	// Modify D = *Number of bits you use for each register*
   // Width of register is 8 bits, do not modify
	RegFile #(.W(8),.D(3)) RF1 (
		.Clk    		 (Clk)		  , 	 
		.Instruction (Instruction) ,  // Actual instruction provided to regfile
		.DataIn      (RegWriteValue) , // Output from regwrite mux
		.DataOutA  (ReadA        ) ,
		.DataOutB  (ReadB		 ) ,
		.DataOutC  (PCTarg     ) // Only time this wire is used is for beq addressing
	);
	
	
	
	assign InA = ReadA;						                       // connect RF out to ALU in
	assign InB = ReadB;
	

	// Arithmetic Logic Unit
	ALU ALU1(
	  .InputA(InA),      	  
	  .InputB(InB),
	  .OP(Instruction[8:6]), //opcode
	  .Out(ALU_out),		  			
	  .Zero(Zero), // zero flag for beq
	  .LT(LT) // less than flag for slt
		 );
	 
	 // Data Memory
	 	DataMem DM1(
		.DataAddress  (ReadA)    , 
		.WriteEn      (MemWrite), // control input
		.DataIn       (ReadB), 
		.DataOut      (MemReadValue)  , 
		.Clk 		  	  (Clk)     ,
		.Reset		  (Reset)
	);

	
	
// count number of instructions executed
// Help you with debugging
	always @(posedge Clk)
	  if (Start == 1)	   // if(start)
		 CycleCt <= 0;
	  else if(Ack == 0)   // if(!halt)
		 CycleCt <= CycleCt+16'b1;

endmodule
