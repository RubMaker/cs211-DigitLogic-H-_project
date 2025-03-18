
`timescale 1ns/1ps

module uart_baud_gen (
  // Write side inputs
  input        clk,          
  input        rst,          
  output       baud_x16_en   // Oversampled Baud rate enable
);



  function integer clogb2;
    input [31:0] value;
    reg   [31:0] my_value;
    begin
      my_value = value - 1;
      for (clogb2 = 0; my_value > 0; clogb2 = clogb2 + 1)
        my_value = my_value >> 1;
    end
  endfunction
  //


  parameter BAUD_RATE    = 57_600;              // Baud rate
  parameter CLOCK_RATE   = 50_000_000;

  localparam OVERSAMPLE_RATE = BAUD_RATE * 16;

  localparam DIVIDER = (CLOCK_RATE+OVERSAMPLE_RATE/2) / OVERSAMPLE_RATE;

  localparam OVERSAMPLE_VALUE = DIVIDER - 1;

  localparam CNT_WID = clogb2(DIVIDER);

  reg [CNT_WID-1:0] internal_count;
  reg               baud_x16_en_reg;
  wire [CNT_WID-1:0] internal_count_m_1; // Count minus 1



  assign internal_count_m_1 = internal_count - 1'b1;

  always @(posedge clk)
  begin
    if (rst)
    begin
      internal_count  <= OVERSAMPLE_VALUE;
      baud_x16_en_reg <= 1'b0;
    end
    else
    begin
      baud_x16_en_reg   <= (internal_count_m_1 == {CNT_WID{1'b0}});

      if (internal_count == {CNT_WID{1'b0}}) 
      begin
        internal_count    <= OVERSAMPLE_VALUE;
      end
      else 
      begin
        internal_count    <= internal_count_m_1;
      end
    end 
  end 

  assign baud_x16_en = baud_x16_en_reg;

endmodule
