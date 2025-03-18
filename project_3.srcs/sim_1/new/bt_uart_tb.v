`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/11 21:43:37
// Design Name: 
// Module Name: uart_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bt_uart_tb();
reg clock;
  reg serial;
  wire rec_valid;
  wire [7:0] rec_data;
  reg [3:0] clkCnt = 0;


  initial begin
    clock = 0;
    forever #5 clock = ~clock; // 10ns 
  end


  initial begin
  serial=0;
  while (1)begin
    serial = ~serial; 
    #10;
  end
  end


  bt_uart rec(
    .clk(clock),
    .rst(0),
    .rx(serial),
    .valid(rec_valid),
    .recieve_data(rec_data)
  );
endmodule
