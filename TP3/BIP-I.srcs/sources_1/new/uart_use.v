`timescale 1ns / 1ps
module uart_use
	#(
	parameter M1 = 8
	)
	(
	input   wire            i_sw,
	input 	wire			i_reset,
	input   wire            i_clk,
	input 	wire [7:0] 	    i_rx_data,
	input   wire            i_rx_done,
	input   wire            i_tx_done,
	output 	wire [7:0] 	    o_tx_data,
	output 	wire 			o_tx_start,
	output  wire [15:0]     o_to_led
   );
   
   
    localparam [2:0]
        waitS    = 3'b000,
        wait_res = 3'b001,
        save_res = 3'b010,
        tx_high  = 3'b011,
        tx_wait_h = 3'b100,
        tx_low   = 3'b101,
        tx_wait_l = 3'b110;

    wire [15:0] acc;
	
	reg [15:0] datos;
	reg [7:0] datos_send;
	reg rd,wr;
	reg [2:0] state_reg, state_next; 
	reg cpu_val;
	reg cpu_val_next;
	reg cpu_clk;
	reg cpu_res_next;
	reg cpu_res;
	
	assign o_tx_data = datos_send;
	assign o_tx_start = wr;
	
	always @(posedge i_clk)
	begin
	   if(i_reset) begin
	       state_reg <= waitS;
	       cpu_val <= 1'b0;
	       cpu_res <= 1'b0;
	       //datos <= 16'b0;
	   end else begin
	       state_reg <= state_next;
	       cpu_val <= cpu_val_next;
	       cpu_res <= cpu_res_next;
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
	                   state_next = wait_res;
	                   cpu_val_next = 1'b1;
	                   cpu_res_next = 1'b1;
	               end else begin
	                   state_next = waitS;
	                   cpu_val_next = 1'b0;
	               end
	           end
	       end
	       wait_res:
	       begin
	           cpu_res_next = 1'b0;
	           state_next = save_res;
	       end
	       save_res:
	           if(acc != 16'b0000000000000000) begin
	               cpu_val_next = 1'b1;
	               cpu_res_next = 1'b0;
	               datos = acc;
	               state_next = tx_high;
	           end
	       tx_high:
               begin
                   cpu_res_next = 1'b0;
                   cpu_val_next = 1'b1;
                   wr = 1'b1;
	               datos_send = datos[15:8];
	               state_next = tx_wait_h;
	           end
	       tx_wait_h:
	           begin
	               cpu_res_next = 1'b0;
	               cpu_val_next = 1'b1;
	               if(i_tx_done) begin
	                   wr = 1'b0;
	                   state_next = tx_low;
	               end
	           end
	       tx_low:
	           begin
	               cpu_res_next = 1'b0;
	               cpu_val_next = 1'b1;
                   wr = 1'b1;
                   datos_send = datos[7:0];
	               state_next = tx_wait_l;
	           end
	       tx_wait_l:
	           begin
	               cpu_res_next = 1'b0;
	               cpu_val_next =1'b1;
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
        .i_rst      (cpu_res),
        .o_acc      (acc),
        .i_sw       (i_sw),
        .o_led      (o_to_led)
        
	);
	
	always@(i_clk) begin
        if(i_reset) begin
            cpu_clk <= 0;
        end else begin
            if(cpu_val) begin
                cpu_clk <= i_clk;
            end else begin
                cpu_clk <= 0;
            end
        end
	end
	
endmodule
