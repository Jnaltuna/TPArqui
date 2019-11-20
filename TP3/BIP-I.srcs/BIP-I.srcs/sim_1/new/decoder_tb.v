`timescale 1ns / 1ps

module decoder_tb;

    reg [4:0] opcode;

    decoder
    #(
        .OPLEN  (5)
    )
    deco
    (
        .i_opcode           (opcode),
        .o_wrPC             (),
        .o_selA             (),
        .o_selB             (),    
        .o_wrAcc            (),
        .o_op               (),
        .o_wrRam            (),
        .o_rdRam            ()
    );

    initial begin
    
    opcode = 5'b00000;
    
    #5
    opcode = 5'b00001;
    #5
    opcode = 5'b00010;
    #5
    opcode = 5'b00011;
    #5
    opcode = 5'b00100;
    #5
    opcode = 5'b00101;
    #5
    opcode = 5'b00110;
    #5
    opcode = 5'b00111;
    end



endmodule
