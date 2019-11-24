`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 09:22:36 PM
// Design Name: 
// Module Name: cpu_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_top(

    );
    
cpu
#(
)
cpu
(
);    
    
data_memory dm
(
.clka(),
.wea(),
.addra(),
.dina(),
.douta()
);

program_memory pm
(
.clka(),
.wea(),
.addra(),
.dina(),
.douta()
);

endmodule
