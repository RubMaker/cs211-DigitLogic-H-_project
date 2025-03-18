`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 12:16:41 PM
// Design Name: 
// Module Name: learn_model
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

module learn_module(
    input clk,  // clock signal
    input reset,  // reset signal
    input [7:0] user_input,  // user input
    input input_complete,  // the button of complete
    input input_quit,  // the button of quit
    input en, // enable signal 
    output reg [7:0] led,
    output reg [7:0] display1,   
    output reg [7:0] display2,   
    output reg [7:0] display3,   
    output reg [7:0] display4,   
    output reg [7:0] display5,   
    output reg [7:0] display6,   
    output reg [7:0] display7,   
    output reg [7:0] display8   
);

// Define state parameters for the state machine
localparam IDLE = 3'b000, // Wait state, waiting for user input
           INPUT_TYPEA = 3'b001, // State for inputting the type of operation A
           INPUT_TYPEB = 3'b010, // State for inputting the type of operation B
           INPUT_OPERAND_A = 3'b011, // State for inputting operand A
           INPUT_OPERAND_B = 3'b100, // State for inputting operand B
           INPUT_RESULT = 3'b101, // State for inputting the result
           JUDGE = 3'b110, // State for judging the correctness of the result
           STATISTICS = 3'b111; // State for displaying statistics

// Define operation types for different categories
localparam arithmetic = 8'b00000001, // Arithmetic operations
           move_operation = 8'b00000010, // Bitwise move operations
           bit_operation = 8'b00000100, // Bitwise operations
           logic_operation = 8'b00001000; // Logical operations

// Define specific operations within each category
localparam add = 8'b00000001, // Addition operation
           sub = 8'b00000010, // Subtraction operation
           left_arithmetic = 8'b00000001, // Left arithmetic shift
           right_arithmetic = 8'b00000010, // Right arithmetic shift
           left_logic = 8'b00000100, // Left logical shift
           right_logic = 8'b00001000, // Right logical shift
           And = 8'b00000001, // Bitwise AND
           Or = 8'b00000010, // Bitwise OR
           Not = 8'b00000100, // Bitwise NOT
           Xor = 8'b00001000, // Bitwise XOR
           logic_and = 8'b00000001, // Logical AND
           logic_or = 8'b00000010, // Logical OR
           logic_not = 8'b00000100, // Logical NOT
           logic_xor = 8'b00001000; // Logical XOR

localparam digit_an = 8'd17, // ASCII code for 'A'
           digit_minue = 8'd16; // ASCII code for '-'

// Internal registers for state and temporary storage
reg [3:0] next_state, state;
reg [7:0] inputa, inputb, result_machine, result_human; // Registers for operands and results
reg [7:0] p1, p2, p3, p4, c1, c2, c3, c4; // Problem and correct count registers
reg [7:0] p1_tmp, p2_tmp, p3_tmp, p4_tmp; // Temporary registers for problem counts
reg [7:0] c1_tmp, c2_tmp, c3_tmp, c4_tmp; // Temporary registers for correct counts
reg [7:0] problem_typeA, problem_typeB; // Registers for storing the type of problem

// Wire for the result of the calculation module
wire [7:0] result;

// get the answer of the problem
calc_module_45 uut(
    .typea(problem_typeA),
    .typeb(problem_typeB),
    .a(inputa),
    .b(inputb),
    .result(result)
);

// state transition
always @(input_complete,input_quit) begin
    case (state)
        IDLE: next_state = (input_complete) ? INPUT_TYPEA : IDLE;
        INPUT_TYPEA: next_state = (input_complete) ? INPUT_TYPEB : INPUT_TYPEA;
        INPUT_TYPEB: next_state = (input_complete) ? INPUT_OPERAND_A : INPUT_TYPEB;
        INPUT_OPERAND_A: begin
            next_state = (input_complete) ? INPUT_OPERAND_B : INPUT_OPERAND_A;
        end
        INPUT_OPERAND_B: next_state = (input_complete) ? INPUT_RESULT : INPUT_OPERAND_B;
        INPUT_RESULT: next_state = (input_complete) ? JUDGE : INPUT_RESULT;
        JUDGE: next_state = (input_quit) ? STATISTICS : (input_complete) ? INPUT_TYPEA : JUDGE;
        STATISTICS: next_state = (input_quit) ? IDLE : STATISTICS;
        default: next_state = IDLE;
    endcase
end

// change state when clock signal is rising or reset signal is rising
always @(posedge clk or posedge reset) begin
    if ( reset || !en ) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// state machine
always @(posedge clk) begin
    if (!en || reset) begin 
//        state <= IDLE;
        inputa <= 8'b00000000;
        inputb <= 8'b00000000;
        result_human <= 8'b00000000;
        result_machine <= 8'b00000000;
        p1 <= 8'b00000000;
        c1 <= 8'b00000000;
        p2 <= 8'b00000000;
        c2 <= 8'b00000000;
        p3 <= 8'b00000000;
        c3 <= 8'b00000000;
        p4 <= 8'b00000000;
        c4 <= 8'b00000000;
        p1_tmp <= 8'b00000000;
        p2_tmp <= 8'b00000000;
        p3_tmp <= 8'b00000000;
        p4_tmp <= 8'b00000000;
        c1_tmp <= 8'b00000000;
        c2_tmp <= 8'b00000000;
        c3_tmp <= 8'b00000000;
        c4_tmp <= 8'b00000000;
        problem_typeA <= 8'b00000000;
        problem_typeB <= 8'b00000000;
    end else begin
        case (state) 
            IDLE: begin 
                p1 <= 8'b00000000;
                c1 <= 8'b00000000;
                p2 <= 8'b00000000;
                c2 <= 8'b00000000;
                p3 <= 8'b00000000;
                c3 <= 8'b00000000;
                p4 <= 8'b00000000;
                c4 <= 8'b00000000;    
                display1 <= digit_an;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
                led <= 8'b00000000;
                // flag_quit <= 1'b0;
            end
            INPUT_TYPEA: begin
                problem_typeA <= user_input;
                led <= user_input;
                display1 <= 8'b00000001;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
                p1_tmp <= p1;
                p2_tmp <= p2;
                p3_tmp <= p3;
                p4_tmp <= p4;
                c1_tmp <= c1;
                c2_tmp <= c2;
                c3_tmp <= c3;
                c4_tmp <= c4;
            end
            INPUT_TYPEB: begin 
                problem_typeB <= user_input;
                led <= user_input;
                display1 <= 8'b00000010;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
                case (problem_typeA)
                    arithmetic: begin
                        p1_tmp <= p1 + 8'd1;
                        // display3 <= 8'd1;
                    end   
                    move_operation: begin
                        p2_tmp <= p2 + 8'd1;
                    end
                    bit_operation: begin
                        p3_tmp <= p3 + 8'd1;
                    end
                    logic_operation: begin
                        p4_tmp <= p4 + 8'd1;
                    end
                    default begin
                        p1_tmp <= p1;
                        p2_tmp <= p2;
                        p3_tmp <= p3;
                        p4_tmp <= p4;
                    end 
                endcase
            end
            INPUT_OPERAND_A: begin
                inputa <= user_input;
                led <= user_input;
                display1 <= 8'b00000011;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
            end
            INPUT_OPERAND_B: begin 
                inputb <= user_input;
                led <= user_input;
                display1 <= 8'b00000100;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
            end
            INPUT_RESULT: begin
                result_human <= user_input;
                result_machine <= result;
                display1 <= 8'b00000101;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
                // display3 <= result_human/100;
                // display4 <= result_human%100/10;
                // display5 <= result_human%10;
                // display6 <= result_machine/100;
                // display7 <= result_machine%100/10;
                // display8 <= result_machine%10;
                if (!(user_input ^ result)) begin
                    case(problem_typeA)
                        arithmetic: begin
                            c1_tmp <= c1 + 8'd1;
                        end   
                        move_operation: begin
                            c2_tmp <= c2 + 8'd1;
                        end
                        bit_operation: begin
                            c3_tmp <= c3 + 8'd1;
                        end
                        logic_operation: begin
                            c4_tmp <= c4 + 8'd1;
                        end
                        default begin
                            c1_tmp <= c1;
                            c2_tmp <= c2;
                            c3_tmp <= c3;
                            c4_tmp <= c4;
                        end 
                    endcase
                end
            end
            JUDGE: begin 
                display1 <= 8'b00000110;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                p1 <= p1_tmp;
                p2 <= p2_tmp;
                p3 <= p3_tmp;
                p4 <= p4_tmp;
                c1 <= c1_tmp;
                c2 <= c2_tmp;
                c3 <= c3_tmp;
                c4 <= c4_tmp;
                // display2 <= p1;
                if (!(result_human ^ result_machine)) begin
                    display8 <= 8'b00000001;
                end else begin
                    display8 <= 8'b00000010;
                end
            end
            STATISTICS: begin
                display1 <= c1;
                display2 <= p1;
                display3 <= c2;
                display4 <= p2;
                display5 <= c3;
                display6 <= p3;
                display7 <= c4;
                display8 <= p4;
            end
            default: ;
        endcase
    end
end

endmodule
