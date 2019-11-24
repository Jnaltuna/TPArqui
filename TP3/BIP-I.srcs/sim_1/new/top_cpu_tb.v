`timescale 1ns / 1ps

module top_cpu_tb;

reg i_clk,i_rst;

cpu_top top(
    .i_clk      (i_clk),
    .i_rst      (i_rst)

);

initial
begin
i_clk <=1'b1;
i_rst <=1'b1;

#10
i_rst <=1'b0;

#100
$stop;
end

always
begin
#10
i_clk=~i_clk;
end

endmodule
