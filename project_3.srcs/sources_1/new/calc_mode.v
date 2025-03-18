`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 14:50:18
// Design Name: 
// Module Name: calc_mode
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


module calc_mode (
    input clk,
    input reset,
    input wire raw_confirm,
    input wire [7:0] input_data,
    input wire en,
    output reg [7:0] display1,
    output reg [7:0] display2,
    output reg [7:0] display3,
    output reg [7:0] display4,
    output reg [7:0] display5,  
    output reg [7:0] led,
    output reg [7:0] led_2
);


    parameter idle = 4'b0000,       
                wait_mode_1= 4'b0001,  
                wait_mode_2 = 4'b0010,  
                wait_a = 4'b0011,    
                wait_b = 4'b0100,    
                calculate = 4'b0101;   

                  
    reg [3:0] current_state,next_state;
    reg [3:0] pre_state= 4'b0;
    reg state_change=1'b0;
    
    reg [7:0] mode_1,mode_2 ,a, b; 
    reg [7:0] result; 

    // Define debounce logic variable
    wire confirm_stable;  
    wire debounced_btn;
    // New signals to track whether a and b are confirmed
    reg mode_1_confirmed=1'b0, mode_2_confirmed=1'b0, a_confirmed=1'b0, b_confirmed=1'b0;
    
    // Intermediate wires to hold the results from different modules  
    wire [7:0] octal_0;
    wire [7:0] octal_1;
    wire [7:0] octal_2;
    wire [7:0] decimal_0;
    wire [7:0] decimal_1;
    wire [7:0] decimal_2;
    wire [7:0] hex_0;
    wire [7:0] hex_1;  // Result from the  conversion module
    
    wire [7:0] seg_2_add;   
    wire [7:0] seg_1_add;
    wire [7:0] seg_0_add;
    wire [7:0] seg_2_sub;   
    wire [7:0] seg_1_sub;
    wire [7:0] seg_0_sub;
    wire [7:0] seg_sign_add;
    wire [7:0] seg_sign_sub;   // Result from the add_sub operation module
    
    wire [7:0] result_arith_left;
    wire [7:0] result_arith_right;
    wire [7:0] result_logic_left;
    wire [7:0] result_logic_right;  //Result from the shift module
    
    
    wire [7:0] and_result;     
    wire [7:0] or_result;
    wire [7:0] not_result_a;
    wire [7:0] not_result_b;
    wire [7:0] xor_result;   // Result from the bitwise operation module
    

    wire  logic_and_result;     
    wire  logic_or_result;
    wire  logic_not_result_a;
    wire  logic_not_result_b;
    wire  logic_xor_result;   // Result from the logical operation module

    debounce u1_debounce (
        .clk(clk),
        .reset(reset),
        .debounced_btn(debounced_btn),
        .btn_in(raw_confirm),
        .confirm_stable(confirm_stable)
    );

    signed_add_sub u1_signed_add_sub (
        .a(a),       // Connect input_a to the module's input 'a'
        .b(b),       // Connect input_b to the module's input 'b'
        .seg_2_add(seg_2_add),  
        .seg_1_add(seg_1_add),
        .seg_0_add(seg_0_add),
        .seg_2_sub(seg_2_sub),  
        .seg_1_sub(seg_1_sub),
        .seg_0_sub(seg_0_sub),
        .seg_sign_add(seg_sign_add),
        .seg_sign_sub(seg_sign_sub) // Connect the module's output 'diff' to output_diff
    );
        
     base_conversion u1_base_conversion (
        .binary(a),       // Connect input_binary to the module's binary input
        .octal_0(octal_0),
        .octal_1(octal_1),
        .octal_2(octal_2),        // Connect the module's octal output to output_octal
        .decimal_0(decimal_0),
        .decimal_1(decimal_1),
        .decimal_2(decimal_2),    // Connect the module's decimal output to output_decimal
        .hex_0(hex_0),
        .hex_1(hex_1)             // Connect the module's hex output to output_hex
    );
            
     bitwise_operations u1_bitwise_operations (
        .a(a),                  // Connect input_a to the module's input a
        .b(b),                  // Connect input_b to the module's input b
        .and_result(and_result),      // Connect module's and_result to output_and
        .or_result(or_result),        // Connect module's or_result to output_or
        .not_result_a(not_result_a),  // Connect module's not_result_a to output_not_a
        .not_result_b(not_result_b),  // Connect module's not_result_b to output_not_b
        .xor_result(xor_result)       // Connect module's xor_result to output_xor
    );
                
     logical_operations u1_logical_operations (
        .a(a),                  // Connect input_a to the module's a input
        .b(b),                  // Connect input_b to the module's b input
        .logic_and_result(logic_and_result), // Connect the module's AND result to logic_and
        .logic_or_result(logic_or_result),   // Connect the module's OR result to logic_or
        .logic_not_result_a(logic_not_result_a), // Connect the module's NOT result of a to logic_not_a
        .logic_not_result_b(logic_not_result_b), // Connect the module's NOT result of b to logic_not_b
        .logic_xor_result(logic_xor_result)  // Connect the module's XOR result to logic_xor
    );
                    
    shift_operation u1_shift_operation (
        .A(a),                    // Connect input_a to the module's input A
        .B(b),                    // Connect input_b to the module's input B
        .result_arith_left(result_arith_left), // Connect module's arithmetic left shift result to arith_left
        .result_arith_right(result_arith_right), // Connect module's arithmetic right shift result to arith_right
        .result_logic_left(result_logic_left), // Connect module's logical left shift result to logic_left
        .result_logic_right(result_logic_right) // Connect module's logical right shift result to logic_right
    );


    // State transition logic (next state logic)
    always @(posedge clk or posedge reset ) begin
        if (reset || !en )
            current_state <= idle; // Reset to idle state
        else begin
          current_state <= next_state;
        end
    end


    // Next state logic based on the current state and inputs
    always @(*) begin
        if (reset || !en) begin
          next_state =idle;

        end
        case (current_state)
            idle: begin
                if (confirm_stable) 
                    next_state = wait_mode_1; 
                else 
                    next_state = idle;
            end

            wait_mode_1: begin
                if (confirm_stable ) begin 
                    next_state = wait_mode_2;
                end
                else 
                    next_state = wait_mode_1;
            end

            wait_mode_2: begin
                if (confirm_stable) begin 
                    next_state = wait_a;
                end
                else 
                    next_state = wait_mode_2;
            end

            wait_a: begin
                if (confirm_stable) begin 
                    if ((mode_1 == 8'b0) || (((mode_1 == 8'b011)||(mode_1 == 8'b100))&&(mode_2 == 8'b10))) begin 
                        next_state = calculate; 
                    end
                    else begin
                        next_state = wait_b; 
                    end
                end
                else 
                    next_state = wait_a;
            end

            wait_b: begin
                if (confirm_stable) begin
                    next_state = calculate; 
                end
                else 
                    next_state = wait_b;
            end

            calculate: begin
                if (confirm_stable) begin
                    next_state = idle; 
                end
                else
                    next_state = calculate;
            end 

            default: next_state = current_state; 
        endcase
    end

    always @(posedge clk) begin
        if (reset || !en ) begin
          led <=8'b 0000_0000;
        display1 <= 8'b0000_0000;
        display2 <= 8'b0000_0000;
        display3 <= 8'b0000_0000;
        display4 <= 8'b0000_0000;
        display5 <= 8'b0000_0000;
        end
        
        if (pre_state != current_state) begin 
            pre_state <= current_state;
            case (current_state)
                idle:begin
                      led <=8'b 0000_0000;
                      led_2<=8'b0000_0001;
                      display1 <= 8'b0000_0000;
                      display2 <= 8'b0000_0000;
                      display3 <= 8'b0000_0000;
                      display4 <= 8'b0000_0000;
                      display5 <= 8'b0000_0000;
                end
                wait_mode_1: begin
                    led_2<=8'b0000_0010;
                      mode_1 <= input_data;
                      led <= input_data;
                      display5 <= 8'b0000_0001;
                    
                end

                wait_mode_2: begin
                    led_2<=8'b0000_0100;
                      mode_2 <= input_data;
                      led <= input_data;
                      display5 <= 8'b0000_0010;
                    
                end

                wait_a: begin
                    led_2<=8'b0000_1000;
                      a <= input_data;
                      led <= input_data;
                      display5 <= 8'b0000_1010;
                    
                end

                wait_b: begin
                    led_2<=8'b0001_0000;
                      b <= input_data;
                      led <= input_data;
                      display5 <= 8'b0000_1011;
                end

                calculate: begin
                    led_2<=8'b0010_0000;
                    display5 <= 8'b0;
                    case (mode_1) 
                        8'b00000000: begin   //base conversion
                            case (mode_2)
                                8'b00: begin
                                  display1 <= octal_0;
                                  display2 <= octal_1;
                                  display3 <= octal_2;
                                  display4 <= 8'b0;
                                  display5 <= 8'b0;
                                end    
                                8'b01: begin
                                  display1 <= decimal_0;
                                  display2 <= decimal_1;
                                  display3 <=decimal_2;
                                  display4 <= 8'b0;
                                  display5 <= 8'b0;
                                end
                                8'b10: begin
                                  display1 <= hex_0;
                                  display2 <= hex_1;
                                  display3 <= 8'b0;
                                  display4 <= 8'b0;
                                  display5 <= 8'b0;
                                end
                                default: display1 <= 8'b0;
                            endcase
                        end
                        8'b00000001: begin  // add and sub
                            case (mode_2)
                                8'b00: begin
                                  display3 <= seg_2_add;
                                  display2 <= seg_1_add;
                                  display1 <= seg_0_add;
                                  display4 <= seg_sign_add;
                                end
                                8'b01: begin
                                  display3 <= seg_2_sub;
                                  display2 <= seg_1_sub;
                                  display1 <= seg_0_sub;
                                  display4 <= seg_sign_sub;
                                end
                                default: display1 <= 0;
                            endcase
                        end
                        8'b00000010: begin  // shift operation
                            case (mode_2)
                                8'b00: led <= result_arith_left;   
                                8'b01: led <= result_arith_right;
                                8'b10: led <= result_logic_left;   
                                8'b11: led <= result_logic_right;   
                                default: led <= 8'b0;
                            endcase
                        end
                        8'b00000011: begin  // bitwise operation
                            case (mode_2)
                                8'b00: led <= and_result;   
                                8'b01: led <= or_result;
                                8'b10: led <= not_result_a;   
                                8'b11: led <= xor_result;   
                                default: led <= 8'b0;
                            endcase
                        end
                        8'b00000100: begin  // bitwise operation
                            case (mode_2)
                                8'b00: led <= {{7{1'b0}},logic_and_result};   
                                8'b01: led <= {{7{1'b0}},logic_or_result};
                                8'b10: led <= {{7{1'b0}},logic_not_result_a};
                                8'b11: led <= {{7{1'b0}},logic_xor_result};   
                                default: led <= 8'b0;
                            endcase
                        end
                        default: led <= 8'b0;
                    endcase
                end

                default: begin
                    a <= a;
                    b <= b;
                end
            endcase
        end
    end
endmodule