`timescale 1ns / 1ps
module system(
    input clk,
    input reset,
	 input Tx_WR,
	 input Tx_EN,
	 input [2:0]baud_select,
	 input Rx_EN,
    input RxD,
    output reg [7:0] Rx_DATA,
    output reg Rx_FERROR,  //FRAMING ERROR
    output reg Rx_PERROR,  //PARITY ERROR
    output reg Rx_VALID,    //Rx_DATA IS VALID
	 output reg TxD,
    output reg Tx_BUSY
    );

	reg [7:0] tx_byte;
	reg parity1=0;
   reg [3:0] remaining_bits1;
	reg [1:0]state1=2'b00;
	wire Rx_sample_ENABLE;
   reg [3:0] remaining_bits2;
	reg [1:0]state2=2'b00;	
	reg parity2=0; // ama vgalei 0 ine zugoi oi assoi
	reg [7:0]Tx_DATA;
			
	//paragetai to sima pou tha xrisimopoiithei gia tin epikoinwnia  
	baud_controller baud_controller_tx_instance(reset,clk,baud_select,Rx_sample_ENABLE);
	
	//transmitter state machine
	 //00: arxikopoiei ta nea dedomena
	 //01: stelnei to 8bit minima
	 //10: upologizei kai stelnei to parity bit
	 //11: stelnei to stop bit
	always@(Rx_sample_ENABLE) 
		if(Tx_EN && Rx_sample_ENABLE)
		begin
			case(state1)
				2'b00:
						begin
							tx_byte <= Tx_DATA;
							remaining_bits1 <= 8;
							TxD <= 0;
							Tx_BUSY<=1;
							state1<= 2'b01;
							end  
			
				2'b01:		begin
								if(remaining_bits1 == 0)
									begin
									TxD <= tx_byte[0];
									tx_byte <= {1'b0, tx_byte[7:1]};
									state1 <= 2'b10;
									end	
								else
									begin
									remaining_bits1 <= remaining_bits1 -1;
									TxD <= tx_byte[0];
									if (TxD)
										parity1 <= ~parity1;
									tx_byte <= {1'b0, tx_byte[7:1]};
									Tx_BUSY<=1;
									end
								end
				2'b10:			
									begin
									TxD <= parity1;
									parity1<=0;
									Tx_BUSY<=1;
									state1<=2'b11;
								end	
				2'b11:
									begin	
									TxD <= 1;
									Tx_BUSY<=0;
									state1<=2'b00;
									end	
			endcase
		end
		
		//receiver state machine
		//00 : dexetai start bit kai kanei arxikopoiiseis
		//01 : dexetai 8bit message
		//10 : upologizei to parity kai to sugkrinei me auto pou pire
		//11 : stelnei stop bit
		always@(Rx_sample_ENABLE) 
		if(Rx_EN && Rx_sample_ENABLE)
			case(state2)
				2'b00:	begin
							Rx_VALID<=0;
							if(!TxD)	
								begin
								remaining_bits2 <= 8;
								state2<=2'b01;	
								end
							end	
				2'b01:   begin
								Rx_VALID<=0; 
									begin
									remaining_bits2 <= remaining_bits2 -1;
									if(remaining_bits2 == 1)
										begin
										state2<=2'b10;;
										end
									if (RxD)
										parity2 <= ~parity2;
									Rx_DATA <= {TxD, Rx_DATA[7:1]};
									end
							end		
				2'b10:	begin
							if(TxD == parity2)
								begin
								state2<=11;
								Rx_VALID<=1;
								Rx_PERROR<=0;
								end
							else
								begin
								state2<=00;
								Rx_PERROR<=1;
								end
							end
				2'b11:	begin
							state2<=00;
							Rx_VALID<=1;
							Rx_FERROR<=0;
							end
		endcase
		//metritis pou analamvanei na allaksei ta dedomena ton transmitter tin katallili stigmi
		reg [1:0]counter=2'b00;
		always@(Tx_BUSY)
			if(!Tx_BUSY)
				case(counter)
					2'b00: Tx_DATA<=8'b10101010;
					2'b01: Tx_DATA<=8'b11110000;
					2'b10: Tx_DATA<=8'b00001111;
					2'b11: Tx_DATA<=8'b01010101;
				endcase
		always@(Tx_BUSY)
			if(!Tx_BUSY)
				counter<=counter+1; 	
				
endmodule
