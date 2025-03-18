`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/10 19:19:24
// Design Name: 
// Module Name: seg_decoder_8
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


module seg_decoder_8 (
    input [7:0] digit,       // ����ʮ�������֣�0-15��
    output reg [7:0] seg     // ����߶�����ܶ���
);
    always @(*) begin
        case (digit)
            8'd0: seg = 8'b0011_1111; // ��ʾ "0"
            8'd1: seg = 8'b0000_0110; // ��ʾ "1"
            8'd2: seg = 8'b0101_1011;// ��ʾ "2"
            8'd3: seg = 8'b0100_1111; // ��ʾ "3"
            8'd4: seg = 8'b0110_0110; // ��ʾ "4"
            8'd5: seg = 8'b0110_1101; // ��ʾ "5"
            8'd6: seg = 8'b0111_1101; // ��ʾ "6"
            8'd7: seg = 8'b0000_0111; // ��ʾ "7"
            8'd8: seg = 8'b0111_1111; // ��ʾ "8"
            8'd9: seg = 8'b0110_1111; // ��ʾ "9"
            8'd10: seg = 8'b0111_0111; // A
            8'd11: seg = 8'b0111_1100; // b
            8'd12: seg = 8'b0011_1001; // C
            8'd13: seg = 8'b0101_1110; // d
            8'd14: seg = 8'b0111_1001; // E
            8'd15: seg = 8'b0111_0001; // F
            8'd16: seg = 8'b0100_0000; //"-"
            8'd17: seg = 8'b00000000; //off
            default: seg = 8'b00000000; // Ĭ��ȫ��
        endcase
    end
endmodule
