

`timescale 1ns/1ps


module uart_rx (
  // Write side inputs
  input            clk_rx,       
  input            rst_clk_rx,   

  input            rxd_i,        
  output           rxd_clk_rx,  

  output     [7:0] rx_data,      // 8 bit data output
  output           rx_data_rdy,  // Ready signal for rx_data
  output           frm_err       // The STOP bit was not detected
);



  parameter BAUD_RATE    = 115_200;             // Baud rate
  parameter CLOCK_RATE   = 50_000_000;


  wire             baud_x16_en;  // 1-in-N enable for uart_rx_ctl FFs


  meta_harden meta_harden_rxd_i0 (
    .clk_dst      (clk_rx),
    .rst_dst      (rst_clk_rx), 
    .signal_src   (rxd_i),
    .signal_dst   (rxd_clk_rx)
  );

  uart_baud_gen #
  ( .BAUD_RATE  (BAUD_RATE),
    .CLOCK_RATE (CLOCK_RATE)
  ) uart_baud_gen_rx_i0 (
    .clk         (clk_rx),
    .rst         (rst_clk_rx),
    .baud_x16_en (baud_x16_en)
  );

  uart_rx_ctl uart_rx_ctl_i0 (
    .clk_rx      (clk_rx),
    .rst_clk_rx  (rst_clk_rx),
    .baud_x16_en (baud_x16_en),

    .rxd_clk_rx  (rxd_clk_rx),
    
    .rx_data_rdy (rx_data_rdy),
    .rx_data     (rx_data),
    .frm_err     (frm_err)
  );

endmodule
