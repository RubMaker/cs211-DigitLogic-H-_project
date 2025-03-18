`timescale 1ns / 1ps

module learn_module_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [7:0] user_input;
    reg input_complete;
    reg input_quit;

    // Outputs
    wire [7:0] led;
    wire [7:0] display1;
    wire [7:0] display2;
    wire [7:0] display3;
    wire [7:0] display4;
    wire [7:0] display5;
    wire [7:0] display6;
    wire [7:0] display7;
    wire [7:0] display8;
    wire [3:0] state;
    wire [3:0] next_state;

    // 实例化待测试模块
    learn_module uut (
        .clk(clk), 
        .reset(reset), 
        .user_input(user_input), 
        .input_complete(input_complete), 
        .input_quit(input_quit), 
        .led(led), 
        .display1(display1), 
        .display2(display2), 
        .display3(display3), 
        .display4(display4), 
        .display5(display5), 
        .display6(display6), 
        .display7(display7), 
        .display8(display8),
        .state(state),
        .next_state(next_state)
    );

    // 时钟信号产生
    initial begin
        clk = 0;
        forever #1 clk = ~clk; // 产生一个周期为10ns的时钟信号
    end

    // 测试序列
    initial begin
        // 初始化输入
        reset = 1; user_input = 8'd0; input_complete = 0; input_quit = 0;
        #15; // 等待15ns

        // 复位模块
        reset = 0;
        #20; // 等待20ns

        // 测试用例1：输入类型A和B，操作数A和B，结果
        input_complete = 1; user_input = 8'd1; // 输入类型A
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd2; // 输入类型B
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd1; // 输入操作数A
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd2; // 输入操作数B
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; //user_input = 8'd15; // 输入结果
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; //user_input = 8'd15; // 输入结果
        #10;
        input_complete = 0;
        #10;

        // 测试用例2：输入类型A和B，操作数A和B，结果
        input_complete = 1; user_input = 8'd2; // 输入类型A
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd2; // 输入类型B
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd3; // 输入操作数A
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd2; // 输入操作数B
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; //user_input = 8'd20; // 输入结果
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; //user_input = 8'd15; // 输入结果
        #10;
        input_complete = 0;
        #10;

        // 测试用例2：输入类型A和B，操作数A和B，结果
        input_complete = 1; user_input = 8'd4; // 输入类型A
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd2; // 输入类型B
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd3; // 输入操作数A
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd2; // 输入操作数B
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; //user_input = 8'd20; // 输入结果
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; //user_input = 8'd15; // 输入结果
        #10;
        input_complete = 0;
        #10;

        // 测试用例2：输入类型A和B，操作数A和B，结果
        input_complete = 1; user_input = 8'd8; // 输入类型A
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd2; // 输入类型B
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd3; // 输入操作数A
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; user_input = 8'd2; // 输入操作数B
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; //user_input = 8'd20; // 输入结果
        #10;
        input_complete = 0;
        #10;
        input_complete = 1; //user_input = 8'd15; // 输入结果
        #10;
        input_complete = 0;
        #10;

        // 退出测试
        input_quit = 1;
        #10;
        input_quit = 0;

        // 结束仿真
        #100;
        $finish;
    end

    // 监控变化
    initial begin
        $monitor("Time = %t, reset = %b, user_input = %d, input_complete = %b, input_quit = %b, led = %h, display1 = %h, display2 = %h, display3 = %h, display4 = %h, display5 = %h, display6 = %h, display7 = %h, display8 = %h", 
                 $time, reset, user_input, input_complete, input_quit, led, display1, display2, display3, display4, display5, display6, display7, display8);
    end

endmodule