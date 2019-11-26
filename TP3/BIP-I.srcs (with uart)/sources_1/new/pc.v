`timescale 1ns / 1ps

module pc
#(
    parameter PCLEN = 11
)
(
    input wire  i_clk,
    input wire  i_rst,
    input wire  i_en,
    input wire [PCLEN-1:0] i_newPCval,
    
    output wire [PCLEN-1:0] o_PCval
);

reg [PCLEN -1 : 0] regPC;

//TODO possible error: not changing with every i_en signal
always @(negedge i_clk)
begin
    if(i_rst)
        regPC <=0;
    else if(i_en)
        regPC <= i_newPCval;
    else
        regPC <= regPC;
end

assign o_PCval = regPC;

endmodule
