`timescale 1ns / 1ps

module datapath
#(
    parameter DBITS = 16,
    parameter ADDR = 11 //view name?
)
(
    input   wire                    i_clk,
    input   wire                    i_rst,
    input   wire    [DBITS -1:0]    i_data_dm,
    input   wire    [ADDR-1:0]      i_operand,  
    input   wire    [1:0]           i_selA,
    input   wire                    i_selB,
    input   wire                    i_WrAcc,
    input   wire                    i_Op,
    
    output  wire    [ADDR-1:0]      o_addr_dm,
    output  wire    [DBITS-1:0]     o_data_dm
    );
    
    
endmodule