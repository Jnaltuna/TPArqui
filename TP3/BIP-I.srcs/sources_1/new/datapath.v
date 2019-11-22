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

wire [DBITS-1:0] au_result;
wire [DBITS-1:0] extended_op;
reg  [DBITS-1:0] mux_A;
reg  [DBITS-1:0] mux_B;
reg  [DBITS-1:0] ACC;

always @(*) 
begin
    case(i_selA)
        2'd0:       mux_A <= i_data_dm;
        2'd1:       mux_A <= extended_op;
        2'd2:       mux_A <= au_result;
        default:    mux_A <= extended_op;
    endcase
end

always @(*) 
begin
    case(i_selB)
        1'b0:       mux_B <= i_data_dm;
        1'b1:       mux_B <= extended_op;
    endcase
end

always @(posedge i_clk) 
begin
    if(i_WrAcc)
        ACC <= mux_A;
    else
        ACC <= ACC;
end


sig_extender
#(
    .NB_OPERAND                     (ADDR),
    .NB_EXTEND                      (DBITS-ADDR)
)
(
    .i_operand                      (i_operand),
    .o_extended                     (extended_op)
);

AU
#(
    .NB_OPERAND                     (DBITS)
)
(
    .i_operation                    (i_Op),
    .i_operandA                     (ACC),
    .i_operandB                     (mux_B),
    .o_result                       (au_result)
);

assign o_data_dm = ACC;
assign o_addr_dm = i_operand;
    
endmodule