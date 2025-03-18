`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/11 21:35:38
// Design Name: 
// Module Name: calc_mode_tb
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




module calc_mode_tb;
    // Testbench signals
    reg clk;
    reg reset;
    reg raw_confirm;
    reg [7:0] input_data;
    wire [7:0] display1;
    wire [7:0] display2;
    wire [7:0] display3;
    wire [7:0] display4;
    wire [7:0] display5;
    
    wire [7:0] led;
    wire [3:0] current_state;
    wire [3:0] next_state;

    // Instantiate the calc_mode module
    calc_mode uut (
        .clk(clk),
        .reset(reset),
        .raw_confirm(raw_confirm),
        .input_data(input_data),
        .led(led),
        .display1(display1),
        .display2(display2),
        .display3(display3),
        .display4(display4),
        .display5(display5)
        // .current_state(current_state),
        // .next_state(next_state)
        //.current_state(current_state)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Clock period is 10ns
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        raw_confirm = 0;
        input_data = 8'b0;

        // Apply reset
        reset = 1;
        #10 reset = 0;
        
        // #60000000 raw_confirm = 1;   
        #60000000 raw_confirm = 0;
        
        input_data = 8'b00000011;
        #60000000 raw_confirm = 1;   // Mode 1 = 1(Base conversion)
        #60000000 raw_confirm = 0;  // Release confirm button

        input_data = 8'b00000000;
        #60000000 raw_confirm = 1;   // Mode 1 = 1(Base conversion)
        #60000000 raw_confirm = 0;  // Release confirm button

        // Step 2: Operand a input (8-bit value)
        #60000000 raw_confirm = 1; input_data = 8'b10101010;  
        #60000000 raw_confirm = 0; 
         // Release confirm button
         
         #60000000 raw_confirm = 1; input_data = 8'b11001100;  
         #60000000 raw_confirm = 0;

         #60000000 raw_confirm = 1;
        #60000000 raw_confirm = 0;

        






        #50

        // Finish the simulation
        $finish;
    end

endmodule


