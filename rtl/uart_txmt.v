`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Md Mudassir Ahmed
// 
// Design Name: UART Receiver Subsystem
// Module Name:  uart_rcvr 
// Project Name: UART IP Core
// Description: Transmitter subsystem with transmitter fsm and fifo buffer.
//	
//////////////////////////////////////////////////////////////////////////////////

module uart_txmt #(parameter 	WIDTH = 8, 
				                      DBIT = 8,			// Data bits
                              SB_TICK = 16) // No. of Stop bits
                  (  input clk, 
                     input reset, 
                     input s_tick, 
                     input [WIDTH-1:0] w_data, 
                     input wr_uart, 
                     output tx, 
                     output tx_full );

	

	//Internal wires
	wire [WIDTH-1:0]tx_din;
	wire tx_done_tick, tx_empty;
	wire tx_fifo_not_empty; /* synthesis syn_keep=1 */
	
	fifo_buf FIFO_TX ( .clk(clk), 
						.reset(reset), 
						.wr_en(wr_uart), 
						.rd_en(tx_done_tick), 
						.w_data(w_data), 
						.r_data(tx_din), 
						.full(tx_full), 
						.empty(),
						.not_empty(tx_fifo_not_empty)
					);
					
	uart_tx  #( 
				.DBIT(DBIT),			// Data bits
				.SB_TICK(SB_TICK)   // Stop bits
			  )
			UART_TX( 	.clk(clk), 
						.reset(reset), 
						.tx_start(tx_fifo_not_empty), 
						.s_tick(s_tick), 
						.din(tx_din), 
						.tx_done_tick(tx_done_tick), 
						.tx(tx)
					);
					
endmodule
