`timescale 1ns / 1ps
module flag_buf
#(
	parameter W = 8 // # buffer bits
)
(
	input		wire				i_clk,
	input		wire				i_reset,
	input 		wire				i_clr_flag,
	input 		wire				i_set_flag,
	input 		wire	[W-1:0] 	i_din,

	output 		wire 				o_flag,
	output 		wire 	[W-1:0] 	o_dout
);

//signal declaration
reg [W-1:0] buf_reg, buf_next;
reg 		flag_reg, flag_next;


//FF & register
always @(posedge i_clk, posedge i_reset) //ver si esta bien reset
begin

	if(i_reset)	begin

		buf_reg		<= 0;
		flag_reg 	<= 1'b0;

	end	else begin

		buf_reg 	<= buf_next;
		flag_reg 	<= flag_next;
	end
end


//next state logic
always @(*)
begin

	buf_next  = buf_reg;
	flag_next = flag_reg;

	if (i_set_flag)	begin

		buf_next = i_din;
		flag_next = 1'b1;

	end else if(i_clr_flag)

		flag_next = 1'b0;
end

//output logic
assign o_dout = buf_reg;
assign o_flag = flag_reg;

endmodule
