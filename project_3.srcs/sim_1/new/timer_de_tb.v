`timescale 1ns / 1ps

module timer_for_demo_3s_tb;

    // Inputs
    reg clk;
    reg reset_n;

    // Outputs
    wire en_led;
    wire [28:0] counter;

    // 实例化待测试模块
    timer_for_demo_3s uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .en_led(en_led), 
        .counter(counter)
    );

    // 时钟信号产生
    initial begin
        clk = 0;
        forever #2 clk = ~clk; // 产生一个周期为10ns的时钟信号
    end

    // 测试序列
    initial begin
        // 初始化输入
        reset_n = 0; // 重置信号拉低，复位模块
        #15; // 等待15ns

        reset_n = 1; // 释放复位信号
        #10; // 等待100ns，观察模块行为

        // 再次触发复位
        reset_n = 0; // 再次拉低复位信号
        #100; // 等待10ns
        reset_n = 1; // 释放复位信号
        #200; // 等待200ns，观察模块行为

        // 结束仿真
        $finish;
    end

    // 监控变化
    initial begin
        $monitor("Time = %t, reset_n = %b, en_led = %b, counter = %d", 
                 $time, reset_n, en_led, counter);
    end

endmodule