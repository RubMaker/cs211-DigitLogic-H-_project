`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 14:50:18
// Design Name: 
// Module Name: calc_mode
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


module calc_module_45 (
    input wire[7:0] typea,typeb,a,b,
    output reg [7:0] result
);  
    wire [7:0] sum;
    wire [7:0] diff;

    wire [7:0] result_arith_left;
    wire [7:0] result_arith_right;
    wire [7:0] result_logic_left;
    wire [7:0] result_logic_right;  //Result from the shift module
    
    
    wire [7:0] and_result;     
    wire [7:0] or_result;
    wire [7:0] not_result_a;
    wire [7:0] not_result_b;
    wire [7:0] xor_result;   // Result from the bitwise operation module
    

    wire  logic_and_result;     
    wire  logic_or_result;
    wire logic_not_result_a;
    wire  logic_not_result_b;
    wire  logic_xor_result;   // Result from the logical operation module
    
    
    signed_add_sub_45 u1_signed_add_sub_45 (
        .a(a),       // Connect input_a to the module's input 'a'
        .b(b),       // Connect input_b to the module's input 'b'
        .sum(sum),
        .diff(diff)
    );
            
     bitwise_operations u1_bitwise_operations (
        .a(a),                  // Connect input_a to the module's input a
        .b(b),                  // Connect input_b to the module's input b
        .and_result(and_result),      // Connect module's and_result to output_and
        .or_result(or_result),        // Connect module's or_result to output_or
        .not_result_a(not_result_a),  // Connect module's not_result_a to output_not_a
        .not_result_b(not_result_b),  // Connect module's not_result_b to output_not_b
        .xor_result(xor_result)       // Connect module's xor_result to output_xor
    );
                
     logical_operations u1_logical_operations (
        .a(a),                  // Connect input_a to the module's a input
        .b(b),                  // Connect input_b to the module's b input
        .logic_and_result(logic_and_result), // Connect the module's AND result to logic_and
        .logic_or_result(logic_or_result),   // Connect the module's OR result to logic_or
        .logic_not_result_a(logic_not_result_a), // Connect the module's NOT result of a to logic_not_a
        .logic_not_result_b(logic_not_result_b), // Connect the module's NOT result of b to logic_not_b
        .logic_xor_result(logic_xor_result)  // Connect the module's XOR result to logic_xor
    );
                    
    shift_operation u1_shift_operation (
        .A(a),                    // Connect input_a to the module's input A
        .B(b),                    // Connect input_b to the module's input B
        .result_arith_left(result_arith_left), // Connect module's arithmetic left shift result to arith_left
        .result_arith_right(result_arith_right), // Connect module's arithmetic right shift result to arith_right
        .result_logic_left(result_logic_left), // Connect module's logical left shift result to logic_left
        .result_logic_right(result_logic_right) // Connect module's logical right shift result to logic_right
    );
// operation state
localparam arithmetic = 8'b00000001,
    move_operation = 8'b00000010,
    bit_operation = 8'b00000100,
    logic_operation = 8'b00001000;
// arithmetic state
localparam add = 8'b00000001,
    sub = 8'b00000010;
// move state
localparam left_arithmetic = 8'b00000001,
    right_arithmetic = 8'b00000010,
    left_logic = 8'b00000100,
    right_logic = 8'b00001000;
// bit state
localparam And = 8'b00000001,
    Or = 8'b00000010,
    Not = 8'b00000100,
    Xor = 8'b00001000;
// logic state
localparam logic_and = 8'b00000001,
    logic_or = 8'b00000010,
    logic_not = 8'b00000100,
    logic_xor = 8'b00001000; 

    always @(*) begin
        case (typea)
            arithmetic: begin
                case (typeb)
                    add: result = sum;
                    sub: result = diff;
                    default: result = 8'b00000000;
                endcase
            end
            move_operation: begin
                case (typeb)
                    left_arithmetic: result = result_arith_left;
                    right_arithmetic: result = result_arith_right;
                    left_logic: result = result_logic_left;
                    right_logic: result = result_logic_right;
                    default: result = 8'b00000000;
                endcase
            end
            bit_operation: begin
                case (typeb)
                    And: result = and_result;
                    Or: result = or_result;
                    Not: result = not_result_a;
                    Xor: result = xor_result;
                    default: result = 8'b00000000;
                endcase
            end
            logic_operation: begin
                case (typeb)
                    logic_and: result[0] = logic_and_result;
                    logic_or: result[0] = logic_or_result;
                    logic_not: result[0] = logic_not_result_a;
                    logic_xor: result[0] = logic_xor_result;
                    default: result[0] = 8'b00000000;
                endcase
            end
            default: result = 8'b00000000;
        endcase
    end
endmodule