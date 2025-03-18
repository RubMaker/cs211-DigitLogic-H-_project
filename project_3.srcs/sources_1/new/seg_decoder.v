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
    input [4:0] digit,       // ����ʮ�������֣�0-15��
    output reg [7:0] seg     // ����߶�����ܶ���
);
    always @(*) begin
        case (digit)
            4'd0: seg = 8'b01111110; // ��ʾ "0"
            4'd1: seg = 8'b00001100; // ��ʾ "1"
            4'd2: seg = 8'b10110110;// ��ʾ "2"
            4'd3: seg = 8'b10011110; // ��ʾ "3"
            4'd4: seg = 8'b11001100; // ��ʾ "4"
            4'd5: seg = 8'b11011010; // ��ʾ "5"
            4'd6: seg = 8'b11111010; // ��ʾ "6"
            4'd7: seg = 8'b00001110; // ��ʾ "8"
            4'd8: seg = 8'b11111110; // ��ʾ "8"
            4'd9: seg = 8'b11011110; // ��ʾ "9"
            4'd10: seg = 8'b11101110; // A
            4'd11: seg = 8'b00111110; // b
            4'd12: seg = 8'b10011100; // C
            4'd13: seg = 8'b01111010; // d
            4'd14: seg = 8'b10011110; // E
            4'd15: seg = 8'b10001110; // F
            default: seg = 8'b00000000; // Ĭ��ȫ��
        endcase
    end
endmodule


