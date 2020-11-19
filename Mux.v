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

module Mux (in0, in1, in2, in3, sel, out);


  input[7:0] in0, in1, in2, in3;	   // opcode
  input[1:0] sel;
  output wire[7:0] out;

	assign out = (sel == 2'b00 || sel == 2'b01) ? (sel == 2'b00 ? in0 : in1) : (sel == 2'b10 ? in2 : in3);


endmodule
