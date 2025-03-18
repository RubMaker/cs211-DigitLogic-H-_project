`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 22:34:21
// Design Name: 
// Module Name: signed_add_sub
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


module signed_add_sub_45 (
    input signed [7:0] a,
    input signed [7:0] b,
    output wire signed [7:0] sum,
    output wire signed [7:0] diff
);
    assign sum = a + b;
    assign diff = a - b;
endmodule



