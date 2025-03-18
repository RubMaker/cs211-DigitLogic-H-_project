`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 19:51:49
// Design Name: 
// Module Name: signed_add_sub_tb
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

module signed_add_sub_tb;

    // Inputs
    reg signed [7:0] a;
    reg signed [7:0] b;

    // Outputs
    wire [7:0] seg_2_add;
    wire [7:0] seg_1_add;
    wire [7:0] seg_0_add;
    wire [7:0] seg_2_sub;
    wire [7:0] seg_1_sub;
    wire [7:0] seg_0_sub;
    wire [7:0] seg_sign_add;
    wire [7:0] seg_sign_sub;

    // Instantiate the Unit Under Test (UUT)
    signed_add_sub uut (
        .a(a),
        .b(b),
        .seg_2_add(seg_2_add),
        .seg_1_add(seg_1_add),
        .seg_0_add(seg_0_add),
        .seg_2_sub(seg_2_sub),
        .seg_1_sub(seg_1_sub),
        .seg_0_sub(seg_0_sub),
        .seg_sign_add(seg_sign_add),
        .seg_sign_sub(seg_sign_sub)
    );

    // Testbench process
    initial begin
        // Monitor output
        $monitor("Time=%0t | a=%d, b=%d | Add: %d%d%d Sign: %b | Sub: %d%d%d Sign: %b",
                 $time, a, b,
                 seg_2_add, seg_1_add, seg_0_add, seg_sign_add,
                 seg_2_sub, seg_1_sub, seg_0_sub, seg_sign_sub);

        // Test Case 1: Positive numbers addition and subtraction
        a = 8'b00001111; b = 8'b10001111;
        #10;

        // Test Case 2: Positive and negative addition and subtraction
        a = 8'd20; b = -8'd5;
        #10;

        // Test Case 3: Negative and positive addition and subtraction
        a = -8'd30; b = 8'd15;
        #10;

        // Test Case 4: Two negative numbers addition and subtraction
        a = -8'd25; b = -8'd35;
        #10;

        // Test Case 5: Edge case, max positive and max negative values
        a = 8'd127; b = -8'd128;
        #10;

        // Test Case 6: Zero addition and subtraction
        a = 8'd0; b = 8'd0;
        #10;

        // Test Case 7: Overflow scenario
        a = 8'd100; b = 8'd100;
        #10;

        // Test Case 8: Underflow scenario
        a = -8'd100; b = -8'd50;
        #10;

        $stop; // End simulation
    end
endmodule

