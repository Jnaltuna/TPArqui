`timescale 1ns / 1ps

module pc_adder
#(
    parameter PCLEN = 11,
    parameter ADD   = 1
)
(
    input wire [PCLEN-1:0] i_PCval,
    
    output wire [PCLEN-1:0] o_newPCval
);

    reg [PCLEN-1:0] regSum;
    
    always@ (*)
    begin
        regSum <= i_PCval + ADD;
    end
    
    assign o_newPCval = regSum;
endmodule
