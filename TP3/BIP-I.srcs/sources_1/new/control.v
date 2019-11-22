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
    localparam PCLEN = 11;
    
    reg [OPLEN-1 : 0] opcode;
    //wire [ADDR-1 :0] operand;
    wire en_PC; 
    wire [ADDR-1 :0] newPCval, PCval;
    
    
    
decoder
#(
    .OPLEN                          (OPLEN)
)
decod
(
    .i_opcode                       (opcode),
    .o_wrPC                         (en_PC),         //add
    .o_selA                         (o_selA),
    .o_selB                         (o_selB),    
    .o_wrAcc                        (o_wrAcc),
    .o_op                           (o_op),
    .o_wrRam                        (o_wrRam),
    .o_rdRam                        (o_rdRam)

); 

pc
#(
    .PCLEN                          (PCLEN)
) 
pc
(
    .i_clk                          (i_clk),
    .i_rst                          (i_rst),
    .i_en                           (en_PC),
    .i_newPCval                     (newPCval),
    .o_PCval                        (PCval)
);  

pc_adder 
#(
    .PCLEN                          (PCLEN)
)
pcadd
(
    .i_PCval                        (PCval),
    .o_newPCval                     (newPCval)
); 


always @ (*)
begin
    opcode <= i_instdata [15: 11];
end
//assign opcode = i_instdata [IBITS-1 -: OPLEN -1]; // view logic
assign o_operand = i_instdata [10:0]; // view logic
assign o_addr_pm = PCval;

    
endmodule
