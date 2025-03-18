`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 22:40:43
// Design Name: 
// Module Name: shift_operation
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


module shift_operation(
    input signed [7:0] A,       // Input signed 8-bit number A
    input [7:0] B,             // Input unsigned 3-bit shift amount B (max shift: 7 bits)
    output [7:0] result_arith_left,  // Result of arithmetic left shift (A <<< B)
    output [7:0] result_arith_right, // Result of arithmetic right shift (A >>> B)
    output [7:0] result_logic_left,  // Result of logical left shift (A << B)
    output [7:0] result_logic_right  // Result of logical right shift (A >> B)
);
    assign result_arith_left  = A <<< B;  // Arithmetic left shift by B bits
    assign result_arith_right = A >>> B;  // Arithmetic right shift by B bits
    assign result_logic_left  = A << B;   // Logical left shift by B bits
    assign result_logic_right = A >> B;   // Logical right shift by B bits
endmodule

