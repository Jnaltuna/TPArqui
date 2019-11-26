`timescale 1ns / 1ps


module uart_tb;

	// Inputs
	reg i_clk;
	reg i_reset;
	reg i_rx;

	// Outputs
	wire o_tx;
	
	reg trans;
	reg i_sw;
	wire [15:0] led;

	// Instantiate the Unit Under Test (UUT)
	uart 
	#(
	.DVSR(5)
	)
	uut (
		.i_clk(i_clk), 
		.i_reset(i_reset), 
		.i_rx(i_rx), 
		.o_tx(o_tx),
		.i_sw(i_sw),
		.led(led)
	);

	initial begin
		// Initialize Inputs
		i_clk = 1'b1;
		i_reset = 1'b1;
		i_rx = 1'b1; //inicio
		
		#5
		i_reset = 1'b0;
		#160 //startA
		i_rx = 1'b0; 
		#160
		i_rx = 1'b1; //dataA = 00000001
		#160
		i_rx = 1'b0; 
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160
		i_rx = 1'b0;
		#160 //stop
		i_rx = 1'b1; 
		
		#200
		i_sw = 1'b0;
		
		#200
		i_sw = 1'b1;
		
	end
	
	always begin
     #1
     i_clk = ~i_clk;
   end
	
	always @ (*) begin
		if(i_reset)
			trans <= 1'b0;
		else
			trans <= o_tx;
	end
      
endmodule