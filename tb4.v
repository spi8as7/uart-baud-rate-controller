`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:05:50 11/13/2015
// Design Name:   system
// Module Name:   C:/Users/Stefanos/Desktop/Diktua/lab2/tb4.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: system
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb4;

	// Inputs
	reg clk;
	reg reset;
	reg Tx_WR;
	reg Tx_EN;
	reg [2:0]baud_select;
	reg Rx_EN;
	reg RxD;
	//reg [7:0]Tx_DATA;

	// Outputs
	wire [7:0] Rx_DATA;
	wire Rx_FERROR;
	wire Rx_PERROR;
	wire Rx_VALID;
	wire TxD;
	wire Tx_BUSY;

	// Instantiate the Unit Under Test (UUT)
	system uut (
		.clk(clk), 
		.reset(reset), 
		.Tx_WR(Tx_WR), 
		.Tx_EN(Tx_EN), 
		.baud_select(baud_select), 
		.Rx_EN(Rx_EN), 
		.RxD(RxD),
		//.Tx_DATA(Tx_DATA),
		.Rx_DATA(Rx_DATA), 
		.Rx_FERROR(Rx_FERROR), 
		.Rx_PERROR(Rx_PERROR), 
		.Rx_VALID(Rx_VALID), 
		.TxD(TxD), 
		.Tx_BUSY(Tx_BUSY)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		//Tx_WR = 1;
		Tx_EN = 1;
		baud_select = 111;
		Rx_EN = 1;
		//Tx_DATA=8'b11101010;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		//#799Tx_DATA=8'b11111111;
		//#48 Tx_WR=0;
		#10000 $finish;	
	end
always #1 clk = ~ clk;
endmodule

