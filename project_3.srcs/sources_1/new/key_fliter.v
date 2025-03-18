// // `timescale 1ns / 1ps
// // //////////////////////////////////////////////////////////////////////////////////
// // // Company: 
// // // Engineer: 
// // // 
// // // Create Date: 11/27/2024 08:45:18 PM
// // // Design Name: 
// // // Module Name: Competition_Mode
// // // Project Name: 
// // // Target Devices: 
// // // Tool Versions: 
// // // Description: 
// // // 
// // // Dependencies: 
// // // 
// // // Revision:
// // // Revision 0.01 - File Created
// // // Additional Comments:
// // // 
// // //////////////////////////////////////////////////////////////////////////////////
// // module competition_module(
// //     input clk,                      // 时钟信号
// //     input reset,                    // 复位信号
// //     input [7:0] user_input,        // 管理员输入
// //     input input_complete,                  // 学生确认答题
// //     input input_quit,                   // 学生提交答案
// //     // input admin_user,
// //     // input stu_number,
// //     // input start_competing,
// //     // output reg en ,                  // 使能信号
// //     output reg [7:0] display1,  // 显示输出
// //     output reg [7:0] display2,  // 显示输出
// //     output reg [7:0] display3,  // 显示输出
// //     output reg [7:0] display4,  // 显示输出
// //     output reg [7:0] display5,  // 显示输出
// //     output reg [7:0] display6,  // 显示输出
// //     output reg [7:0] display7,  // 显示输出
// //     output reg [7:0] display8,  // 显示输出
// //     output reg [7:0] led1,          // LED显示
// //     output reg [7:0] led2       // LED显示
// //     // output reg [30:0] state,
// //     // output reg [30:0] next_state,
// //     // output reg [30:0] pre_state,
// //     // output wire [7:0] Timer
// //     // number_flash = number_flash + 1;
// //             //     // en = en_led;
// //             //     display1 = current_question/100;
// //             //     display2 = current_question%100/10;
// //             //     display3 = current_question%10;
// //             //     display4 = digit_an;
// //             //     display5 = number_total_questions/100; 
// //             //     display6 = number_total_questions%100/10;
// //             //     display7 = number_total_questions%10;
// //             //     display8 = digit_an;er
// //     // output reg [5:0] count_type,
// //     // output reg [4:0] count_number,
// //     // output wire [3:0] Number_questions,
// //     // output reg flag_type,
// //     // output reg flag_problem_input_complete,
// //     // output reg flag_problem_input_complete_tmp
// //     // output wire [7:0] Machine_answer,
// //     // output reg [3:0] Count_number_machine,
// //     // output wire [7:0] Machine_answer_1,
// //     // output wire [7:0] Machine_answer_2,
// //     // output wire [7:0] Res
// //     // output reg flag_start_stu,
// //     // output reg [3:0] number_flash,
// //     // output wire en_led,
// //     // output reg [1:0] student_id,
// //     // output reg [4:0] timer,
// //     // output reg [7:0] winner,
// //     // output wire [7:0] true_player1,
// //     // output wire [7:0] true_player2,
// //     // output wire [7:0] input_answer1,
// //     // output wire [7:0] input_answer2
// //     // output reg []
// //     // output reg flag_check_over
// // );
// // // assign Timer = timer;
// // // assign time1 = time_question[count_number][count_type][1];
// // // assign input_answer1 = player_answer[count_number][count_type][1];
// // // assign input_answer2 = player_answer[count_number][count_type][2];
// // // assign true_player1 = total_true[1];
// // // assign true_player2 = total_true[2];
// // // assign  Number_questions = number_questions[count_type];
// // // assign Machine_answer = machine_answer[count_number][count_type];
// // // assign Machine_answer_1 = (!(|inputA[1][13])) ? 8'b00000001 : 8'b00000000;
// // // assign Machine_answer_2 = machine_answer[0][14];
// // // 竞赛状态定义
// // localparam Idle = 31'b00000000000000000000000000000000,
// //             Admin_input_problem = 31'b0000000000000000000000000000001,
// //             Admin_input_problem_number = 31'b0000000000000000000000000000010,
// //             Admin_input_problem_number_A = 31'b0000000000000000000000000000100,
// //             Admin_input_problem_number_B = 31'b0000000000000000000000000001000,
// //             Admin_input_student_number_phase1 = 31'b0000000000000000000000000010000,
// //             Admin_input_student_number_phase2 = 31'b0000000000000000000000000100000,
// //             Student_compitition = 31'b0000000000000000000000001000000,
// //             Student_compitition_show_light = 31'b0000000000000000000000010000000,
// //             // Student_compitition_show_an = 31'b0000000000000000000000010000000,
// //             // Student_compitition_show_light = 31'b0000000000000000000000100000000,
// //             Student_compitition_answer_input_wait = 31'b0000000000000000000001000000000,
// //             Student_compitition_answer_input_phase3 = 31'b0000000000000000000010000000000,
// //             Student_compitition_answer_check = 31'b0000000000000000000100000000000,
// //             Result_show_output = 31'b0000000000000000001000000000000,
// //             Result_show_update = 31'b0000000000000000010000000000000,
// //             Review = 31'b0000000000000000100000000000000,
// //             Review_time_phase1 = 31'b0000000000000001000000000000000,
// //             Review_time_phase2 = 31'b0000000000000010000000000000000,
// //             Review_time_phase3 = 31'b0000000000000100000000000000000,
// //             Review_time_phase4 = 31'b0000000000001000000000000000000,
// //             Review_machine_answer_phase1 = 31'b0000000000010000000000000000000,
// //             Review_machine_answer_phase2 = 31'b0000000000100000000000000000000,
// //             Review_machine_answer_phase3 = 31'b0000000001000000000000000000000,
// //             Review_input_answer_phase1 = 31'b0000000010000000000000000000000,
// //             Review_input_answer_phase2 = 31'b0000000100000000000000000000000,
// //             Review_input_answer_phase3 = 31'b0000001000000000000000000000000,
// //             Review_input_answer_phase4 = 31'b0000010000000000000000000000000,
// //             Student_compitition_answer_input_initial_timer = 31'b0000100000000000000000000000000,
// //             Student_compitition_show_light_initial_timer = 31'b0001000000000000000000000000000,
// //             Result_show_initial = 31'b0010000000000000000000000000000,
// //             Student_compitition_initial = 31'b0100000000000000000000000000000,
// //             Admin_input_problem_initial = 31'b1000000000000000000000000000000;
// // // Student_compitition_answer_input_phase2 = 31'b0000000000000000000000100000000000,
// // // Student_compitition_answer_input_phase_to_3 = 31'b0000010000000000000000000000000000,            


// // // 存储题目
// // reg [5:0] count_type = 8'd0;//总共14个
// // reg flag_type = 1'b0;
// // // reg en = 1'b1;
// // // reg flag_number1 = 1'b0;
// // // reg flag_number2 = 1'b0;
// // reg flag_problem_input_complete = 1'b0;
// // reg flag_problem_input_complete_tmp = 1'b0;
// // reg flag_subproblem_input_complete = 1'b0;
// // // reg flag_subproblem_input_uncomplete = 1'b0;
// // // reg flag_answer_input = 1'b0;
// // reg flag_student_number_input_complete = 1'b0;
// // reg flag_competing = 1'b0;
// // // reg flag_show_winner = 1'b0;
// // // reg flag_get_result = 1'b0;
// // // reg flag_start_flash = 1'b0;
// // reg flag_result_ok = 1'b0;
// // reg [3:0] count_number = 4'd0;
// // reg [31:0] state, next_state;
// // reg [31:0] pre_state = 31'd0;
// // reg [3:0] number_questions[15:0];
// // // reg [4:0] question_type[7:0];
// // reg [7:0] student_number = 8'd4;
// // reg [3:0] student_id = 2'd0;
// // reg [7:0] winner = 8'b00000000;
// // reg [11:0] winner_time = 12'd0;
// // reg [7:0] winner_true = 8'b00000000;
// // reg [7:0] number_total_questions=0;
// // reg [7:0] current_question=0;
// // reg [3:0] current_player=0;
// // // reg [3:0] number_flash=0;

// // (*ram_style = "block"*) reg [4:0] time_question[10:0][14:0][4:0];
// // (*ram_style = "block"*) reg [11:0] total_time[4:0];
// // (*ram_style = "block"*) reg [7:0] total_true[4:0];
// // (*ram_style = "block"*) reg whether_input_answer[10:0][14:0][4:0];
// // (*ram_style = "block"*) reg flag_whether_first_compitition = 1'b0;
// // (*ram_style = "block"*) reg [7:0] player_answer[10:0][14:0][4:0];
// // (*ram_style = "block"*) reg [7:0] machine_answer[10:0][14:0];
// // (*ram_style = "block"*) reg [7:0] inputA[10:0][14:0];
// // (*ram_style = "block"*) reg [7:0] inputB[10:0][14:0];
// // (*ram_style = "block"*) reg question_true[10:0][14:0][4:0];
// // (*ram_style = "block"*) reg [7:0] current_number = 8'b00000000;
// // (*ram_style = "block"*) reg [5:0] number2type[141:0];
// // (*ram_style = "block"*) reg [7:0] number2count[141:0];

// // // reg [4:0] time_question[14:0][4:0];
// // // reg [11:0] total_time[4:0];
// // // reg [7:0] total_true[4:0];
// // // reg whether_input_answer[14:0][4:0];
// // // reg flag_whether_first_compitition = 1'b0;
// // // reg [7:0] player_answer[14:0][4:0];
// // // reg [7:0] machine_answer[14:0];
// // // reg [7:0] inputA[14:0];
// // // reg [7:0] inputB[14:0];
// // // reg question_true[14:0][4:0];
// // // reg [26:0] counter;
// // // reg [7:0] current_number = 8'b00000000;
// // // reg [5:0] number2type[14:0];
// // // reg [7:0] number2count[14:0];


// // // operation state
// // localparam arithmetic = 8'b00000001,
// //            move_operation = 8'b00000010,
// //            bit_operation = 8'b00000100,
// //            logic_operation = 8'b00001000;
// // // arithmetic state
// // localparam add = 8'b00000001,
// //            sub = 8'b00000010;
// // // move state
// // localparam left_arithmetic = 8'b00000001,
// //            right_arithmetic = 8'b00000010,
// //            left_logic = 8'b00000100,
// //            right_logic = 8'b00001000;
// // // bit state
// // localparam And = 8'b00000001,
// //            Or = 8'b00000010,
// //            Not = 8'b00000100,
// //            Xor = 8'b00001000;
// // // logic state
// // localparam logic_and = 8'b00000001,
// //            logic_or = 8'b00000010,
// //            logic_not = 8'b00000100,
// //            logic_xor = 8'b00001000; 
// // localparam digit_an = 8'd17,
// //             digit_minue = 8'd16;
// // reg [7:0] problem_typeA,problem_typeB,inputa,inputb;
// // wire [7:0] Res;
// // localparam check_time = 8'b00000001,
// //     check_answer = 8'b00000010,
// //     check_input = 8'b00000100;
// // // reg [7:0] review_module;
// // reg [7:0] check_id;
// // reg [7:0] check_number = 8'b00000000;
// // // reg flag_check_number = 1'b0;
// // // reg flag_module=1'b0;
// // reg flag_check_id = 1'b0;
// // // reg [3:0] Count_number_machine = 4'd0;
// // calc_module_45 get_number(
// //     .typea(problem_typeA),
// //     .typeb(problem_typeB),
// //     .a(inputa),
// //     .b(inputb),
// //     .result(Res)
// // );

// // // reg flag_start_timer = 1'b0;
// // // reg flag_stop_timer = 1'b0;
// // // reg flag_start_stu = 1'b0;
// // reg flag_check_over = 1'b0;
// // // wire [7:0] Timer;
// // // reg [7:0] TIMER = 8'b00000000;
// // reg reset_n = 1'b1;
// // wire en_led;
// // wire [7:0] timer ;
// // timer_module get_time(
// //     .clk(clk),
// //     .reset_n(reset_n),
// //     .timer(timer),
// //     .en_led(en_led)
// // );
// // // wire [4:0] Timer ;
// // // assign Timer = timer;
// // // 时序逻辑：在时钟边沿更新状态和输出
// // always @(posedge clk or posedge reset) begin
// //     if (reset) begin
// //         state <= Idle;
// //     end else begin
// //         state <= next_state;
// //     end
// // end

