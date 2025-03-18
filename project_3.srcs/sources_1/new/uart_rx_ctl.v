
`timescale 1ns/1ps


module uart_rx_ctl (
  // Write side inputs
  input            clk_rx,       
  input            rst_clk_rx,   
  input            baud_x16_en,  // 16x oversampling enable

  input            rxd_clk_rx,   // RS232 RXD pin - after sync to clk_rx

  output reg [7:0] rx_data,      // 8 bit data output
                                 //  - valid when rx_data_rdy is asserted
  output reg       rx_data_rdy,  // Ready signal for rx_data
  output reg       frm_err       
);


  localparam 
    IDLE  = 2'b00,
    START = 2'b01,
    DATA  = 2'b10,
    STOP  = 2'b11;



  reg [1:0]    state;             // Main state machine
  reg [3:0]    over_sample_cnt;   // Oversample counter - 16 per bit
  reg [2:0]    bit_cnt;           // Bit counter - which bit are we RXing
  wire         over_sample_cnt_done; // We are in the middle of a bit
  wire         bit_cnt_done;         // This is the last data bit
  
  // Main state machine
  always @(posedge clk_rx)
  begin
    if (rst_clk_rx)
    begin
      state       <= IDLE;
    end
    else
    begin
      if (baud_x16_en) 
      begin
        case (state)
          IDLE: begin
            // On detection of rxd_clk_rx being low, transition to the START
            // state
            if (!rxd_clk_rx)
            begin
              state <= START;
            end
          end // IDLE state

          START: begin
            // After 1/2 bit period, re-confirm the start state
            if (over_sample_cnt_done)
            begin
              if (!rxd_clk_rx)
              begin
                // Was a legitimate start bit (not a glitch)
                state <= DATA;
              end
              else
              begin
                // Was a glitch - reject
                state <= IDLE;
              end
            end // if over_sample_cnt_done
          end // START state

          DATA: begin
            // Once the last bit has been received, check for the stop bit
            if (over_sample_cnt_done && bit_cnt_done)
            begin
              state <= STOP;
            end
          end // DATA state

          STOP: begin
            // Return to idle
            if (over_sample_cnt_done)
            begin
              state <= IDLE;
            end
          end // STOP state
        endcase
      end // if baud_x16_en
    end // if rst_clk_rx
  end // always 


  always @(posedge clk_rx)
  begin
    if (rst_clk_rx)
    begin
      over_sample_cnt    <= 4'd0;
    end
    else
    begin
      if (baud_x16_en) 
      begin
        if (!over_sample_cnt_done)
        begin
          over_sample_cnt <= over_sample_cnt - 1'b1;
        end
        else
        begin
          if ((state == IDLE) && !rxd_clk_rx)
          begin
            over_sample_cnt <= 4'd7;
          end
          else if ( ((state == START) && !rxd_clk_rx) || (state == DATA)  )
          begin
            over_sample_cnt <= 4'd15;
          end
        end
      end // if baud_x16_en
    end // if rst_clk_rx
  end // always 

  assign over_sample_cnt_done = (over_sample_cnt == 4'd0);

  always @(posedge clk_rx)
  begin
    if (rst_clk_rx)
    begin
      bit_cnt    <= 3'b0;
    end
    else
    begin
      if (baud_x16_en) 
      begin
        if (over_sample_cnt_done)
        begin
          if (state == START)
          begin
            bit_cnt <= 3'd0;
          end
          else if (state == DATA)
          begin
            bit_cnt <= bit_cnt + 1'b1;
          end
        end // if over_sample_cnt_done
      end // if baud_x16_en
    end // if rst_clk_rx
  end // always 

  assign bit_cnt_done = (bit_cnt == 3'd7);

  always @(posedge clk_rx)
  begin
    if (rst_clk_rx)
    begin
      rx_data     <= 8'b0000_0000;
      rx_data_rdy <= 1'b0;
    end
    else
    begin
      if (baud_x16_en && over_sample_cnt_done) 
      begin
        if (state == DATA)
        begin
          rx_data[bit_cnt] <= rxd_clk_rx;
          rx_data_rdy      <= (bit_cnt == 3'd7);
        end
        else
        begin
          rx_data_rdy      <= 1'b0;
        end
      end
    end // if rst_clk_rx
  end // always 

  always @(posedge clk_rx)
  begin
    if (rst_clk_rx)
    begin
      frm_err     <= 1'b0;
    end
    else
    begin
      if (baud_x16_en) 
      begin
        if ((state == STOP) && over_sample_cnt_done && !rxd_clk_rx)
        begin
          frm_err <= 1'b1;
        end
        else
        begin
          frm_err <= 1'b0;
        end
      end // if baud_x16_en
    end // if rst_clk_rx
  end // always 


endmodule
