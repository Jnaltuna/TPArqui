`timescale 1ns / 1ps
module uart_use
	#(
	parameter M1 = 8
	)
	(
	input 	wire			i_reset,
	input   wire            i_clk,
	input 	wire [7:0] 	    i_rx_data,
	input   wire            i_rx_done,
	input   wire            i_tx_done,
	output 	wire [7:0] 	    o_tx_data,
	output 	wire 			o_tx_start
   );

    localparam [2:0]
        waitA   = 3'b000,
        waitB   = 3'b001,
        waitOP  = 3'b010,
        saveR   = 3'b011,
        sendR   = 3'b100,
        waitTX  = 3'b101;
    
    reg [7:0] A;
    reg [7:0] B;
    reg [7:0] OP; 
    reg [7:0] tempA;
    reg [7:0] tempB;
    reg [7:0] tempOP;
    reg [2:0] state_reg, state_next;   
    
    wire [7:0] res;
	
	reg [7:0] datos;
	reg rd,wr;
	
	assign o_tx_data = datos;
	assign o_tx_start = wr;
	
	always @(posedge i_clk)
	begin
	   if(i_reset) begin
	       state_reg <= waitA;
	       A <= 8'b0;
	       B <= 8'b0;
	       OP <= 8'b0;
	   end else begin
	       if(state_next == waitB)
	           A <= tempA;
	       else if(state_next == waitOP)
	           B <= tempB;
	       else if(state_next == saveR)
	           OP <= tempOP;
	       else if(state_next == sendR)
	           datos <= res;
	           
	       state_reg <= state_next;
	   end
	end
	
	always @(*)
	begin
	   state_next = state_reg;
	   
	   case(state_reg)
	       waitA:
	       begin
	           wr = 1'b0;
	           if(i_rx_done) begin
	               tempA = i_rx_data;
	               state_next = waitB;
	           end
	       end
	       waitB:
	           if(i_rx_done) begin
	               tempB = i_rx_data;
	               state_next = waitOP;
	           end
	       waitOP:
	           if(i_rx_done) begin
	               tempOP = i_rx_data;
	               state_next = saveR;
	           end
	       saveR:
	           begin
	           //temp = res;
	           state_next = sendR;
	           end
	       sendR:
	           begin
	           wr = 1'b1;
	           state_next = waitA;
	           end
	       waitTX: 
	           if(i_tx_done) begin
	               wr = 1'b0;
	               state_next = waitA;
	           end
	   endcase
	end
	
	alu
	#(
	   .LEN_DATO       (8),
	   .LEN_OP         (6)
	)
	alu
	(
	   .i_dato_a       (A),
	   .i_dato_b       (B),
	   .i_op_code      (OP),
	   .o_resultado    (res)
	);
	       
	/*
	//Take incoming data
	always @ (*)
	begin
	   if(i_rx_done)
	       datos <= 8'b0;
	       datos <= i_rx_data;
	end
	
	always @(posedge i_clk)
	begin
	   if(i_rx_done)
	       rd <= 1'b1;
	   else
	       rd <= 1'b0;
	end

	always @(posedge i_clk)
	   if(i_reset)
	   begin
	       wr<= 1'b0;   
	   end
	   else
	   if(rd)
	   begin
	       wr <=1'b1;
	   end
	   else
	   begin
	       wr <=1'b0;
	   end
			
	*/
	
endmodule
