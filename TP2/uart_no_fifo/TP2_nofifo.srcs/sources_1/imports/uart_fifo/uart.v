`timescale 1ns / 1ps

module uart
#( //Default settings: 19200 baud, 8 data bits, 1 stop, 2² fifo
	parameter	DBIT 	 = 8,
	parameter	SB_TICK  = 16,
	parameter	DVSR 	 = 163,
	parameter	DVSR_BIT = 8,
	parameter	FIFO_W 	 = 1
)
(
	input 	wire 			i_clk,		//clock del sistema
	input 	wire 			i_reset,		//algun pulsaor
	input 	wire			i_rx,			//a pc
	
	output	wire 			o_tx			//a pc
);
	//input wire i_rd_uart, i_wr_uart, [7:0] i_w_data
	//output o_tx_full, o_rx_empty,  [7:0] o_r_data
	
	//declaracion de registros/wires
wire tick, rx_done_tick, tx_done_tick;
wire [7:0] rx_data_out;
wire [7:0] tx_data_in;
//wire rd_uart,wr_uart;
//wire [7:0] r_data;
wire [7:0] w_data;
wire tx_start;
//wire tx_full, rx_empty, r_data, rd_uart, wr_uart, w_data; //TODO ver estos
	
//baud rate generator
mod_m_counter
#(
	.M										   (DVSR),
	.N										   (DVSR_BIT)
)
baud_gen_unit
(
	.clk									   (i_clk),
	.reset									   (i_reset),
	.q										   (		),
	.max_tick								   (tick)
);

//Receptor uart
uart_rx
#(
	.DBIT									   (DBIT),
	.SB_TICK								   (SB_TICK)
)
uart_rx_unit
(
	.i_clk									   (i_clk),
	.i_reset								   (i_reset),
	.i_rx									   (i_rx),
	.i_s_tick								   (tick),
	.o_rx_done_tick						       (rx_done_tick),
	.o_dout									   (rx_data_out)
);

//Transmisor uart
uart_tx
#(
	.DBIT										(DBIT),
	.SB_TICK									(SB_TICK)
)
uart_tx_unit
(
	.i_clk									    (i_clk),
	.i_reset									(i_reset),
	.i_tx_start								    (tx_start),
	.i_s_tick								    (tick),
	.i_din									    (tx_data_in),
	.o_tx_done_tick						        (tx_done_tick),
	.o_tx										(o_tx)
);

//test
uart_use
#(
	.M1 										(DBIT)
)
dloop
(
    .i_reset                                    (i_reset),
    .i_clk                                      (i_clk),
    .i_rx_data                                  (rx_data_out),
    .i_rx_done                                  (rx_done_tick),
    .i_tx_done                                  (tx_done_tick),
    .o_tx_data                                  (tx_data_in),
    .o_tx_start                                 (tx_start)
    
);
	
endmodule