// // reg flag_admin_input_problem_B = 1'b0;
// // reg flag_admin_input_problem_initial = 1'b0;
// // reg flag_student_compitition_initial = 1'b0;
// // reg flag_student_compitition = 1'b0;
// // reg flag_student_compitition_show_light_initial_timer = 1'b0;
// // reg flag_student_compitition_show_answer_initial_timer = 1'b0;
// // reg flag_review_time_phase4 = 1'b0;
// // reg flag_result_show_output = 1'b0;
// // // 组合逻辑：计算下一个状态和临时变量
// // always @(*) begin
// //     case (state)
// //         Idle: begin
// //             if(input_complete && !(user_input ^ 8'b00000001)) begin
// //                 next_state = Admin_input_problem_initial;
// //             end else if (input_complete && !(user_input ^ 8'b00000010)) begin
// //                 next_state = Admin_input_student_number_phase1;
// //             end else if (input_complete /*&& (user_input == 8'b00000100)*/ && student_id < student_number) begin
// //                 next_state = Student_compitition_initial;
// //             end else if(input_complete && !(student_id ^ student_number) && !flag_result_ok) begin
// //                 next_state = Result_show_initial;
// //             end else begin
// //                 next_state = next_state;
// //             end
// //         end
// //         Admin_input_problem_initial: begin
// //             next_state = flag_admin_input_problem_initial ? Admin_input_problem : Admin_input_problem_initial;
// //         end
// //         Admin_input_problem: begin
// //             next_state = input_complete ? ( Admin_input_problem_number) : (flag_problem_input_complete ? Idle : Admin_input_problem);
// //         end
// //         Admin_input_problem_number: begin
// //             next_state = input_complete ? Admin_input_problem_number_A : Admin_input_problem_number;
// //         end
// //         Admin_input_problem_number_A: begin
// //             next_state = input_complete ? Admin_input_problem_number_B : Admin_input_problem_number_A;
// //         end
// //         Admin_input_problem_number_B: begin
// //             if (flag_admin_input_problem_B) begin 
// //                 next_state = (flag_subproblem_input_complete) ? Admin_input_problem : Admin_input_problem_number;
// //             end else begin
// //                 next_state = Admin_input_problem_number_B;
// //             end
// //         end
// //         Admin_input_student_number_phase1: begin
// //             next_state = input_complete ? Admin_input_student_number_phase2 : Admin_input_student_number_phase1;
// //         end
// //         Admin_input_student_number_phase2: begin
// //             next_state = flag_student_number_input_complete ? Idle : Admin_input_student_number_phase2;
// //         end
// //         Student_compitition_initial: begin
// //             next_state = flag_student_compitition_initial ? Student_compitition : Student_compitition_initial;
// //         end
// //         Student_compitition: begin
// //             next_state = flag_student_compitition ? Student_compitition_show_light : Student_compitition;
// //         end 
// //         //TODO 看效果，也可以改成先亮后暗
// //         // Student_compitition_show_an: begin
// //         //     next_state = en_led ? Student_compitition_show_light : Student_compitition_show_an;
// //         // end
// //         // Student_compitition_show_light: begin
// //         //     if (number_flash==4'd8) begin 
// //         //         next_state = Student_compitition_show_light_initial_timer;
// //         //     end else begin
// //         //         next_state = en_led ? Student_compitition_show_light : Student_compitition_show_an;
// //         //     end
// //         // end
// //         Student_compitition_show_light: begin
// //             if (timer==8'd6) begin 
// //                 next_state = Student_compitition_show_light_initial_timer;
// //             end else begin
// //                 next_state = Student_compitition_show_light;
// //             end
// //         end
// //         Student_compitition_show_light_initial_timer: begin
// //             next_state = flag_student_compitition_show_light_initial_timer ? Student_compitition_answer_input_wait : Student_compitition_show_light_initial_timer;
// //         end
// //         Student_compitition_answer_input_wait: begin
// //             if (!(timer ^ 8'd20)) begin
// //                 next_state = Student_compitition_answer_input_initial_timer;
// //             end else if (input_complete) begin 
// //                 next_state = Student_compitition_answer_input_phase3;
// //             end
// //             else begin 
// //                 next_state = Student_compitition_answer_input_wait;
// //             end
// //         end
// //         Student_compitition_answer_input_initial_timer : begin 
// //             next_state = flag_student_compitition_show_answer_initial_timer ? Student_compitition_answer_check : Student_compitition_answer_input_initial_timer;
// //         end
// //         // Student_compitition_answer_input_phase2: begin
// //         //     if (input_complete) begin 
// //         //         next_state = Student_compitition_answer_input_phase_to_3;
// //         //     end else begin
// //         //         next_state = en_led ? Student_compitition_answer_input_wait : Student_compitition_answer_input_phase2;
// //         //     end
// //         // end
// //         // Student_compitition_answer_input_phase_to_3: begin
// //         //     next_state = Student_compitition_answer_input_phase3 ;
// //         // end
// //         Student_compitition_answer_input_phase3: begin
// //             next_state = Student_compitition_answer_check ;
// //         end
// //         Student_compitition_answer_check: begin
// //             next_state = !(flag_competing ^ 0) ? Idle : Student_compitition;
// //         end
// //         Result_show_initial: begin
// //             next_state = (winner == 8'b00000001) ? Result_show_output : Result_show_initial;
// //         end
// //         Result_show_output: begin
// //             if (flag_result_show_output) begin
// //                 next_state = flag_result_ok ? Review : Result_show_update;
// //             end else begin
// //                 next_state = Result_show_output;
// //             end
// //         end
// //         Result_show_update: begin
// //             next_state = input_complete ? Result_show_output : Result_show_update;
// //         end
// //         Review: begin
// //             if (input_quit) begin
// //                 next_state = Idle;
// //             end else  if (input_complete) begin
// //                 case (user_input)
// //                     check_time: begin
// //                         next_state = Review_time_phase1;
// //                     end
// //                     check_answer: begin
// //                         next_state = Review_machine_answer_phase1;
// //                     end
// //                     check_input: begin
// //                         next_state = Review_input_answer_phase1;
// //                     end
// //                     default: next_state = next_state;
// //                 endcase
// //             end else begin
// //                 next_state = Review;
// //             end
// //         end
// //         Review_time_phase1: begin
// //             next_state = (input_complete) ? Review_time_phase2 : Review_time_phase1;
// //         end
// //         Review_time_phase2: begin
// //             next_state = (input_complete) ? Review_time_phase3 : Review_time_phase2;
// //         end
// //         Review_time_phase3: begin
// //             next_state = (input_complete) ? ((flag_check_over)? Review : Review_time_phase4) : Review_time_phase3;
// //         end
// //         Review_time_phase4: begin
// //             next_state = (flag_review_time_phase4) ? Review_time_phase3 : Review_time_phase4;
// //         end
// //         Review_machine_answer_phase1: begin
// //             next_state = (input_complete) ? Review_machine_answer_phase2 : Review_machine_answer_phase1;
// //         end
// //         Review_machine_answer_phase2: begin
// //             next_state = (input_complete) ? Review_machine_answer_phase3 : Review_machine_answer_phase2;
// //         end
// //         Review_machine_answer_phase3: begin
// //             next_state = (input_complete) ? Review : Review_machine_answer_phase3;
// //         end
// //         Review_input_answer_phase1: begin
// //             next_state = (input_complete) ? Review_input_answer_phase2 : Review_input_answer_phase1;
// //         end
// //         Review_input_answer_phase2: begin
// //             next_state = (input_complete) ? Review_input_answer_phase3 : Review_input_answer_phase2;
// //         end
// //         Review_input_answer_phase3: begin
// //             next_state = (input_complete) ? Review_input_answer_phase4 : Review_input_answer_phase3;
// //         end
// //         Review_input_answer_phase4: begin
// //             next_state = (input_complete) ? Review : Review_input_answer_phase4;
// //         end
// //         default: next_state = next_state;

// //     endcase
// // end


// // always @(state,pre_state) begin
// //     if (state == Idle) begin
// //         reset_n = 1'b1;
// //         count_number = 4'd0;
// //         count_type = 8'd0;
// //         // Count_number_machine = 4'd0;
// //         flag_problem_input_complete = 1'b0;
// //         flag_problem_input_complete_tmp = 1'b0;
// //         flag_whether_first_compitition = 1'b0;
// //         flag_admin_input_problem_initial = 1'b1;
// //     end else if (state == Student_compitition_answer_input_wait) begin
// //         reset_n = 1'b0;
// //         flag_student_compitition_show_light_initial_timer = 1'b0;
// //         display1 = current_question/100;
// //         display2 = current_question%100/10;
// //         display3 = current_question%10;
// //         display4 = number_total_questions/100; 
// //         display5 = number_total_questions%100/10;
// //         display6 = number_total_questions%10;
// //         display7 = timer/10;
// //         display8 = timer%10;
// //     end else if (state == Student_compitition_show_light) begin 
// //         // Student_compitition_show_an: begin
// //         reset_n = 1'b0;
// //         if (!en_led) begin 
// //             display1 = digit_an;
// //             display2 = digit_an;
// //             display3 = digit_an;
// //             display4 = digit_an;
// //             display5 = digit_an;
// //             display6 = digit_an;
// //             display7 = digit_an;
// //             display8 = digit_an;
// //             led1 = inputA[count_number][count_type]; // 在LED上显示题目
// //             led2 = inputB[count_number][count_type]; // 在LED上显示题目
// //             // machine_answer[number_questions[count_type]][count_type] = machine_answer[0][count_type+1];
// //             // number_flash = number_flash + 1;
// //         end else begin
// //             // number_flash = number_flash + 1;
// //             display1 = current_question/100;
// //             display2 = current_question%100/10;
// //             display3 = current_question%10;
// //             display4 = digit_an;
// //             display5 = number_total_questions/100; 
// //             display6 = number_total_questions%100/10;
// //             display7 = number_total_questions%10;
// //             display8 = digit_an;
// //         end
// //             //     reset_n = 1'b0;
// //             //     flag_student_compitition = 1'b0;
// //             //     // en = en_led;
// //             //     display1 = digit_an;
// //             //     display2 = digit_an;
// //             //     display3 = digit_an;
// //             //     display4 = digit_an;
// //             //     display5 = digit_an;
// //             //     display6 = digit_an;
// //             //     display7 = digit_an;
// //             //     display8 = digit_an;
// //             //     led1 = inputA[count_number][count_type]; // 在LED上显示题目
// //             //     led2 = inputB[count_number][count_type]; // 在LED上显示题目
// //             //     machine_answer[number_questions[count_type]][count_type] = machine_answer[0][count_type+1];
// //             //     number_flash = number_flash + 1;
// //             // end
// //             // Student_compitition_show_light: begin
// //             //     number_flash = number_flash + 1;
// //             //     // en = en_led;
// //             //     display1 = current_question/100;
// //             //     display2 = current_question%100/10;
// //             //     display3 = current_question%10;
// //             //     display4 = digit_an;
// //             //     display5 = number_total_questions/100; 
// //             //     display6 = number_total_questions%100/10;
// //             //     display7 = number_total_questions%10;
// //             //     display8 = digit_an;
// //             // end
// //     end else  if (state != pre_state) begin
// //         pre_state = state;
// //         case (state)
// //             Idle :;
// //             Admin_input_problem_initial: begin
// //             end
// //             Admin_input_problem: begin
// //                 flag_admin_input_problem_initial = 1'b0;
// //                 flag_admin_input_problem_B = 1'b0;
// //                 count_type = count_type + 1;
// //                 flag_type = 1'b0;
// //                 count_number = 4'd0;
// //                 // Count_number_machine = 4'd0;
// //                 if (flag_problem_input_complete_tmp) begin
// //                     flag_problem_input_complete = 1'b1;
// //                     // machine_answer[number_questions[14]][14] = Res;
// //                     // machine_answer[0][15] = Res;
// //                 end
                
