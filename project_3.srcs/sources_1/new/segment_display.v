`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/23 10:41:34
// Design Name: 
// Module Name: segment_display
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


module segment_display(
    input clk,
    input reset,
    input [7:0] segment0,
    input [7:0] segment1,
    input [7:0] segment2,
    input [7:0] segment3,
    input [7:0] segment4,
    input [7:0] segment5,
    input [7:0] segment6,
    input [7:0] segment7,
    output reg [7:0] segment_0,
    output reg [7:0] segment_1,
    output reg seg_0,
    output reg seg_1,
    output reg seg_2,
    output reg seg_3,
    output reg seg_4,
    output reg seg_5,
    output reg seg_6,
    output reg seg_7
    );

    reg [7:0] segment_choosing;
    parameter max_cnt=50000;
    reg div_clk=0;
    reg[18:0] divclk_cnt = 0;

    always@(posedge clk)
    begin
        if(divclk_cnt==max_cnt)
        begin
            div_clk=~div_clk;
            divclk_cnt=0;
        end
        else
        begin
            divclk_cnt=divclk_cnt+1'b1;
        end
    end

    always @(posedge div_clk or posedge reset) begin
        if (reset) begin
            segment_choosing<= 2'b00;
        end else begin
            if (segment_choosing >= 2'b11) begin
              segment_choosing<=2'b00;
            end
            else begin
              segment_choosing <= segment_choosing +1;
            end
            case (segment_choosing)
            (2'b00):begin
              segment_0<=segment0;
              segment_1<=segment4;
              seg_0<=1;
              seg_3<=0;
              seg_4<=1;
              seg_7<=0;
            end

            (2'b01):begin
              segment_0<=segment1;
              segment_1<=segment5;
              seg_1<=1;
              seg_0<=0;
              seg_4<=0;
              seg_5<=1;
            end

            (2'b10):begin
              segment_0<=segment2;
              segment_1<=segment6;
              seg_2<=1;
              seg_1<=0;
              seg_5<=0;
              seg_6<=1;
            end

            (2'b11):begin
              segment_0<=segment3;
              segment_1<=segment7;
              seg_3<=1;
              seg_2<=0;
              seg_7<=1;
              seg_6<=0;
            end

            default begin
              segment_0<=8'b00111111;
              segment_1<=8'b00111111;
            end   
            endcase
        end
    end

endmodule
