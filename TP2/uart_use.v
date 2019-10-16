`timescale 1ns / 1ps
module uart_use
	#(
	parameter M1 = 8
	)
	(
	input 	wire 			tx_full,
	input 	wire 			rx_empty,
	input 	wire [7:0] 	r_data,
	input 	wire			i_reset,
	output 	wire [7:0] 	w_data,
	output 	wire 			rd_uart,
	output 	wire 			wr_uart
   );

	assign w_data = r_data + 1;
	reg rd,wr;
	
	always @ (*)
		if(i_reset)
		begin
			rd <= 1'b0;
			wr <= 1'b0;
		end
		else
		if(rx_empty != 1 && tx_full != 1)
		begin
			rd <= 1'b1;
			wr <= 1'b1;
		end
			
	assign rd_uart = rd;
	assign wr_uart = wr;
	
endmodule
