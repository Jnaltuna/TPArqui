`timescale 1ns / 1ps

module pc_test;

	reg i_clk;
	reg i_reset;
	reg en;
	wire [10:0] newPCval, PCval;

    pc pc(
        .i_clk          (i_clk),
        .i_rst          (i_reset),
        .i_en           (en),
        .i_newPCval     (newPCval),
        .o_PCval        (PCval)
    );
    
    pc_adder add(
        .i_PCval        (PCval),
        .o_newPCval     (newPCval)    
    );
    
   initial
   begin
   i_clk = 1'b1;
   i_reset = 1'b1;
   en = 1'b0;
   #5
   i_reset = 1'b0;
   #100
   $stop;
   end
    
   always begin
    #2
    en = 1'b1;
    #1
    en = 1'b0;
   end
    
   always begin
     #1
     i_clk = ~i_clk;
   end


endmodule
