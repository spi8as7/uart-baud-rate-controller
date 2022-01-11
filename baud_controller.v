`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:16 11/04/2015 
// Design Name: 
// Module Name:    baud_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module baud_controller(
    input reset,
    input clk,
    input [2:0] baud_select,
    output sample_ENABLE
    );
	
	//MAXIMUM timi metriti 10416 ara thelei 14 bit
	reg[13:0] q;
	reg [13:0]counter;
	wire[13:0] q_next;

	//counter
	always@(posedge clk,posedge reset)
		if(reset)
			q<=0;
		else 
			q<= q_next;
	
	//rithmizei tin maximum timi tou metriti analogws to baud_rate
	always@(posedge clk,posedge reset)
		if(reset) 
			counter<=1;
		else
			case(baud_select) 
				3'b000: 	
							begin
							counter <= 14'b10100010110000;
							end
				3'b001: 	
							begin
							counter <= 12'b101000101100;
							end
				3'b010: 	
							begin
							counter <= 10'b1010001011;
							end
				3'b011: 	
							begin
							counter <= 9'b101000101;
							end
				3'b100: 	
							begin
							counter <= 8'b10100010;
							end
				3'b101: 	
							begin
							counter <= 7'b1010001;
							end
				3'b110: 	
							begin
							counter <= 6'b110110;
							end	
				3'b111: 	
							begin
							counter <= 5'b11100;
							end								
			endcase				
	
	//next state
	assign q_next = ( q == counter ) ? 0 : q+1;	
	//output
	assign sample_ENABLE = ( q == counter ) ? 1'b1 : 1'b0;

endmodule
