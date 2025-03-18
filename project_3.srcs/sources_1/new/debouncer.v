
`timescale 1ns/1ps


module debouncer (
  input            clk,          
  input            rst,          
  
  input            signal_in,    
  output           signal_out    
);

`include "clogb2.txt"

  parameter 
    FILTER = 200_000_000;     

  localparam
    RELOAD = FILTER - 1,
    FILTER_WIDTH = clogb2(FILTER);
    

  reg                    signal_out_reg; // Current output
  reg [FILTER_WIDTH-1:0] cnt;            // Counter
  wire signal_in_clk; 
  meta_harden meta_harden_signal_in_i0 (
    .clk_dst       (clk),
    .rst_dst       (rst),
    .signal_src    (signal_in),
    .signal_dst    (signal_in_clk)
  );

  always @(posedge clk)
  begin
    if (rst)
    begin
      signal_out_reg <= signal_in_clk;
      cnt            <= RELOAD;
    end
    else // !rst
    begin
      if (signal_in_clk == signal_out_reg)
      begin
        cnt <= RELOAD;
      end
      else if (cnt == 0)
      begin
        signal_out_reg <= signal_in_clk;
        cnt            <= RELOAD;
      end
      else 
      begin
        cnt <= cnt - 1'b1; 
      end
    end 
  end 

  assign signal_out = signal_out_reg;

endmodule
