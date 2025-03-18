`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/07 14:36:54
// Design Name: 
// Module Name: seg_decoder_neg
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


module seg_decoder_neg (
    input negative,        // ���븺�ű�־
    output reg [7:0] seg   // ����߶�����ܶ���
);
    always @(*) begin
        if (negative)
            seg = 8'b10000000; // ��ʾ����
        else
            seg = 8'b00000000; // ����ʾ�κ�����
    end
endmodule

