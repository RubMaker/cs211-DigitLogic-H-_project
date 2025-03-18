`timescale 1ns/1ps


module reset_bridge (
  input            clk_dst,      
  input            rst_in,       // Asynchronous reset signal
  output reg       rst_dst       // Synchronized reset signal
);
  reg           rst_meta;        
  always @(posedge clk_dst or posedge rst_in)
  begin
    if (rst_in)
    begin
      rst_meta <= 1'b1;
      rst_dst  <= 1'b1;
    end
    else 
    begin
      rst_meta <= 1'b0;
      rst_dst  <= rst_meta;
    end 
  end 

endmodule

