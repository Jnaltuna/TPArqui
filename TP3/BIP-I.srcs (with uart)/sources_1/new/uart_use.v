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
        waitS    = 3'b000,
        save_res = 3'b001,
        tx_high  = 3'b010,
        tx_wait_h = 3'b011,
        tx_low   = 3'b100,
        tx_wait_l = 3'b101;

    wire [15:0] led;
	
	reg [15:0] datos;
	reg [7:0] datos_send;
	reg rd,wr;
	reg [2:0] state_reg, state_next; 
	reg cpu_val;
	reg cpu_val_next;
	reg cpu_clk;
	
	assign o_tx_data = datos_send;
	assign o_tx_start = wr;
	
	always @(posedge i_clk)
	begin
	   if(i_reset) begin
	       state_reg <= waitS;
	       cpu_val <= 1'b0;
	       //datos <= 16'b0;
	   end else begin
	       state_reg <= state_next;
	       cpu_val <= cpu_val_next;
	   end
	end
	
	always @(*)
	begin
	   state_next = state_reg;
	   
	   case(state_reg)
	       waitS:
	       begin
	           wr = 1'b0;
	           if(i_rx_done) begin
	               if(i_rx_data == 8'b00000001) begin
	                   state_next = save_res;
	                   cpu_val_next = 1'b1;
	               end else begin
	                   state_next = waitS;
	                   cpu_val_next = 1'b0;
	               end
	           end
	       end
	       save_res:
	           if(led != 16'b0000000000000000) begin
	               cpu_val_next = 1'b0;
	               datos = led;
	               state_next = tx_high;
	           end
	       tx_high:
               begin
                   cpu_val_next = 1'b0;
                   wr = 1'b1;
	               datos_send = datos[15:8];
	               state_next = tx_wait_h;
	           end
	       tx_wait_h:
	           begin
	               cpu_val_next = 1'b0;
	               if(i_tx_done) begin
	                   wr = 1'b0;
	                   state_next = tx_low;
	               end
	           end
	       tx_low:
	           begin
	               cpu_val_next = 1'b0;
                   wr = 1'b1;
                   datos_send = datos[7:0];
	               state_next = tx_wait_l;
	           end
	       tx_wait_l:
	           begin
	               cpu_val_next =1'b0;
	               if(i_tx_done) begin
    	               state_next = waitS;
	                  wr = 1'b0;
	               end
	           end
	   endcase
	end
	
	cpu_top top
	(
        .i_clk      (cpu_clk),
        .i_rst      (i_reset),
        .led        (led)
        
	);
	
	always@(posedge i_clk) begin
        if(i_reset) begin
            cpu_clk <= 0;
        end else begin
            if(cpu_val) begin
                cpu_clk <= ~cpu_clk;
            end else begin
                cpu_clk <= 0;
            end
        end
	end
	
endmodule
