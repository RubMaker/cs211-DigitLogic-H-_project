`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 09:48:30 PM
// Design Name: 
// Module Name: timer_for_demo_3s
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
module timer_for_demo_3s(
    input clk,          // ʱ���ź�
    input reset_n,        // ��λ�ź�
    output reg en_led,  // ��ʱ������
    output reg [28:0] counter  // ��ʱ������
);

reg [28:0] counter;

always @(posedge clk) begin
    if (reset_n) begin
        counter <= 29'd0;
        en_led <= 1'b0;
    end
    else begin
        if (counter >= 29'd300000000) begin
        // if (counter >= 29'd3) begin
            counter <= 29'd0;
            en_led <= 1'b1;
        end
        else begin
            en_led <= 1'b0;
            counter <= counter + 1;
        end
    end
end

endmodule