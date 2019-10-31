`timescale 1ns / 1ps

module uart_rx_tb;

	localparam M = 5;
	localparam N = 8;

	// Inputs
	reg i_clk;
	reg i_reset;
	reg i_rx;
	wire i_s_tick;

	// Outputs
	wire o_rx_done_tick;
	wire [7:0] o_dout;
	
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
		
        
		// Add stimulus here

	end
	
	always begin
     #1
     i_clk = ~i_clk;
   end
	
	mod_m_counter
	#(
		.N(N),
		.M(M)
	)
	baud
	(
		.clk(i_clk),
		.reset(i_reset),
		.max_tick(i_s_tick),
		.q()
	);

	// Instantiate the Unit Under Test (UUT)
	uart_rx uut (
		.i_clk(i_clk), 
		.i_reset(i_reset), 
		.i_rx(i_rx), 
		.i_s_tick(i_s_tick), 
		.o_rx_done_tick(o_rx_done_tick), 
		.o_dout(o_dout)
	);
      
endmodule

