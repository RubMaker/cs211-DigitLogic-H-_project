`timescale 1ns/1ps


module bt_uart (
  input            clk_pin,      // Clock input (from pin)
  input            rst_pin,        // Active HIGH reset (from pin)

  input            rxd_pin,        // RS232 RXD pin
  output           txd_pin,        // RS232 RXD pin

  // Loopback selector
  input            lb_sel_pin,     // Loopback selector 
  //BT 
    output bt_pw_on,
    output bt_master_slave,
    output bt_sw_hw,
    output bt_rst_n,
    output bt_sw,
    input  [5:0]  sw_pin,
    

    output     [6:0] seg7_0_7bit,
    output     [6:0] seg7_1_7bit,
    output     [3:0] seg7_0_an,
    output     [3:0] seg7_1_an,
    output     seg7_0_dp,
    output     seg7_1_dp,
  // LED outputs
	output  [7:0] led_pins2

  
);

parameter BAUD_RATE           = 9600;   
parameter CLOCK_RATE_RX       = 100_000_000;
parameter CLOCK_RATE_TX       = 100_000_000; 

        
  wire        txd_o;
  wire        lb_sel_i;
  wire        spi_clk_o;
  wire        spi_mosi_o;
  wire        dac_cs_n_o;
  wire [15:0]  led_o;
  wire [7:0] led_o2;

  wire        clk_rx;         // Receive clock
  wire        clk_tx;         // Transmit clock
  wire        clk_samp;       // Sample clock
  wire        en_clk_samp;    // Enable for clk_samp, syncronous to clk_tx
  wire        clock_locked;   

  // From Reset Generator
  wire        rst_clk_rx;     
  wire        rst_clk_tx;     
  wire        rst_clk_samp;   

  // From the  receiver
  wire        rxd_clk_rx;     
  wire        rx_data_rdy;    // New character is ready
  wire [7:0]  rx_data;        // New character

  wire        send_char_val;  // A character is ready to be sent
  wire [7:0]  send_char;      // Character to be sent

  wire        send_resp_val;  // A response is requested
  wire [1:0]  send_resp_type; // Type of response - see localparams
  wire [15:0] send_resp_data; // Data to be output

  wire [31:0] bt_data32;

  wire        send_resp_done;   // The response generation is complete

  wire [7:0]  char_fifo_din;    // Character to push into the FIFO
  wire        char_fifo_wr_en;  // Write enable (push) for the FIFO

  wire [7:0]  char_fifo_dout;   // Character to be popped from the FIFO
  wire        char_fifo_full;   // The character FIFO is full
  wire        char_fifo_empty;  // The character FIFO is full

  wire        char_fifo_rd_en;  
  wire        txd_tx;           

  // Instantiate the clock generator
  clk_gen clk_gen_i0 (
    .clk_pin         (clk_pin),         
    .rst_i           (rst_pin),           

    .rst_clk_tx      (rst_clk_tx),      // For clock divider

    .pre_clk_tx      (),      // Current divider

    .clk_rx          (clk_rx),          // Receive clock
    .clk_tx          (clk_tx),          // Transmit clock
    .clk_samp        (),        

    .en_clk_samp     (),    
    .clock_locked    (clock_locked)     
  );

  // Instantiate the reset generator
  rst_gen rst_gen_i0 (
    .clk_rx          (clk_rx),          // Receive clock
    .clk_tx          (clk_tx),          // Transmit clock
    .clk_samp        ( ),        

    .rst_i           (rst_pin),           
    .clock_locked    (clock_locked),    

    .rst_clk_rx      (rst_clk_rx),      // Reset, synchronized to clk_rx
    .rst_clk_tx      (rst_clk_tx),      // Reset, synchronized to clk_tx
    .rst_clk_samp    ( )    
  );

  uart_rx #(
    .BAUD_RATE   (BAUD_RATE),
    .CLOCK_RATE  (CLOCK_RATE_RX)
  ) uart_rx_i0 (
    .clk_rx      (clk_rx),              
    .rst_clk_rx  (rst_clk_rx),          

    .rxd_i       (rxd_pin),               // RS232 receive pin
    .rxd_clk_rx  (rxd_clk_rx),          // RXD pin after sync to clk_rx
    
    .rx_data_rdy (rx_data_rdy),         // New character is ready
    .rx_data     (rx_data),             // New character
    .frm_err     ()                     
  );

  cmd_parse cmd_parse_i0 (
    .clk_rx            (clk_rx),         
    .rst_clk_rx        (rst_clk_rx),     

    .rx_data           (rx_data),        
    .rx_data_rdy       (rx_data_rdy),    // Ready signal for rx_data

    .char_fifo_full    (char_fifo_full), // The char_fifo is full

    .send_char_val     (send_char_val),  // A character is ready to be sent
    .send_char         (send_char),      // Character to be sent

    .send_resp_val     (send_resp_val),  // A response is requested
    .send_resp_type    (send_resp_type), 
    .send_resp_data    (send_resp_data), // Data to be output

    .send_resp_done    (send_resp_done), // The response generation is complete
    .bt_data8                   (led_pins2),
    .bt_data16                (),
	.bt_data32                (bt_data32)
  );


  resp_gen resp_gen_i0 (
    .clk_rx             (clk_rx),        
    .rst_clk_rx         (rst_clk_rx),     

    .char_fifo_full     (char_fifo_full), // The char_fifo is full

    .send_char_val      (send_char_val),  // A character is ready to be sent
    .send_char          (send_char),      // Character to be sent

    .send_resp_val      (send_resp_val),  // A response is requested
    .send_resp_type     (send_resp_type), // Type of response - see localparams
    .send_resp_data     (send_resp_data), // Data to be output

    .send_resp_done     (send_resp_done), 

    .char_fifo_din      (char_fifo_din),  
    .char_fifo_wr_en    (char_fifo_wr_en) 
  );

  char_fifo char_fifo_i0 (
    .din        (char_fifo_din), // Bus [7 : 0] 
    .rd_clk     (clk_tx),
    .rd_en      (char_fifo_rd_en),
    .rst        (rst_pin),          // ASYNCHRONOUS reset - to both sides
    .wr_clk     (clk_rx),
    .wr_en      (char_fifo_wr_en),
    .dout       (char_fifo_dout), // Bus [7 : 0] 
    .empty      (char_fifo_empty),
    .full       (char_fifo_full)
  );

  uart_tx #(
    .BAUD_RATE    (BAUD_RATE),
    .CLOCK_RATE   (CLOCK_RATE_TX)
  ) uart_tx_i0 (
    .clk_tx             (clk_tx),          
    .rst_clk_tx         (rst_clk_tx),      

    .char_fifo_empty    (char_fifo_empty), 
    .char_fifo_dout     (char_fifo_dout),  
    .char_fifo_rd_en    (char_fifo_rd_en), 

    .txd_tx             (txd_tx)          
  );
  lb_ctl lb_ctl_i0 (
    .clk_tx     (clk_tx),         
    .rst_clk_tx (rst_clk_tx),      

    .lb_sel_i   (lb_sel_pin),        // Undebounced slide switch input

    .txd_tx     (txd_tx),          // Normal transmit data
    .rxd_clk_rx (rxd_clk_rx),      

    .txd_o      (txd_pin)            
  );
  
  
  seg7decimal seg7_0(
    .x          (bt_data32[31:16]),
    .clk        (clk_tx),
    .clr        (rst_clk_tx),
    .a_to_g     (seg7_0_7bit),
    .an         (seg7_0_an),
    .dp         (seg7_0_dp)
    );

  seg7decimal seg7_1(
    .x          (bt_data32[15:0]),
    .clk        (clk_tx),
    .clr        (rst_clk_tx),
    .a_to_g     (seg7_1_7bit),
    .an         (seg7_1_an),
    .dp         (seg7_1_dp)
    );


assign bt_master_slave = sw_pin[0];
assign bt_sw_hw        = sw_pin[1];
assign bt_rst_n        = sw_pin[2];
assign bt_sw           = sw_pin[3];
assign bt_pw_on        = sw_pin[4];



endmodule
