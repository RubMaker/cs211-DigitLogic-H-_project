`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/10 20:15:29
// Design Name: 
// Module Name: timer_module
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

module timer_module(
    input clk,          
    input reset_n,       
    output reg [4:0] timer,  
    output reg en_led
);
    reg [26:0] counter;

    always @(posedge clk) begin
        if (reset_n) begin
            counter <= 27'd0;
            en_led <= 1'b0;
            timer <= 5'd0;
        end
        else begin
            if (counter >= 27'd100000000) begin
            // if (counter >= 29'd3) begin
                timer <= timer + 1;
                counter <= 27'd0;
                en_led <= (en_led)? 1'b0 : 1'b1;
            end
            else begin
                timer <= timer;
                en_led <= en_led;
                counter <= counter + 1;
            end
        end
    end
endmodule

