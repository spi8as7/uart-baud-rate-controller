`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:20:37 11/12/2015
// Design Name:   uart_receiver
// Module Name:   C:/Users/Stefanos/Desktop/Diktua/lab2/tb3.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_receiver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb3;

	// Inputs
	reg reset;
	reg clk;
	reg [2:0] baud_select;
	reg Rx_EN;
	reg RxD;

	// Outputs
	wire [7:0] Rx_DATA;
	wire Rx_FERROR;
	wire Rx_PERROR;
	wire Rx_VALID;

	// Instantiate the Unit Under Test (UUT)
	uart_receiver uut (
		.reset(reset), 
		.clk(clk), 
		.baud_select(baud_select), 
		.Rx_EN(Rx_EN), 
		.RxD(RxD), 
		.Rx_DATA(Rx_DATA), 
		.Rx_FERROR(Rx_FERROR), 
		.Rx_PERROR(Rx_PERROR), 
		.Rx_VALID(Rx_VALID)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		clk = 0;
		Rx_EN =1;
		baud_select = 111;
		//Tx_DATA=8'b10101110;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#50RxD=0; //start bit
		#58RxD=0;
		#58RxD=1;
		#58RxD=0;
		#58RxD=1;
		#58RxD=0;
		#58RxD=1;
		#58RxD=0;
		#58RxD=1;
		#58RxD=0; //parity bit
		#58RxD=1; //stop bit
		#10000 $finish;	
	end
	
always #1 clk = ~ clk; 
//always #1 Rx_EN =  ~Rx_EN;      

endmodule

