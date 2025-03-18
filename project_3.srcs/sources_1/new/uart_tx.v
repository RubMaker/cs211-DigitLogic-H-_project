

`timescale 1ns/1ps


module uart_tx (
  input        clk_tx,          // Clock input
  input        rst_clk_tx,      // Active HIGH reset - synchronous to clk_tx

  input        char_fifo_empty, 
  input  [7:0] char_fifo_dout,  // Data from the char FIFO
  output       char_fifo_rd_en, // Pop signal to the char FIFO

  output       txd_tx           // The transmit serial signal
);



  parameter BAUD_RATE    = 57_600;              // Baud rate

  parameter CLOCK_RATE   = 50_000_000;



  wire             baud_x16_en;  // 1-in-N enable for uart_rx_ctl FFs
  

  uart_baud_gen #
  ( .BAUD_RATE  (BAUD_RATE),
    .CLOCK_RATE (CLOCK_RATE)
  ) uart_baud_gen_tx_i0 (
    .clk         (clk_tx),
    .rst         (rst_clk_tx),
    .baud_x16_en (baud_x16_en)
  );

  uart_tx_ctl uart_tx_ctl_i0 (
    .clk_tx	        (clk_tx),          
    .rst_clk_tx	        (rst_clk_tx),      

    .baud_x16_en        (baud_x16_en),     // 16x oversample enable

    .char_fifo_empty	(char_fifo_empty), // Empty signal from char FIFO (FWFT)
    .char_fifo_dout	(char_fifo_dout),  // Data from the char FIFO
    .char_fifo_rd_en	(char_fifo_rd_en), // Pop signal to the char FIFO

    .txd_tx	        (txd_tx)           // The transmit serial signal
  );

endmodule
