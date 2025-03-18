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


module signed_add_sub (
    input signed [7:0] a,
    input signed [7:0] b,
    output [7:0] seg_2_add,      
    output [7:0] seg_1_add,       
    output [7:0] seg_0_add,
    output [7:0] seg_2_sub,      
    output [7:0] seg_1_sub,       
    output [7:0] seg_0_sub,       
    output reg [7:0] seg_sign_add,
    output reg [7:0] seg_sign_sub     
);
    wire signed [7:0] sum = a + b;   
    wire signed [7:0] diff = a - b;
    wire sign_add;
    wire sign_sub; 

    bin_to_dec sum_converter (
        .binary(sum),              
        .hundred(seg_2_add),
        .ten(seg_1_add),
        .one(seg_0_add),
        .negative(sign_add)
    );

    bin_to_dec sub_converter (
        .binary(diff),              
        .hundred(seg_2_sub),
        .ten(seg_1_sub),
        .one(seg_0_sub),
        .negative(sign_sub)
    );

    always @( *) begin
        case (sign_add)
            1'b1:begin
              seg_sign_add = 8'b00010000;
            end
            
            1'b0:begin
              seg_sign_add = 8'b00000000;
            end

            default 
              seg_sign_add = 8'b00010000;
        endcase

        case (sign_sub)
            1'b1:begin
              seg_sign_sub = 8'b00010000;
            end
            
            1'b0:begin
              seg_sign_sub = 8'b00000000;
            end

            default 
              seg_sign_sub = 8'b00010000;
        endcase
    end

    

    

    
endmodule