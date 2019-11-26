`timescale 1ns / 1ps

//Uart top interface. Creates instance of TX module, RX module, module that implements ALU and sends results to LED for testing.
module uart
#( //Current settings: 9600 baud, 8 data bits, 1 stop 
	parameter	DBIT 	 = 8,              //number of data bits
	parameter	SB_TICK  = 16,             //number of ticks that the stop bit uses. 16 = 1 stop bit  
	parameter	DVSR 	 = 651,            //number to count to for mod_m_counter
	parameter	DVSR_BIT = 16,             //number of bits for counter
	parameter	FIFO_W 	 = 1               //for use if fifo is implementer. number of places
)
(
	input 	wire 			i_clk,		    //clock del sistema
	input 	wire 			i_reset,		//algun pulsaor
	input 	wire			i_rx,			//a pc
	input   wire            i_sw,
	
	output	wire 			o_tx,	        //a pc
	output  wire [15:0]      led             //LEDs to test result before TX
);

//declaracion de registros/wires
wire tick, rx_done_tick, tx_done_tick;
wire [7:0] rx_data_out; //data received 
wire [7:0] tx_data_in;  //data to be sent
wire tx_start;          //used to start transmission
//reg [15:0] res;          //store result to display on LEDs
	
//baud rate generator
mod_m_counter
#(
	.M										   (DVSR),    //number to count to
	.N										   (DVSR_BIT) //number of bits on counter
)
baud_gen_unit
(
	.clk									   (i_clk),
	.reset									   (i_reset),
	.q										   (		),
	.max_tick								   (tick)     //tick generates when counter reaches "M"
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

//module to use uart TX and RX
uart_use
#(
	.M1 										(DBIT)
)
dloop
(
    .i_reset                                    (i_reset),
    .i_clk                                      (i_clk),
    .i_rx_data                                  (rx_data_out),  //data rec lane
    .i_rx_done                                  (rx_done_tick), //rx valid tick
    .i_tx_done                                  (tx_done_tick), //tx valid tick
    .o_tx_data                                  (tx_data_in),   //data tx lane
    .o_tx_start                                 (tx_start),  
    .o_to_led                                   (led),   
    .i_sw                                       (i_sw) 
    
);

//used for testing alu output
//always @ (posedge i_clk)
//begin
//    if(i_reset)
//        res <= 15'b0;
//    else if(tx_start)
//        res <= tx_data_in;
//end

//assign led = res;
	
endmodule
