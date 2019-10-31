module tp1_sw(
		input 	wire 		signed [7:0] switch,
		input 	wire 				 [2:0] buttons,
		input		wire						 i_clock,
		output 	wire 		signed [7:0] led

    );
	 
	 localparam LEN_DATO_01 = 8;
	 localparam LEN_OP_01 = 6;
	 
	 reg signed [7:0] i_dato_a_01 = 0;
	 reg signed [7:0] i_dato_b_01 = 0;
	 reg [5:0] i_op_01 = 0;
	 wire signed [7:0] o_resultado_01;
	 
	 assign led = o_resultado_01;
	 
	 //always @(*)
	 //begin
	//	led <= o_resultado_01;
	 //end
	 
	 always @ (posedge i_clock)
	 begin
		casez (buttons)
			3'b1?? : i_dato_a_01 <= switch;
			3'b?1? : i_dato_b_01 <= switch;
			3'b??1 : i_op_01 <= switch;
		endcase
		//case (buttons)
		//100:	i_dato_a_01 <= switch;
		//010:	i_dato_b_01 <= switch;
		//001:	i_op_01 <= switch;
		//endcase
	 end
	 
	 tp1
    #(
      .LEN_DATO           (LEN_DATO_01),
      .LEN_OP	           (LEN_OP_01)
    )
    u_tp1_01
    (
      .o_resultado           	(o_resultado_01),
      .i_dato_a     	     		(i_dato_a_01),
      .i_dato_b	   			(i_dato_b_01),
      .i_op_code			 		(i_op_01)
    );

endmodule
