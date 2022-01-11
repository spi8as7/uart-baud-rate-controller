`timescale 1ns / 1ps
module uart_transmitter(
    input reset,
    input clk,
    input [7:0] Tx_DATA,
    input [2:0] baud_select,
    input Tx_EN, 
    input Tx_WR,
    output reg TxD,
    output reg Tx_BUSY
    );
	 
	reg [7:0] tx_byte;
	reg parity=0;
   reg [3:0] remaining_bits;
	reg [1:0]state=2'b00;
	reg [10:0]debug;
	 
	wire Tx_sample_ENABLE; 
	 
	 //paragei to sima pou tha xrisimopoiisei o transmitter gia na steilei dedomena
	 baud_controller baud_controller_tx_instance(reset,clk,baud_select,Tx_sample_ENABLE);
	 
	 //transmitter state machine
	 //00: arxikopoiei ta nea dedomena
	 //01: stelnei to 8bit minima
	 //10: upologizei kai stelnei to parity bit
	 //11: stelnei to stop bit
	 always@(Tx_sample_ENABLE) 
		if(Tx_EN && Tx_sample_ENABLE)
		begin
			case(state)
				2'b00:
						begin
							tx_byte <= Tx_DATA;
							remaining_bits <= 8;
							TxD <= 0;
							debug <= {TxD, debug[10:1]};
							Tx_BUSY<=1;
							state<= 2'b01;
							end  
			
				2'b01:		begin
								if(remaining_bits == 0)
									begin
									TxD <= tx_byte[0];
									tx_byte <= {1'b0, tx_byte[7:1]};
									debug <= {TxD, debug[10:1]};
									state <= 2'b10;
									end	
								else
									begin
									remaining_bits <= remaining_bits -1;
									TxD <= tx_byte[0];
									debug <= {TxD, debug[10:1]};
									if (TxD)
										parity <= ~parity;
									tx_byte <= {1'b0, tx_byte[7:1]};
									Tx_BUSY<=1;
									end
								end
				2'b10:			
									begin
									TxD <= parity;
									debug <= {TxD, debug[10:1]};
									parity<=0;
									Tx_BUSY<=1;
									state<=2'b11;
								end	
				2'b11:
									begin	
									TxD <= 1;
									debug <= {TxD, debug[10:1]};
									Tx_BUSY<=0;
									state<=2'b00;
									end	
			endcase
		end
		

endmodule
