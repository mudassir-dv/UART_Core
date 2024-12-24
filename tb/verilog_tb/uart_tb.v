module uart_tb();
  //Xmission related signals
  reg clk, reset;
  reg [7:0] w_data;
  reg wr_uart;
  wire tx_fifo_full;

  //Receiver related signals
  reg rd_uart;
  wire [7:0] r_data;
  wire rx_fifo_full, rx_fifo_empty;
  
  wire tx2rx;

  // Configuare the design
  localparam Baud_rate = 115200,
			       clk_freq  = 25000000,
			       width     = 8;

  // Instantiate uart Xmitter and receiver seperately 
  // Or instantiate uart_top only
  uart_txmt_top #(.WIDTH(width),
			 .BR(Baud_rate),
  			 .CLK_FQ(clk_freq)
            )	
		 	DUT_TX(	.clk(clk), 
                 	.reset(reset), 
                 	.wr_uart(wr_uart), 
                 	.tx(tx2rx), 
                 	.w_data(w_data), 
                 	.tx_fifo_full(tx_fifo_full)
                );
  
  uart_rcvr_top #(.WIDTH(width),
			 .BR(Baud_rate),
  			 .CLK_FQ(clk_freq)
            )	
  			DUT_RX(	.clk(clk), 
                   .reset(reset), 
                   .rd_uart(rd_uart), 
                   .rx(tx2rx), 
                   .r_data(r_data), 
                   .rx_fifo_empty(rx_fifo_empty), 
                   .rx_fifo_full(rx_fifo_full)
                  );
  
  initial begin 
  	clk = 1'b0;
    forever #20 clk = ~clk;
  end

  // task to reset dut
  task reset_dut();
    begin
      @(negedge clk)
      reset <= 1'b0;
      @(negedge clk)
      reset <= 1'b1;
    end
  endtask

  //task to write data for Xmission 
  task write_data(input[7:0] i);
    begin
      if(tx_fifo_full == 0)begin
      	@(negedge clk)
      	wr_uart <= 1'b1;
      	w_data <= i;
      end
      else begin
      	@(negedge clk)
      	wr_uart <= 1'b0;
      end
    end
  endtask
  
  initial begin
    reset_dut();
    repeat(2)
   		write_data({$random}%256);
//     repeat(2300*2)
//       #40;
  end

  // drive signal rd_uart for reading the data Xmitted
  initial begin
    wait(rx_fifo_empty == 0)
    @(negedge clk)
    	rd_uart <= 1'b1;
    wait(rx_fifo_empty == 1)
    @(negedge clk)
    	rd_uart <= 1'b0;
    #50;
    $finish;
  end

  // monitor all the signals
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    $monitor($time,": reset = %b ,wr_uart = %b, rd_uart = %b, w_data = %0h, r_data = %0h, tx_fifo_full = %b, rx_fifo_full = %b, rx_fifo_empty = %b, tx2rx = %b", reset, wr_uart, rd_uart, w_data, r_data, tx_fifo_full, rx_fifo_full, rx_fifo_empty, tx2rx);
  end
  
endmodule