// //             end 
// //             Admin_input_problem_number: begin
// //                 flag_admin_input_problem_B = 1'b0;
// //                 count_number = count_number + 1;
// //                 current_number = current_number + 1;
// //                 // machine_answer[Count_number_machine][count_type] = Res;
// //                 if (!(flag_type ^ 1'b0)) begin
// //                     number_questions[count_type] = user_input;
// //                     led1 = user_input;
// //                     number_total_questions = number_total_questions + user_input;
// //                     flag_type = 1'b1;
// //                 end
// //             end
// //             Admin_input_problem_number_A: begin
// //                 inputA[count_number][count_type] = user_input;
// //                 number2count[current_number] = count_number;
// //                 number2type[current_number] = count_type;
// //                 flag_subproblem_input_complete = 1'b0;
// //                 // flag_subproblem_input_uncomplete = 1'b0;
// //                 inputa = user_input;
// //                 led1 = user_input;
// //                 case (count_type)
// //                     8'd1: begin 
// //                         problem_typeA = arithmetic;
// //                         problem_typeB = add;
// //                     end
// //                     8'd2: begin
// //                         problem_typeA = arithmetic;
// //                         problem_typeB =sub;
// //                     end
// //                     8'd3: begin
// //                         problem_typeA = move_operation;
// //                         problem_typeB = left_arithmetic;
// //                     end
// //                     8'd4: begin
// //                         problem_typeA = move_operation;
// //                         problem_typeB = right_arithmetic;
// //                     end
// //                     8'd5: begin
// //                         problem_typeA = move_operation;
// //                         problem_typeB = left_logic;
// //                     end
// //                     8'd6: begin
// //                         problem_typeA = move_operation;
// //                         problem_typeB = right_logic;
// //                     end
// //                     8'd7: begin
// //                         problem_typeA = bit_operation;
// //                         problem_typeB = And;
// //                     end
// //                     8'd8: begin 
// //                         problem_typeA = bit_operation;
// //                         problem_typeB = Or;
// //                     end
// //                     8'd9: begin
// //                         problem_typeA = bit_operation;
// //                         problem_typeB = Not;
// //                     end
// //                     8'd10: begin
// //                         problem_typeA = bit_operation;
// //                         problem_typeB = Xor;
// //                     end 
// //                     8'd11: begin
// //                         problem_typeA = logic_operation;
// //                         problem_typeB = logic_and;
// //                     end
// //                     8'd12: begin
// //                         problem_typeA = logic_operation;
// //                         problem_typeB = logic_or;
// //                     end
// //                     8'd13: begin
// //                         problem_typeA = logic_operation;
// //                         problem_typeB = logic_not;
// //                     end
// //                     8'd14: begin
// //                         problem_typeA = logic_operation;
// //                         problem_typeB = logic_xor;
// //                     end 
// //                         default: problem_typeA = 8'b00000000;
// //                 endcase
// //             end
// //             Admin_input_problem_number_B: begin
// //                 inputB[count_number][count_type] = user_input;
// //                 machine_answer[count_number][count_type] = Res;
// //                 // Count_number_machine = Count_number_machine + 1;
// //                 inputb = user_input;
// //                 led1 = user_input;
// //                 if(count_number >= number_questions[count_type]) begin
// //                     flag_subproblem_input_complete = 1'b1;
// //                     // flag_subproblem_input_uncomplete = 1'b0;
// //                     // if (!(count_type ^ 8'd14)) begin
// //                     if (count_type == 8'd3) begin
// //                         flag_problem_input_complete_tmp = 1'b1;
// //                     end
// //                 end
// //                 if (count_number < number_questions[count_type]) begin
// //                     flag_subproblem_input_complete = 1'b0;
// //                     // flag_subproblem_input_uncomplete = 1'b1;
// //                 end
// //                 flag_admin_input_problem_B = 1'b1;
// //             end
// //             Admin_input_student_number_phase1: begin
// //                 flag_student_number_input_complete = 1'b0;
// //             end
// //             Admin_input_student_number_phase2: begin
// //                 student_number = user_input;
// //                 student_id = 3'd0;
// //                 led1 = user_input;
// //                 flag_student_number_input_complete = 1'b1;
// //             end
// //             Student_compitition_initial : begin
// //                 // number_flash = 4'd0;
// //                 count_number = 4'd0;
// //                 count_type = 8'd0;
// //                 flag_type = 1'b0;
// //                 if (!(flag_whether_first_compitition ^ 1'b0)) begin
// //                     flag_whether_first_compitition = 1'b1;
// //                     student_id = 3'd1;
// //                 end else begin 
// //                     student_id = student_id + 1;
// //                 end
// //                 total_true[student_id] = 8'b00000000;
// //                 current_question = 8'd0;
// //                 flag_competing = 1'b1;
// //                 // en = 1'b1;
// //                 flag_result_ok = 1'b0;
// //                 flag_student_compitition_initial = 1'b1;
// //             end
// //             Student_compitition: begin
// //                 flag_student_compitition_initial = 1'b0;
// //                 // number_flash = 4'd0;
// //                 count_number = count_number + 1;
// //                 if (!(flag_type ^ 1'b0)) begin
// //                     count_type = count_type + 1;
// //                     count_number = 1'b1;
// //                     flag_type = 1'b1;
// //                 end
// //                 reset_n = 1'b1;
// //                 current_question = current_question + 1;
// //                 flag_student_compitition = 1'b1;
// //             end
// //             // Student_compitition_show_an: begin
// //             //     reset_n = 1'b0;
// //             //     flag_student_compitition = 1'b0;
// //             //     // en = en_led;
// //             //     display1 = digit_an;
// //             //     display2 = digit_an;
// //             //     display3 = digit_an;
// //             //     display4 = digit_an;
// //             //     display5 = digit_an;
// //             //     display6 = digit_an;
// //             //     display7 = digit_an;
// //             //     display8 = digit_an;
// //             //     led1 = inputA[count_number][count_type]; // 在LED上显示题目
// //             //     led2 = inputB[count_number][count_type]; // 在LED上显示题目
// //             //     machine_answer[number_questions[count_type]][count_type] = machine_answer[0][count_type+1];
// //             //     number_flash = number_flash + 1;
// //             // end
// //             // Student_compitition_show_light: begin
// //             //     number_flash = number_flash + 1;
// //             //     // en = en_led;
// //             //     display1 = current_question/100;
// //             //     display2 = current_question%100/10;
// //             //     display3 = current_question%10;
// //             //     display4 = digit_an;
// //             //     display5 = number_total_questions/100; 
// //             //     display6 = number_total_questions%100/10;
// //             //     display7 = number_total_questions%10;
// //             //     display8 = digit_an;
// //             // end
// //             // Student_compitition_answer_input_wait: begin
// //             //     reset_n = 1'b0;
// //             //     flag_student_compitition_show_light_initial_timer = 1'b0;
// //             // end
// //             Student_compitition_show_light_initial_timer: begin
// //                 reset_n = 1'b1;
// //                 flag_student_compitition_show_light_initial_timer = 1'b1;
// //             end
// //             Student_compitition_answer_input_initial_timer: begin
// //                 whether_input_answer[count_number][count_type][student_id] = 1'b0;
// //                 total_time[student_id] = total_time[student_id] + 8'd20;
// //                 time_question[count_number][count_type][student_id] = 8'd20;
// //                 flag_student_compitition_show_answer_initial_timer = 1'b1;
// //             end
// //             // Student_compitition_answer_input_phase2: begin
// //             //     timer = timer + 1;
// //             // end
// //             // Student_compitition_answer_input_phase_to_3: begin
// //             //     flag_answer_input = 1'b0;
// //             // end
// //             Student_compitition_answer_input_phase3: begin
// //                 total_time[student_id] = total_time[student_id] + timer;
// //                 time_question[count_number][count_type][student_id] = timer;
// //                 player_answer[count_number][count_type][student_id] = user_input;
// //                 led1 = user_input;
// //                 whether_input_answer[count_number][count_type][student_id] = 1'b1;
// //                 // flag_answer_input = 1'b1;
// //             end
// //             Student_compitition_answer_check: begin
// //                 flag_student_compitition_show_answer_initial_timer = 1'b0;
// //                 if(!(whether_input_answer[count_number][count_type][student_id] ^ 1'b0)) begin
// //                     question_true[count_number][count_type][student_id] = 1'b0;
// //                 end else begin 
// //                     if(!(player_answer[count_number][count_type][student_id] ^ machine_answer[count_number][count_type])) begin
// //                         question_true[count_number][count_type][student_id] = 1'b1;
// //                         total_true[student_id] = total_true[student_id] + 1;
// //                     end else begin
// //                         question_true[count_number][count_type][student_id] = 1'b0;
// //                     end
// //                 end
// //                 if(!(count_number ^ number_questions[count_type])) begin
// //                     flag_type = 1'b0;
// //                     // if(!(count_type ^ 8'd14)) begin
// //                     if(count_type == 8'd3) begin
// //                         flag_competing = 1'b0;
// //                     end
// //                 end 
// //             end
// //             Result_show_initial: begin
// //                 current_player = 3'd1;
// //                 winner_time = total_time[1];
// //                 winner_true = total_true[1];
// //                 winner = 8'b00000001;
// //             end
// //             Result_show_output: begin
// //                 if (current_player <= student_number) begin
// //                     display1 = total_true[current_player]/100;
// //                     display2 = total_true[current_player]%100/10;
// //                     display3 = total_true[current_player]%10;
// //                     display4 = digit_an;
// //                     display5 = total_time[current_player]/1000;
// //                     display6 = total_time[current_player]%1000/100;
// //                     display7 = total_time[current_player]%100/10;
// //                     display8 = total_time[current_player]%10;
// //                     if (total_true[current_player] > winner_true) begin
// //                         winner = current_player;
// //                         winner_time = total_time[current_player];
// //                         winner_true = total_true[current_player];
// //                     end else if (!(total_true[current_player] ^ winner_true) && total_time[current_player] < winner_time) begin
// //                         winner = current_player;
// //                         winner_time = total_time[current_player];
// //                         winner_true = total_true[current_player];
// //                     end
// //                 end else begin
// //                     display1 = winner;
// //                     display2 = digit_an;
// //                     display3 = digit_an;
// //                     display4 = digit_an;
// //                     display5 = digit_an;
// //                     display6 = digit_an;
// //                     display7 = digit_an;
// //                     display8 = digit_an;

// //                     flag_result_ok = 1'b1;
// //                 end
// //                 flag_result_show_output = 1'b1;
// //             end
// //             Result_show_update: begin
// //                 flag_result_show_output = 1'b0;
// //                 current_player = current_player + 1;
// //             end
// //             Review: begin
// //                 flag_check_over = 1'b0;
// //                 flag_result_show_output = 1'b0;
// //             end
// //             Review_time_phase1: begin
// //             end
// //             Review_time_phase2: begin
// //                 current_player = user_input;
// //                 led1 = user_input;
// //                 count_number = 4'd1;
// //                 count_type = 8'd1;
// //             end
// //             Review_time_phase3:begin
// //                 flag_review_time_phase4 = 1'b0;
// //                 if(count_number <= number_questions[count_type]) begin
// //                     display1 = count_number/10;
// //                     display2 = count_number%10;
// //                     display3 = digit_an;
// //                     display4 = digit_an;
// //                     display5 = time_question[count_number][count_type][current_player]/1000;
// //                     display6 = time_question[count_number][count_type][current_player]%1000/100;
// //                     display7 = time_question[count_number][count_type][current_player]%100/10;
// //                     display8 = time_question[count_number][count_type][current_player]%10;
// //                 end else begin
// //                     // if(!(count_type ^ 8'd14) && count_number > number_questions[count_type]) begin
// //                     if(count_type == 8'd3 && count_number > number_questions[count_type]) begin
// //                         display1 = current_player;
// //                         display2 = digit_an;
// //                         display3 = digit_an;
// //                         display4 = digit_an;
// //                         display5 = total_time[current_player]/1000;
// //                         display6 = total_time[current_player]%1000/100;
// //                         display7 = total_time[current_player]%100/10;
// //                         display8 = total_time[current_player]%10;
// //                         flag_check_over = 1'b1;
// //                     end
// //                 end
// //                 // flag_check_id = 1'b0;
// //             end
// //             Review_time_phase4: begin
// //                 if(count_number < number_questions[count_type]) begin
// //                     count_number = count_number + 1;
// //                 // end else if(!(count_type ^ 8'd14)) begin
// //                 end else if(count_type == 8'd3) begin
// //                     count_number = count_number + 1;
// //                 end else begin
// //                     count_type = count_type + 1;
// //                     count_number = 4'd1;
// //                 end
// //                 flag_review_time_phase4 = 1'b1;
// //                 // flag_check_id = 1'b1;
// //             end
// //             Review_machine_answer_phase1:begin
// //             end
// //             Review_machine_answer_phase2:begin
// //                 check_number = user_input;
// //                 led1 = user_input;
// //             end
// //             Review_machine_answer_phase3: begin
// //                 display1 = number2type[check_number]/10;
// //                 display2 = number2type[check_number]%10;
// //                 display3 = digit_an;
// //                 display4 = digit_an;
// //                 //TODO 特盘状态2
// //                 if (!(machine_answer[number2count[check_number]][number2type[check_number]][7] ^ 1'b1) && (!((number2type[check_number] ^ 6'd2) && (number2type[check_number] ^ 6'd3)))) begin
// //                     display5 = digit_minue;
// //                 end else begin 
// //                     display8 = digit_an;
// //                 end
// //                 display6 = machine_answer[number2count[check_number]][number2type[check_number]]/100;
// //                 display7 = machine_answer[number2count[check_number]][number2type[check_number]]%100/10;
// //                 display8 = machine_answer[number2count[check_number]][number2type[check_number]]%10;
// //                 led1 = inputA[number2count[check_number]][number2type[check_number]];
// //                 led2 = inputB[number2count[check_number]][number2type[check_number]];
// //             end
// //             Review_input_answer_phase1: begin
// //             end
// //             Review_input_answer_phase2: begin
// //                 check_id = user_input;
// //                 led1 = user_input;
// //             end
// //             Review_input_answer_phase3: begin
// //                 check_number = user_input;
// //                 led1 = user_input;
// //             end
// //             Review_input_answer_phase4: begin
// //                 led1 = player_answer[number2count[check_number]][number2type[check_number]][check_id];
// //                 led2 = (question_true[number2count[check_number]][number2type[check_number]][check_id])? 8'b00000001 : 8'b00000010;
// //             end
            
// //         endcase
// //     end
// // end
// // endmodule

// // endmodule
// // // always @(input_complete,flag_problem_input_complete,flag_studnet_number_input_complete) begin
// // //     case (state)
// // //         Idle: begin
// // //             if (input_complete && admin_user) begin
// // //                 next_state <= Admin_input_problem;
// // //                 flag_problem_input_complete <= 1'b0;
// // //                 flag_type <= 1'b0;
// // //                 flag_number1 <= 1'b0;
// // //                 flag_number2 <= 1'b0;
// // //                 flag_get_result <= 1'b0;
// // //                 count_type <= 8'd0;
// // //                 count_number <= 4'd0;
// // //             end else begin
// // //                 if (input_complete && stu_number) begin
// // //                     next_state <= Admin_input_student_number;
// // //                     flag_studnet_number_input_complete <= 1'b0;
// // //                 end else begin
// // //                     if (input_complete && flag_competing && student_id != student_number) begin
// // //                         next_state <= Student_ans;
// // //                         student_id <= student_id + 1;
// // //                         flag_competing <= 1'b0;
// // //                         number_flash <= 0;
// // //                         count_number <= 4'd0;
// // //                         count_type <= 8'd0;
// // //                         flag_start_timer <= 1'b0;
// // //                         flag_stop_timer <= 1'b0;
// // //                     end else if (student_id == student_number)begin
// // //                         next_state <= Result;     
// // //                         student_id <= 0;
// // //                         flag_result_ok <= 1'b0;
// // //                         flag_show_winner <= 1'b0;
// // //                     end else begin
// // //                         next_state <= Idle;
// // //                     end
// // //                 end
// // //             end
// // //         end
// // //         Admin_input_problem: 
// // //             next_state <= flag_problem_input_complete ? Idle : Admin_input_problem;
// // //         Admin_input_student_number: 
// // //             next_state <= flag_studnet_number_input_complete ? Idle : Admin_input_student_number;
// // //         Student_ans: 
// // //             next_state <= flag_competing ? Idle : Student_ans;
// // //         Result: 
// // //             next_state <= (flag_result_ok) ? Review : Result;
// // //         Review: 
// // //             next_state <= (input_quit) ? Idle : Review; // 复核后返回到IDLE状态
// // //         default: 
// // //             next_state <= Idle;
// // //     endcase
// // // end

