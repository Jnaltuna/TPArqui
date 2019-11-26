`timescale 1ns / 1ps

module datapath_tb;

reg clk,rst,selB,WrAcc,Op;
reg [15:0] i_data_dm;
reg [10:0] operand;
reg [1:0] selA;
wire [10:0] addr_dm;
wire [15:0] o_data_dm;

datapath data(
    .i_clk              (clk),
    .i_rst              (rst),
    .i_data_dm          (i_data_dm),
    .i_operand          (operand),
    .i_selA             (selA),
    .i_selB             (selB),
    .i_WrAcc            (WrAcc),
    .i_Op               (Op),
    .o_addr_dm          (addr_dm),
    .o_data_dm          (o_data_dm)
);

initial begin
    
    clk <= 1'b0;
    rst <= 1'b1;
    selB <= 1'b0;
    WrAcc <= 1'b0;
    Op <= 1'b0;
    i_data_dm <= 16'd0;
    operand <= 11'd0;
    selA <= 2'b00;

    #10
    clk <= 1'b1;
    #10
    clk <= 1'b0;
    rst <= 1'b0;
    
    #10 //suma
    clk <= 1'b1;
    i_data_dm <= 11'd0;
    operand <= 11'd1;
    selA <= 2'd2;
    selB <= 1'b1;
    WrAcc <= 1'b1;
    Op <= 1'b1;

    #10
    clk <= 1'b0;

    #10 //suma
    clk <= 1'b1;
    i_data_dm <= 11'd0;
    operand <= 11'd1;
    selA <= 2'd2;
    selB <= 1'b1;
    WrAcc <= 1'b1;
    Op <= 1'b1;

    #10
    clk <= 1'b0;

    #10 //suma
    clk <= 1'b1;
    i_data_dm <= 11'd0;
    operand <= 11'd2;
    selA <= 2'd2;
    selB <= 1'b1;
    WrAcc <= 1'b1;
    Op <= 1'b0;

    #10
    clk <= 1'b0;

end

endmodule
