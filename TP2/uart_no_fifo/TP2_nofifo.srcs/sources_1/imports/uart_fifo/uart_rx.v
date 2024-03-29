`timescale 1ns / 1ps

module uart_rx
#(
	parameter 				DBIT 	= 8, // # data bits
	parameter 				SB_TICK = 16 // # ticks for stop bits
)
(
	input 	wire 			i_clk,			//clock del sistema
	input 	wire 			i_reset,		//mismo reset que uart
	input 	wire 			i_rx,			//dato entrante
	input 	wire 			i_s_tick,		//tick que viene del baud rate gen

	output 	reg 			o_rx_done_tick,	//indica que el dato en dout es el recibido
	output 	wire 	[7:0]	o_dout			//cuando rx_done_tick esta en 1, tiene el dato recibido
);
 
//symbolic state declaration
localparam [1:0]
	idle 	= 2'b00,
	start 	= 2'b01,
	data 	= 2'b10,
	stop 	= 2'b11;
	
//signal declaration
reg [1:0] state_reg, state_next;
reg [3:0] s_reg, s_next;
reg [2:0] n_reg, n_next;
reg [7:0] b_reg, b_next;


//FSMD state & data registers
always @(posedge i_clk, posedge i_reset) //esta bien posedge reset???
begin

	if(i_reset) begin

		state_reg <= idle;
		s_reg <= 0;
		n_reg <= 0;
		b_reg <= 0;
	
	end	else begin

		state_reg <= state_next;
		s_reg <= s_next;
		n_reg <= n_next;
		b_reg <= b_next;
	end
end

always @(*)
begin

	state_next 		= state_reg;
	o_rx_done_tick 	= 1'b0;
	s_next 			= s_reg;
	n_next 			= n_reg;
	b_next 			= b_reg;

	case(state_reg)
		idle:
			if(~i_rx) begin
				state_next = start;
				s_next = 0;
			end
		start:
			if(i_s_tick)
				if(s_reg == 7) begin
					state_next = data;
					s_next = 0;
					n_next = 0;
				end	else
					s_next = s_reg + 1;
		data:
			if(i_s_tick)
				if(s_reg == 15) begin
						s_next = 0;
						b_next = {i_rx, b_reg[7:1]};

						if(n_reg==(DBIT-1))
							state_next = stop;
						else
							n_next = n_reg + 1;
				end	else
					s_next = s_reg + 1;
		stop:
			if(i_s_tick)
				if(s_reg==(SB_TICK-1)) begin
					state_next = idle;
					o_rx_done_tick = 1'b1;

				end	else
					s_next = s_reg + 1;
		//default: // Do nothing?
	endcase
end

//output
assign o_dout = b_reg;
	
endmodule
