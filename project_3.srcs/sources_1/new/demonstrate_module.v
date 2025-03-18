`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 09:28:51 PM
// Design Name: 
// Module Name: demonstration_module
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

module demonstration_module(
    input clk,            // 100 clk          
    input reset,          // reset signal          
    input [7:0] user_input,              // input data 
    input input_complete,               // input complete signal
    input en,                       // enable signal
    output reg [7:0] display1,  
    output reg [7:0] display2,  
    output reg [7:0] display3,  
    output reg [7:0] display4,  
    output reg [7:0] display5,  
    output reg [7:0] display6,  
    output reg [7:0] display7,  
    output reg [7:0] display8,  
    output reg [7:0] led
);

// assign Couter = counter;
// Special digit encoding for special state
localparam digit_an = 8'd17, // for no light
            digit_minue = 8'd16; // for '-'

// State encoding for the state machine
localparam Idle = 4'd0, // State 0: Idle state, waiting for input
           Input_a = 4'd1, // State 1: Input state for variable 'a'
           Input_b = 4'd2, // State 2: Input state for variable 'b'
           Demo = 4'd3; // State 3: Demonstration state to show the result

// Registers for current state and next state
reg [3:0] state = 4'd0; // Current state register initialized to Idle
reg [3:0] next_state = 4'd0; // Next state register

// Registers for input variables and result
reg [7:0] inputa = 8'd0; // Register for input 'a'
reg [7:0] inputb = 8'd0; // Register for input 'b'
reg [7:0] result = 8'd0; // Register for the result of the operation
reg [7:0] result_tmp = 8'd0; // Temporary register for result calculation

// Active-low reset signal
reg reset_n = 1'b1; // Reset signal, active low

// Wire for enabling the LED (not defined in the provided code)
wire en_led; // Enable signal for the LED

// Flag to indicate when to update the number display
reg flag_number_update = 1'b0; // Update flag initialized to 0

// Timer module instance for a 3-second demonstration
timer_for_demo_3s timer_for_demo_3s_inst(
    .clk(clk), // Clock input for the timer
    .reset_n(reset_n), // Active-low reset input for the timer
    .en_led(en_led), // Enable signal for the LED output
    .counter(couter) // Counter output (should be 'counter' based on context)
);

// State transition on clock edge or reset
always @(posedge clk or posedge reset) begin
    if ( reset || !en ) begin
        // If reset is active or enable is low, go to Idle state
        state <= Idle;
    end else begin
        // Otherwise, transition to the next state
        state <= next_state;
    end
end

// State transition based on input_complete signal
always @(*) begin
    case (state)
        Idle: begin
            // If input_complete is high, transition to Input_a, else stay in Idle
            next_state = (input_complete) ? Input_a : Idle;
        end
        Input_a: begin
            // If input_complete is high, transition to Input_b, else stay in Input_a
            next_state = (input_complete) ? Input_b : Input_a;
        end
        Input_b: begin
            // If input_complete is high, transition to Demo, else stay in Input_b
            next_state = (input_complete) ? Demo : Input_b;
        end
        Demo: begin
            // If input_complete is high, transition back to Idle, else stay in Demo
            next_state = (input_complete) ? Idle : Demo;
        end
        default: begin
            // Default case to handle undefined states
            next_state = next_state;
        end
    endcase
end

//state machine
always @(posedge clk) begin
    // If the enable signal is low or the reset signal is active, reset all registers and flags
    if (!en || reset) begin 
        // Reset the state to Idle (commented out, but likely intended to be used)
        // state <= Idle;
        inputa <= 8'd0; // Reset input 'a' to 0
        inputb <= 8'd0; // Reset input 'b' to 0
        result <= 8'd0; // Reset the result to 0
        result_tmp <= 8'd0; // Reset the temporary result to 0
        reset_n <= 1'b1; // Set the active-low reset signal to high (inactive)
        flag_number_update <= 1'b0; // Clear the number update flag
    end else begin
        // Otherwise, perform actions based on the current state
        case (state) 
            Idle: begin
                // Initialize all inputs and displays to default values
                inputa <= 8'd0; // Clear input 'a'
                inputb <= 8'd0; // Clear input 'b'
                // Set all display segments to show 'A' (assuming digit_an represents 'A')
                display1 <= digit_an;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
                led <= 8'd0; // Turn off all LEDs
                reset_n <= 1'b1; // Keep the reset signal inactive
            end
            Input_a: begin
                // Load user input into input 'a' and display it on the LEDs and specific displays
                inputa <= user_input; // Store user input in 'a'
                led <= user_input; // Display user input on LEDs
                // Display 'A' on the first four segments and the user input on the next four
                display1 <= digit_an;
                display2 <= user_input[2];
                display3 <= user_input[1];
                display4 <= user_input[0];
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
                // reset_n <= 1'b1; // Keep the reset signal inactive (commented out)
            end
            Input_b: begin
                // Load user input into input 'b', update displays, and reset result and flags
                inputb <= user_input; // Store user input in 'b'
                led <= user_input; // Display user input on LEDs
                // Display 'A' on the first and fifth segments, input 'a' on the next three, and input 'b' on the last three
                display1 <= digit_an;
                display2 <= inputa[2];
                display3 <= inputa[1];
                display4 <= inputa[0];
                display5 <= digit_an;
                display6 <= user_input[2];
                display7 <= user_input[1];
                display8 <= user_input[0];
                result <= 8'd0; // Reset the result
                result_tmp <= 8'd0; // Reset the temporary result
                flag_number_update <= 1'b0; // Clear the number update flag
                // reset_n <= 1'b1; // Keep the reset signal inactive (commented out)
            end
            Demo: begin 
                if (en_led) begin // 3s need to get next result by plus proper number
                    if (!(Input_b^8'd0)) begin
                    end else if (!flag_number_update) begin 
                        if(!(inputb[0]^ 1'b1)) begin
                            result <= result_tmp + inputa;
                            inputb[0] <= 1'b0;
                            led <= result_tmp + inputa;
                                        // flag_complete_cacl <= 1'b1;
                        end else if(!(inputb[1] ^ 1'b1)) begin
                            result <= result_tmp + (inputa<<1);
                            inputb[1] <= 1'b0;
                            led <= result_tmp + (inputa<<1);
                                        // flag_complete_cacl <= 1'b1;
                        end else if(!(inputb[2] ^ 1'b1)) begin
                            result <= result_tmp + (inputa<<2);
                            inputb[2] <= 1'b0;
                            led <= result_tmp + (inputa<<2);
                                        // flag_complete_cacl <= 1'b1;
                                end           
                            end
                            reset_n <= 1'b1;
                            flag_number_update <= 1'b1;
                        end else begin // represent the result
                                result_tmp <= result;
                                flag_number_update <= 1'b0;
                                reset_n <= 1'b0;
                                if (!(result ^ 8'd0)) begin//the result is 0
                                    display1 <= digit_an;
                                    display2 <= digit_an;
                                    display3 <= digit_an;
                                    display4 <= digit_an;
                                    display5 <= digit_an;
                                    display6 <= 8'd0;
                                    display7 <= 8'd0;
                                    display8 <= 8'd0;
                                    led <= 8'd0;
                                        // en <= 8'b00000111;
                                end else begin
                                    if (!(result[7] ^ 1'b1)) begin//the result is 8 bit number
                                        display1 <= 8'd1;
                                        display2 <= result[6];
                                        display3 <= result[5];
                                        display4 <= result[4];
                                        display5 <= result[3];
                                        display6 <= result[2];
                                        display7 <= result[1];
                                        display8 <= result[0];
                                        // en <= 8'b11111111;
                                    end else if (!(result[6] ^ 1'b1)) begin//the result is 7 bit number
                                        display1 <= digit_an;
                                        display2 <= 8'd1;
                                        display3 <= result[5];
                                        display4 <= result[4];
                                        display5 <= result[3];
                                        display6 <= result[2];
                                        display7 <= result[1];
                                        display8 <= result[0];
                                        // en <= 8'b01111111;
                                    end else if (!(result[5] ^ 1'b1)) begin//the result is 6 bit number
                                        display1 <= digit_an;
                                        display2 <= digit_an;
                                        display3 <= result[5];
                                        display4 <= result[4];
                                        display5 <= result[3];
                                        display6 <= result[2];
                                        display7 <= result[1];
                                        display8 <= result[0];
                                        // en <= 8'b00111111;
                                    end else if (!(result[4] ^ 1'b1)) begin//the result is 5 bit number
                                        display1 <= digit_an;
                                        display2 <= digit_an;
                                        display3 <= digit_an;
                                        display4 <= result[4];
                                        display5 <= result[3];
                                        display6 <= result[2];
                                        display7 <= result[1];
                                        display8 <= result[0];
                                        // en <= 8'b00011111;
                                    end else if (!(result[3] ^ 1'b1)) begin//the result is 4 bit number
                                        display1 <= digit_an;
                                        display2 <= digit_an;
                                        display3 <= digit_an;
                                        display4 <= digit_an;
                                        display5 <= result[3];
                                        display6 <= result[2];
                                        display7 <= result[1];
                                        display8 <= result[0];
                                        // en <= 8'b00001111;
                                    end else if (!(result[2] ^ 1'b1)) begin//the result is 3 bit number
                                        display1 <= digit_an;
                                        display2 <= digit_an;
                                        display3 <= digit_an;
                                        display4 <= digit_an;
                                        display5 <= digit_an;
                                        display6 <= result[2];
                                        display7 <= result[1];
                                        display8 <= result[0];
                                        // en <= 8'b00000111;
                                    end else if (!(result[1] ^ 1'b1)) begin//the result is 2 bit number
                                        display1 <= digit_an;
                                        display2 <= digit_an;
                                        display3 <= digit_an;
                                        display4 <= digit_an;
                                        display5 <= digit_an;
                                        display6 <= digit_an;
                                        display7 <= result[1];
                                        display8 <= result[0];
                                    end else if (!(result[0] ^ 1'b1)) begin//the result is 1 bit number
                                        display1 <= digit_an;
                                        display2 <= digit_an;
                                        display3 <= digit_an;
                                        display4 <= digit_an;
                                        display5 <= digit_an;
                                        display6 <= digit_an;
                                        display7 <= digit_an;
                                        display8 <= result[0];
                                    end
                                end
                            end
            end
        endcase
    end 
end

endmodule
