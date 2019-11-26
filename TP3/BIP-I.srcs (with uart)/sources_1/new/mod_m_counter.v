`timescale 1ns / 1ps

module mod_m_counter
#(
	parameter N = 4, //number of bits in counter
	parameter M = 10 //mod-M
)
(
	input  wire                clk,
	input  wire                reset,

	output wire                max_tick,
	output wire    [N-1:0]     q
);

//declaracion de registros
reg 	[N-1:0] r_reg;
wire 	[N-1:0] r_next;
	
//state change logic
always@(posedge clk)
begin
	if (reset) begin
		r_reg <= 0;
	end else begin
		r_reg <= r_next;
	end
end

//next-state logic
assign r_next = (r_reg==(M-1)) ? 0 : r_reg + 1; //if r_reg reaches max "M" value, set to 0. Else add 1

//output
assign q = r_reg;                               //output counter reg
assign max_tick = (r_reg==(M-1)) ? 1'b1 : 1'b0; //set tick when r_reg is max value, for 1 clock cycle


endmodule

