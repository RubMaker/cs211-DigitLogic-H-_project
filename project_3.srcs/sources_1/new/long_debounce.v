`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/10 02:18:27
// Design Name: 
// Module Name: long_debounce
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
module long_debounce (
    input  wire clk,       
    input  wire reset,        
    input  wire btn_in,         
    output reg  debounced_btn, 
    output reg  confirm_stable       
);

    parameter STABLE_COUNT_MAX = 250;
   
    reg sync_ff1, sync_ff2;      
    reg [7:0] stable_counter;     
    reg last_stable_state;        
    reg debounced_btn_dly;        
    wire slow_clk;

    slow_clk_gen uut(
        .clk(clk),
        .reset(reset),
        .slow_clk(slow_clk)
    );


    always @(posedge slow_clk or posedge reset) begin
        if (reset) begin
            sync_ff1 <= 1'b0;
            sync_ff2 <= 1'b0;
        end else begin
            sync_ff1 <= btn_in;
            sync_ff2 <= sync_ff1;
        end
    end

   
    always @(posedge slow_clk or posedge reset) begin
        if (reset) begin
            stable_counter    <= 0;
            debounced_btn     <= 0;
            last_stable_state <= 0;
        end else begin
            if (sync_ff2 == last_stable_state) begin
                if (stable_counter < STABLE_COUNT_MAX) begin
                    stable_counter <= stable_counter + 1'b1;
                end else begin
                    stable_counter <= STABLE_COUNT_MAX;
                    debounced_btn <= last_stable_state;
                end
            end else begin
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