`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 22:58:08
// Design Name: 
// Module Name: bitwise_operations
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


module bitwise_operations(
    input [7:0] a,                // 8-bit input a
    input [7:0] b,                // 8-bit input b
    output [7:0] and_result,      // Output for bitwise AND operation
    output [7:0] or_result,       // Output for bitwise OR operation
    output [7:0] not_result_a,    // Output for bitwise NOT of a
    output [7:0] not_result_b,    // Output for bitwise NOT of b
    output [7:0] xor_result       // Output for bitwise XOR operation
);
    // Compute bitwise operations
    assign and_result = a & b;    // Bitwise AND
    assign or_result = a | b;     // Bitwise OR
    assign not_result_a = ~a;     // Bitwise NOT for a
    assign not_result_b = ~b;     // Bitwise NOT for b
    assign xor_result = a ^ b;    // Bitwise XOR
endmodule

