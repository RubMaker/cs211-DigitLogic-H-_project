
`timescale 1ns/1ps


module cmd_parse(
  input             clk_rx,         
  input             rst_clk_rx,     

  input      [7:0]  rx_data,        // Character to be parsed
  input             rx_data_rdy,    // Ready signal for rx_data

  input             char_fifo_full, 
  output reg        send_char_val,  
  output reg [7:0]  send_char,      
  output reg        send_resp_val,  
  output reg [1:0]  send_resp_type, 
  output reg [15:0] send_resp_data, // Data to be output
  input             send_resp_done, 

  output reg [7:0] bt_data8,
  output reg [15:0] bt_data16,
  output reg [31:0] bt_data32
);


  parameter MAX_ARG_CH   = 8;    // Number of characters in largest set of args

  localparam [1:0]
     RESP_OK   = 2'b00,
     RESP_ERR  = 2'b01;

  localparam
     IDLE      = 3'b000,
     CMD_WAIT  = 3'b001,
     GET_ARG   = 3'b010,
     SEND_RESP = 3'b011;

   localparam
     CMD_W     = 7'h57,
     CMD_R     = 7'h52,
     CMD_N     = 7'h4e,
     CMD_P     = 7'h50,
     CMD_S     = 7'h53,
     CMD_n_l   = 7'h6e,
     CMD_p_l   = 7'h70,
     CMD_s_l   = 7'h73,
     CMD_G     = 7'h47,
     CMD_C     = 7'h43,
     CMD_H     = 7'h48;


 `include "clogb2.txt"
  reg [2:0]         state;    
  reg               old_rx_data_rdy; 
  reg [6:0]         cur_cmd;  
  reg [4*MAX_ARG_CH-5:0]        arg_sav;  
  reg [clogb2(MAX_ARG_CH)-1:0]  arg_cnt;  

  wire new_char = rx_data_rdy && !old_rx_data_rdy && !char_fifo_full; 
  reg [7:0] bt_data8_reserve;
  

  function [4:0] to_val;
    input [6:0] char;
  begin
    if ((char >= 7'h30) && (char <= 7'h39)) // 0-9
    begin
      to_val[4]   = 1'b0;
      to_val[3:0] = char[3:0];
    end
    else if (((char >= 7'h41) && (char <= 7'h46)) || // A-F
             ((char >= 7'h61) && (char <= 7'h66)) )  // a-f
    begin
      to_val[4]   = 1'b0;
      to_val[3:0] = char[3:0] + 4'h9; // gives 10 - 15
    end
    else 
    begin
      to_val      = 5'b1_0000;
    end
  end
  endfunction

  always @(posedge clk_rx)
  begin
    if (rst_clk_rx)
    begin
      old_rx_data_rdy <= 1'b0;
    end
    else
    begin
      old_rx_data_rdy <= rx_data_rdy;
    end
  end

  always @(posedge clk_rx)
  begin
    if (rst_clk_rx)
    begin
      send_char_val <= 1'b0;
      send_char     <= 8'h00;
    end
    else if (new_char)
    begin
      send_char_val <= 1'b1;
      send_char     <= rx_data;
    end // if !rst and new_char
    else
    begin
      send_char_val <= 1'b0;
    end
  end // always


  wire [4:0]  char_to_digit = to_val(rx_data);
  wire        char_is_digit = !char_to_digit[4];


  wire [4*MAX_ARG_CH-1:0] arg_val       = {arg_sav,char_to_digit[3:0]};

  always @(posedge clk_rx)
  begin
    if (rst_clk_rx)
    begin
      state             <= IDLE;
      cur_cmd           <= 7'h00;
      arg_sav           <= 28'b0;
      arg_cnt           <= 3'b0;
      send_resp_val     <= 1'b0;
      send_resp_type    <= RESP_ERR;
      send_resp_data    <= 16'h0000;
      bt_data8          <=16'h00;
      bt_data8_reserve <=16'h00;
      bt_data16         <= 16'h0000;
	  bt_data32         <= 32'h00000000;
    end
    else
    begin

      case (state)

        IDLE: begin // Wait for the '*'
          if (new_char && (rx_data[6:0] == 7'h2A))
          begin
            state <= CMD_WAIT;
          end 
        end 

        CMD_WAIT: begin 
          if (new_char)
          begin
            cur_cmd <= rx_data[7:0];
            case (rx_data[6:0])
  
              CMD_W: begin 

                state   <= GET_ARG;
                arg_cnt <= 3'd7;
              end  
  
              CMD_N: begin 

                state   <= GET_ARG;
                arg_cnt <= 3'd3;
              end  //  N
              
              CMD_H: begin
              // Get 2 characters arguments
              state <= GET_ARG;
              arg_cnt <=3'd1;
              end //H
  
              default: begin
                send_resp_val  <= 1'b1;
                send_resp_type <= RESP_ERR;
                state          <= SEND_RESP;
              end 
            endcase 
          end 
        end 
        
        GET_ARG: begin

          if (new_char)
          begin
            if (!char_is_digit)
            begin
              // Send an error response
              send_resp_val  <= 1'b1;
              send_resp_type <= RESP_ERR;
              state          <= SEND_RESP;
            end
            else 
            begin
              if (arg_cnt != 3'b000) 
              begin

                arg_sav <= arg_val;  

                arg_cnt <= arg_cnt - 1'b1;
              end 
              else 
              begin
                case (cur_cmd) 
                  CMD_W: begin
                      bt_data32 <= arg_val[31:0]; 
					  // Send OK
                      send_resp_val     <= 1'b1;
                      send_resp_type    <= RESP_OK;
                      state             <= SEND_RESP;
                  end // CMD_W

                  CMD_N: begin
                       bt_data16     <= arg_val[15:0];
                      // Send OK
                      send_resp_val  <= 1'b1;
                      send_resp_type <= RESP_OK;
                      state          <= SEND_RESP;
                  end // CMD_N

                  CMD_H:begin
                        bt_data8    <= arg_val[7:0];
                        send_resp_val <= 1'b1;
                        send_resp_type <= RESP_OK;
                        state <= SEND_RESP;
                   end //CMD_H


                endcase
              end 
            end 
          end 
        end 

        SEND_RESP: begin
          if (send_resp_done)
          begin
            send_resp_val <= 1'b0;
            state         <= IDLE;
          end
        end 
        default: begin
          state <= IDLE;
        end 

      endcase
    end 
  end 


endmodule
