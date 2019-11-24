`timescale 1ns / 1ps

module mem_tb;

reg i_clk;
reg [0:0] wea;
reg [10:0] addra;
reg [15:0] dina;
wire [15:0] douta;

data_memory mem
(
    .clka       (i_clk),
    .wea        (wea),
    .addra      (addra),
    .dina       (dina),
    .douta      (douta)
);

initial begin
    
    i_clk <=0;

    #10
    i_clk <=1;
    wea <= 1'b1;
    addra <= 11'b00000000010;
    dina <= 16'b0000000000000011;

    #10
    i_clk <=0;

    #10
    i_clk <=1;
    wea<=1'b1;
    addra <= 11'b00000000011;
    dina<= 16'b0000000000000010;

    #10
    i_clk <=0;

    #10
    i_clk <=1;
    wea <= 1'b0;
    addra <= 11'b00000000010;
    //dina <= 16'b0000000000000011;

    #10
    i_clk <=0;

    #10
    i_clk <=1;

    #10
    i_clk <=0;


end

endmodule
