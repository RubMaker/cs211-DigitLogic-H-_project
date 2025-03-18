`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/13 19:48:39
// Design Name: 
// Module Name: bitwise_operations_tb
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


`timescale 1ns / 1ps

module bitwise_operations_tb;

    // Inputs
    reg [7:0] a;
    reg [7:0] b;

    // Outputs
    wire [7:0] and_result;
    wire [7:0] or_result;
    wire [7:0] not_result_a;
    wire [7:0] not_result_b;
    wire [7:0] xor_result;

    // Instantiate the Unit Under Test (UUT)
    bitwise_operations uut (
        .a(a),
        .b(b),
        .and_result(and_result),
        .or_result(or_result),
        .not_result_a(not_result_a),
        .not_result_b(not_result_b),
        .xor_result(xor_result)
    );

    initial begin
        // Monitor the outputs
        $monitor("Time = %0d, a = %b, b = %b, and_result = %b, or_result = %b, not_result_a = %b, not_result_b = %b, xor_result = %b",
                 $time, a, b, and_result, or_result, not_result_a, not_result_b, xor_result);

        // Test Case 1
        a = 8'b11001100; b = 8'b10101010;
        #10;

        // Test Case 2
        a = 8'b11110000; b = 8'b00001111;
        #10;

        // Test Case 3
        a = 8'b00000000; b = 8'b11111111;
        #10;

        // Test Case 4
        a = 8'b10101010; b = 8'b01010101;
        #10;

        // Test Case 5
        a = 8'b11111111; b = 8'b00000000;
        #10;

        // Finish simulation
        $finish;
    end

endmodule