// // // 控制逻辑：根据当前状态控制输出
// // // always @(*) begin
// // //     case (state)
// // //         Idle: begin
// // //         end
// // //         Admin_input_problem: begin
// // //             if(input_complete) begin
// // //                 if(flag_type == 1'b0) begin
// // //                     number_questions[count_type] <= user_input; 
// // //                     flag_type <= 1'b1;
// // //                     count_number <= 4'd0;
// // //                     number_total_questions <= number_total_questions + user_input;
// // //                 end  else if(flag_type == 1'b1) begin
// // //                     if (flag_number1 == 1'b0) begin
// // //                         inputA[count_number][count_type] <= user_input;
// // //                         inputa <= user_input;
// // //                         flag_number1 <= 1'b1; 
// // //                         current_number <= current_number + 1;
// // //                     end else begin
// // //                         if (flag_number2 == 1'b0) begin
// // //                             inputB[count_number][count_type] <= user_input;
// // //                             inputb <= user_input;
// // //                             number2count[current_number] <= count_number;
// // //                             number2type[current_number] <= count_type;
// // //                             case (count_type)
// // //                                 8'd0: begin 
// // //                                     problem_typeA <= arithmetic;
// // //                                     problem_typeB <= add;
// // //                                 end
// // //                                 8'd1: begin
// // //                                     problem_typeA <= arithmetic;
// // //                                     problem_typeB <=sub;
// // //                                 end
// // //                                 8'd2: begin
// // //                                     problem_typeA <= move_operation;
// // //                                     problem_typeB <= left_arithmetic;
// // //                                 end
// // //                                 8'd3: begin
// // //                                     problem_typeA <= move_operation;
// // //                                     problem_typeB <= right_arithmetic;
// // //                                 end
// // //                                 8'd4: begin
// // //                                     problem_typeA <= move_operation;
// // //                                     problem_typeB <= left_logic;
// // //                                 end
// // //                                 8'd5: begin
// // //                                     problem_typeA <= move_operation;
// // //                                     problem_typeB <= right_logic;
// // //                                 end
// // //                                 8'd6: begin
// // //                                     problem_typeA <= bit_operation;
// // //                                     problem_typeB <= And;
// // //                                 end
// // //                                 8'd7: begin 
// // //                                     problem_typeA <= bit_operation;
// // //                                     problem_typeB <= Or;
// // //                                 end
// // //                                 8'd8: begin
// // //                                     problem_typeA <= bit_operation;
// // //                                     problem_typeB <= Not;
// // //                                 end
// // //                                 8'd9: begin
// // //                                     problem_typeA <= bit_operation;
// // //                                     problem_typeB <= Xor;
// // //                                 end 
// // //                                 8'd10: begin
// // //                                     problem_typeA <= logic_operation;
// // //                                     problem_typeB <= logic_and;
// // //                                 end
// // //                                 8'd11: begin
// // //                                     problem_typeA <= logic_operation;
// // //                                     problem_typeB <= logic_or;
// // //                                 end
// // //                                 8'd12: begin
// // //                                     problem_typeA <= logic_operation;
// // //                                     problem_typeB <= logic_not;
// // //                                 end
// // //                                 8'd13: begin
// // //                                     problem_typeA <= logic_operation;
// // //                                     problem_typeB <= logic_xor;
// // //                                 end 
// // //                                 default: problem_typeA <= 8'b00000000;
// // //                             endcase
// // //                             flag_number2 <= 1'b1;
// // //                             flag_get_result <= 1'b1;
// // //                         end else begin
// // //                             if(flag_get_result) begin
// // //                                 machine_answer[count_number][count_type]<= Res;
// // //                                 flag_get_result <= 1'b0;
// // //                             end else begin
// // //                                 if (count_number < number_questions[count_type]) begin
// // //                                     flag_number1 <= 1'b0;
// // //                                     flag_number2 <= 1'b0;
// // //                                     count_number <= count_number + 1;
// // //                                 end else begin
// // //                                     if (count_type == 8'd14) begin
// // //                                         flag_problem_input_complete <= 1'b1;
// // //                                     end else begin
// // //                                         count_number <= 4'd0;
// // //                                         count_type <= count_type + 1;
// // //                                         flag_type <= 1'b0;
// // //                                     end
// // //                                 end
// // //                             end
// // //                         end
// // //                     end
// // //                 end
// // //             end
// // //         end
// // //         Admin_input_student_number: begin
// // //             if(input_complete) begin
// // //                 student_number <= user_input;
// // //                 flag_studnet_number_input_complete <= 1'b1;
// // //                 flag_competing <= 1'b1;
// // //             end
// // //         end
// // //         Student_ans: begin
// // //             if (input_complete) begin
// // //                 flag_competing <= 1'b1;
// // //             end
// // //             // 显示当前题目编号和题目
// // //             //闪烁三次
// // //             // if(flag_start_timer==0) begin
// // //             //     flag_start_timer <= 1'b1;
// // //             //     TIMER = 8'b00000000;
// // //             // end else begin 
// // //             //     if (number_flash < 6) begin
// // //             //         if (Timer != TIMER) begin // 0.5秒
// // //             //             TIMER <= Timer;
// // //             //             en_led <= ~en_led; // 每1秒翻转一次LED状态
// // //             //             number_flash <= number_flash + 1;
// // //             //         end
// // //             //         display1 <= current_question/100;
// // //             //         display2 <= current_question%100/10;
// // //             //         display3 <= current_question%10;
// // //             //         display5 <= number_total_questions/100; 
// // //             //         display6 <= number_total_questions%100/10;
// // //             //         display7 <= number_total_questions%10;
// // //             //         led1 <= inputA[count_number][count_type]; // 在LED上显示题目
// // //             //         led2 <= inputB[count_number][count_type]; // 在LED上显示题目
// // //             //     end else begin 
// // //             //         if (flag_stop_timer == 0) begin 
// // //             //             flag_stop_timer <= 1'b1;
// // //             //         end else begin
// // //             //             if(count_number<number_questions[count_type]) begin 
                            
// // //             //             end   
// // //             //         end
// // //             //     end
// // //             // end
// // //                 // end else begin
// // //                 //     if(count_number<number_questions[count_type]) begin
// // //                 //         if (TIMER >= 20 or input_complete) begin
// // //                 //             total_time[current_player] <= total_time[current_player] + timer;
// // //                 //             time_question[count_number][count_type][current_player] <= timer;
// // //                 //             if (input_complete) begin
// // //                 //                 player_answer[count_number][count_type][current_player] <= user_input;
// // //                 //                 if (user_input == machine_answer[count_number][count_type]) begin
// // //                 //                     total_true[current_player] <= total_true[current_player] + 1;
// // //                 //                     question_true[count_number][count_type][current_player] <= 1'b1;
// // //                 //                 end else begin
// // //                 //                     question_true[count_number][count_type][current_player] <= 1'b0;
// // //                 //                 end
// // //                 //             end else begin
// // //                 //                 player_answer[count_number][count_type][current_player] <= 8'b11111111; //代表没有输入结果
// // //                 //                 question_true[count_number][count_type][current_player] <= 1'b0;
// // //                 //             end
// // //                 //             timer <=0;
// // //                 //             count_number <= count_number + 1; // 显示下一题
// // //                 //             number_flash <= 0;
// // //                 //         end else begin
                            
// // //                 //         end
// // //                 //         led1 <= inputA[count_number][count_type]; // 在LED上显示题目
// // //                 //         led2 <= inputB[count_number][count_type]; // 在LED上显示题目
// // //                 //     end else begin
// // //                 //         if(count_type < 8'd14) begin
// // //                 //             count_type <= count_type + 1;
// // //                 //             count_number <= 4'd0;
// // //                 //         end else begin
// // //                 //             current_player <= current_player + 1;
// // //                 //             count_number <= 0;
// // //                 //             count_type <= 0;
// // //                 //             number_flash <= 0;
// // //                 //             if (current_player == student_number) begin
// // //                 //                 flag_result_ok <= 1'b1;
// // //                 //             end
// // //                 //         end
// // //                 //     end
// // //                 // end
// // //         end
// // //         Result: begin
// // //             if (input_complete) begin
// // //                 if (student_id<student_number) begin
// // //                     display1 <= total_true[student_id]/100;
// // //                     display2 <= total_true[student_id]%100/10;
// // //                     display3 <= total_true[student_id]%10;
// // //                     display5 <= total_time[student_id]/1000;
// // //                     display6 <= total_time[student_id]%1000/100;
// // //                     display7 <= total_time[student_id]%100/10;
// // //                     display8 <= total_time[student_id]%10;
// // //                     if (student_id == 0) begin 
// // //                         winner <= student_id;
// // //                         winner_time <= total_time[student_id];
// // //                         winner_true <= total_true[student_id];
// // //                     end else begin
// // //                         if (total_true[student_id] > winner_true) begin
// // //                             winner <= student_id;
// // //                             winner_time <= total_time[student_id];
// // //                             winner_true <= total_true[student_id];
// // //                         end else if (total_true[student_id] == winner_true) begin
// // //                             if (total_time[student_id] < winner_time) begin
// // //                                 winner <= student_id;
// // //                                 winner_time <= total_time[student_id];
// // //                                 winner_true <= total_true[student_id];
// // //                             end
// // //                         end
// // //                     end
// // //                 end else begin
// // //                     if (flag_show_winner == 0) begin
// // //                         display1 <= winner;
// // //                         flag_show_winner <= 1'b1;
// // //                     end else begin
// // //                         flag_result_ok <= 1'b1;
// // //                     end
                    
// // //                 end
// // //             end
// // //         end
// // //         Review: begin
// // //             if (input_complete) begin
// // //                 if(flag_module == 0) begin
// // //                     flag_module <= 1'b1;
// // //                     review_module <= user_input;
// // //                 end else begin
// // //                     case(review_module)
// // //                         check_time: begin
// // //                             if(input_complete) begin
// // //                                 if(flag_check_id == 0) begin
// // //                                     check_id <= user_input;
// // //                                     flag_check_id <= 1'b1;   
// // //                                     count_number <= 0;
// // //                                     count_type <= 0;              
// // //                                 end else begin
// // //                                     if(count_number < number_questions[count_type]) begin
// // //                                         display1 <= count_number/10;
// // //                                         display2 <= count_number%10;
// // //                                         display5 <= time_question[count_number][count_type][check_id]/1000;
// // //                                         display6 <= time_question[count_number][count_type][check_id]%1000/100;
// // //                                         display7 <= time_question[count_number][count_type][check_id]%100/10;
// // //                                         display8 <= time_question[count_number][count_type][check_id]%10;
// // //                                         count_number <= count_number + 1;
// // //                                     end else begin
// // //                                         if(count_type < 8'd14) begin
// // //                                             count_type <= count_type + 1;
// // //                                             count_number <= 0;
// // //                                         end else begin
// // //                                             flag_module <= 0;
// // //                                             flag_check_id <= 0;
// // //                                         end
// // //                                     end
// // //                                 end
// // //                             end
// // //                         end
// // //                         check_answer: begin
// // //                             if(input_complete) begin
// // //                                 if(flag_check_id == 0) begin
// // //                                     check_id <= user_input;
// // //                                     flag_check_id <= 1'b1;              
// // //                                 end else begin
// // //                                     flag_module <= 0;
// // //                                     flag_check_id <= 0;
// // //                                     display1 <= number2type[check_id]/10;
// // //                                     display2 <= number2type[check_id]%10;
// // //                                     led1 <= inputA[number2count[check_id]][number2type[check_id]];
// // //                                     led2 <= inputB[number2count[check_id]][number2type[check_id]];
// // //                                     display5 <= machine_answer[number2count[check_id]][number2type[check_id]]/100;
// // //                                     display6 <= machine_answer[number2count[check_id]][number2type[check_id]]%100/10;
// // //                                     display7 <= machine_answer[number2count[check_id]][number2type[check_id]]%10;
// // //                                 end
// // //                             end
// // //                         end
// // //                         check_input: begin
// // //                             if(input_complete) begin
// // //                                 if(flag_check_id == 0) begin
// // //                                     check_id <= user_input;
// // //                                     flag_check_id <= 1'b1;              
// // //                                 end else begin
// // //                                     if(flag_check_number == 0) begin
// // //                                         check_number <= user_input;
// // //                                         flag_check_number <= 1'b1;
// // //                                     end else begin
// // //                                         led1 <= player_answer[number2count[check_number]][number2type[check_number]][check_id];
// // //                                         led2 <= (question_true[number2count[check_number]][number2type[check_number]][check_id])? 8'b00000001 : 8'b00000010;
// // //                                     end
// // //                                 end
// // //                             end
// // //                         end
// // //                     endcase
// // //                 end
// // //             end
// // //         end
// // //     endcase
// // // end
// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 11/27/2024 08:45:18 PM
// // Design Name: 
// // Module Name: Competition_Mode
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////
// module competition_module(
//     // input clk,                      // 时钟信号
//     // input reset,                    // 复位信号
//     // input [7:0] user_input,        // 管理员输入
//     // input input_complete,                  // 学生确认答题
//     // input input_quit,                   // 学生提交答案
//     // // input admin_user,
//     // // input stu_number,
//     // // input start_competing,
//     // // output reg en ,                  // 使能信号
//     // output reg [7:0] display1,  // 显示输出
//     // output reg [7:0] display2,  // 显示输出
//     // output reg [7:0] display3,  // 显示输出
//     // output reg [7:0] display4,  // 显示输出
//     // output reg [7:0] display5,  // 显示输出
//     // output reg [7:0] display6,  // 显示输出
//     // output reg [7:0] display7,  // 显示输出
//     // output reg [7:0] display8,  // 显示输出
//     // output reg [7:0] led1,          // LED显示
//     // output reg [7:0] led2       // LED显示

