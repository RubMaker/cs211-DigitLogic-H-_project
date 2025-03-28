set_property IOSTANDARD LVCMOS33 [get_ports {led_1[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_data[0]}]
set_property PACKAGE_PIN F6 [get_ports {led[7]}]
set_property PACKAGE_PIN G4 [get_ports {led[6]}]
set_property PACKAGE_PIN G3 [get_ports {led[5]}]
set_property PACKAGE_PIN J4 [get_ports {led[4]}]
set_property PACKAGE_PIN H4 [get_ports {led[3]}]
set_property PACKAGE_PIN J3 [get_ports {led[2]}]
set_property PACKAGE_PIN J2 [get_ports {led[1]}]
set_property PACKAGE_PIN K2 [get_ports {led[0]}]
set_property PACKAGE_PIN R1 [get_ports {input_data[0]}]
set_property PACKAGE_PIN N4 [get_ports {input_data[1]}]
set_property PACKAGE_PIN M4 [get_ports {input_data[2]}]
set_property PACKAGE_PIN R2 [get_ports {input_data[3]}]
set_property PACKAGE_PIN P2 [get_ports {input_data[4]}]
set_property PACKAGE_PIN P3 [get_ports {input_data[5]}]
set_property PACKAGE_PIN P4 [get_ports {input_data[6]}]
set_property PACKAGE_PIN P5 [get_ports {input_data[7]}]
set_property PACKAGE_PIN V1 [get_ports raw_confirm]
set_property IOSTANDARD LVCMOS33 [get_ports raw_confirm]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN P17 [get_ports clk]
set_property PACKAGE_PIN R15 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
set_property PACKAGE_PIN D4 [get_ports {seg[0]}]
set_property PACKAGE_PIN E3 [get_ports {seg[1]}]
set_property PACKAGE_PIN D3 [get_ports {seg[2]}]
set_property PACKAGE_PIN F4 [get_ports {seg[3]}]
set_property PACKAGE_PIN F3 [get_ports {seg[4]}]
set_property PACKAGE_PIN E2 [get_ports {seg[5]}]
set_property PACKAGE_PIN D2 [get_ports {seg[6]}]
set_property PACKAGE_PIN H2 [get_ports {seg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports seg_0]
set_property IOSTANDARD LVCMOS33 [get_ports seg_1]
set_property IOSTANDARD LVCMOS33 [get_ports seg_2]
set_property IOSTANDARD LVCMOS33 [get_ports seg_3]
set_property PACKAGE_PIN G6 [get_ports seg_0]
set_property PACKAGE_PIN E1 [get_ports seg_1]
set_property PACKAGE_PIN F1 [get_ports seg_2]
set_property PACKAGE_PIN G1 [get_ports seg_3]


# bt_uart
set_property IOSTANDARD LVCMOS33 [get_ports lb_sel_pin]

##USB-RS232 Interface
##Bank = 16, Pin name = ,					Sch name = UART_TXD_IN
set_property PACKAGE_PIN L3 [get_ports rxd_pin]
set_property IOSTANDARD LVCMOS33 [get_ports rxd_pin]

# BT
set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33} [get_ports {switch2[0]}]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {switch2[1]}]
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {switch2[2]}]
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {switch2[3]}]
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {switch2[4]}]


set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports bt_pw_on]
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports bt_master_slave]
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports bt_sw_hw]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports bt_rst_n]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports bt_sw]

# vga ports
set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports hsync]
set_property IOSTANDARD LVCMOS33 [get_ports vsync]
set_property PACKAGE_PIN F5 [get_ports {vga_r[0]}]
set_property PACKAGE_PIN C6 [get_ports {vga_r[1]}]
set_property PACKAGE_PIN C5 [get_ports {vga_r[2]}]
set_property PACKAGE_PIN B7 [get_ports {vga_r[3]}]
set_property PACKAGE_PIN B6 [get_ports {vga_g[0]}]
set_property PACKAGE_PIN A6 [get_ports {vga_g[1]}]
set_property PACKAGE_PIN A5 [get_ports {vga_g[2]}]
set_property PACKAGE_PIN D8 [get_ports {vga_g[3]}]
set_property PACKAGE_PIN C7 [get_ports {vga_b[0]}]
set_property PACKAGE_PIN E6 [get_ports {vga_b[1]}]
set_property PACKAGE_PIN E5 [get_ports {vga_b[2]}]
set_property PACKAGE_PIN E7 [get_ports {vga_b[3]}]
set_property PACKAGE_PIN D7 [get_ports hsync]
set_property PACKAGE_PIN C4 [get_ports vsync]

