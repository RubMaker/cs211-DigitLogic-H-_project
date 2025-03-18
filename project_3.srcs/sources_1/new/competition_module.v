`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2024 08:45:18 PM
// Design Name: 
// Module Name: Competition_Mode
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
module competition_module(
    input clk,                      // 
    input reset,                    //
    input [7:0] user_input,        // 
    input input_complete,                
    input input_quit,                   
    input en,                          
    output reg [7:0] display1,  
    output reg [7:0] display2,  
    output reg [7:0] display3,  
    output reg [7:0] display4,  
    output reg [7:0] display5,  
    output reg [7:0] display6,  
    output reg [7:0] display7,  
    output reg [7:0] display8,  
    output reg [7:0] led1,         
    output reg [7:0] led2      

);

// state defination
localparam Idle = 19'b00000000000000000000; 
// input  questions states
localparam Admin_input_problem_number = 19'b00000000000000000001;  
localparam Admin_input_problem_number_A = 19'b00000000000000000010; 
localparam Admin_input_problem_number_B = 19'b00000000000000000100;
// input student state 
localparam Admin_input_student_number = 19'b00000000000000001000; 
// compitition state
localparam Student_compitition = 19'b00000000000000010000; 
localparam Student_compitition_show = 19'b00000000000000100000; 
localparam Student_compitition_answer_check = 19'b00000000000010000000; 
// result show state
localparam Result_show_output = 19'b00000000000100000000; 
localparam Result_show_update = 19'b00000000001000000000; 
// review state
localparam Review = 19'b00000000010000000000; 
//review time
localparam Review_time_phase1 = 19'b00000000100000000000; 
localparam Review_time_phase2 = 19'b00000001000000000000; 
localparam Review_time_phase3 = 19'b00000010000000000000; 
//review answer of every question
localparam Review_machine_answer_phase1 = 19'b00000100000000000000; 
localparam Review_machine_answer_phase2 = 19'b00001000000000000000; 
//review own input of every question
localparam Review_input_answer_phase1 = 19'b00010000000000000000; 
localparam Review_input_answer_phase2 = 19'b00100000000000000000; 
localparam Review_input_answer_phase3 = 19'b01000000000000000000; 

// operation state
localparam arithmetic = 8'b00000001,
           move_operation = 8'b00000010,
           bit_operation = 8'b00000100,
           logic_operation = 8'b00001000;
// arithmetic state
localparam add = 8'b00000001,
           sub = 8'b00000010;
// move state
localparam left_arithmetic = 8'b00000001,
           right_arithmetic = 8'b00000010,
           left_logic = 8'b00000100,
           right_logic = 8'b00001000;
// bit state
localparam And = 8'b00000001,
           Or = 8'b00000010,
           Not = 8'b00000100,
           Xor = 8'b00001000;
// logic state
localparam logic_and = 8'b00000001,
           logic_or = 8'b00000010,
           logic_not = 8'b00000100,
           logic_xor = 8'b00001000; 
localparam digit_an = 8'd17,
            digit_minue = 8'd16;
localparam check_time = 8'b00000001,
            check_answer = 8'b00000010,
            check_input = 8'b00000100;

// used to clear register
integer i,j,k;
reg [7:0] count_type = 8'd0;// type from 1 to 14
reg [7:0] count_type_tmp = 8'd0;
reg [7:0] count_number = 8'd0;
reg [7:0] count_number_tmp = 8'd0;
reg flag_problem_input_complete = 1'b0;
reg flag_subproblem_input_complete = 1'b0;
reg flag_competing = 1'b0;
reg flag_result_ok = 1'b0;
reg [18:0] state = 19'd0, next_state = 19'd0;
reg [7:0] student_number = 8'd4;
reg [3:0] student_id = 2'd0;
reg [3:0] student_id_tmp = 2'd0;
reg [7:0] winner = 8'b00000000;
reg [11:0] winner_time = 12'd0;
reg [7:0] winner_true = 8'b00000000;
reg [7:0] number_total_questions = 8'd0;
reg [7:0] number_total_questions_tmp = 8'd0;
// reg [7:0] current_question= 8'd0;
// reg [7:0] current_question_tmp= 8'd0;
reg [3:0] current_player=0;
reg [4:0] Timer;
reg [7:0] current_number = 8'b00000000;
reg [7:0] current_number_tmp = 8'b00000000;
reg flag_whether_first_compitition = 1'b0;

//regiter for recording data of module
(*ram_style = "block"*) reg [3:0] number_questions[14:0];
(*ram_style = "block"*) reg [4:0] time_question[141:0][4:0];
(*ram_style = "block"*) reg [11:0] total_time[4:0];
(*ram_style = "block"*) reg [11:0] total_time_tmp[4:0];
(*ram_style = "block"*) reg [7:0] total_true[4:0];
(*ram_style = "block"*) reg [7:0] total_true_tmp[4:0];
(*ram_style = "block"*) reg whether_input_answer[141:0][4:0];
(*ram_style = "block"*) reg [7:0] player_answer[141:0][4:0];
(*ram_style = "block"*) reg [7:0] machine_answer[141:0];
(*ram_style = "block"*) reg [7:0] inputA[141:0];
(*ram_style = "block"*) reg [7:0] inputB[141:0];
(*ram_style = "block"*) reg question_true[141:0][4:0];
(*ram_style = "block"*) reg [5:0] number2type[141:0];
(*ram_style = "block"*) reg [7:0] number2count[141:0];


reg [7:0] problem_typeA,problem_typeB,inputa,inputb;
wire [7:0] Res;
reg [7:0] check_id;
reg [7:0] check_number = 8'b00000000;
reg flag_check_id = 1'b0;
reg flag_check_over = 1'b0;
reg reset_n = 1'b1;
wire en_led;
wire [4:0] timer ;
reg flag_review_time_phase3 = 1'b0;
reg flag_result_show_output = 1'b0;
reg flag_next_question = 1'b0;

// get the result of every question
calc_module_45 get_number(
    .typea(problem_typeA),
    .typeb(problem_typeB),
    .a(inputa),
    .b(inputb),
    .result(Res)
);

// get the time of every 1s
timer_module get_time(
    .clk(clk),
    .reset_n(reset_n),
    .timer(timer),
    .en_led(en_led)
);

//change the state of the module
always @(posedge clk or posedge reset) begin
    if (reset|| !en) begin
        state <= Idle;
    end else begin
        state <= next_state;
    end
end

// state transition
always @(*) begin
    // The state machine's behavior is defined within a case statement that switches based on the current state
    case (state)
        Idle: begin
            // If the input is complete and in the center state, switch based on user input
            if (input_complete) begin //the center state 
                case (user_input)
                    8'b00000001: begin
                        next_state = Admin_input_problem_number; // Transition to Admin input problem number state
                    end
                    8'b00000010: begin
                        next_state = Admin_input_student_number; // Transition to Admin input student number state
                    end
                    8'b00000100: begin
                        next_state = Student_compitition; // Transition to Student competition state
                    end
                    8'b00001000: begin
                        next_state = Result_show_output; // Transition to Result show output state
                    end
                    8'b00010000: begin
                        next_state = Review; // Transition to Review state
                    end
                    default: next_state = Idle; // Stay in Idle state if input does not match any case
                endcase
            end else begin
                next_state = Idle; // Stay in Idle state if input is not complete
            end
        end
        // The following states handle transitions based on various conditions and inputs
        Admin_input_problem_number: begin
            next_state = input_complete ? Admin_input_problem_number_A : Admin_input_problem_number; // Transition based on input completion
        end
        Admin_input_problem_number_A: begin
            // Transition logic based on flags and input completion
            if (flag_subproblem_input_complete) begin
                next_state = Admin_input_problem_number;
            end else if (flag_problem_input_complete)begin
                next_state = Idle;
            end else begin 
                next_state = input_complete ? Admin_input_problem_number_B : Admin_input_problem_number_A;
            end
        end
        Admin_input_problem_number_B: begin
            // Transition logic based on input completion and flags
            if (input_complete)begin
                if (flag_problem_input_complete) begin
                    next_state = Idle;
                end else if(flag_subproblem_input_complete) begin
                    next_state = Admin_input_problem_number;
                end else begin
                    next_state = Admin_input_problem_number_A;
                end
            end else begin
                next_state = Admin_input_problem_number_B;
            end
        end
        Admin_input_student_number: begin
            next_state = input_complete ? Idle: Admin_input_student_number; // Transition based on input completion
        end
        Student_compitition : begin
            next_state = input_complete ? Student_compitition_show : Student_compitition; // Transition based on input completion
        end 
        Student_compitition_show: begin
            // Transition based on timer and input completion
            if ((!(timer ^ 8'd26)) || input_complete) begin
                next_state = Student_compitition_answer_check;
            end else begin 
                next_state = Student_compitition_show;
            end
        end
        Student_compitition_answer_check: begin
            // Transition logic based on input completion and competing flag
            if (input_complete) begin 
                if (flag_competing) begin
                    next_state = Idle;
                end else begin
                    next_state = Student_compitition;
                end
            end else begin
                next_state = Student_compitition_answer_check;
            end
        end
        Result_show_output: begin
            // Transition based on result show output flag
            if (flag_result_show_output) begin
                next_state = Result_show_update;
            end else begin
                next_state = Result_show_output;
            end
        end
        Result_show_update: begin
            // Transition logic based on input completion and result OK flag
            if (input_complete) begin
                if (flag_result_ok) begin
                    next_state = Idle;
                end else 
                    next_state = Result_show_output;
            end else begin
                next_state = Result_show_update;
            end
        end
        Review: begin
            // Transition logic based on quit input and input completion
            if (input_quit) begin
                next_state = Idle;
            end else  if (input_complete) begin
                case (user_input)
                    check_time: begin
                        next_state = Review_time_phase1;
                    end
                    check_answer: begin
                        next_state = Review_machine_answer_phase1;
                    end
                    check_input: begin
                        next_state = Review_input_answer_phase1;
                    end
                    default: next_state = next_state;
                endcase
            end else begin
                next_state = Review;
            end
        end
        Review_time_phase1: begin
            next_state = (input_complete) ? Review_time_phase2 : Review_time_phase1;
        end
        // Review_time_phase2: begin
        //     next_state = (input_complete) ? Review_time_phase3 : Review_time_phase2;
        // end
        Review_time_phase2: begin
            next_state = (input_complete) ? ((flag_check_over)? Review : Review_time_phase3) : Review_time_phase2;
        end
        Review_time_phase3: begin
            next_state = (flag_review_time_phase3) ? Review_time_phase2 : Review_time_phase3;
        end
        Review_machine_answer_phase1: begin
            next_state = (input_complete) ? Review_machine_answer_phase2 : Review_machine_answer_phase1;
        end
        Review_machine_answer_phase2: begin
            next_state = (input_complete) ? Review : Review_machine_answer_phase2;
        end
        // Review_machine_answer_phase3: begin
        //     next_state = (input_complete) ? Review : Review_machine_answer_phase3;
        // end
        Review_input_answer_phase1: begin
            next_state = (input_complete) ? Review_input_answer_phase2 : Review_input_answer_phase1;
        end
        Review_input_answer_phase2: begin
            next_state = (input_complete) ? Review_input_answer_phase3 : Review_input_answer_phase2;
        end
        Review_input_answer_phase3: begin
            next_state = (input_complete) ? Review : Review_input_answer_phase3;
        end
        default: next_state = Idle;

    endcase
end

//state machine
always @(posedge clk) begin 
    if (!en || reset) begin//reset and clear the register
        count_type <= 8'd0;
        count_number <= 8'd0;
        count_type_tmp <= 8'd0;
        count_number_tmp <= 8'd0;
        flag_problem_input_complete <= 1'b0;
        flag_subproblem_input_complete <= 1'b0;
        flag_competing <= 1'b0;
        flag_result_ok <= 1'b0;
//        state <= Idle;
        student_id <= 2'd0;
        student_id_tmp <= 2'd0;
        winner <= 8'b00000000;
        number_total_questions <= 8'd0;
        number_total_questions_tmp <= 8'd0;
        // current_question <= 8'd0;
        // current_question_tmp <= 8'd0;
        current_player <= 3'd0;
        Timer <= 5'd0;
        current_number <= 8'b00000000;
        current_number_tmp <= 8'b00000000;
        problem_typeA <= 8'b00000000;
        problem_typeB <= 8'b00000000;
        inputa <= 8'b00000000;
        inputb <= 8'b00000000;
        check_id <= 8'b00000000;
        check_number <= 8'b00000000;
        flag_check_id <= 1'b0;
        flag_check_over <= 1'b0;
        reset_n <= 1'b1;
        flag_review_time_phase3 <= 1'b0;
        flag_result_show_output <= 1'b0;
        flag_next_question <= 1'b0;
        flag_whether_first_compitition <= 0;
        for (i = 0; i <= 141; i = i + 1) begin
                for (k = 0; k <= 4; k = k + 1) begin
                    time_question[i][k] <= 0;
                    whether_input_answer[i][k] <= 0;
                    player_answer[i][k] <= 0;
                    question_true[i][k] <= 0;
                end
            // end
        end
        for (i=0; i<=14; i = i + 1) begin
            number_questions[i] <= 0;
        end
        for (i = 0; i <= 4; i = i + 1) begin
            total_time[i] <= 0;
            total_time_tmp[i] <= 0;
            total_true[i] <= 0;
            total_true_tmp[i] <= 0;
        end
        // for (i = 0; i <= 10; i = i + 1) begin
        //     for (j = 0; j <= 14; j = j + 1) begin
        //         // machine_answer[i][j] <= 0;
        //         inputA[i][j] <= 0;
        //         inputB[i][j] <= 0;
        //     end
        // end
        for (i = 0; i <= 141; i = i + 1) begin
            number2type[i] <= 0;
            number2count[i] <= 0;
            machine_answer[i] <= 0;
            inputA[i] <= 0;
            inputB[i] <= 0;
        end
    end else begin 
        case (state)
            Idle: begin// Idle state  reset registers and wait for into next state
                reset_n <= 1'b1;
                count_number_tmp <= 8'd0;
                count_type_tmp <= 8'd0;
                flag_competing <= 1'b0;
                flag_problem_input_complete <= 1'b0;
                current_number_tmp <= 8'b00000000;
                student_id_tmp <= 2'd0;
                winner_time <= total_time[0];
                winner_true <= total_true[0];
                winner <= 8'b00000000;
                flag_result_ok <= 1'b0;
                flag_result_show_output <= 1'b0;
                flag_next_question <= 1'b0;
                number_total_questions_tmp <= 8'd0;
                total_time_tmp[0] <= 12'd0;
                total_time_tmp[1] <= 12'd0;
                total_time_tmp[2] <= 12'd0;
                total_time_tmp[3] <= 12'd0;
                total_time_tmp[4] <= 12'd0;
                total_true_tmp[0] <= 8'd0;
                total_true_tmp[1] <= 8'd0;
                total_true_tmp[2] <= 8'd0;
                total_true_tmp[3] <= 8'd0;
                total_true_tmp[4] <= 8'd0;
                // current_question_tmp <= 8'd0;
                display1 <= digit_an;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
                led1 <= 8'd0;
                led2 <= 8'd0;
            end            
            Admin_input_problem_number: begin //input the number of questions of current type
                flag_subproblem_input_complete <= 1'b0;
                count_type <= count_type_tmp;
                number_questions[count_type_tmp] <= user_input;
                led1 <= count_type_tmp;
                led2 <= count_number_tmp;
                number_total_questions <= number_total_questions_tmp + user_input;
                display1 <= (count_type_tmp+1)/10;
                display2 <= (count_type_tmp+1)%10;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= user_input;
            end
            Admin_input_problem_number_A: begin //input the first number of current question
                                                //if current type of question is 0 the input next type's number
                if (number_questions[count_type] == 0) begin
                    if (count_type == 8'd13) begin
                        flag_problem_input_complete <= 1'b1;
                        display1 = 8'd4;
                        display2 = digit_an;
                        number_total_questions_tmp <= number_total_questions;
                    end else begin
                        count_number_tmp <= 8'd0;
                        current_number_tmp <= current_number;
                        count_type_tmp <= count_type + 1;
                        display1 <= 8'd5;
                        display2 <= count_type;
                        flag_subproblem_input_complete <= 1'b1;
                        number_total_questions_tmp <= number_total_questions;
                    end
                end else begin
                    // count_number_tmp <= count_number + 1;
                    number_total_questions_tmp <= number_total_questions;
                    count_number <= count_number_tmp;
                    inputA[current_number_tmp] <= user_input;
                    inputa <= user_input;
                    led1 <= user_input;
                    current_number <= current_number_tmp;
                    number2count[current_number_tmp] <= count_number_tmp;
                    number2type[current_number_tmp] <= count_type;
                    case (count_type + 1)  //get the type of current question to get the result of current question
                            8'd1: begin 
                                problem_typeA <= arithmetic;
                                problem_typeB <= add;
                            end
                            8'd2: begin
                                problem_typeA <= arithmetic;
                                problem_typeB =sub;
                            end
                            8'd3: begin
                                problem_typeA <= move_operation;
                                problem_typeB <= left_arithmetic;
                            end
                            8'd4: begin
                                problem_typeA <= move_operation;
                                problem_typeB <= right_arithmetic;
                            end
                            8'd5: begin
                                problem_typeA <= move_operation;
                                problem_typeB <= left_logic;
                            end
                            8'd6: begin
                                problem_typeA <= move_operation;
                                problem_typeB <= right_logic;
                            end
                            8'd7: begin
                                problem_typeA <= bit_operation;
                                problem_typeB <= And;
                            end
                            8'd8: begin 
                                problem_typeA <= bit_operation;
                                problem_typeB <= Or;
                            end
                            8'd9: begin
                                problem_typeA <= bit_operation;
                                problem_typeB <= Not;
                            end
                            8'd10: begin
                                problem_typeA <= bit_operation;
                                problem_typeB <= Xor;
                            end 
                            8'd11: begin
                                problem_typeA <= logic_operation;
                                problem_typeB <= logic_and;
                            end
                            8'd12: begin
                                problem_typeA <= logic_operation;
                                problem_typeB <= logic_or;
                            end
                            8'd13: begin
                                problem_typeA <= logic_operation;
                                problem_typeB <= logic_not;
                            end
                            8'd14: begin
                                problem_typeA <= logic_operation;
                                problem_typeB <= logic_xor;
                            end 
                            default: problem_typeA <= 8'b00000000;
                        endcase
                        display1 <= (count_type+1)/10;
                        display2 <= (count_type+1)%10;
                        display3 <= (count_number_tmp+1)/10;
                        display4 <= (count_number_tmp+1)%10;
                        display5 <= (current_number_tmp+1)/10;
                        display6 <= (current_number_tmp+1)%10;
                        display7 <= digit_an;
                        display8 <= digit_an;
                end
            end
            Admin_input_problem_number_B: begin //input the second number of current question
                inputB[current_number] <= user_input;
                inputb <= user_input;
                led1 <= user_input;
                machine_answer[current_number] <= Res;
                if (count_number < number_questions[count_type]-1) begin //check go to next question or next type
                    count_number_tmp <= count_number + 1;
                    current_number_tmp <= current_number + 1;
                    // display1 <= 8'd9;
                    // display2 <= number_questions[count_type];
                    // display3 <= count_type_tmp;
                end else begin
                    if (count_type == 8'd13) begin
                        flag_problem_input_complete <= 1'b1;// all questions input complete
                        // display1 = 8'd4;
                        // display2 = digit_an;
                    end else begin
                        count_number_tmp <= 8'd0;
                        current_number_tmp <= current_number + 1;
                        count_type_tmp <= count_type + 1;
                        // display1 <= 8'd5;
                        // display2 <= count_type;
                        flag_subproblem_input_complete <= 1'b1;// go to next type
                    end
                end

                display1 <= (count_type+1)%10;
                display2 <= (count_type+1)/10;
                display3 <= (count_number+1)/10;
                display4 <= (count_number+1)%10;
                display5 <= (current_number+1)/10;
                display6 <= (current_number+1)%10;
                display7 <= digit_an;
                display8 <= digit_an;
            end
            Admin_input_student_number: begin //input the number of students
                student_number <= user_input;
                display1 <= digit_an;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= user_input;
                led1 <= user_input;
            end
            Student_compitition: begin //start the competition for every student and every questions
                student_id <= student_id_tmp;
                current_number <= current_number_tmp;
                total_true_tmp[student_id_tmp] <= total_true[student_id_tmp];
                count_number <= count_number_tmp;
                count_type <= count_type_tmp;
                // current_question <= current_question_tmp;
                Timer <= 8'd0;
                reset_n <= 1'b1;
                display1 <= student_id+1;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
            end
            Student_compitition_show: begin //show the question and the answer of every student
                reset_n <= 1'b0;
                if (timer <= 5'd6) begin 
                    if (en_led) begin 
                        display1 <= digit_an;
                        display2 <= digit_an;
                        display3 <= digit_an;
                        display4 <= digit_an;
                        display5 <= digit_an;
                        display6 <= digit_an;
                        display7 <= digit_an;
                        display8 <= digit_an;
                        led1 <= inputA[current_number]; // the fist LED show the first number of the question
                        led2 <= inputB[current_number]; // the second LED show the second number of the question
                    end else begin
                        display1 <= (current_number+1)/100;
                        display2 <= (current_number+1)%100/10;
                        display3 <= (current_number+1)%10;
                        display4 <= digit_an;
                        display5 <= number_total_questions/100; 
                        display6 <= number_total_questions%100/10;
                        display7 <= number_total_questions%10;
                        display8 <= digit_an;
                        led1 <= inputA[current_number]; // the fist LED show the first number of the question
                        led2 <= inputB[current_number]; // the second LED show the second number of the question
                    end
                end else begin //the time to input the own answer of the question
                    display1 <= (current_number+1)/100;
                    display2 <= (current_number+1)%100/10;
                    display3 <= (current_number+1)%10;
                    display4 <= number_total_questions/100; 
                    display5 <= number_total_questions%100/10;
                    display6 <= number_total_questions%10;
                    display7 <= (timer - 5'd6)/10;// the time to anware the question from 0 to 20
                    display8 <= (timer - 5'd6)%10;
                    player_answer[current_number][student_id] <= user_input;
                    led1 <= inputA[current_number]; // the fist LED show the first number of the question
                    led2 <= inputB[current_number]; // the second LED show the second number of the question
                    total_time_tmp[student_id] <= total_time[student_id] + timer - 5'd6;
                    Timer <= timer - 5'd6;
                end
            end
            Student_compitition_answer_check:begin
                reset_n <= 1'b1;
                display1 <= student_id+1;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an; 
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= (Timer)/10;
                display8 <= (Timer)%10;
                
                total_time[student_id] <= total_time_tmp[student_id];
                time_question[current_number][student_id] <= Timer;
                if (!(Timer^5'd20))  begin //check the time of the answer of the question 
                                            //no input
                    whether_input_answer[current_number][student_id] <= 1'b0;
                    question_true[current_number][student_id] <= 1'b0;
                    // display4 <= 8'd1;
                end else begin
                    whether_input_answer[current_number][student_id] <= 1'b1;
                    if (!(player_answer[current_number][student_id] ^ machine_answer[current_number])) begin //the input is right
                        question_true[current_number][student_id] <= 1'b1;
                        total_true[student_id] <= total_true_tmp[student_id] + 1;
                        // display4 <= 8'd2;
                    end else begin// the input is wrong
                        // display4 <= 8'd3;
                        question_true[current_number][student_id] <= 1'b0;
                    end
                end
                //check the next question or the next student
                if (current_number < number_total_questions-1) begin    
                    // count_number_tmp <= count_number + 1;
                    // current_question_tmp <= current_question + 1;
                    current_number_tmp <= current_number + 1;
                    count_number_tmp <= number2count[current_number+1];
                    count_type_tmp <= number2type[current_number+1];
                    // display2 <= 8'd1;
                end else begin
                    if (student_id < student_number -1) begin
                        current_number_tmp <= 8'd0;
                        count_number_tmp <=number2count[0];
                        count_type_tmp <= number2type[0];
                        student_id_tmp <= student_id + 1;
                        // display2 <= 8'd3;
                    end else begin
                        flag_competing <= 1'b1;
                        // display2 <= 8'd4;
                    end
                end
            end
            Result_show_output: begin
                student_id <= student_id_tmp;
                if (student_id_tmp < student_number) begin //show the result of every student
                    display1 <= student_id_tmp + 1;
                    display2 <= total_true[student_id_tmp]/100;
                    display3 <= total_true[student_id_tmp]%100/10;
                    display4 <= total_true[student_id_tmp]%10;
                    display5 <= total_time[student_id_tmp]/(1000);
                    display6 <= total_time[student_id_tmp]%1000/100;
                    display7 <= total_time[student_id_tmp]%100/10;
                    display8 <= total_time[student_id_tmp]%10;
                    if (total_true[student_id_tmp] > winner_true) begin //get the winner when the true number is more than the last winner
                        winner <= student_id_tmp;
                        winner_time <= total_time[student_id_tmp];
                        winner_true <= total_true[student_id_tmp];
                    end else if (!(total_true[student_id_tmp] ^ winner_true) && total_time[student_id_tmp] < winner_time) begin 
                        //get the winner when the true number is equal to the last winner and the time is less than the last winner
                        winner <= student_id_tmp;
                        winner_time <= total_time[student_id_tmp];
                        winner_true <= total_true[student_id_tmp];
                    end
                end else begin //show the winner
                    display1 <= winner + 1;
                    display2 <= digit_an;
                    display3 <= digit_an;
                    display4 <= digit_an;
                    display5 <= digit_an;
                    display6 <= digit_an;
                    display7 <= digit_an;
                    display8 <= digit_an;

                    flag_result_ok <= 1'b1;
                end
                flag_result_show_output <= 1'b1;
            end
            Result_show_update: begin//update the state to the next student
                flag_result_show_output <= 1'b0;
                student_id_tmp <= student_id + 1;
            end
            Review: begin//the start of the review
                flag_check_over <= 1'b0;
                flag_result_show_output <= 1'b0;
                display1 <= 8'd4;
                display2 <= 8'd4;
                display3 <= 8'd4;
                display4 <= 8'd4;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
            end
            Review_time_phase1: begin// input the number of the student to review 
                current_player <= user_input;
                led1 <= user_input;
                count_number_tmp <= 4'd0;
                count_type_tmp <= 8'd0;
                current_number_tmp <= 8'd0;
                display1 <= 8'd1;
                display2 <= 8'd1;
                display3 <= 8'd1;
                display4 <= 8'd1;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
            end
            Review_time_phase2: begin
                flag_review_time_phase3 <= 1'b0;
                count_number <= count_number_tmp;
                count_type <= count_type_tmp;
                current_number <= current_number_tmp;
                if(current_number_tmp < number_total_questions) begin//show the time of every question
                    display1 <= (current_number_tmp+1)/10;
                    display2 <= (current_number_tmp+1)%10;
                    display3 <= digit_an;
                    display4 <= digit_an;
                    display5 <= time_question[current_number_tmp][current_player-1]/(1000);
                    display6 <= time_question[current_number_tmp][current_player-1]/100%10;
                    display7 <= time_question[current_number_tmp][current_player-1]%100/10;
                    display8 <= time_question[current_number_tmp][current_player-1]%10;
                end else begin
                    if(current_number_tmp >= number_total_questions) begin
                        //show the total time of the student
                        display1 <= current_player;
                        display2 <= digit_an;
                        display3 <= digit_an;
                        display4 <= digit_an;
                        display5 <= total_time[current_player-1]/(1000);
                        display6 <= total_time[current_player-1]%1000/100;
                        display7 <= total_time[current_player-1]%100/10;
                        display8 <= total_time[current_player-1]%10;
                        flag_check_over <= 1'b1;
                    end
                end
            end
            //update the state to the next question 
            Review_time_phase3: begin
                current_number_tmp <= current_number + 1;
                count_number_tmp <= number2count[current_number + 1];
                count_type_tmp <= number2type[current_number + 1];
                //end //else if(!(count_type ^ 8'd13)) begin
                //     count_number_tmp <= count_number + 1;
                // end else begin
                //     count_type_tmp <= count_type + 1;
                //     count_number_tmp <= 4'd0;
                // end
                flag_review_time_phase3 <= 1'b1;
            end
            //review the real answer of the question
            Review_machine_answer_phase1: begin
                check_number <= user_input-1;
                led1 <= user_input;
                display1 <= 8'd2;
                display2 <= 8'd2;
                display3 <= 8'd2;
                display4 <= 8'd2;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
            end
            Review_machine_answer_phase2: begin
                display1 <= (number2type[check_number]+1)/10;
                display2 <= (number2type[check_number]+1)%10;
                display3 <= digit_an;
                display4 <= digit_an;
                //special case for the minue number in type 1 and 2
                if ((machine_answer[check_number] >= 8'b1000_0000) && ((!(number2type[check_number] ^ 6'd0) || !(number2type[check_number] ^ 6'd1)))) begin
                    display5 <= digit_minue;
                    display6 <= (8'd255 - machine_answer[check_number] + 1)/100;
                    display7 <= (8'd255 - machine_answer[check_number] + 1)%100/10;
                    display8 <= (8'd255 - machine_answer[check_number] + 1)%10;
                end else begin //other type of question
                    display5 <= digit_an;
                    display6 <= machine_answer[check_number]/100;
                    display7 <= machine_answer[check_number]%100/10;
                    display8 <= machine_answer[check_number]%10;
                end
                led1 <= inputA[check_number];
                led2 <= inputB[check_number];
            end
            //input the student
            Review_input_answer_phase1: begin
                check_id <= user_input-1;
                led1 <= user_input;
                display1 <= 8'd3;
                display2 <= 8'd3;
                display3 <= 8'd3;
                display4 <= 8'd3;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
            end
            //input the question
            Review_input_answer_phase2: begin
                check_number <= user_input-1;
                led1 <= user_input;
                display1 <= 8'd3;
                display2 <= 8'd3;
                display3 <= 8'd1;
                display4 <= 8'd1;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= digit_an;
            end
            //show the answer of the question of this student
            Review_input_answer_phase3: begin
                led1 <= player_answer[check_number][check_id];
                led2 <= machine_answer[check_number];
                display1 <= digit_an;
                display2 <= digit_an;
                display3 <= digit_an;
                display4 <= digit_an;
                display5 <= digit_an;
                display6 <= digit_an;
                display7 <= digit_an;
                display8 <= (question_true[check_number][check_id])? 8'b00000001 : 8'b00000010;
                //check the answer of the question is right or wrong
            end
            default: begin
                display1 <= 8'd3;
                display2 <= 8'd2;
                display3 <= 8'd1;
                display4 <= 8'd0;
                display5 <= 8'd0;
                display6 <= 8'd0;
                display7 <= 8'd0;
                display8 <= 8'd8;
            end
        endcase
    end
end

endmodule
