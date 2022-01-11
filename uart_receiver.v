`timescale 1ns / 1ps
module uart_receiver(
    input reset,
    input clk,
    input [2:0] baud_select,
    input Rx_EN,
    input RxD,
    output reg [7:0] Rx_DATA,
    output Rx_FERROR,  //FRAMING ERROR
    output reg Rx_PERROR,  //PARITY ERROR
    output reg Rx_VALID    //Rx_DATA IS VALID
    );

	
	wire Rx_sample_ENABLE;
   reg [3:0] remaining_bits;
	reg [1:0]state=2'b00;	
	reg parity=0; // ama vgalei 0 ine zugoi oi assoi
	reg [10:0]debug;
	reg debug_sima;
	
	baud_controller baud_controller_rx_instance(reset,clk,baud_select,Rx_sample_ENABLE);
	//receiver state machine
	//00 : dexetai start bit kai kanei arxikopoiiseis
	//01 : dexetai 8bit message
	//10 : upologizei to parity kai to sugkrinei me auto pou pire
	//11 : stelnei stop bit
	always@(Rx_sample_ENABLE) 
		if(Rx_EN && Rx_sample_ENABLE)
			case(state)
				2'b00:	begin
							Rx_VALID<=0;
							if(!RxD)	
								begin
								debug <= {RxD, debug[10:1]};
								remaining_bits <= 8;
								state<=2'b01;
								debug_sima<=RxD;	
								end
							end	
				2'b01:   begin
								Rx_VALID<=0;
								//if(remaining_bits == 0)
								//	begin
								//	state<=2'b10;
								//	Rx_DATA <= {RxD, Rx_DATA[7:1]};
									//debug <= {RxD, debug[10:1]};
									//end
								//else 
									begin
									remaining_bits <= remaining_bits -1;
									if(remaining_bits == 1)
										begin
										state<=2'b10;
										//Rx_DATA <= {RxD, Rx_DATA[7:1]};
										debug <= {RxD, debug[10:1]};
										debug_sima<=RxD;
										end
									if (RxD)
										parity <= ~parity;
									Rx_DATA <= {RxD, Rx_DATA[7:1]};
									debug <= {RxD, debug[10:1]};
									debug_sima<=RxD;
									end
							end		
				2'b10:	begin
							//Rx_VALID<=0;
							debug <= {RxD, debug[10:1]};
							debug_sima<=RxD;
							if(RxD == parity)
								begin
								state<=11;
								Rx_VALID<=1;
								debug_sima<=RxD;
								end
							else
								begin
								state<=00;
								debug_sima<=RxD;
								Rx_PERROR<=1;
								end
							end
				2'b11:	begin
							state<=00;
							debug <= {RxD, debug[10:1]};
							debug_sima<=RxD;
							Rx_VALID<=1;
							end
	endcase
endmodule
