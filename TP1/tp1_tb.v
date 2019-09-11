module testb_tp1();
    //local parameters
    localparam  LEN_DATO_01     =  8;
    localparam  LEN_OP_01       =  6;
    //Inputs
    reg                                           i_clock;
  	reg											  i_reset;
  	reg signed	[LEN_DATO_01-1:0] 		          i_dato_a_01;
  	reg signed  [LEN_DATO_01-1:0]  			      i_dato_b_01;
  reg			[LEN_OP_01-1:0]					  i_op_code_01;
    //Outputs
  	wire signed [LEN_DATO_01-1:0]        o_resultado_01;
    
    initial begin
      #0
      $dumpvars;
      i_clock        = 1'b1;
      i_dato_a_01 	 = 0;
      i_dato_b_01  	 = 0;
      i_op_code_01	 = 6'b100000;
      #100
		$display("Fin de la simulacion");
      $finish;
    end // initial
    always begin
      #5
      i_clock = ~i_clock;
    end

    always begin
      #2//test suma
      i_op_code_01 = 6'b100000;
      i_dato_a_01 = $random;
      i_dato_b_01 = $random;
      #2
      if(i_dato_a_01 + i_dato_b_01 != o_resultado_01)
        $display(" *ADD ERROR* "); 
      #2//test resta
      i_op_code_01 = 6'b100010;
      i_dato_a_01 = $random;
      i_dato_b_01 = $random;
      #2
      if(i_dato_a_01 - i_dato_b_01 != o_resultado_01)
        $display(" *SUB ERROR* ");
      #2//and
      i_op_code_01 = 6'b100100;
      i_dato_a_01 = $random;
      i_dato_b_01 = $random;
      #2
      if((i_dato_a_01 & i_dato_b_01) != o_resultado_01)
        $display(" *AND ERROR* ");
      #2//or
      i_op_code_01 = 6'b100101;
      i_dato_a_01 = $random;
      i_dato_b_01 = $random;
      #2
      if((i_dato_a_01 | i_dato_b_01) != o_resultado_01)
        $display(" *OR ERROR* ");
      #2//xor
      i_op_code_01 = 6'b100110;
      i_dato_a_01 = $random;
      i_dato_b_01 = $random;
      #2
      if((i_dato_a_01 ^ i_dato_b_01) != o_resultado_01)
        $display(" *XOR ERROR* "); 
      #2//sra
      i_op_code_01 = 6'b000011;
      i_dato_a_01 = 8'b10100000;
      i_dato_b_01 = 8'b00000010;
      #2
      if(8'b11101000 != o_resultado_01)
        $display(" *SRA ERROR* "); 
      #2//srl
      i_op_code_01 = 6'b000010;
      i_dato_a_01 = 8'b10100000;
      i_dato_b_01 = 8'b00000001;
      #2
      if(8'b01010000 != o_resultado_01)
        $display(" *SRL ERROR* "); 
      #2//nor
      i_op_code_01 = 6'b100111;
      i_dato_a_01 = 8'b00001000;
      i_dato_b_01 = 8'b00010000;
      #2
      if(8'b11100111 != o_resultado_01)
        $display(" *NOR ERROR* "); 
    end

    tp1
    #(
      .LEN_DATO           (LEN_DATO_01),
      .LEN_OP	          (LEN_OP_01)
    )
    u_tp1_01
    (
      .o_resultado           (o_resultado_01),
      //.i_clock      	     (i_clock),
      .i_dato_a     	     (i_dato_a_01),
      .i_dato_b	   			 (i_dato_b_01),
      .i_op_code			 (i_op_code_01)
    );

endmodule // testb_tp1
