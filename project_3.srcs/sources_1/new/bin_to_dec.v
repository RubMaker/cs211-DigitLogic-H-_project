`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/07 14:07:36
// Design Name: 
// Module Name: bin_to_dec
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

module bin_to_dec (
    input signed [7:0] binary,  // 确保输入声明为有符号类型
    output reg [7:0] hundred,  // 输出百位
    output reg [7:0] ten,      // 输出十位
    output reg [7:0] one,      // 输出个位
    output reg negative        // 负号标志
);
    reg [7:0] abs_binary;  // 绝对值变量，用于计算正数部分

    always @(*) begin
        // 判断是否为负数
        if (binary < 0) begin
            negative = 1;
            abs_binary = -binary;  // 将负数转为绝对值
        end else begin
            negative = 0;
            abs_binary = binary;
        end

        // 分离出百位、十位和个位
        hundred = abs_binary / 100;           // 计算百位
        ten = (abs_binary % 100) / 10;       // 计算十位
        one = abs_binary % 10;               // 计算个位
    end
endmodule