//     input clk,
//     input reset,
//     input wire button_1,//power_off, stand_by, run_mode
//     input wire button_2,//button in the mode to ensure the input
//     input wire button_3,//quit in the mode
//     input wire button_4,//quit to the stand_by
//     input wire [7:0] user_input,
//     output reg [7:0] led1,
//     output reg [7:0] led2,
//     output reg [7:0] segment_0,
//     output reg [7:0] segment_1,
//     output reg seg_0,
//     output reg seg_1,
//     output reg seg_2,
//     output reg seg_3,
//     output reg seg_4,
//     output reg seg_5,
//     output reg seg_6,
//     output reg seg_7
//     // output reg [21:0] state,
//     // output reg [21:0] next_state,
//     // output reg [5:0] count_type
//     // output reg [30:0] pre_state,
//     // output wire [7:0] Timer
//     // number_flash = number_flash + 1;
//             //     // en = en_led;
//             //     display1 = current_question/100;
//             //     display2 = current_question%100/10;
//             //     display3 = current_question%10;
//             //     display4 = digit_an;
//             //     display5 = number_total_questions/100; 
//             //     display6 = number_total_questions%100/10;
//             //     display7 = number_total_questions%10;
//             //     display8 = digit_an;er
//     // output reg [5:0] count_type,
//     // output reg [4:0] count_number,
//     // output wire [3:0] Number_questions,
//     // output reg flag_type,
//     // output reg flag_problem_input_complete,
//     // output reg flag_problem_input_complete_tmp
//     // output wire [7:0] Machine_answer,
//     // output reg [3:0] Count_number_machine,
//     // output wire [7:0] Machine_answer_1,
//     // output wire [7:0] Machine_answer_2,
//     // output wire [7:0] Res
//     // output reg flag_start_stu,
//     // output reg [3:0] number_flash,
//     // output wire en_led,
//     // output reg [1:0] student_id,
//     // output reg [4:0] timer,
//     // output reg [7:0] winner,
//     // output wire [7:0] true_player1,
//     // output wire [7:0] true_player2,
//     // output wire [7:0] input_answer1,
//     // output wire [7:0] input_answer2
//     // output reg []
//     // output reg flag_check_over
// );
// // assign Timer = timer;
// // assign time1 = time_question[count_number][count_type][1];
// // assign input_answer1 = player_answer[count_number][count_type][1];
// // assign input_answer2 = player_answer[count_number][count_type][2];
// // assign true_player1 = total_true[1];
// // assign true_player2 = total_true[2];
// // assign  Number_questions = number_questions[count_type];
// // assign Machine_answer = machine_answer[count_number][count_type];
// // assign Machine_answer_1 = (!(|inputA[1][13])) ? 8'b00000001 : 8'b00000000;
// // assign Machine_answer_2 = machine_answer[0][14];
// // 竞赛状态定义
// localparam Idle = 19'b00000000000000000000; // 全0，表示初始状态
// localparam Admin_input_problem_number = 19'b00000000000000000001; // 第1位
// localparam Admin_input_problem_number_A = 19'b00000000000000000010; // 第2位
// localparam Admin_input_problem_number_B = 19'b00000000000000000100; // 第3位
// localparam Admin_input_student_number = 19'b00000000000000001000; // 第4位
// localparam Student_compitition = 19'b00000000000000010000; // 第5位
// localparam Student_compitition_show_light = 19'b00000000000000100000; // 第6位
// localparam Student_compitition_answer_input_wait = 19'b00000000000001000000; // 第7位
// localparam Student_compitition_answer_check = 19'b00000000000010000000; // 第8位
// localparam Result_show_output = 19'b00000000000100000000; // 第9位
// localparam Result_show_update = 19'b00000000001000000000; // 第10位
// localparam Review = 19'b00000000010000000000; // 第11位
// localparam Review_time_phase1 = 19'b00000000100000000000; // 第12位
// localparam Review_time_phase2 = 19'b00000001000000000000; // 第13位
// localparam Review_time_phase3 = 19'b00000010000000000000; // 第14位
// localparam Review_machine_answer_phase1 = 19'b00000100000000000000; // 第15位
// localparam Review_machine_answer_phase2 = 19'b00001000000000000000; // 第16位
// localparam Review_input_answer_phase1 = 19'b00010000000000000000; // 第17位
// localparam Review_input_answer_phase2 = 19'b00100000000000000000; // 第18位
// localparam Review_input_answer_phase3 = 19'b01000000000000000000; // 第19位
// localparam Student_compitition_show_light_initial_timer = 19'b10000000000000000000; // 第20位     


// // 存储题目
// reg [7:0] count_type = 8'd0;//总共14个
// reg [7:0] count_type_tmp = 8'd0;
// reg [7:0] count_number = 8'd0;
// reg [7:0] count_number_tmp = 8'd0;
// // reg flag_type = 1'b0;
// // reg en = 1'b1;
// // reg flag_number1 = 1'b0;
// // reg flag_number2 = 1'b0;
// reg flag_problem_input_complete = 1'b0;
// // reg flag_problem_input_complete_tmp = 1'b0;
// reg flag_subproblem_input_complete = 1'b0;
// // reg flag_subproblem_input_uncomplete = 1'b0;
// // reg flag_answer_input = 1'b0;
// // reg flag_student_number_input_complete = 1'b0;
// reg flag_competing = 1'b0;
// // reg flag_show_winner = 1'b0;
// // reg flag_get_result = 1'b0;
// // reg flag_start_flash = 1'b0;
// reg flag_result_ok = 1'b0;
// reg [19:0] state, next_state;
// // reg [19:0] pre_state = 19'd0;
// reg [3:0] number_questions[15:0];
// // reg [4:0] question_type[7:0];
// reg [7:0] student_number = 8'd4;
// reg [3:0] student_id = 2'd0;
// reg [3:0] student_id_tmp = 2'd0;
// reg [7:0] winner = 8'b00000000;
// reg [11:0] winner_time = 12'd0;
// reg [7:0] winner_true = 8'b00000000;
// reg [7:0] number_total_questions = 8'd0;
// reg [7:0] number_total_questions_tmp = 8'd0;
// reg [7:0] current_question=0;
// reg [3:0] current_player=0;
// reg [4:0] Timer;
// // reg [3:0] number_flash=0;

// (*ram_style = "block"*) reg [4:0] time_question[10:0][14:0][4:0];
// (*ram_style = "block"*) reg [11:0] total_time[4:0];
// (*ram_style = "block"*) reg [11:0] total_time_tmp[4:0];
// (*ram_style = "block"*) reg [7:0] total_true[4:0];
// (*ram_style = "block"*) reg [7:0] total_true_tmp[4:0];
// (*ram_style = "block"*) reg whether_input_answer[10:0][14:0][4:0];
// (*ram_style = "block"*) reg flag_whether_first_compitition = 1'b0;
// (*ram_style = "block"*) reg [7:0] player_answer[10:0][14:0][4:0];
// (*ram_style = "block"*) reg [7:0] machine_answer[10:0][14:0];
// (*ram_style = "block"*) reg [7:0] inputA[10:0][14:0];
// (*ram_style = "block"*) reg [7:0] inputB[10:0][14:0];
// (*ram_style = "block"*) reg question_true[10:0][14:0][4:0];
// reg [7:0] current_number = 8'b00000000;
// reg [7:0] current_number_tmp = 8'b00000000;
// (*ram_style = "block"*) reg [5:0] number2type[141:0];
// (*ram_style = "block"*) reg [7:0] number2count[141:0];

// // reg [4:0] time_question[14:0][4:0];
// // reg [11:0] total_time[4:0];
// // reg [7:0] total_true[4:0];
// // reg whether_input_answer[14:0][4:0];
// // reg flag_whether_first_compitition = 1'b0;
// // reg [7:0] player_answer[14:0][4:0];
// // reg [7:0] machine_answer[14:0];
// // reg [7:0] inputA[14:0];
// // reg [7:0] inputB[14:0];
// // reg question_true[14:0][4:0];
// // reg [26:0] counter;
// // reg [7:0] current_number = 8'b00000000;
// // reg [5:0] number2type[14:0];
// // reg [7:0] number2count[14:0];


// // operation state
// localparam arithmetic = 8'b00000001,
//            move_operation = 8'b00000010,
//            bit_operation = 8'b00000100,
//            logic_operation = 8'b00001000;
// // arithmetic state
// localparam add = 8'b00000001,
//            sub = 8'b00000010;
// // move state
// localparam left_arithmetic = 8'b00000001,
//            right_arithmetic = 8'b00000010,
//            left_logic = 8'b00000100,
//            right_logic = 8'b00001000;
// // bit state
// localparam And = 8'b00000001,
//            Or = 8'b00000010,
//            Not = 8'b00000100,
//            Xor = 8'b00001000;
// // logic state
// localparam logic_and = 8'b00000001,
//            logic_or = 8'b00000010,
//            logic_not = 8'b00000100,
//            logic_xor = 8'b00001000; 
// localparam digit_an = 8'd17,
//             digit_minue = 8'd16;
// reg [7:0] problem_typeA,problem_typeB,inputa,inputb;
// wire [7:0] Res;
// localparam check_time = 8'b00000001,
//     check_answer = 8'b00000010,
//     check_input = 8'b00000100;
// // reg [7:0] review_module;
// reg [7:0] check_id;
// reg [7:0] check_number = 8'b00000000;
// // reg flag_check_number = 1'b0;
// // reg flag_module=1'b0;
// reg flag_check_id = 1'b0;
// // reg [3:0] Count_number_machine = 4'd0;
// calc_module_45 get_number(
//     .typea(problem_typeA),
//     .typeb(problem_typeB),
//     .a(inputa),
//     .b(inputb),
//     .result(Res)
// );

// // reg flag_start_timer = 1'b0;
// // reg flag_stop_timer = 1'b0;
// // reg flag_start_stu = 1'b0;
// reg flag_check_over = 1'b0;
// // wire [7:0] Timer;
// // reg [7:0] TIMER = 8'b00000000;
// reg reset_n = 1'b1;
// wire en_led;
// wire [7:0] timer ;
// timer_module get_time(
//     .clk(clk),
//     .reset_n(reset_n),
//     .timer(timer),
//     .en_led(en_led)
// );
// // wire [4:0] Timer ;
// // assign Timer = timer;
// // 时序逻辑：在时钟边沿更新状态和输出
// always @(posedge clk or posedge reset) begin
//     if (reset) begin
//         state <= Idle;
//     end else begin
//         state <= next_state;
//     end
// end

