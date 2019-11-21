`timescale 1ns / 1ps

module cpu
#(
    parameter DBITS = 16,
    parameter IBITS = 16,
    parameter ADDR = 11 //view name?
)
(
    input   wire                i_clk,
    input   wire                i_rst,
    input   wire    [IBITS-1:0] i_instdata,
    input   wire    [DBITS-1:0] i_data_dm,
    
    output  wire    [ADDR-1:0]  o_addr_pm,
    output  wire    [ADDR-1:0]  o_addr_dm,
    output  wire                o_Rd,
    output  wire                o_Wr,
    output  wire    [DBITS-1:0] o_data_dm    
    );
    
    control cont
    (
    );
    
    datapath data
    (
    );
    
    
endmodule