`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Md Mudassir Ahmed
// Design Name: UART Top 
// Module Name:    uart_top 
// Project Name: UART IP Core
// Description: UART Top Module 
//          ***** Default settings ******
//            - Baud Rate   : 19,200 baud rate.
//            - Data format : 1 start bit, 8 data bits, 1 stop bit.
//		        - Buffer Space: 8x8 FIFO.
//////////////////////////////////////////////////////////////////////////////////

module uart_top #(	parameter WIDTH = 8,
			                        BR = 115200,
  			                      CLK_FQ = 25000000)
                (  input clk, 
                   input reset,
                   input rd_uart, 
                   input wr_uart,
                   input rx,
                   input [WIDTH-1:0] w_data,
                   output [WIDTH-1:0] r_data,
                   output tx,
                   output rx_fifo_full, 
                   output rx_fifo_empty, 
                   output tx_fifo_full );

	// connecting wires 
	wire tick;

	// Instantiating baud rate generator
  	baudGenerator #(.BAUD_RATE(BR),
                  	.CLK_FREQ(CLK_FQ),
                  	.WIDTH(WIDTH)
                   )  
  		   BAUD_GEN (	.clk(clk), 
				.reset(reset), 
				.max_tick(tick)
			 );
	
	// Instantiating uart receiver				
 	 uart_rcvr UART_RCVR (	.clk(clk), 
				.reset(reset), 
				.s_tick(tick), 
				.rx(rx), 
				.rd_uart(rd_uart), 
				.r_data(r_data),
				.rx_empty(rx_fifo_empty), 
				.rx_full(rx_fifo_full)
                        );
	
	// Instantiating uart transmitter			
	uart_txmt UART_TXMT	(	.clk(clk), 
					.reset(reset), 
					.s_tick(tick), 
					.w_data(w_data), 
					.wr_uart(wr_uart), 
					.tx(tx), 
					.tx_full(tx_fifo_full)
				);
    
  
endmodule
