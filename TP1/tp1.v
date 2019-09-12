// Code your design here
module tp1
  #(
		parameter LEN_DATO = 3,
    	parameter LEN_OP = 6
  )
  (
  		//input	wire					i_clock,
    	//input 	wire 					i_reset,
   	input 	wire signed	[LEN_DATO-1:0]	i_dato_a,
    	input		wire signed	[LEN_DATO-1:0]	i_dato_b,
    	input 	wire			[LEN_OP-1:0]	i_op_code,
    	output 	wire signed	[LEN_DATO-1:0]	o_resultado
  );

  //Definiciones de op code
  localparam ADD = 6'b100000;
  localparam SUB = 6'b100010;
  localparam AND = 6'b100100;
  localparam OR  = 6'b100101;
  localparam XOR = 6'b100110;
  localparam SRA = 6'b000011;
  localparam SRL = 6'b000010;
  localparam NOR = 6'b100111;
  
  reg signed [LEN_DATO-1:0] res = 0;
  
  assign o_resultado = res;
  
  always @ (*)
    begin
      case (i_op_code)
        ADD : res <= i_dato_a + i_dato_b;
        SUB	: res <= i_dato_a - i_dato_b;
        AND : res <= i_dato_a & i_dato_b;
        OR	: res <= i_dato_a | i_dato_b;
        XOR	: res <= i_dato_a ^ i_dato_b;
        SRA : res <= i_dato_a >>> i_dato_b ;
        SRL : res <= i_dato_a >> i_dato_b;
        NOR : res <= ~(i_dato_a|i_dato_b);
		  default : res <= i_dato_a;
      endcase
    end
  
endmodule