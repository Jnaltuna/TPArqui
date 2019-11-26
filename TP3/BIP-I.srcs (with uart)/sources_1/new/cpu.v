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

    //Declaracion de wires internos
    wire selB,wrAcc,op;
    wire [1:0] selA;
    wire [10:0] operand;
    
    control
    #(
        .IBITS                      (IBITS),
        .ADDR                       (ADDR)
    )
     cont
    (
        .i_clk                      (i_clk),
        .i_rst                      (i_rst),
        .i_instdata                 (i_instdata),
        .o_addr_pm                  (o_addr_pm),
        .o_operand                  (operand),
        .o_selA                     (selA),
        .o_selB                     (selB),    
        .o_wrAcc                    (wrAcc),
        .o_op                       (op),
        .o_wrRam                    (o_Wr),
        .o_rdRam                    (o_Rd)
    );
    
    datapath
    #(
        .DBITS                      (DBITS),
        .ADDR                       (ADDR)
    ) 
    data
    (
        .i_clk                      (i_clk),
        .i_rst                      (i_rst),
        .i_data_dm                  (i_data_dm),
        .i_operand                  (operand),
        .i_selA                     (selA),
        .i_selB                     (selB),
        .i_WrAcc                    (wrAcc),
        .i_Op                       (op),
        .o_addr_dm                  (o_addr_dm),
        .o_data_dm                  (o_data_dm)
    );
    
    
endmodule