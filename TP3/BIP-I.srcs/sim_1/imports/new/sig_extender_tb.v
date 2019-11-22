`timescale 1ns / 1ps

module sig_extender_tb;

	reg	[10:0]	operand;
	
	sig_extender extender
	(
		.i_operand		(operand),
		.o_extendedOp	()
	);

	initial 
	begin
		
		operand <= 11'd120;
		#2
		operand <= 11'd305;
		#2
		operand <= 11'd11;

	end
endmodule