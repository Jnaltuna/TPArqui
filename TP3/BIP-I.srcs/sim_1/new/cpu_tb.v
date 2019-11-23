`timescale 1ns / 1ps

module cpu_tb;

reg i_clk,i_rst;
reg [15:0] i_instdata,i_data_dm;
wire [10:0] o_addr_dm,o_addr_pm;
wire o_Rd,o_Wr;
wire [15:0] o_data_dm;

cpu cpu(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_instdata(i_instdata),
    .i_data_dm(i_data_dm),
    .o_addr_pm(o_addr_pm),
    .o_addr_dm(o_addr_dm),
    .o_Rd(o_Rd),
    .o_Wr(o_Wr),
    .o_data_dm(o_data_dm)
);

initial
begin
    i_clk <= 1'b0;
    i_rst <= 1'b1;
    i_instdata <= 16'b0000000000000000;
    i_data_dm <=  16'b0000000000000000;

    #10
    i_rst <= 1'b0;

    #10 //ADDI 1 -> ACC = 1
    i_instdata <= 16'b0010100000000001;
    i_clk <= 1'b1;
    #10
    i_clk <= 1'b0;

    #10 //ADDI 3 -> ACC = 4
    i_instdata <= 16'b0010100000000011;
    i_clk <= 1'b1;
    #10
    i_clk <= 1'b0;

    #10 //SUBI 1 -> ACC = 3
    i_instdata <= 16'b0011100000000001;
    i_clk <= 1'b1;
    #10
    i_clk <= 1'b0;

    #10 //ADD [1] -> ACC = 7
    i_instdata <= 16'b0010010000000001;
    i_data_dm <=  16'b0000000000000100;
    i_clk <= 1'b1;
    #10
    i_clk <= 1'b0;

    #10 //STO [7] -> o_data_dm = 7
    i_instdata <= 16'b0000100000000111;
    i_clk <= 1'b1;
    #10
    i_clk <= 1'b0;

    #10 //LD [1] -> ACC = 11111...
    i_instdata <= 16'b0001000000000001;
    i_data_dm <=  16'b1111111111111111;
    i_clk <= 1'b1;
    #10
    i_clk <= 1'b0;

end





endmodule
