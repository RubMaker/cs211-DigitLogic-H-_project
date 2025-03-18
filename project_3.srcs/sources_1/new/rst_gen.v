
`timescale 1ns/1ps


module rst_gen (
  input             clk_rx,          
  input             clk_tx,          
  input             clk_samp,        

  input             rst_i,           
  input             clock_locked,    

  output            rst_clk_rx,      
  output            rst_clk_tx,      
  output            rst_clk_samp     
);

  wire int_rst;
  
  assign int_rst = rst_i || !clock_locked;

  reset_bridge reset_bridge_clk_rx_i0 (
    .clk_dst   (clk_rx),
    .rst_in    (int_rst),
    .rst_dst   (rst_clk_rx)
  );

  reset_bridge reset_bridge_clk_tx_i0 (
    .clk_dst   (clk_tx),
    .rst_in    (int_rst),
    .rst_dst   (rst_clk_tx)
  );
  
  reset_bridge reset_bridge_clk_samp_i0 (
    .clk_dst   (clk_samp),
    .rst_in    (int_rst),
    .rst_dst   (rst_clk_samp)
  );

endmodule
