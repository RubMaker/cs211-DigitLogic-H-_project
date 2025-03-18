`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 23:14:31
// Design Name: 
// Module Name: logical_operations
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


module logical_operations(
    input [7:0] a,                // 8-bit input a
    input [7:0] b,                // 8-bit input b
    output logic_and_result,      // Output for logical AND operation
    output logic_or_result,       // Output for logical OR operation
    output logic_not_result_a,    // Output for logical NOT operation for a
    output logic_not_result_b,    // Output for logical NOT operation for b
    output logic_xor_result       // Output for logical XOR operation
);
    // Compute logical operations
    assign logic_and_result = (|a) && (|b); // Logical AND: reduce a and b to 1-bit and perform logical AND
    assign logic_or_result  = (|a) || (|b); // Logical OR: reduce a and b to 1-bit and perform logical OR
    assign logic_not_result_a = !(|a);      // Logical NOT: reduce a to 1-bit and perform logical NOT for a
    assign logic_not_result_b = !(|b);      // Logical NOT: reduce a to 1-bit and perform logical NOT for b
    assign logic_xor_result = (|a) ^ (|b);  // Logical XOR: reduce a and b to 1-bit and perform logical XOR
endmodule

