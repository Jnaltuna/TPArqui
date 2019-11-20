`timescale 1ns / 1ps

module control
#(
    parameter IBITS = 16,
    parameter ADDR = 11 //view name?
)
(
    input   wire                     i_clk,
    input   wire                     i_rst,
    input   wire    [IBITS -1:0]     i_instdata,
    
    output  wire    [ADDR -1:0]     o_addr_pm,
    output  wire    [ADDR -1:0]     o_operand,
    output  wire    [1:0]           o_selA,
    output  wire                    o_selB,    
    output  wire                    o_WrAcc,
    output  wire                    o_Op,
    output  wire                    o_WrRam,
    output  wire                    o_RdRam
    );
    
    
endmodule
