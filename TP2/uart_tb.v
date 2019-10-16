`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:11:54 10/16/2019
// Design Name:   uart
// Module Name:   /home/jna/Xilinx/13.4/ISE_DS/tp2/uart_tb.v
// Project Name:  tp2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_tb;

	// Inputs
	reg i_clk;
	reg i_reset;
	reg i_rx;

	// Outputs
	wire o_tx;
	
	reg trans;

	// Instantiate the Unit Under Test (UUT)
	uart 
	#(
	.DVSR(5)
	)
	uut (
		.i_clk(i_clk), 
		.i_reset(i_reset), 
		.i_rx(i_rx), 
		.o_tx(o_tx)
	);

	initial begin
		// Initialize Inputs
		i_clk = 1'b1;
		i_reset = 1'b1;
		i_rx = 1'b1; //inicio
		
		#5
		i_reset = 1'b0;
		#160 //start
		i_rx = 1'b0; 
		#160
		i_rx = 1'b1; //data = 10101010
		#160
		i_rx = 1'b0; 
		#160
		i_rx = 1'b1;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b1;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b1;
		#160
		i_rx = 1'b0;
		
		#160 //stop
		i_rx = 1'b1; 

	end
	
	always begin
     #1
     i_clk = ~i_clk;
   end
	
	always @ (*) begin
		if(i_reset)
			trans <= 0'b0;
		else
			trans <= o_tx;
	end
      
endmodule

