`timescale 1ns / 1ps

module decoder
#(
  parameter OPLEN = 5
)
(
  input   wire    [OPLEN -1:0]    i_opcode,
    
  output  reg                    o_wrPC,
  output  reg    [1:0]           o_selA,
  output  reg                    o_selB,    
  output  reg                    o_wrAcc,
  output  reg                    o_op,
  output  reg                    o_wrRam,
  output  reg                    o_rdRam
);
  
  //OPCODE FOR BIP-I
  localparam HLT  = 5'b00000;
  localparam STO  = 5'b00001;
  localparam LD   = 5'b00010;
  localparam LDI  = 5'b00011;
  localparam ADD  = 5'b00100;
  localparam ADDI = 5'b00101;
  localparam SUB  = 5'b00110;
  localparam SUBI = 5'b00111;
  
  always @ (*) 
  begin
        
        case(i_opcode)
            HLT:
            begin
                o_wrPC  <= 0;
                o_selA  <= 0;
                o_selB  <= 0;
                o_wrAcc <= 0;
                o_op    <= 0;
                o_wrRam <= 0;
                o_rdRam <= 0;
            end
            STO:
            begin
                o_wrPC  <= 1;
                o_selA  <= 0;
                o_selB  <= 0;
                o_wrAcc <= 0;
                o_op    <= 0;
                o_wrRam <= 1;
                o_rdRam <= 0;
            end
            LD:
            begin
                o_wrPC  <= 1;
                o_selA  <= 0;
                o_selB  <= 0;
                o_wrAcc <= 1;
                o_op    <= 0;
                o_wrRam <= 0;
                o_rdRam <= 1;
            end
            LDI:
            begin
                o_wrPC  <= 1;
                o_selA  <= 1;
                o_selB  <= 0;
                o_wrAcc <= 1;
                o_op    <= 0;
                o_wrRam <= 0;
                o_rdRam <= 0;
            end
            ADD:
            begin
                o_wrPC  <= 1;
                o_selA  <= 2;
                o_selB  <= 0;
                o_wrAcc <= 1;
                o_op    <= 1;
                o_wrRam <= 0;
                o_rdRam <= 1;
            end
            ADDI:
            begin
                o_wrPC  <= 1;
                o_selA  <= 2;
                o_selB  <= 1;
                o_wrAcc <= 1;
                o_op    <= 1;
                o_wrRam <= 0;
                o_rdRam <= 0;
            end
            SUB:
            begin
                o_wrPC  <= 1;
                o_selA  <= 2;
                o_selB  <= 0;
                o_wrAcc <= 1;
                o_op    <= 0;
                o_wrRam <= 0;
                o_rdRam <= 1;
            end
            SUBI:
            begin
                o_wrPC  <= 1;
                o_selA  <= 2;
                o_selB  <= 1;
                o_wrAcc <= 1;
                o_op    <= 0;
                o_wrRam <= 0;
                o_rdRam <= 0;
            end
            default:
            begin
                o_wrPC  <= 0;
                o_selA  <= 0;
                o_selB  <= 0;
                o_wrAcc <= 0;
                o_op    <= 0;
                o_wrRam <= 0;
                o_rdRam <= 0;
           end
        endcase
  end

endmodule