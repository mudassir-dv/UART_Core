`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Md Mudassir Ahmed
// Design Name: UART Receiver Subsystem
// Module Name:  uart_rcvr 
// Project Name: UART IP Core
// Description: Receiver subsystem with receiver fsm and fifo buffer.
//////////////////////////////////////////////////////////////////////////////////

module uart_rcvr #( parameter W = 8 )
                  (  input clk, 
                     input reset, 
                     input s_tick, 
                     input rx, 
                     input rd_uart, 
                     output [W-1:0] r_data, 
                     output rx_empty, 
                     output rx_full );
	
	wire [W-1:0]rx_dout;
	wire rx_done_tick;
	
	uart_rx UART_RX (	.clk(clk), 
						.reset(reset), 
						.rx(rx), 
						.s_tick(s_tick), 
						.rx_done_tick(rx_done_tick), 
						.dout(rx_dout)
					 );
					
	fifo_buf FIFO_RX (	.clk(clk), 
						.reset(reset), 
						.wr_en(rx_done_tick), 
						.rd_en(rd_uart), 
						.w_data(rx_dout), 
						.r_data(r_data), 
						.full(rx_full), 
						.empty(rx_empty),
						.not_empty()
					 );
	
endmodule
