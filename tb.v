`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:33:46 11/06/2015
// Design Name:   baud_controller
// Module Name:   C:/Users/Stefanos/Desktop/Diktua/lab2/tb.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: baud_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

	// Inputs
	reg reset;
	reg clk;
	reg [2:0] baud_select;

	// Outputss
	wire sample_ENABLE;

	// Instantiate the Unit Under Test (UUT)
	baud_controller uut (
		.reset(reset), 
		.clk(clk), 
		.baud_select(baud_select), 
		.sample_ENABLE(sample_ENABLE)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		clk = 0;
		baud_select = 111;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#10000 $finish;	
	end
always #1 clk = ~ clk;    
endmodule