// reg flag_admin_input_problem_B = 1'b0;
// reg flag_admin_input_problem_initial = 1'b0;
// reg flag_student_compitition_initial = 1'b0;
// reg flag_student_compitition = 1'b0;
// reg flag_student_compitition_show_light_initial_timer = 1'b0;
// reg flag_student_compitition_show_answer_initial_timer = 1'b0;
// reg flag_review_time_phase3 = 1'b0;
// reg flag_result_show_output = 1'b0;
// reg flag_next_question = 1'b0;
// // 组合逻辑：计算下一个状态和临时变量
// always @(*) begin
//     case (state)
//         Idle: begin
//             if(input_complete && !(user_input ^ 8'b00000001)) begin
//                 next_state = Admin_input_problem_number;
//             end else if (input_complete && !(user_input ^ 8'b00000010)) begin
//                 next_state = Admin_input_student_number;
//             end else if (input_complete && (user_input == 8'b00000100) ) begin
//                 next_state = Student_compitition;
//             end else if(input_complete && (user_input == 8'b00001000)) begin
//                 next_state = Result_show_output;
//             end else begin
//                 next_state = Idle;
//             end
//         end
//         // Admin_input_problem_initial: begin
//         //     next_state = flag_admin_input_problem_initial ? Admin_input_problem : Admin_input_problem_initial;
//         // end
//         // Admin_input_problem: begin
//         //     next_state = input_complete ? ( Admin_input_problem_number) : (flag_problem_input_complete ? Idle : Admin_input_problem);
//         // end
//         Admin_input_problem_number: begin
//             next_state = input_complete ? Admin_input_problem_number_A : Admin_input_problem_number;
//         end
//         Admin_input_problem_number_A: begin
//             next_state = input_complete ? Admin_input_problem_number_B : Admin_input_problem_number_A;
//         end
//         Admin_input_problem_number_B: begin
//             if (flag_problem_input_complete) begin
//                 next_state = Idle;
//             end else if (input_complete)begin
//                 if(flag_subproblem_input_complete) begin
//                     next_state = Admin_input_problem_number;
//                 end else begin
//                     next_state = Admin_input_problem_number_A;
//                 end
//             end else begin
//                 next_state = Admin_input_problem_number_B;
//             end
//             // if (flag_admin_input_problem_B) begin 
//             //     next_state = (flag_subproblem_input_complete) ? Admin_input_problem : Admin_input_problem_number;
//             // end else begin
//             //     next_state = Admin_input_problem_number_B;
//             // end
//         end
//         Admin_input_student_number: begin
//             next_state = input_complete ? Idle: Admin_input_student_number;
//         end
//         // Admin_input_student_number_phase1: begin
//         //     next_state = input_complete ? Admin_input_student_number_phase2 : Admin_input_student_number_phase1;
//         // end
//         // Admin_input_student_number_phase2: begin
//         //     next_state = flag_student_number_input_complete ? Idle : Admin_input_student_number_phase2;
//         // end
//         // Student_compitition_initial: begin
//         //     next_state = flag_student_compitition_initial ? Student_compitition : Student_compitition_initial;
//         // end
//         Student_compitition: begin
//             next_state = flag_student_compitition ? Student_compitition_show_light : Student_compitition;
//         end 
//         //TODO 看效果，也可以改成先亮后暗
//         // Student_compitition_show_an: begin
//         //     next_state = en_led ? Student_compitition_show_light : Student_compitition_show_an;
//         // end
//         // Student_compitition_show_light: begin
//         //     if (number_flash==4'd8) begin 
//         //         next_state = Student_compitition_show_light_initial_timer;
//         //     end else begin
//         //         next_state = en_led ? Student_compitition_show_light : Student_compitition_show_an;
//         //     end
//         // end
//         Student_compitition_show_light: begin
//             if (timer==8'd6) begin 
//                 next_state = Student_compitition_show_light_initial_timer;
//             end else begin
//                 next_state = Student_compitition_show_light;
//             end
//         end
//         Student_compitition_show_light_initial_timer: begin
//             next_state = flag_student_compitition_show_light_initial_timer ? Student_compitition_answer_input_wait : Student_compitition_show_light_initial_timer;
//         end
//         Student_compitition_answer_input_wait: begin
//             if ((!(timer ^ 8'd20)) || input_complete) begin
//                 next_state = Student_compitition_answer_check;
//             end else begin 
//                 next_state = Student_compitition_answer_input_wait;
//             end
//         end
//         // Student_compitition_answer_input_initial_timer : begin 
//         //     next_state = flag_student_compitition_show_answer_initial_timer ? Student_compitition_answer_check : Student_compitition_answer_input_initial_timer;
//         // end
//         // Student_compitition_answer_input_phase2: begin
//         //     if (input_complete) begin 
//         //         next_state = Student_compitition_answer_input_phase_to_3;
//         //     end else begin
//         //         next_state = en_led ? Student_compitition_answer_input_wait : Student_compitition_answer_input_phase2;
//         //     end
//         // end
//         // Student_compitition_answer_input_phase_to_3: begin
//         //     next_state = Student_compitition_answer_input_phase3 ;
//         // end
//         // Student_compitition_answer_input_phase3: begin
//         //     next_state = Student_compitition_answer_check ;
//         // end
//         Student_compitition_answer_check: begin
//             if (flag_next_question) begin
//                 next_state = Student_compitition_show_light;
//             end else if (flag_competing) begin
//                 next_state = Idle;
//             end
//             next_state = Student_compitition;
//         end
//         // Result_show_initial: begin
//         //     next_state = (winner == 8'b00000001) ? Result_show_output : Result_show_initial;
//         // end
//         Result_show_output: begin
//             if (flag_result_show_output) begin
//                 next_state = flag_result_ok ? Review : Result_show_update;
//             end else begin
//                 next_state = Result_show_output;
//             end
//         end
//         Result_show_update: begin
//             next_state = input_complete ? Result_show_output : Result_show_update;
//         end
//         Review: begin
//             if (input_quit) begin
//                 next_state = Idle;
//             end else  if (input_complete) begin
//                 case (user_input)
//                     check_time: begin
//                         next_state = Review_time_phase1;
//                     end
//                     check_answer: begin
//                         next_state = Review_machine_answer_phase1;
//                     end
//                     check_input: begin
//                         next_state = Review_input_answer_phase1;
//                     end
//                     default: next_state = next_state;
//                 endcase
//             end else begin
//                 next_state = Review;
//             end
//         end
//         Review_time_phase1: begin
//             next_state = (input_complete) ? Review_time_phase2 : Review_time_phase1;
//         end
//         // Review_time_phase2: begin
//         //     next_state = (input_complete) ? Review_time_phase3 : Review_time_phase2;
//         // end
//         Review_time_phase2: begin
//             next_state = (input_complete) ? ((flag_check_over)? Review : Review_time_phase3) : Review_time_phase2;
//         end
//         Review_time_phase3: begin
//             next_state = (flag_review_time_phase3) ? Review_time_phase2 : Review_time_phase3;
//         end
//         Review_machine_answer_phase1: begin
//             next_state = (input_complete) ? Review_machine_answer_phase2 : Review_machine_answer_phase1;
//         end
//         Review_machine_answer_phase2: begin
//             next_state = (input_complete) ? Review : Review_machine_answer_phase2;
//         end
//         // Review_machine_answer_phase3: begin
//         //     next_state = (input_complete) ? Review : Review_machine_answer_phase3;
//         // end
//         Review_input_answer_phase1: begin
//             next_state = (input_complete) ? Review_input_answer_phase2 : Review_input_answer_phase1;
//         end
//         Review_input_answer_phase2: begin
//             next_state = (input_complete) ? Review_input_answer_phase3 : Review_input_answer_phase2;
//         end
//         Review_input_answer_phase3: begin
//             next_state = (input_complete) ? Review : Review_input_answer_phase3;
//         end
//         // Review_input_answer_phase4: begin
//         //     next_state = (input_complete) ? Review : Review_input_answer_phase4;
//         // end
//         default: next_state = next_state;

//     endcase
// end


// always @(state) begin
//     case (state)
//         Idle: begin
//             reset_n = 1'b1;
//             count_number_tmp = 8'd0;
//             count_type_tmp = 8'd0;
//             flag_competing = 1'b0;
//             // Count_number_machine = 4'd0;
//             flag_problem_input_complete = 1'b0;
//             // flag_problem_input_complete_tmp = 1'b0;
//             flag_whether_first_compitition = 1'b0;
//             flag_admin_input_problem_initial = 1'b1;
//             current_number_tmp = 8'b00000000;
//             student_id_tmp = 2'd0;
//             flag_student_compitition = 1'b0;
//             // current_player = 3'd0;
//             winner_time = total_time[0];
//             winner_true = total_true[0];
//             winner = 8'b00000000;
//             flag_result_ok = 1'b0;
//             flag_result_ok = 1'b0;
//             flag_result_show_output = 1'b0;
//             flag_student_compitition_show_light_initial_timer = 1'b0;
//             flag_next_question = 1'b0;
//             display1 = digit_an;
//             display2 = digit_an;
//             display3 = digit_an;
//             display4 = 8'd4;
//             display5 = digit_an;
//             display6 = digit_an;
//             display7 = digit_an;
//             display8 = digit_an;
//             number_total_questions_tmp = 8'd0;
//             // if (!(flag_whether_first_compitition ^ 1'b0)) begin
//             //     flag_whether_first_compitition = 1'b1;
//             //     student_id = 3'd1;
//             // end else begin 
//             //     student_id = student_id + 1;
//             // end
//         end            
//         Admin_input_problem_number: begin 
//             flag_subproblem_input_complete = 1'b0;
//             count_type = count_type_tmp;
//             count_number = count_number_tmp;
//             number_questions[count_type] = user_input;
//             led1 = count_type;
//             led2 = count_number;
//             display1 = (count_type+1)/10;
//             display2 = (count_type+1)%10;
//             display3 = digit_an;
//             display4 = digit_an;
//             display5 = digit_an;
//             display6 = digit_an;
//             display7 = digit_an;
//             display8 = count_type_tmp;
//             number_total_questions = number_total_questions_tmp + user_input;
//             display7 = number_total_questions;
//             // flag_admin_input_problem_initial = 1'b0;
//             // flag_admin_input_problem_B = 1'b0;
//             // count_type = count_type + 1;
//             // flag_type = 1'b0;
//             // count_number = 4'd0;
//             // if (flag_problem_input_complete_tmp) begin
//             //     flag_problem_input_complete = 1'b1;
//             // end
//         end
//         Admin_input_problem_number_A: begin
//             inputA[count_number][count_type] = user_input;
//             number_total_questions_tmp = number_total_questions;
//             inputa = user_input;
//             led1 = user_input;
//             current_number = current_number_tmp;
//             number2count[current_number] = count_number;
//             number2type[current_number] = count_type;
//             display1 = (count_type+1)/10;
//             display2 = (count_type+1)%10;
//             display3 = 8'd1;
//             display4 = digit_an;
//             display5 = digit_an;
//             display6 = digit_an;
//             display7 = number_total_questions;
//             display8 = digit_an;
//             case (count_type + 1)
//                     8'd1: begin 
//                         problem_typeA = arithmetic;
//                         problem_typeB = add;
//                     end
//                     8'd2: begin
//                         problem_typeA = arithmetic;
//                         problem_typeB =sub;
//                     end
//                     8'd3: begin
//                         problem_typeA = move_operation;
//                         problem_typeB = left_arithmetic;
//                     end
//                     8'd4: begin
//                         problem_typeA = move_operation;
//                         problem_typeB = right_arithmetic;
//                     end
//                     8'd5: begin
//                         problem_typeA = move_operation;
//                         problem_typeB = left_logic;
//                     end
//                     8'd6: begin
//                         problem_typeA = move_operation;
//                         problem_typeB = right_logic;
//                     end
//                     8'd7: begin
//                         problem_typeA = bit_operation;
//                         problem_typeB = And;
//                     end
//                     8'd8: begin 
//                         problem_typeA = bit_operation;
//                         problem_typeB = Or;
//                     end
//                     8'd9: begin
//                         problem_typeA = bit_operation;
//                         problem_typeB = Not;
//                     end
//                     8'd10: begin
//                         problem_typeA = bit_operation;
//                         problem_typeB = Xor;
//                     end 
//                     8'd11: begin
//                         problem_typeA = logic_operation;
//                         problem_typeB = logic_and;
//                     end
//                     8'd12: begin
//                         problem_typeA = logic_operation;
//                         problem_typeB = logic_or;
//                     end
//                     8'd13: begin
//                         problem_typeA = logic_operation;
//                         problem_typeB = logic_not;
//                     end
//                     8'd14: begin
//                         problem_typeA = logic_operation;
//                         problem_typeB = logic_xor;
//                     end 
//                         default: problem_typeA = 8'b00000000;
//                 endcase
//             // flag_subproblem_input_complete = 1'b0;
//             // flag_problem_input_complete_tmp = 1'b0;
//             // flag_admin_input_problem_initial = 1'b0;
//             // flag_admin_input_problem_B = 1'b0;
//             // count_type = count_type + 1;
//             // flag_type = 1'b0;
//             // count_number = 4'd0;
//             // if (flag_problem_input_complete_tmp) begin
//                 // flag_problem_input_complete = 1'b1;
//             // end
//         end
//         Admin_input_problem_number_B: begin 
//             display1 = (count_type+1)/10;
//             display2 = (count_type+1)%10;
//             display3 = 8'd2;
//             display4 = digit_an;
//             display5 = digit_an;
//             display6 = digit_an;
//             display7 = digit_an;
//             display8 = digit_an;
//             inputB[count_number][count_type] = user_input;
//             inputb = user_input;
//             led1 = user_input;
//             machine_answer[count_number][count_type] = Res;
//             // led1 = user_input;
//             if (count_number < number_questions[count_type]-1) begin
//                 count_number_tmp = count_number + 1;
//                 // current_number_tmp = current_number + 1;
//             end else begin
//                 if (count_type == 8'd13) begin
//                     flag_problem_input_complete = 1'b1;
//                     display4 = 8'd4;
//                 end else begin
//                     count_number_tmp = 8'd0;
//                     count_type_tmp = count_type + 1;
//                     // current_number_tmp = current_number + 1;
//                     display8 = 8'd5;
//                     display7 = count_type_tmp;
//                     flag_subproblem_input_complete = 1'b1;
//                 end
//             end
//             display6 = count_type_tmp;
//             // led1 = number_questions[count_type];
//             // led2 = count_type_tmp;
//             // flag_problem_input_complete_tmp = 1'b0;
//             // flag_admin_input_problem_initial = 1'b0;
//             // flag_admin_input_problem_B = 1'b0;
//             // count_type = count_type + 1;
//             // flag_type = 1'b0;
//             // count_number = 4'd0;
//             // if (flag_subproblem_input_complete) begin
//                 // flag_problem_input_complete_tmp = 1'b1;
//             // end
//         end
//         Admin_input_student_number: begin 
//             student_number = user_input;
//             // flag_student_number_input_complete = 1'b1;
//             // flag_competing = 1'b1;
//         end
//         Student_compitition: begin
//             student_id = student_id_tmp;
//             total_true[student_id] = 8'b00000000;
//             count_number = count_number_tmp;
//             count_type = count_type_tmp;
//             current_question = 8'd0;
//             flag_competing = 1'b1;
//             // en = 1'b1;
//             flag_result_ok = 1'b0;
//             flag_student_compitition = 1'b1;
//             // flag_student_compitition = 1'b1;
//             // flag_student_compitition_initial = 1'b0;
//             // flag_student_compitition_show_light_initial_timer = 1'b0;
//             // flag_student_compitition_show_answer_initial_timer = 1'b0;
//             // flag_review_time_phase4 = 1'b0;
//             // flag_result_show_output = 1'b0;
//             // flag_result_ok = 1'b0;
//             // flag_check_over = 1'b0;
//             // flag_check_id = 1'b0;
//             // flag_check_number
//         end
//         Student_compitition_show_light: begin
//             flag_next_question = 1'b0;
//             reset_n = 1'b0;
//             if (!en_led) begin 
//                 display1 = digit_an;
//                 display2 = digit_an;
//                 display3 = digit_an;
//                 display4 = digit_an;
//                 display5 = digit_an;
//                 display6 = digit_an;
//                 display7 = digit_an;
//                 display8 = digit_an;
//                 led1 = inputA[count_number][count_type]; // 在LED上显示题目
//                 led2 = inputB[count_number][count_type]; // 在LED上显示题目
//                 // machine_answer[number_questions[count_type]][count_type] = machine_answer[0][count_type+1];
//                 // number_flash = number_flash + 1;
//             end else begin
//                 // number_flash = number_flash + 1;
//                 display1 = current_question/100;
//                 display2 = current_question%100/10;
//                 display3 = current_question%10;
//                 display4 = digit_an;
//                 display5 = number_total_questions/100; 
//                 display6 = number_total_questions%100/10;
//                 display7 = number_total_questions%10;
//                 display8 = digit_an;
//             end
//         end
//         Student_compitition_show_light_initial_timer: begin
//             reset_n = 1'b1;
//             flag_student_compitition_show_light_initial_timer = 1'b1;
//         end
//         Student_compitition_answer_input_wait: begin
//             reset_n = 1'b0;
//             flag_student_compitition_show_light_initial_timer = 1'b0;
//             display1 = current_question/100;
//             display2 = current_question%100/10;
//             display3 = current_question%10;
//             display4 = number_total_questions/100; 
//             display5 = number_total_questions%100/10;
//             display6 = number_total_questions%10;
//             display7 = timer/10;
//             display8 = timer%10;
//             player_answer[count_number][count_type][student_id] = user_input;
//             total_time_tmp[student_id] = total_time[student_id] + timer;
//             Timer = timer;
//         end
//         Student_compitition_answer_check:begin
//             reset_n = 1'b1;
//             total_time[student_id] = total_time_tmp[student_id];
//             time_question[count_number][count_type][student_id] = timer;
//             if (!(Timer^4'd20))  begin
//                 whether_input_answer[count_number][count_type][student_id] = 1'b0;
//                 question_true[count_number][count_type][student_id] = 1'b0;
//             end else begin
//                 whether_input_answer[count_number][count_type][student_id] = 1'b1;
//                 if (!(player_answer[count_number][count_type][student_id] ^ machine_answer[count_number][count_type])) begin
//                     question_true[count_number][count_type][student_id] = 1'b1;
//                     total_true_tmp[student_id] = total_true[student_id] + 1;
//                 end else begin
//                     question_true[count_number][count_type][student_id] = 1'b0;
//                 end
//             end
//             if (count_number < number_questions[count_type]-1) begin
//                 count_number_tmp = count_number + 1;
//                 flag_next_question = 1'b1;
//             end else begin
//                 if (count_type < 8'd13) begin
//                     count_number_tmp = 4'd0;
//                     count_type_tmp = count_type + 1;
//                     flag_next_question = 1'b1;
//                 end else if (student_id < student_number -1) begin
//                     count_number_tmp = 4'd0;
//                     count_type_tmp = 8'd0;
//                     student_id_tmp = student_id + 1;
//                     flag_next_question = 1'b1;
//                 end else begin
//                     flag_competing = 1'b1;
//                 end
//             end
//         end
//         Result_show_output: begin
//             student_id = student_id_tmp;
//             if (student_id < student_number) begin
//                 display1 = total_true[student_id]/100;
//                 display2 = total_true[student_id]%100/10;
//                 display3 = total_true[student_id]%10;
//                 display4 = digit_an;
//                 display5 = total_time[student_id]/1000;
//                 display6 = total_time[student_id]%1000/100;
//                 display7 = total_time[student_id]%100/10;
//                 display8 = total_time[student_id]%10;
//                 if (total_true[student_id] > winner_true) begin
//                     winner = student_id;
//                     winner_time = total_time[student_id];
//                     winner_true = total_true[student_id];
//                 end else if (!(total_true[student_id] ^ winner_true) && total_time[student_id] < winner_time) begin
//                     winner = student_id;
//                     winner_time = total_time[student_id];
//                     winner_true = total_true[student_id];
//                 end
//             end else begin
//                 display1 = winner;
//                 display2 = digit_an;
//                 display3 = digit_an;
//                 display4 = digit_an;
//                 display5 = digit_an;
//                 display6 = digit_an;
//                 display7 = digit_an;
//                 display8 = digit_an;

