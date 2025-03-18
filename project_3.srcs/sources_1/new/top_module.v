`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/04 20:06:26
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clk,
    input wire button_1,//power_off, stand_by, run_mode
    input wire button_2,//button in the mode to ensure the input
    input wire button_3,//quit in the mode
    input wire button_4,
    input wire button_5,
    input wire [7:0] switch1,
    input wire [5:0] switch2,

    input wire rxd_pin,
    input wire lb_sel_pin,
    input wire bt_in,
    
    output bt_pw_on,
    output bt_master_slave,
    output bt_sw_hw,
    output bt_rst_n,
    output bt_sw,

    output reg [7:0] led_1,
    output reg [7:0] led_2, 
    output wire [7:0] segment_0,
    output wire [7:0] segment_1,
    output wire seg_0,
    output wire seg_1,
    output wire seg_2,
    output wire seg_3,
    output wire seg_4,
    output wire seg_5,
    output wire seg_6,
    output wire seg_7,
    


    output hsync,   // line synchronization signal
    output vsync,   // vertical synchronization signal
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
    );

    parameter power_off = 8'b0000_0001,
    stand_by = 8'b0000_0010,
    calc_mode = 8'b0000_0100,
    learn_mode = 8'b0000_1000,
    competition_mode = 8'b0001_0000,
    demonstration_mode = 8'b0010_0000;

    wire reset;


    reg [7:0] current_state,next_state;
    reg [7:0] pre_state;


    //choose the mode to run
    reg [7:0] mode;
    reg running = 0;
    
    //for the calc_mode
    wire [7:0] led_calc;
    wire [7:0] led_2_calc;
    //decimal
    wire [7:0] display1_calc;
    wire [7:0] display2_calc;
    wire [7:0] display3_calc;
    wire [7:0] display4_calc;
    wire [7:0] display5_calc;
    //bcd code
    wire [7:0] display1_seg_calc;
    wire [7:0] display2_seg_calc;
    wire [7:0] display3_seg_calc;
    wire [7:0] display4_seg_calc;
    wire [7:0] display5_seg_calc;
    wire [7:0] display6_seg_calc;
    wire [7:0] display7_seg_calc;
    wire [7:0] display8_seg_calc;
    //state
    wire [3:0] current_state_calc;


    //for the learn_mode
    //decimal
    wire [7:0] led_learn;
    wire [7:0] display1_learn;
    wire [7:0] display2_learn;
    wire [7:0] display3_learn;
    wire [7:0] display4_learn;
    wire [7:0] display5_learn;
    wire [7:0] display6_learn;
    wire [7:0] display7_learn;
    wire [7:0] display8_learn;
    //bcd code
    wire [7:0] display1_seg_learn;
    wire [7:0] display2_seg_learn;
    wire [7:0] display3_seg_learn;
    wire [7:0] display4_seg_learn;
    wire [7:0] display5_seg_learn;
    wire [7:0] display6_seg_learn;
    wire [7:0] display7_seg_learn;
    wire [7:0] display8_seg_learn;


    //for the competition module
    wire [7:0] led_1_competition;
    wire [7:0] led_2_competition;
    //deicimal
    wire [7:0] display1_competition;
    wire [7:0] display2_competition;
    wire [7:0] display3_competition;
    wire [7:0] display4_competition;
    wire [7:0] display5_competition;
    wire [7:0] display6_competition;
    wire [7:0] display7_competition;
    wire [7:0] display8_competition;
    //bcd code
    wire [7:0] display1_seg_competition;
    wire [7:0] display2_seg_competition;
    wire [7:0] display3_seg_competition;
    wire [7:0] display4_seg_competition;
    wire [7:0] display5_seg_competition;
    wire [7:0] display6_seg_competition;
    wire [7:0] display7_seg_competition;
    wire [7:0] display8_seg_competition;
    //8-segment flicker
    wire flicker;


    //for the demonstration module
    wire [7:0] led_demonstration;
    //deicimal
    wire [7:0] display1_demonstration;
    wire [7:0] display2_demonstration;
    wire [7:0] display3_demonstration;
    wire [7:0] display4_demonstration;
    wire [7:0] display5_demonstration;
    wire [7:0] display6_demonstration;
    wire [7:0] display7_demonstration;
    wire [7:0] display8_demonstration;
    //bcd code
    wire [7:0] display1_seg_demonstration;
    wire [7:0] display2_seg_demonstration;
    wire [7:0] display3_seg_demonstration;
    wire [7:0] display4_seg_demonstration;
    wire [7:0] display5_seg_demonstration;
    wire [7:0] display6_seg_demonstration;
    wire [7:0] display7_seg_demonstration;
    wire [7:0] display8_seg_demonstration;

    //button
    wire confirm_stable_1;
    wire debounced_btn_1;
    wire confirm_stable_2;
    wire debounced_btn_2;
    wire confirm_stable_3;
    wire debounced_btn_3;
    wire confirm_stable_4;
    wire debounced_btn_4;
    wire confirm_stable_5;
    wire debounced_btn_5;
    wire long_confirm_stable;
    wire long_btn;
    //8 segment
    reg [7:0] segment0;
    reg [7:0] segment1;
    reg [7:0] segment2;
    reg [7:0] segment3;
    reg [7:0] segment4;
    reg [7:0] segment5;
    reg [7:0] segment6;
    reg [7:0] segment7;

    reg [7:0] segment_choosing;
    parameter max_cnt=50000;
    reg div_clk=0;
    reg[18:0] divclk_cnt = 0;

    wire [7:0] switch;
    
    wire [7:0] bt_recieve;

   wire [7:0] segment_0_wire;
   wire [7:0] segment_1_wire;
   wire seg_0_wire;
   wire seg_1_wire;
   wire seg_2_wire;
   wire seg_3_wire;
   wire seg_4_wire;
   wire seg_5_wire;
   wire seg_6_wire;
   wire seg_7_wire;

    bt_uart u1_bt_uart(
        .clk_pin(clk),
        .rst_pin(reset),
        .rxd_pin(rxd_pin),
        .txd_pin(),
        .lb_sel_pin(lb_sel_pin),
        .bt_pw_on(bt_pw_on),
        .bt_master_slave(bt_master_slave),
        .bt_sw_hw(bt_sw_hw),
        .bt_rst_n(bt_rst_n),
        .bt_sw(bt_sw),
        .sw_pin(switch2),
        .seg7_0_7bit(),
        .seg7_1_7bit(),
        .seg7_0_an(),
        .seg7_1_an(),
        .seg7_0_dp(),
        .seg7_1_dp(),
        .led_pins2(bt_recieve)
    );

  assign switch=(bt_in==1)?bt_recieve:switch1;

  vga_top u1_vga_top(
    .clk(clk),
     .rst(reset),
    .script(switch), 
    .led_1(led_1), 
    .led_2(led_2), 
        .segment0(segment0),
        .segment1(segment1),
        .segment2(segment2),
        .segment3(segment3),
        .segment4(segment4),
        .segment5(segment5),
        .segment6(segment6),
        .segment7(segment7),
    
        .game_mode(current_state),
        .hsync(hsync),   // line synchronization signal
        .vsync(vsync),   // vertical synchronization signal
        .red(red),
        .green(green),
        .blue(blue)
);
    
    calc_mode u1_calc_mode(
        .clk(clk),
        .reset(reset),
        .raw_confirm(button_2),
        .input_data(switch),
        .en(mode[2]),
        .display1(display1_calc),
        .display2(display2_calc),
        .display3(display3_calc),
        .display4(display4_calc),
        .display5(display5_calc),
        .led(led_calc),
        .led_2(led_2_calc)
    );



    learn_module u1_learn_module(
        .clk(clk),
        .reset(reset),
        .user_input(switch),
        .input_complete(confirm_stable_2),
        .input_quit(confirm_stable_3),
        .led(led_learn),
        .en(mode[3]),
        .display8(display1_learn),
        .display7(display2_learn),
        .display6(display3_learn),
        .display5(display4_learn),
        .display4(display5_learn),
        .display3(display6_learn),
        .display2(display7_learn),
        .display1(display8_learn)
    );

    
    competition_module u1_competition_module(
        .clk(clk),
        .reset(reset),
        .user_input(switch),
        .input_complete(confirm_stable_2),
        .input_quit(confirm_stable_3),
        .led1(led_1_competition),
        .led2(led_2_competition),
        .en(mode[4]),
        .display8(display1_competition),
        .display7(display2_competition),
        .display6(display3_competition),
        .display5(display4_competition),
        .display4(display5_competition),
        .display3(display6_competition),
        .display2(display7_competition),
        .display1(display8_competition)
    );
    


    demonstration_module u1_demonstration_module(
      .clk(clk),
        .reset(reset),
        .user_input(switch),
        .en(mode[5]),
        .led(led_demonstration),
        .input_complete(confirm_stable_2),
        .display8(display1_demonstration),
        .display7(display2_demonstration),
        .display6(display3_demonstration),
        .display5(display4_demonstration),
        .display4(display5_demonstration),
        .display3(display6_demonstration),
        .display2(display7_demonstration),
        .display1(display8_demonstration)
    );


    debounce u1_debounce (
        .clk(clk),
        .reset(reset),
        .debounced_btn(debounced_btn_1),
        .btn_in(button_1),
        .confirm_stable(confirm_stable_1)
    );


    debounce u2_debounce (
        .clk(clk),
        .reset(reset),
        .debounced_btn(debounced_btn_2),
        .btn_in(button_2),
        .confirm_stable(confirm_stable_2)
    );


    debounce u3_debounce (
        .clk(clk),
        .reset(reset),
        .debounced_btn(debounced_btn_3),
        .btn_in(button_3),
        .confirm_stable(confirm_stable_3)
    );

    debounce u4_debounce (
        .clk(clk),
        .reset(reset),
        .debounced_btn(debounced_btn_4),
        .btn_in(button_4),
        .confirm_stable(confirm_stable_4)
    );
    
    //Reset
    debounce u5_debounce(
        .clk(clk),
        .reset(reset),
        .debounced_btn(debounced_btn_5),
        .btn_in(button_5),
        .confirm_stable(confirm_stable_5)
    );
    
    assign reset = confirm_stable_5 || long_confirm_stable;

    long_debounce u1_long_debounce (
        .clk(clk),
        .reset(reset),
        .debounced_btn(long_btn),
        .btn_in(button_4),
        .confirm_stable(long_confirm_stable)
    );

    seg_decoder_8 u1_seg_decoder_8(
        .digit(display1_learn),
        .seg(display1_seg_learn)
    );
    seg_decoder_8 u2_seg_decoder_8(
        .digit(display2_learn),
        .seg(display2_seg_learn)
    );
    seg_decoder_8 u3_seg_decoder_8(
        .digit(display3_learn),
        .seg(display3_seg_learn)
    );
    seg_decoder_8 u4_seg_decoder_8(
        .digit(display4_learn),
        .seg(display4_seg_learn)
    );
    seg_decoder_8 u5_seg_decoder_8(
        .digit(display5_learn),
        .seg(display5_seg_learn)
    );
    seg_decoder_8 u6_seg_decoder_8(
        .digit(display6_learn),
        .seg(display6_seg_learn)
    );
    seg_decoder_8 u7_seg_decoder_8(
        .digit(display7_learn),
        .seg(display7_seg_learn)
    );
    seg_decoder_8 u8_seg_decoder_8(
        .digit(display8_learn),
        .seg(display8_seg_learn)
    );

    seg_decoder_8 v1_seg_decoder_8(
        .digit(display1_competition),
        .seg(display1_seg_competition)
    );
    seg_decoder_8 v2_seg_decoder_8(
        .digit(display2_competition),
        .seg(display2_seg_competition)
    );
    seg_decoder_8 v3_seg_decoder_8(
        .digit(display3_competition),
        .seg(display3_seg_competition)
    );
    seg_decoder_8 v4_seg_decoder_8(
        .digit(display4_competition),
        .seg(display4_seg_competition)
    );
    seg_decoder_8 v5_seg_decoder_8(
        .digit(display5_competition),
        .seg(display5_seg_competition)
    );
    seg_decoder_8 v6_seg_decoder_8(
        .digit(display6_competition),
        .seg(display6_seg_competition)
    );
    seg_decoder_8 v7_seg_decoder_8(
        .digit(display7_competition),
        .seg(display7_seg_competition)
    );
    seg_decoder_8 v8_seg_decoder_8(
        .digit(display8_competition),
        .seg(display8_seg_competition)
    );

    seg_decoder_8 v9_seg_decoder_8(
        .digit(display1_calc),
        .seg(display1_seg_calc)
    );
    seg_decoder_8 v10_seg_decoder_8(
        .digit(display2_calc),
        .seg(display2_seg_calc)
    );
    seg_decoder_8 v11_seg_decoder_8(
        .digit(display3_calc),
        .seg(display3_seg_calc)
    );
    seg_decoder_8 v12_seg_decoder_8(
        .digit(display4_calc),
        .seg(display4_seg_calc)
    );
    seg_decoder_8 v121_seg_decoder_8(
        .digit(display5_calc),
        .seg(display5_seg_calc)
    );

    seg_decoder_8 v13_seg_decoder_8(
        .digit(display1_demonstration),
        .seg(display1_seg_demonstration)
    );
    seg_decoder_8 v14_seg_decoder_8(
        .digit(display2_demonstration),
        .seg(display2_seg_demonstration)
    );
    seg_decoder_8 v15_seg_decoder_8(
        .digit(display3_demonstration),
        .seg(display3_seg_demonstration)
    );
    seg_decoder_8 v16_seg_decoder_8(
        .digit(display4_demonstration),
        .seg(display4_seg_demonstration)
    );

    seg_decoder_8 v17_seg_decoder_8(
        .digit(display5_demonstration),
        .seg(display5_seg_demonstration)
    );
    seg_decoder_8 v18_seg_decoder_8(
        .digit(display6_demonstration),
        .seg(display6_seg_demonstration)
    );
    seg_decoder_8 v19_seg_decoder_8(
        .digit(display7_demonstration),
        .seg(display7_seg_demonstration)
    );
    seg_decoder_8 v20_seg_decoder_8(
        .digit(display8_demonstration),
        .seg(display8_seg_demonstration)
    );
    segment_display u_segment_display (
        .clk        (clk),
        .reset      (reset),
        .segment0   (segment0),
        .segment1   (segment1),
        .segment2   (segment2),
        .segment3   (segment3),
        .segment4   (segment4),
        .segment5   (segment5),
        .segment6   (segment6),
        .segment7   (segment7),
        .segment_0  (segment_0_wire),
        .segment_1  (segment_1_wire),
        .seg_0      (seg_0_wire),
        .seg_1      (seg_1_wire),
        .seg_2      (seg_2_wire),
        .seg_3      (seg_3_wire),
        .seg_4      (seg_4_wire),
        .seg_5      (seg_5_wire),
        .seg_6      (seg_6_wire),
        .seg_7      (seg_7_wire)
    );

    assign segment_0 = segment_0_wire;
    assign segment_1 = segment_1_wire;
    assign seg_0 = seg_0_wire;
    assign seg_1 = seg_1_wire;
    assign seg_2 = seg_2_wire;
    assign seg_3 = seg_3_wire;
    assign seg_4 = seg_4_wire;
    assign seg_5 = seg_5_wire;
    assign seg_6 = seg_6_wire;
    assign seg_7 = seg_7_wire;


    //next state logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= power_off; // Reset to idle state
        else begin
          current_state <= next_state;

        end
    end

    
    always @(*) begin
        case (current_state)
            power_off: begin
                if (confirm_stable_1) 
                    next_state = stand_by; 
                else 
                    next_state = power_off;
            end

            stand_by: begin
                if (long_confirm_stable) begin
                  next_state = power_off;
                end
                if(confirm_stable_1) begin
                  case (mode) 
                    calc_mode: begin
                      next_state = calc_mode;
                    end
                    learn_mode: begin
                      next_state = learn_mode;
                    end
                    competition_mode : begin
                      next_state = competition_mode;
                    end
                    demonstration_mode: begin
                      next_state = demonstration_mode;
                    end
                    default 
                        next_state = stand_by;
                  endcase
                end else begin
                  next_state = stand_by;
                end
            end

            calc_mode:begin
              if(long_confirm_stable) begin
                next_state =power_off;
              end
              if(confirm_stable_1)
                next_state = stand_by;
              else
                next_state = calc_mode;  
            end

            learn_mode:begin
              if(long_confirm_stable) begin
                next_state =power_off;
              end
              if(confirm_stable_1)
                next_state = stand_by;
              else
                next_state = learn_mode;  
            end

            competition_mode:begin
              if(long_confirm_stable) begin
                next_state =power_off;
              end
              if(confirm_stable_1)
                next_state = stand_by;
              else
                next_state = competition_mode;
            end
            
            demonstration_mode:begin
              if(long_confirm_stable) begin
                next_state =power_off;
              end
              if(confirm_stable_1)
                next_state = stand_by;
              else
                next_state = demonstration_mode;
            end


            default 
                next_state = current_state;
        endcase
    end
    
    //update
    always @(*) begin
      case (current_state)
      power_off:begin
        led_1= 8'b0000_0000;
        led_2 = 8'b0000_0000;
        segment0 = 8'b0000_0000;
               segment1 = 8'b0000_0000;
                segment2 = 8'b0000_0000;
                segment3 = 8'b0000_0000;
                segment4 = 8'b0000_0000;
                segment5 = 8'b0000_0000;
                segment6  = 8'b0000_0000;
                segment7 = 8'b0000_0000;
      end

      stand_by:begin
        running = 1'b0;
        led_2 = 8'b00000010;
        segment0 = 8'b0011_1111;
        segment1 = 8'b0011_1111;
        segment2 = 8'b0011_1111;
        segment3 = 8'b0011_1111;
        segment4 = 8'b0011_1111;
        segment5 = 8'b0011_1111;
        segment6  = 8'b0011_1111;
        segment7 = 8'b0011_1111;
        if(!running) begin
          mode = switch;
        end
      end


      calc_mode: begin
        led_2 = led_2_calc;
        led_1 = led_calc;
        running = 1'b1;
        segment0 = display1_seg_calc;
        segment1 = display2_seg_calc;
        segment2 = display3_seg_calc;
        segment3 = display4_seg_calc;
        segment4 = display5_seg_calc;
        segment5 = 8'b0011_1111;
        segment6 = 8'b0011_1111;
        segment7 = 8'b0011_1111;
    end

    learn_mode: begin
        led_2 =8'd0;
                    running = 1'b1;
                  led_1= led_learn;
                  segment0 = display1_seg_learn;
                  segment1 = display2_seg_learn;
                  segment2 = display3_seg_learn;
                  segment3 = display4_seg_learn;
                  segment4 = display5_seg_learn;
                  segment5 = display6_seg_learn;
                  segment6 = display7_seg_learn;
                  segment7 = display8_seg_learn;
                end
    competition_mode:begin
                    running = 1'b1;
                  led_1 <= led_1_competition;
                  led_2 <= led_2_competition;
                  segment0 <= display1_seg_competition;
                  segment1 <= display2_seg_competition;
                  segment2 <= display3_seg_competition;
                  segment3 <= display4_seg_competition;
                  segment4 <= display5_seg_competition;
                  segment5 <= display6_seg_competition;
                  segment6 <= display7_seg_competition;
                  segment7 <= display8_seg_competition;
                end

    demonstration_mode:begin
                    running = 1'b1;
                  led_1 <= led_demonstration;
                  led_2 <= 8'b0000_0000;
                  segment0 <= display1_seg_demonstration;
                  segment1 <= display2_seg_demonstration;
                  segment2 <= display3_seg_demonstration;
                  segment3 <= display4_seg_demonstration;
                  segment4 <= display5_seg_demonstration;
                  segment5 <= display6_seg_demonstration;
                  segment6 <= display7_seg_demonstration;
                  segment7 <= display8_seg_demonstration;
                end

    default begin
                  led_2 <= 0;
                  segment0 <= 8'b0011_1111;
                  segment1 <= 8'b0011_1111;
                  segment2 <= 8'b0011_1111;
                  segment3 <= 8'b0011_1111;
                  segment4 <= 8'b0011_1111;
                  segment5 <= 8'b0011_1111;
                  segment6 <= 8'b0011_1111;
                  segment7 <= 8'b0011_1111;
                end
    
      endcase
      end

endmodule
