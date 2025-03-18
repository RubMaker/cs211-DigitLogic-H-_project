`timescale 1ns/1ps


module clk_div (
  input             clk_tx,          // Clock input
  input             rst_clk_tx,      
  
  input      [15:0] pre_clk_tx,      // Current divider
  output reg        en_clk_samp     
);

  reg [15:0]             cnt;            // Counter
  always @(posedge clk_tx)
  begin
    if (rst_clk_tx)
    begin
      en_clk_samp    <= #5 1'b1;    
      cnt            <= 16'b0;
    end
    else // !rst
    begin

      en_clk_samp <= #5 (cnt == 16'b1);

      if (cnt == 0) 
      begin
        cnt <= pre_clk_tx - 1'b1;
      end
      else 
      begin
        cnt <= cnt - 1'b1; 
      end
    end 
  end 

endmodule
