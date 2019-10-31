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
	input wire             i_clk,
	input wire             tx_empty,
	output 	wire [7:0] 	w_data,
	output 	wire 			rd_uart,
	output 	wire 			wr_uart
   );

	
	reg [7:0] datos;
	reg rd,wr;
	
	assign w_data = datos;
	
	always @ (*)
	begin
	   if(rx_empty != 1)
	       datos <= r_data;
	end
//	always @ (posedge i_clk)
//		if(i_reset)
//		begin
//			rd <= 1'b0;
//			wr <= 1'b0;
//		end
//		else
//		if(rx_empty != 1 && tx_full != 1)
//		begin
//			rd <= 1'b1;
//			wr <= 1'b1;
//		end
	
	always @(posedge i_clk)
	   if(i_reset)
	   begin
	       rd <= 1'b0;
	   end
	   else
	   if(rx_empty !=1 && tx_full != 1)
	   begin
	   rd <=1'b1;
	   end
	   else
	   begin
	       rd <=1'b0;
	   end
	
	   always @(posedge i_clk)
	   if(i_reset)
	   begin
	       wr<= 1'b0;   
	   end
	   else
	   if(rx_empty != 1)
	   begin
	       wr <=1'b1;
	   end
	   else
	   begin
	       wr <=1'b0;
	   end
			
	assign rd_uart = rd;
	assign wr_uart = wr;
	
endmodule
