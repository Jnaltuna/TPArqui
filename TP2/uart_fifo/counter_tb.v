`timescale 1ns / 1ps
module counter_tb();

	localparam N = 8;
	localparam M = 163;
	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire max_tick;
	wire [N-1:0] q;

	initial begin
		// Initialize Inputs
		clk = 1'b1;
		reset = 1'b1;
		#5
		reset = 0'b0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end

	always begin
     #1
     clk = ~clk;
   end
      
	// Instantiate the Unit Under Test (UUT)
	mod_m_counter 
	#(
		.N(N),
		.M(M)
	)
	contador
	(
		.clk(clk), 
		.reset(reset), 
		.max_tick(max_tick), 
		.q(q)
	);
	
endmodule

