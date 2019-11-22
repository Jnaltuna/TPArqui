`timescale 1ns / 1ps

module sig_extender
#(
    parameter   NB_OPERAND  =   11,
    parameter   NB_EXTEND   =   5
)
(
    input   wire    [NB_OPERAND-1   :   0]  i_operand,
    
    output  wire    [NB_EXTEND-1    :   0]  o_extendedOp    
);

reg [NB_OPERAND+NB_EXTEND-1 : 0] extended;

assign  o_extendedOp = extended;

always @(*)
begin
    extended <= {{NB_EXTEND{1'b0}}, i_operand};
end

endmodule
