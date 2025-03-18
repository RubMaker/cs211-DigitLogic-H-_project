`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/04 15:05:26
// Design Name: 
// Module Name: debounce
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


`timescale 1ns/1ps
module debounce (
    input  wire clk,       // 慢时钟信号(已分频，100Hz)
    input  wire reset,          // 异步复位，低电平有效
    input  wire btn_in,         // 来自机械按键的异步输入信号
    output reg  debounced_btn,  // 去抖后的稳定输出信号
    output reg  confirm_stable       // 按键从0到1变化时产生的单周期脉冲
);

    parameter STABLE_COUNT_MAX = 2;
    //=========================================================================
    // 寄存器定义
    //=========================================================================
    reg sync_ff1, sync_ff2;       // 两级同步D触发器
    reg [7:0] stable_counter;     // 稳定计数器, 根据需要调整位宽
    reg last_stable_state;        // 记录上次已确认的稳定状态
    reg debounced_btn_dly;        // 用于检测debounced_btn的上一次状态
    wire slow_clk;

    slow_clk_gen uut(
        .clk(clk),
        .reset(reset),
        .slow_clk(slow_clk)
    );

    //=========================================================================
    // 异步信号同步化（两级D触发器）
    //=========================================================================
    always @(posedge slow_clk or posedge reset) begin
        if (reset) begin
            sync_ff1 <= 1'b0;
            sync_ff2 <= 1'b0;
        end else begin
            sync_ff1 <= btn_in;
            sync_ff2 <= sync_ff1;
        end
    end

    //=========================================================================
    // 稳定性判定逻辑
    //=========================================================================
    always @(posedge slow_clk or posedge reset) begin
        if (reset) begin
            stable_counter    <= 0;
            debounced_btn     <= 0;
            last_stable_state <= 0;
        end else begin
            if (sync_ff2 == last_stable_state) begin
                // 状态相同，计数器累积
                if (stable_counter < STABLE_COUNT_MAX) begin
                    stable_counter <= stable_counter + 1'b1;
                end else begin
                    stable_counter <= STABLE_COUNT_MAX;
                    // 达到稳定次数后，更新输出
                    debounced_btn <= last_stable_state;
                end
            end else begin
                // 状态变化，重新计数
                last_stable_state <= sync_ff2;
                stable_counter    <= 0;
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            debounced_btn_dly <= 1'b0;
            confirm_stable         <= 1'b0;
        end else begin
            debounced_btn_dly <= debounced_btn;
            confirm_stable <= (debounced_btn & ~debounced_btn_dly);
        end
    end

endmodule



