`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Md Mudassir Ahmed
// 
// Design Name: Baud Rate Generator
// Module Name: baudGenerator 
// Project Name: UART Core
// Description: Generates the required ticks at regular intervals based on the  
//              clock frequency and specified baud rate. 
//
//////////////////////////////////////////////////////////////////////////////////

module baudGenerator #(  parameter CLK_FREQ  = 25000000,
                                  BAUD_RATE = 19200,
                                  WIDTH	   = 8 ) 
                      ( input clk, 
                        input reset, 
                        output max_tick
                      );

    parameter DVSR = CLK_FREQ/(16*BAUD_RATE);	// baud rate divisor
											                        // DVSR = 25MHz/(16*baud_rate)
                                              //Sampling rate: 16
  //Declare internal signal for counting
  reg [WIDTH-1:0] count;

  //Counter Block
  always @(posedge clk, negedge reset)
		begin
			if(!reset)
				count <= {WIDTH{1'b0}};
          	else if(count == DVSR)
          		count <= {WIDTH{1'b0}};
          	else
              count <= count + 1;
		end

  //Max_tick Output Logic
	assign max_tick = (count == DVSR)? 1'b1 : 1'b0; 
	
endmodule
