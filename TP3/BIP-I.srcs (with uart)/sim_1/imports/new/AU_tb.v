`timescale 1ns / 1ps

module testb_AU;

reg			operation;
reg [15:0]	opA;
reg [15:0]	opB;

AU
#(
	.NB_OPERAND	(16)
)
au
(
	.i_operation	(operation),
	.i_operandA		(opA),
	.i_operandB		(opB),
	.o_result		()
);

initial begin

operation 	= 1'b1;
opA 		= 16'd15;
opB 		= 16'd10;

#2
operation 	= 1'b0;
#2
opA 		= 16'd10;
#2
opB 		= 16'd20;
#2
operation 	= 1'b1;

end

endmodule