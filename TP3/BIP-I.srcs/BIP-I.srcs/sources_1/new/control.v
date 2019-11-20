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
    output  wire                    o_wrAcc,
    output  wire                    o_op,
    output  wire                    o_wrRam,
    output  wire                    o_rdRam
    );
    
    localparam OPLEN = 5;
    
    wire [OPLEN-1 : 0] opcode;
    wire [ADDR-1 :0] operand;
    
    
    
decoder
#(
    .OPLEN                          (OPLEN)
)
decod
(
    .i_opcode                       (opcode),
    .o_wrPC                         (),         //add
    .o_selA                         (o_selA),
    .o_selB                         (o_selB),    
    .o_wrAcc                        (o_wrAcc),
    .o_op                           (o_op),
    .o_wrRam                        (o_wrRam),
    .o_rdRam                        (o_rdRam)

);    

assign opcode = i_instdata [IBITS-1 +: OPLEN -1]; // view logic
assign operand = i_instdata [IBITS-1+OPLEN :0]; // view logic

    
endmodule
