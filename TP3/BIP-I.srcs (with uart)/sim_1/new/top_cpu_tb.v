`timescale 1ns / 1ps

module top_cpu_tb;

reg i_clk,i_rst;
//wire [10:0] pc;
//wire [15:0] acc;
//wire [15:0] inst;
wire [15:0] led;

cpu_top top(
    .i_clk      (i_clk),
    .i_rst      (i_rst),
    .led        (led)
    //.o_pc       (pc),
    //.o_acc      (acc),
    //.o_inst     (inst)
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