//                 flag_result_ok = 1'b1;
//             end
//             flag_result_show_output = 1'b1;
//         end
//         Result_show_update: begin
//             flag_result_show_output = 1'b0;
//             student_id_tmp = student_id + 1;
//         end
//         Review: begin
//             flag_check_over = 1'b0;
//             flag_result_show_output = 1'b0;
//         end
//         Review_time_phase1: begin
//             current_player = user_input;
//             count_number_tmp = 4'd0;
//             count_type_tmp = 8'd0;
//         end
//         Review_time_phase2: begin
//             flag_review_time_phase3 = 1'b0;
//             count_number = count_number_tmp;
//             count_type = count_type_tmp;
//             if(count_number < number_questions[count_type]) begin
//                 display1 = count_number/10;
//                 display2 = count_number%10;
//                 display3 = digit_an;
//                 display4 = digit_an;
//                 display5 = time_question[count_number][count_type][current_player]/1000;
//                 display6 = time_question[count_number][count_type][current_player]%1000/100;
//                 display7 = time_question[count_number][count_type][current_player]%100/10;
//                 display8 = time_question[count_number][count_type][current_player]%10;
//             end else begin
//                 if(!(count_type ^ 8'd13) && count_number > number_questions[count_type]) begin
//                 // if(count_type == 8'd3 && count_number > number_questions[count_type]) begin
//                     display1 = current_player;
//                     display2 = digit_an;
//                     display3 = digit_an;
//                     display4 = digit_an;
//                     display5 = total_time[current_player]/1000;
//                     display6 = total_time[current_player]%1000/100;
//                     display7 = total_time[current_player]%100/10;
//                     display8 = total_time[current_player]%10;
//                     flag_check_over = 1'b1;
//                 end
//             end
//         end
//         Review_time_phase3: begin
//             if(count_number < number_questions[count_type]-1) begin
//                 count_number_tmp = count_number + 1;
//             end else if(!(count_type ^ 8'd13)) begin
//             // end else if(count_type == 8'd3) begin
//                 count_number_tmp = count_number + 1;
//             end else begin
//                 count_type_tmp = count_type + 1;
//                 count_number_tmp = 4'd0;
//             end
//             flag_review_time_phase3 = 1'b1;
//         end
//         Review_machine_answer_phase1: begin
//             check_number = user_input-1;
//         end
//         Review_machine_answer_phase2: begin
//             display1 = number2type[check_number]/10;
//             display2 = number2type[check_number]%10;
//             display3 = digit_an;
//             display4 = digit_an;
//             //TODO 特盘状态2
//             if (!(machine_answer[number2count[check_number]][number2type[check_number]][7] ^ 1'b1) && (((number2type[check_number] ^ 6'd0) && (number2type[check_number] ^ 6'd1)))) begin
//                 display5 = digit_minue;
//             end else begin 
//                 display5 = digit_an;
//             end
//             display6 = machine_answer[number2count[check_number]][number2type[check_number]]/100;
//             display7 = machine_answer[number2count[check_number]][number2type[check_number]]%100/10;
//             display8 = machine_answer[number2count[check_number]][number2type[check_number]]%10;
//             led1 = inputA[number2count[check_number]][number2type[check_number]];
//             led2 = inputB[number2count[check_number]][number2type[check_number]];
//         end
//         Review_input_answer_phase1: begin
//             check_id = user_input-1;
//         end
//         Review_input_answer_phase2: begin
//             check_number = user_input-1;
//         end
//         Review_input_answer_phase3: begin
//             led1 = player_answer[number2count[check_number]][number2type[check_number]][check_id];
//             // led2 = (question_true[number2count[check_number]][number2type[check_number]][check_id])? 8'b00000001 : 8'b00000010;
//             display1 = digit_an;
//             display2 = digit_an;
//             display3 = digit_an;
//             display4 = digit_an;
//             display5 = digit_an;
//             display6 = digit_an;
//             display7 = digit_an;
//             display8 = (question_true[number2count[check_number]][number2type[check_number]][check_id])? 8'b00000001 : 8'b00000010;
//         end
//         default: begin
//         end

//     endcase
// end




// reg [7:0] display1,display2,display3,display4,display5,display6,display7,display8;
// reg [7:0] segment_choosing;
// parameter max_cnt=50000;
// reg div_clk=0;
// reg[18:0] divclk_cnt = 0;
// always@(posedge clk)
//     begin
//         if(divclk_cnt==max_cnt)
//         begin
//             div_clk=~div_clk;
//             divclk_cnt=0;
//         end
//         else
//         begin
//             divclk_cnt=divclk_cnt+1'b1;
//         end
//     end
// always @(posedge div_clk or negedge reset) begin
//     if (reset) begin
//         segment_choosing<= 2'b00;
//     end else begin
//         if (segment_choosing >= 2'b11) begin
//           segment_choosing<=2'b00;
//         end
//         else begin
//           segment_choosing <= segment_choosing +1;
//         end
//         case (segment_choosing)
//         (2'b00):begin
//             segment_0<=display8_seg;
//             segment_1<=display4_seg;
//             seg_0<=1;
//             seg_1<=0;
//             seg_3<=0;
//             seg_4<=1;
//             seg_5<=0;
//             seg_6<=0;
//             seg_7<=0;
//         end

//         (2'b01):begin
//             segment_0<=display7_seg;
//             segment_1<=display3_seg;
//             seg_0<=0;
//             seg_1<=1;
//             seg_2<=0;
//             seg_3<=0;
//             seg_4<=0;
//             seg_5<=1;
//             seg_6<=0;
//             seg_7<=0;
//         end

//         (2'b10):begin
//             segment_0<=display6_seg;
//             segment_1<=display2_seg;
//             seg_1<=0;
//             seg_2<=1;
//             seg_3<=0;
//             seg_4<=0;
//             seg_5<=0;
//             seg_6<=1;
//             seg_7<=0;
//         end

//         (2'b11):begin
//             segment_0=display5_seg;
//             segment_1=display1_seg;
//             seg_0<=0;
//             seg_1<=0;
//             seg_2<=0;
//             seg_3<=1;
//             seg_4<=0;
//             seg_5<=0;
//             seg_7<=1;
//             seg_6<=0;
//         end

//         default begin
//           segment_0<=8'b00111111;
//           segment_1<=8'b00111111;
//         end   
//         endcase
//     end
// end
// wire [7:0] display1_seg;
// wire [7:0] display2_seg;
// wire [7:0] display3_seg;
// wire [7:0] display4_seg;
// wire [7:0] display5_seg;
// wire [7:0] display6_seg;
// wire [7:0] display7_seg;
// wire [7:0] display8_seg;
// wire input_complete;
// wire input_quit;
// wire debounced_btn_1;
// wire debounced_btn_2;
// seg_decoder_8 u1_seg_decoder_8(
//         .digit(display1),
//         .seg(display1_seg)
//     );
//     seg_decoder_8 u2_seg_decoder_8(
//         .digit(display2),
//         .seg(display2_seg)
//     );
//     seg_decoder_8 u3_seg_decoder_8(
//         .digit(display3),
//         .seg(display3_seg)
//     );
//     seg_decoder_8 u4_seg_decoder_8(
//         .digit(display4),
//         .seg(display4_seg)
//     );
//     seg_decoder_8 u5_seg_decoder_8(
//         .digit(display5),
//         .seg(display5_seg)
//     );
//     seg_decoder_8 u6_seg_decoder_8(
//         .digit(display6),
//         .seg(display6_seg)
//     );
//     seg_decoder_8 u7_seg_decoder_8(
//         .digit(display7),
//         .seg(display7_seg)
//     );
//     seg_decoder_8 u8_seg_decoder_8(
//         .digit(display8),
//         .seg(display8_seg)
//     );
//     debounce u1_debounce (
//         .clk(clk),
//         .reset(reset),
//         .debounced_btn(debounced_btn_1),
//         .btn_in(button_1),
//         .confirm_stable(input_complete)
//     );

//     debounce u2_debounce (
//         .clk(clk),
//         .reset(reset),
//         .debounced_btn(debounced_btn_2),
//         .btn_in(button_2),
//         .confirm_stable(input_quit)
//     );


// endmodule
// // // always @(input_complete,flag_problem_input_complete,flag_studnet_number_input_complete) begin
// // //     case (state)
// // //         Idle: begin
// // //             if (input_complete && admin_user) begin
// // //                 next_state <= Admin_input_problem;
// // //                 flag_problem_input_complete <= 1'b0;
// // //                 flag_type <= 1'b0;
// // //                 flag_number1 <= 1'b0;
// // //                 flag_number2 <= 1'b0;
// // //                 flag_get_result <= 1'b0;
// // //                 count_type <= 8'd0;
// // //                 count_number <= 4'd0;
// // //             end else begin
// // //                 if (input_complete && stu_number) begin
// // //                     next_state <= Admin_input_student_number;
// // //                     flag_studnet_number_input_complete <= 1'b0;
// // //                 end else begin
// // //                     if (input_complete && flag_competing && student_id != student_number) begin
// // //                         next_state <= Student_ans;
// // //                         student_id <= student_id + 1;
// // //                         flag_competing <= 1'b0;
// // //                         number_flash <= 0;
// // //                         count_number <= 4'd0;
// // //                         count_type <= 8'd0;
// // //                         flag_start_timer <= 1'b0;
// // //                         flag_stop_timer <= 1'b0;
// // //                     end else if (student_id == student_number)begin
// // //                         next_state <= Result;     
// // //                         student_id <= 0;
// // //                         flag_result_ok <= 1'b0;
// // //                         flag_show_winner <= 1'b0;
// // //                     end else begin
// // //                         next_state <= Idle;
// // //                     end
// // //                 end
// // //             end
// // //         end
// // //         Admin_input_problem: 
// // //             next_state <= flag_problem_input_complete ? Idle : Admin_input_problem;
// // //         Admin_input_student_number: 
// // //             next_state <= flag_studnet_number_input_complete ? Idle : Admin_input_student_number;
// // //         Student_ans: 
// // //             next_state <= flag_competing ? Idle : Student_ans;
// // //         Result: 
// // //             next_state <= (flag_result_ok) ? Review : Result;
// // //         Review: 
// // //             next_state <= (input_quit) ? Idle : Review; // 复核后返回到IDLE状态
// // //         default: 
// // //             next_state <= Idle;
// // //     endcase
// // // end

