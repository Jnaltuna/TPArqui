`timescale 1ns / 1ps

module sig_extender_tb;

	reg	[10:0]	operand;
	
	sig_extender
	#(
		.NB_OPERAND	(11),
		.NB_EXTEND	(5)
	)
	extender
	(
		.i_operand		(operand),
		.o_extended		()
	);

	initial begin
		
		operand = 11'd120;
		#2
		operand = 11'd305;
		#2
		operand = 11'd11;

	end
endmodule