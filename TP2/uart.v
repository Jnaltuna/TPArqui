`timescale 1ns / 1ps
module uart
	#( //Default settings: 19200 baud, 8 data bits, 1 stop, 2² fifo
		parameter	DBIT = 8,
		parameter	SB_TICK = 16,
		parameter	DVSR = 163,
		parameter	DVSR_BIT = 8,
		parameter	FIFO_W = 2
   )
	(
		input 	wire 			i_clk,
		input 	wire 			i_reset,
		input 	wire 			i_rd_uart,
		input		wire 			i_wr_uart,
		input 	wire			i_rx,
		input 	wire [7:0] 	i_w_data,
		output 	wire 			o_tx_full,
		output	wire 			o_rx_empty,
		output	wire 			o_tx,
		output 	wire [7:0] 	o_r_data
	);
	
	//signals
	wire tick, rx_done_tick, tx_done_tick;
	wire tx_empty, tx_fifo_not_empty;
	wire [7:0] tx_fifo_out, rx_data_out;
	
	//body
	
	//falta codigo, pagina 260
endmodule