// // // 控制逻辑：根据当前状态控制输出
// // // always @(*) begin
// // //     case (state)
// // //         Idle: begin
// // //         end
// // //         Admin_input_problem: begin
// // //             if(input_complete) begin
// // //                 if(flag_type == 1'b0) begin
// // //                     number_questions[count_type] <= user_input; 
// // //                     flag_type <= 1'b1;
// // //                     count_number <= 4'd0;
// // //                     number_total_questions <= number_total_questions + user_input;
// // //                 end  else if(flag_type == 1'b1) begin
// // //                     if (flag_number1 == 1'b0) begin
// // //                         inputA[count_number][count_type] <= user_input;
// // //                         inputa <= user_input;
// // //                         flag_number1 <= 1'b1; 
// // //                         current_number <= current_number + 1;
// // //                     end else begin
// // //                         if (flag_number2 == 1'b0) begin
// // //                             inputB[count_number][count_type] <= user_input;
// // //                             inputb <= user_input;
// // //                             number2count[current_number] <= count_number;
// // //                             number2type[current_number] <= count_type;
// // //                             case (count_type)
// // //                                 8'd0: begin 
// // //                                     problem_typeA <= arithmetic;
// // //                                     problem_typeB <= add;
// // //                                 end
// // //                                 8'd1: begin
// // //                                     problem_typeA <= arithmetic;
// // //                                     problem_typeB <=sub;
// // //                                 end
// // //                                 8'd2: begin
// // //                                     problem_typeA <= move_operation;
// // //                                     problem_typeB <= left_arithmetic;
// // //                                 end
// // //                                 8'd3: begin
// // //                                     problem_typeA <= move_operation;
// // //                                     problem_typeB <= right_arithmetic;
// // //                                 end
// // //                                 8'd4: begin
// // //                                     problem_typeA <= move_operation;
// // //                                     problem_typeB <= left_logic;
// // //                                 end
// // //                                 8'd5: begin
// // //                                     problem_typeA <= move_operation;
// // //                                     problem_typeB <= right_logic;
// // //                                 end
// // //                                 8'd6: begin
// // //                                     problem_typeA <= bit_operation;
// // //                                     problem_typeB <= And;
// // //                                 end
// // //                                 8'd7: begin 
// // //                                     problem_typeA <= bit_operation;
// // //                                     problem_typeB <= Or;
// // //                                 end
// // //                                 8'd8: begin
// // //                                     problem_typeA <= bit_operation;
// // //                                     problem_typeB <= Not;
// // //                                 end
// // //                                 8'd9: begin
// // //                                     problem_typeA <= bit_operation;
// // //                                     problem_typeB <= Xor;
// // //                                 end 
// // //                                 8'd10: begin
// // //                                     problem_typeA <= logic_operation;
// // //                                     problem_typeB <= logic_and;
// // //                                 end
// // //                                 8'd11: begin
// // //                                     problem_typeA <= logic_operation;
// // //                                     problem_typeB <= logic_or;
// // //                                 end
// // //                                 8'd12: begin
// // //                                     problem_typeA <= logic_operation;
// // //                                     problem_typeB <= logic_not;
// // //                                 end
// // //                                 8'd13: begin
// // //                                     problem_typeA <= logic_operation;
// // //                                     problem_typeB <= logic_xor;
// // //                                 end 
// // //                                 default: problem_typeA <= 8'b00000000;
// // //                             endcase
// // //                             flag_number2 <= 1'b1;
// // //                             flag_get_result <= 1'b1;
// // //                         end else begin
// // //                             if(flag_get_result) begin
// // //                                 machine_answer[count_number][count_type]<= Res;
// // //                                 flag_get_result <= 1'b0;
// // //                             end else begin
// // //                                 if (count_number < number_questions[count_type]) begin
// // //                                     flag_number1 <= 1'b0;
// // //                                     flag_number2 <= 1'b0;
// // //                                     count_number <= count_number + 1;
// // //                                 end else begin
// // //                                     if (count_type == 8'd14) begin
// // //                                         flag_problem_input_complete <= 1'b1;
// // //                                     end else begin
// // //                                         count_number <= 4'd0;
// // //                                         count_type <= count_type + 1;
// // //                                         flag_type <= 1'b0;
// // //                                     end
// // //                                 end
// // //                             end
// // //                         end
// // //                     end
// // //                 end
// // //             end
// // //         end
// // //         Admin_input_student_number: begin
// // //             if(input_complete) begin
// // //                 student_number <= user_input;
// // //                 flag_studnet_number_input_complete <= 1'b1;
// // //                 flag_competing <= 1'b1;
// // //             end
// // //         end
// // //         Student_ans: begin
// // //             if (input_complete) begin
// // //                 flag_competing <= 1'b1;
// // //             end
// // //             // 显示当前题目编号和题目
// // //             //闪烁三次
// // //             // if(flag_start_timer==0) begin
// // //             //     flag_start_timer <= 1'b1;
// // //             //     TIMER = 8'b00000000;
// // //             // end else begin 
// // //             //     if (number_flash < 6) begin
// // //             //         if (Timer != TIMER) begin // 0.5秒
// // //             //             TIMER <= Timer;
// // //             //             en_led <= ~en_led; // 每1秒翻转一次LED状态
// // //             //             number_flash <= number_flash + 1;
// // //             //         end
// // //             //         display1 <= current_question/100;
// // //             //         display2 <= current_question%100/10;
// // //             //         display3 <= current_question%10;
// // //             //         display5 <= number_total_questions/100; 
// // //             //         display6 <= number_total_questions%100/10;
// // //             //         display7 <= number_total_questions%10;
// // //             //         led1 <= inputA[count_number][count_type]; // 在LED上显示题目
// // //             //         led2 <= inputB[count_number][count_type]; // 在LED上显示题目
// // //             //     end else begin 
// // //             //         if (flag_stop_timer == 0) begin 
// // //             //             flag_stop_timer <= 1'b1;
// // //             //         end else begin
// // //             //             if(count_number<number_questions[count_type]) begin 
                            
// // //             //             end   
// // //             //         end
// // //             //     end
// // //             // end
// // //                 // end else begin
// // //                 //     if(count_number<number_questions[count_type]) begin
// // //                 //         if (TIMER >= 20 or input_complete) begin
// // //                 //             total_time[current_player] <= total_time[current_player] + timer;
// // //                 //             time_question[count_number][count_type][current_player] <= timer;
// // //                 //             if (input_complete) begin
// // //                 //                 player_answer[count_number][count_type][current_player] <= user_input;
// // //                 //                 if (user_input == machine_answer[count_number][count_type]) begin
// // //                 //                     total_true[current_player] <= total_true[current_player] + 1;
// // //                 //                     question_true[count_number][count_type][current_player] <= 1'b1;
// // //                 //                 end else begin
// // //                 //                     question_true[count_number][count_type][current_player] <= 1'b0;
// // //                 //                 end
// // //                 //             end else begin
// // //                 //                 player_answer[count_number][count_type][current_player] <= 8'b11111111; //代表没有输入结果
// // //                 //                 question_true[count_number][count_type][current_player] <= 1'b0;
// // //                 //             end
// // //                 //             timer <=0;
// // //                 //             count_number <= count_number + 1; // 显示下一题
// // //                 //             number_flash <= 0;
// // //                 //         end else begin
                            
// // //                 //         end
// // //                 //         led1 <= inputA[count_number][count_type]; // 在LED上显示题目
// // //                 //         led2 <= inputB[count_number][count_type]; // 在LED上显示题目
// // //                 //     end else begin
// // //                 //         if(count_type < 8'd14) begin
// // //                 //             count_type <= count_type + 1;
// // //                 //             count_number <= 4'd0;
// // //                 //         end else begin
// // //                 //             current_player <= current_player + 1;
// // //                 //             count_number <= 0;
// // //                 //             count_type <= 0;
// // //                 //             number_flash <= 0;
// // //                 //             if (current_player == student_number) begin
// // //                 //                 flag_result_ok <= 1'b1;
// // //                 //             end
// // //                 //         end
// // //                 //     end
// // //                 // end
// // //         end
// // //         Result: begin
// // //             if (input_complete) begin
// // //                 if (student_id<student_number) begin
// // //                     display1 <= total_true[student_id]/100;
// // //                     display2 <= total_true[student_id]%100/10;
// // //                     display3 <= total_true[student_id]%10;
// // //                     display5 <= total_time[student_id]/1000;
// // //                     display6 <= total_time[student_id]%1000/100;
// // //                     display7 <= total_time[student_id]%100/10;
// // //                     display8 <= total_time[student_id]%10;
// // //                     if (student_id == 0) begin 
// // //                         winner <= student_id;
// // //                         winner_time <= total_time[student_id];
// // //                         winner_true <= total_true[student_id];
// // //                     end else begin
// // //                         if (total_true[student_id] > winner_true) begin
// // //                             winner <= student_id;
// // //                             winner_time <= total_time[student_id];
// // //                             winner_true <= total_true[student_id];
// // //                         end else if (total_true[student_id] == winner_true) begin
// // //                             if (total_time[student_id] < winner_time) begin
// // //                                 winner <= student_id;
// // //                                 winner_time <= total_time[student_id];
// // //                                 winner_true <= total_true[student_id];
// // //                             end
// // //                         end
// // //                     end
// // //                 end else begin
// // //                     if (flag_show_winner == 0) begin
// // //                         display1 <= winner;
// // //                         flag_show_winner <= 1'b1;
// // //                     end else begin
// // //                         flag_result_ok <= 1'b1;
// // //                     end
                    
// // //                 end
// // //             end
// // //         end
// // //         Review: begin
// // //             if (input_complete) begin
// // //                 if(flag_module == 0) begin
// // //                     flag_module <= 1'b1;
// // //                     review_module <= user_input;
// // //                 end else begin
// // //                     case(review_module)
// // //                         check_time: begin
// // //                             if(input_complete) begin
// // //                                 if(flag_check_id == 0) begin
// // //                                     check_id <= user_input;
// // //                                     flag_check_id <= 1'b1;   
// // //                                     count_number <= 0;
// // //                                     count_type <= 0;              
// // //                                 end else begin
// // //                                     if(count_number < number_questions[count_type]) begin
// // //                                         display1 <= count_number/10;
// // //                                         display2 <= count_number%10;
// // //                                         display5 <= time_question[count_number][count_type][check_id]/1000;
// // //                                         display6 <= time_question[count_number][count_type][check_id]%1000/100;
// // //                                         display7 <= time_question[count_number][count_type][check_id]%100/10;
// // //                                         display8 <= time_question[count_number][count_type][check_id]%10;
// // //                                         count_number <= count_number + 1;
// // //                                     end else begin
// // //                                         if(count_type < 8'd14) begin
// // //                                             count_type <= count_type + 1;
// // //                                             count_number <= 0;
// // //                                         end else begin
// // //                                             flag_module <= 0;
// // //                                             flag_check_id <= 0;
// // //                                         end
// // //                                     end
// // //                                 end
// // //                             end
// // //                         end
// // //                         check_answer: begin
// // //                             if(input_complete) begin
// // //                                 if(flag_check_id == 0) begin
// // //                                     check_id <= user_input;
// // //                                     flag_check_id <= 1'b1;              
// // //                                 end else begin
// // //                                     flag_module <= 0;
// // //                                     flag_check_id <= 0;
// // //                                     display1 <= number2type[check_id]/10;
// // //                                     display2 <= number2type[check_id]%10;
// // //                                     led1 <= inputA[number2count[check_id]][number2type[check_id]];
// // //                                     led2 <= inputB[number2count[check_id]][number2type[check_id]];
// // //                                     display5 <= machine_answer[number2count[check_id]][number2type[check_id]]/100;
// // //                                     display6 <= machine_answer[number2count[check_id]][number2type[check_id]]%100/10;
// // //                                     display7 <= machine_answer[number2count[check_id]][number2type[check_id]]%10;
// // //                                 end
// // //                             end
// // //                         end
// // //                         check_input: begin
// // //                             if(input_complete) begin
// // //                                 if(flag_check_id == 0) begin
// // //                                     check_id <= user_input;
// // //                                     flag_check_id <= 1'b1;              
// // //                                 end else begin
// // //                                     if(flag_check_number == 0) begin
// // //                                         check_number <= user_input;
// // //                                         flag_check_number <= 1'b1;
// // //                                     end else begin
// // //                                         led1 <= player_answer[number2count[check_number]][number2type[check_number]][check_id];
// // //                                         led2 <= (question_true[number2count[check_number]][number2type[check_number]][check_id])? 8'b00000001 : 8'b00000010;
// // //                                     end
// // //                                 end
// // //                             end
// // //                         end
// // //                     endcase
// // //                 end
// // //             end
// // //         end
// // //     endcase
// // // end
