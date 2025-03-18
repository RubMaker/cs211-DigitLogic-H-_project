`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/08 14:09:03
// Design Name: 
// Module Name: seg_decoder
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


module seg_decoder (
    input [4:0] digit,       // 输入十进制数字（0-15）
    output reg [7:0] seg     // 输出七段数码管段码
);
    always @(*) begin
        case (digit)
            4'd0: seg = 8'b01111110; // 显示 "0"
            4'd1: seg = 8'b00001100; // 显示 "1"
            4'd2: seg = 8'b10110110;// 显示 "2"
            4'd3: seg = 8'b10011110; // 显示 "3"
            4'd4: seg = 8'b11001100; // 显示 "4"
            4'd5: seg = 8'b11011010; // 显示 "5"
            4'd6: seg = 8'b11111010; // 显示 "6"
            4'd7: seg = 8'b00001110; // 显示 "8"
            4'd8: seg = 8'b11111110; // 显示 "8"
            4'd9: seg = 8'b11011110; // 显示 "9"
            4'd10: seg = 8'b11101110; // A
            4'd11: seg = 8'b00111110; // b
            4'd12: seg = 8'b10011100; // C
            4'd13: seg = 8'b01111010; // d
            4'd14: seg = 8'b10011110; // E
            4'd15: seg = 8'b10001110; // F
            default: seg = 8'b00000000; // 默认全灭
        endcase
    end
endmodule


