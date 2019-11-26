`timescale 1ns / 1ps

module control_tb;

reg i_clk,i_rst;
reg [15:0] i_instdata;
wire [1:0] selA;
wire selB,wrAcc,op,wrRam,rdRam;
wire [10:0] addr_pm,operand;

control control(
    .i_clk              (i_clk),
    .i_rst              (i_rst),
    .i_instdata         (i_instdata),
    .o_addr_pm          (addr_pm),
    .o_operand          (operand),
    .o_selA             (selA),
    .o_selB             (selB),    
    .o_wrAcc            (wrAcc),
    .o_op               (op),
    .o_wrRam            (wrRam),
    .o_rdRam            (rdRam)
);

initial
begin

i_clk <= 1'b0;
i_rst <= 1'b1;
i_instdata <= 16'b0000000000000000;

#10
i_rst <= 1'b0;

#10
i_instdata <= 16'b0000100000000001;
i_clk <= 1'b1;
#10
i_clk <= 1'b0;

#10
i_instdata <= 16'b0001000000000001;
i_clk <= 1'b1;
#10
i_clk <= 1'b0;

#10
i_instdata <= 16'b0001100000000001;
i_clk <= 1'b1;
#10
i_clk <= 1'b0;

#10
i_instdata <= 16'b0010000000000001;
i_clk <= 1'b1;
#10
i_clk <= 1'b0;

#10
i_instdata <= 16'b0010100000000001;
i_clk <= 1'b1;
#10
i_clk <= 1'b0;

#10
i_instdata <= 16'b0011000000000001;
i_clk <= 1'b1;
#10
i_clk <= 1'b0;

#10
i_instdata <= 16'b0011100000000001;
i_clk <= 1'b1;
#10
i_clk <= 1'b0;
end

endmodule
