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
wire tx_empty, tx_fifo_not_empty;
wire [7:0] tx_fifo_out, rx_data_out;
wire rd_uart,wr_uart;
wire [7:0] r_data;
wire [7:0] w_data;
//wire tx_full, rx_empty, r_data, rd_uart, wr_uart, w_data; //TODO ver estos
wire tx_full,rx_empty;
	
//baud rate generator
mod_m_counter
#(
	.M											(DVSR),
	.N											(DVSR_BIT)
)
baud_gen_unit
(
	.clk										(i_clk),
	.reset									(i_reset),
	.q											(		),
	.max_tick								(tick)
);

//Receptor uart
uart_rx
#(
	.DBIT										(DBIT),
	.SB_TICK									(SB_TICK)
)
uart_rx_unit
(
	.i_clk									(i_clk),
	.i_reset									(i_reset),
	.i_rx										(i_rx),
	.i_s_tick								(tick),
	.o_rx_done_tick						(rx_done_tick),
	.o_dout									(rx_data_out)
);

//fifo rx
fifo
#(
	.B											(DBIT),
	.W											(FIFO_W)
)
fifo_rx_unit
(
	.i_clk									(i_clk),
	.i_reset									(i_reset),
	.i_rd										(rd_uart),
	.i_wr										(rx_done_tick),
	.i_w_data								(rx_data_out), //w_data_out
	.o_empty									(rx_empty),
	.o_full									(			),
	.o_r_data								(r_data)
);
//fifo tx
fifo
#(
	.B(DBIT),
	.W(FIFO_W)
)
fifo_tx_unit
(
	.i_clk									(i_clk),
	.i_reset									(i_reset),
	.i_rd										(tx_done_tick),
	.i_wr										(wr_uart),
	.i_w_data								(w_data),
	.o_empty									(tx_empty),
	.o_full									(tx_full),
	.o_r_data								(tx_fifo_out)
);	

//Transmisor uart
uart_tx
#(
	.DBIT										(DBIT),
	.SB_TICK									(SB_TICK)
)
uart_tx_unit
(
	.i_clk									(i_clk),
	.i_reset									(i_reset),
	.i_tx_start								(tx_fifo_not_empty),
	.i_s_tick								(tick),
	.i_din									(tx_fifo_out),
	.o_tx_done_tick						(tx_done_tick),
	.o_tx										(o_tx)
);

//test
uart_use
#(
	.M1 										(DBIT)
)
dloop
(
	.tx_full 								(tx_full),
	.rx_empty 								(rx_empty),
	.r_data 									(r_data), //datos recibidos en rx
	.rd_uart 								(rd_uart),//señal para indicar que reciba
	.wr_uart 								(wr_uart),//señal para indicar que envie
	.w_data 									(w_data), //datos a enviar por tx
	.i_reset									(i_reset),
	.i_clk                                        (i_clk),
	.tx_empty                                  (tx_empty)
);
	
assign tx_fifo_not_empty = ~tx_empty;
	
endmodule