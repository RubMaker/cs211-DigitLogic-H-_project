`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 10:11:53 PM
// Design Name: 
// Module Name: demonstration_module_tb
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
module demonstration_module_tb;

// Inputs
reg clk;
reg reset;
reg [7:0] user_input;
reg input_complete;

// Outputs
wire [7:0] display1;
wire [7:0] display2;
wire [7:0] display3;
wire [7:0] display4;
wire [7:0] display5;
wire [7:0] display6;
wire [7:0] display7;
wire [7:0] display8;
wire [7:0] led;
// wire [3:0] state;
// wire [3:0] next_state;
// wire [7:0] en;
// wire reset_n;
// wire [28:0] counter;
// wire en_;
// 实例化被测试模块
demonstration_module uut (
    .clk(clk), 
    .reset(reset), 
    .user_input(user_input), 
    .input_complete(input_complete), 
    .display1(display1), 
    .display2(display2), 
    .display3(display3), 
    .display4(display4), 
    .display5(display5), 
    .display6(display6), 
    .display7(display7), 
    .display8(display8),
    .led(led)
    // .state(state),
    // .next_state(next_state),
    // .en(en),
    // .reset_n(reset_n)
    // .Counter(counter)
    // .en_(en_)
);

initial begin
    // 初始化输入
    clk = 0;
    reset = 1;
    user_input = 0;
    input_complete = 0;

    // 等待100纳秒以确保复位完成
    #95;
    reset = 0; // 释放复位信号

    // 模拟用户输入和确认
    #10 input_complete = 1; // 模拟第一次输入完成
    user_input = 8'b101; // 模拟输入第一个3位无符号数
    #10 input_complete = 0; // 清除输入完成信号

    #10 input_complete = 1; // 模拟第二次输入完成
    user_input = 8'b110; // 模拟输入第二个3位无符号数
    #10 input_complete = 0; // 清除输入完成信号

    // 模拟退出演示
    #10 input_complete = 1; // 模拟退出演示的输入
    #10 input_complete = 0; // 清除输入完成信号

    // 测试结束
    #1000;
    $finish;
end

// 时钟信号生成
always #5 clk = ~clk; // 每10纳秒切换一次，即100MHz时钟

endmodule