`timescale 1ns / 1ps
module fifo
#(
	parameter B = 8,	//bits in a word
	parameter W = 4 	//number of address bits
)
(
	input	wire				i_clk,
	input	wire				i_reset,
	input 	wire				i_rd,
	input 	wire				i_wr,
	input 	wire	[B-1:0] 	i_w_data,
	output 	wire 				o_empty,
	output 	wire				o_full,
	output 	wire 	[B-1:0] 	o_r_data
);

//signals
reg [B-1:0] array_reg [2**W-1:0];
reg [W-1:0] w_ptr_reg, w_ptr_next, w_ptr_succ;
reg [W-1:0] r_ptr_reg, r_ptr_next, r_ptr_succ;
reg full_reg, empty_reg, full_next, empty_next;

wire 		wr_en;

//register file write operation
always @(posedge i_clk)
	if (wr_en)
		array_reg [w_ptr_reg] <= i_w_data;
	
//register file read operation
assign o_r_data = array_reg [r_ptr_reg];
//write enabled only when FIFO is not full
assign wr_en = i_wr & ~full_reg;

//fifo control logic
//register for read and write pointers
always @(posedge i_clk, posedge i_reset)
begin

	if(i_reset) begin

		w_ptr_reg <=0;
		r_ptr_reg <=0;
		full_reg <= 1'b0;
		empty_reg <= 1'b1;

	end else begin

		w_ptr_reg <= w_ptr_next;
		r_ptr_reg <= r_ptr_next;
		full_reg <= full_next;
		empty_reg <= empty_next;

	end
end


//next_state logic for read and write pointers
always @ (*)
begin

	//succesive pointer values
	w_ptr_succ = w_ptr_reg + 1;
	r_ptr_succ = r_ptr_reg + 1;

	//default: keep old vlaues
	w_ptr_next = w_ptr_reg;
	r_ptr_next = r_ptr_reg;
	full_next = full_reg;
	empty_next = empty_reg;
	
	case({i_wr,i_rd})
		//2'b00: no op
		2'b01: //read
			if(~empty_reg) //not empty
				begin
					r_ptr_next = r_ptr_succ;
					full_next = 1'b0;
					if(r_ptr_succ == w_ptr_reg)
						empty_next = 1'b1;
				end
		2'b10: //write
			if(~full_reg) //not full
				begin
					w_ptr_next = w_ptr_succ;
					empty_next = 1'b0;
					if(w_ptr_succ==r_ptr_reg)
						full_next = 1'b1;
				end
		2'b11: //write and read
			begin
				w_ptr_next = w_ptr_succ;
				r_ptr_next = r_ptr_succ;
			end
		//default: 
		//	begin
		//		
		//	end
	endcase
end

//output
assign o_full 	= 	full_reg;
assign o_empty = 	empty_reg;

endmodule