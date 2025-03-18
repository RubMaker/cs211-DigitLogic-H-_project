

`timescale 1ns/1ps


module uart_tx_ctl (
  input            clk_tx,          // Clock input
  input            rst_clk_tx,      

  input            baud_x16_en,     // 16x bit oversampling pulse

  input            char_fifo_empty, // Empty signal from char FIFO (FWFT)
  input      [7:0] char_fifo_dout,  // Data from the char FIFO
  output           char_fifo_rd_en, // Pop signal to the char FIFO

  output reg       txd_tx           // The transmit serial signal
);


  localparam 
    IDLE  = 2'b00,
    START = 2'b01,
    DATA  = 2'b10,
    STOP  = 2'b11;



  reg [1:0]    state;             
  reg [3:0]    over_sample_cnt;   // Oversample counter - 16 per bit
  reg [2:0]    bit_cnt;           
  reg          char_fifo_pop;     
                                
  wire         over_sample_cnt_done; 
  wire         bit_cnt_done;         
  

  always @(posedge clk_tx)
  begin
    if (rst_clk_tx)
    begin
      state         <= IDLE;
      char_fifo_pop <= 1'b0;
    end
    else
    begin
      if (baud_x16_en) 
      begin
        char_fifo_pop <= 1'b0;
        case (state)
          IDLE: begin
            if (!char_fifo_empty)
            begin
              state <= START;
            end
          end // IDLE state

          START: begin
            if (over_sample_cnt_done)
            begin
              state <= DATA;
            end // if over_sample_cnt_done
          end // START state

          DATA: begin
            if (over_sample_cnt_done && bit_cnt_done)
            begin
              char_fifo_pop <= 1'b1;
              state         <= STOP;
            end
          end // DATA state

          STOP: begin
            if (over_sample_cnt_done)
            begin
              if (char_fifo_empty)
              begin
                state <= IDLE;
              end
              else
              begin
                state <= START;
              end
            end
          end // STOP state
        endcase
      end // if baud_x16_en
    end // if rst_clk_tx
  end // always 

  assign char_fifo_rd_en = char_fifo_pop && baud_x16_en;

  always @(posedge clk_tx)
  begin
    if (rst_clk_tx)
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
          if (((state == IDLE) && !char_fifo_empty) ||
              (state == START) || 
              (state == DATA)  ||
              ((state == STOP) && !char_fifo_empty))
          begin
            over_sample_cnt <= 4'd15;
          end
        end
      end // if baud_x16_en
    end // if rst_clk_tx
  end // always 

  assign over_sample_cnt_done = (over_sample_cnt == 4'd0);

  always @(posedge clk_tx)
  begin
    if (rst_clk_tx)
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
    end // if rst_clk_tx
  end // always 

  assign bit_cnt_done = (bit_cnt == 3'd7);

  // Generate the output
  always @(posedge clk_tx)
  begin
    if (rst_clk_tx)
    begin
      txd_tx    <= 1'b1;
    end
    else
    begin
      if (baud_x16_en)
      begin
        if ((state == STOP) || (state == IDLE))
        begin
          txd_tx <= 1'b1;
        end
        else if (state == START)
        begin
          txd_tx <= 1'b0;
        end
        else // we are in DATA
        begin
          txd_tx <= char_fifo_dout[bit_cnt];
        end
      end // if baud_x16_en
    end // if rst
  end // always

endmodule
