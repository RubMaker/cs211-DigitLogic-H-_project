-makelib ies_lib/xil_defaultlib -sv \
  "F:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "F:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_3.srcs/sources_1/ip/clk_core/clk_core_clk_wiz.v" \
  "../../../../project_3.srcs/sources_1/ip/clk_core/clk_core.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

