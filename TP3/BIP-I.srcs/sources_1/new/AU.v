`timescale 1ns / 1ps

module AU
#(
    parameter NB_OPERAND    = 16    
)
(
    input   wire                        i_operation,
    input   wire [NB_OPERAND-1  :   0]  i_operandA,
    input   wire [NB_OPERAND-1  :   0]  i_operandB, 
    
    output  wire [NB_OPERAND-1  :   0]  o_result
);

    reg [NB_OPERAND-1 : 0] regResult;
    
    assign o_result = regResult;

    always @(*)
    begin
        if(i_operation)
            regResult <= i_operandA + i_operandB;
        else
            regResult <= i_operandA - i_operandB;
    end

endmodule
