`timescale 1ns / 1ps

module cpu_top
(
    input   wire        i_clk,
    input   wire        i_rst,
    output  wire        led //remove after
);

localparam DBITS = 16;
localparam IBITS = 16;
localparam ADDR  = 11;

wire [IBITS-1:0] instdata;
wire [DBITS-1:0] i_data_dm, o_data_dm;
wire [ADDR-1:0] addr_pm,addr_dm;
wire wr_dm; //TODO: view if we need to do something with Rd
reg [IBITS-1:0] i_data_pm;
reg wr_pm;

reg led_reg;//remove
always@(posedge i_clk)
begin
    led_reg <= 1'b1;
end
assign led = led_reg;//remove
    
cpu
#(
    .DBITS              (DBITS),
    .IBITS              (IBITS),
    .ADDR               (ADDR)
)
cpu
(
    .i_clk              (i_clk),
    .i_rst              (i_rst),
    .i_instdata         (instdata),
    .i_data_dm          (i_data_dm),
    .o_addr_pm          (addr_pm),
    .o_addr_dm          (addr_dm),
    .o_Rd               (),
    .o_Wr               (wr_dm),
    .o_data_dm          (o_data_dm)
);    
    
data_memory dm
(
    .clka               (i_clk),
    .wea                (wr_dm),
    .addra              (addr_dm),
    .dina               (o_data_dm),
    .douta              (i_data_dm)
);

program_memory pm
(
    .clka               (i_clk),
    .wea                (wr_pm),
    .addra              (addr_pm),
    .dina               (i_data_pm),
    .douta              (instdata)
);

always @ (posedge i_clk)
begin
    i_data_pm <= 16'b0000000000000000;
    wr_pm <= 1'b0;
end
endmodule
