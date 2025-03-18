`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/11 22:21:55
// Design Name: 
// Module Name: top_module_tb
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


module top_module_tb;
    // 输入信号定义
    reg clk;
    reg reset;
    reg button_1;
    reg button_2;
    reg button_3;
    reg button_4;
    reg [7:0] switch;

    // 输出信号定义
    wire [7:0] led_1;
    wire [7:0] led_2;
    wire [7:0] segment_0;
    wire [7:0] segment_1;
    wire seg_0;
    wire seg_1;
    wire seg_2;
    wire seg_3;
    wire seg_4;
    wire seg_5;
    wire seg_6;
    wire seg_7;
    wire [7:0] current_state;
    wire [7:0] next_state;
    wire [7:0] mode;
    // wire [7:0] mode_2;
    // wire [3:0] state_calc;
  wire [7:0] segment0;
  wire [7:0] segment1;
  wire [7:0] segment2;
  wire [7:0] segment3;
  wire [7:0] segment4;
  wire [7:0] segment5;
  wire [7:0] segment6;
  wire [7:0] segment7;


    // 实例化 top_module
    top_module uut (
        .clk(clk),
        .reset(reset),
        .button_1(button_1),
        .button_2(button_2),
        .button_3(button_3),
        .button_4(button_4),
        .switch(switch),
        .led_1(led_1),
        .led_2(led_2),
        .segment_0(segment_0),
        .segment_1(segment_1),
        .seg_0(seg_0),
        .seg_1(seg_1),
        .seg_2(seg_2),
        .seg_3(seg_3),
        .seg_4(seg_4),
        .seg_5(seg_5),
        .seg_6(seg_6),
        .seg_7(seg_7),
        .segment0(segment0),
        .segment1(segment1),
        .segment2(segment2),
        .segment3(segment3),
        .segment4(segment4),
        .segment5(segment5),
        .segment6(segment6),
        .segment7(segment7),        
        // .state_calc(state_calc),
        // .a(a),
        // .b(b),
        .mode(mode),
        // .mode_2(mode_2),
        .current_state(current_state),
        .next_state(next_state)
    );

    // 时钟信号生成
    always #1 clk = ~clk;

    // 测试逻辑
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        button_1=0;
        button_2 = 0;
        switch = 8'b0;

        // Apply reset
        reset = 1;
        #10 reset = 0;
        
        #8000000 button_1 = 1;   
        #8000000 button_1 = 0;  //go into stand_by

        switch = 8'b0001_0000;
        #8000000 button_1 = 1;  
        #16000000 button_1 = 0;  //go into calc mode
        


        switch = 8'b00000100;
        #8000000 button_2 = 1;   
        #8000000 button_2 = 0;  //input mode1

        switch = 8'b00000010;
        #8000000 button_2 = 1;  
        #8000000 button_2 = 0;  //input mode2

        #8000000 button_2 = 1; switch = 8'b00000001;  
        #8000000 button_2 = 0; //input a
         
         #8000000 button_2 = 1; switch = 8'b00000001;  
         #8000000 button_2 = 0;//input b

         #8000000 button_2 = 1;
        #8000000 button_2 = 0;

        #8000000 button_2 = 1;
        #8000000 button_2 = 0;
        
        switch = 8'b00001000;
        #8000000 button_2 = 1;   
        #8000000 button_2 = 0;  //input mode1

        switch = 8'b00000010;
        #8000000 button_2 = 1;  
        #8000000 button_2 = 0;  //input mode2

        #8000000 button_2 = 1; switch = 8'b00000001;  
        #8000000 button_2 = 0; //input a
         
         #8000000 button_2 = 1; switch = 8'b00000001;  
         #8000000 button_2 = 0;//input b

         #8000000 button_2 = 1;
        #8000000 button_2 = 0;

        #8000000 button_2 = 1;
        #8000000 button_2 = 0;

        #8000000 button_3 = 1;
        #8000000 button_3 = 0;


        #50

        // Finish the simulation
        $finish;
    end
endmodule

