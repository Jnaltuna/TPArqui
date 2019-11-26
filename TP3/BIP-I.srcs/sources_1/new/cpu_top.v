`timescale 1ns / 1ps

module cpu_top
#(
    parameter ADDR = 11,
    parameter DBITS = 16
)
(
    input   wire                i_clk,
    input   wire                i_rst,
    input   wire    [2:0]       i_sw,
    
    //output  wire [DBITS-1:0]    o_acc,
    output  wire    [DBITS-1:0] led
    
    //output  wire [ADDR-1:0] o_pc,
    //output  wire [DBITS-1:0] o_acc,
    //output  wire [DBITS-1:0] o_inst
    
);

localparam IBITS = 16;


wire [IBITS-1:0] instdata;
wire [DBITS-1:0] i_data_dm, o_data_dm;
wire [ADDR-1:0] addr_pm,addr_dm;
wire wr_dm; //TODO: view if we need to do something with Rd
reg [IBITS-1:0] i_data_pm;
reg wr_pm;
reg [DBITS-1:0] acc_reg;
reg [DBITS-1:0] led_reg;
reg [ADDR-1:0] clock_count;
    
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
    .clka               (~i_clk),
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

always @(posedge i_clk)
begin
    if(instdata == 16'b0000000000000000)
       acc_reg <= o_data_dm;
    else
       acc_reg <= 16'b0000000000000000; 
end

//always @(posedge i_clk)
//begin
//    if(i_sw) begin //envio PC
//        led_reg <= {5'b10000,addr_pm};
//    end else begin //envio contador de clock
//        led_reg <= {5'b00000,clock_count};
//    end   
//end

always @(posedge i_clk)
begin
    case(i_sw)
        3'b100:
            led_reg <= o_data_dm;
        3'b010:
            led_reg <= {5'b10000,addr_pm};
        3'b001:
            led_reg <= {5'b00000,clock_count};
        default:
            led_reg <= 16'd0;
    endcase
end

always @(negedge i_clk)
begin
    if(i_rst) begin
        clock_count <= 11'b00000000000;
    end else begin
        if(instdata != 16'b0000000000000000)
            clock_count <= clock_count + 1;
        else
            clock_count <= clock_count;
    end
end

assign led = led_reg;
//assign o_acc = acc_reg;

//assign o_pc = addr_pm;
//assign o_acc = o_data_dm;
//assign o_inst = instdata;

endmodule
