`timescale 1ns/1ps


module lb_ctl (
  input            clk_tx,          
  input            rst_clk_tx,      
  
  input            lb_sel_i,        // Undebounced slide switch input
  
  input            txd_tx,          // Normal transmit data
  input            rxd_clk_rx,      // Receive data

  output reg       txd_o            // Transmit data to pin
);

  parameter FILTER = 200_000; // 0.004s at 50MHz
  wire         lb_sel_filt;          // Filtered value of the lb_sel switch
  wire         rxd_clk_tx;           // RXD re-synchronized to clk_tx

  debouncer #(
    .FILTER     (FILTER)
  ) debouncer_i0 (
    .clk        (clk_tx),
    .rst        (rst_clk_tx),
    .signal_in  (lb_sel_i),
    .signal_out (lb_sel_filt)
  );

  meta_harden meta_harden_rxd_i0 (
    .clk_dst    (clk_tx),
    .rst_dst    (rst_clk_tx),
    .signal_src (rxd_clk_rx),
    .signal_dst (rxd_clk_tx)
  );
  always @(posedge clk_tx)
  begin
    if (rst_clk_tx)
    begin
      txd_o <= 1'b0;
    end
    else
    begin
      txd_o <= lb_sel_filt ? rxd_clk_tx : txd_tx;
    end
  end

endmodule
