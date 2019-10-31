`timescale 1ns / 1ps
module uart_use
	#(
	parameter M1 = 8
	)
	(
	input 	wire			i_reset,
	input   wire            i_clk,
	input 	wire [7:0] 	    i_rx_data,
	input   wire            i_rx_done,
	input   wire            i_tx_done,
	output 	wire [7:0] 	    o_tx_data,
	output 	wire 			o_tx_start
   );

	
	reg [7:0] datos;
	reg rd,wr;
	
	assign o_tx_data = datos;
	
	//Take incoming data
	always @ (*)
	begin
	   if(i_rx_done)
	       datos <= i_rx_data;
	end
	
	always @(posedge i_clk)
	begin
	   if(i_rx_done)
	       rd <= 1'b1;
	   else
	       rd <= 1'b0;
	end

	always @(posedge i_clk)
	   if(i_reset)
	   begin
	       wr<= 1'b0;   
	   end
	   else
	   if(rd)
	   begin
	       wr <=1'b1;
	   end
	   else
	   begin
	       wr <=1'b0;
	   end
			
	assign o_tx_start = wr;
	
endmodule
