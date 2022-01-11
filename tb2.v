`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:58:54 11/07/2015
// Design Name:   uart_transmitter
// Module Name:   C:/Users/Stefanos/Desktop/Diktua/lab2/tb2.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_transmitter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb2;

	// Inputs
	reg reset;
	reg clk;
	reg [7:0] Tx_DATA;
	reg [2:0] baud_select;
	reg Tx_EN;
	reg Tx_WR;

	// Outputs
	wire TxD;
	wire Tx_BUSY;

	// Instantiate the Unit Under Test (UUT)
	uart_transmitter uut (
		.reset(reset), 
		.clk(clk), 
		.Tx_DATA(Tx_DATA), 
		.baud_select(baud_select), 
		.Tx_EN(Tx_EN), 
		.Tx_WR(Tx_WR), 
		.TxD(TxD), 
		.Tx_BUSY(Tx_BUSY)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		clk = 0;
		Tx_EN =1;
		baud_select = 111;
		Tx_DATA=8'b10101010;
		Tx_WR=1;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		reset = 0;
		//#799Tx_DATA=8'b11001000;
		#60 Tx_WR=0; 
		//#302 Tx_EN=0;
		//#800 Tx_WR=1;
		//#810 Tx_WR=0;
		#10000 $finish;	
	end
always #1 clk = ~ clk; 
//always #1 Tx_EN =  ~Tx_EN;
endmodule

