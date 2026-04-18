###############################################################################
# Created by write_sdc
###############################################################################
current_design soc_top
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 20.0000 [get_ports {clk}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[0]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[0]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[10]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[10]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[11]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[11]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[12]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[12]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[13]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[13]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[14]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[14]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[15]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[15]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[16]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[16]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[17]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[17]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[18]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[18]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[19]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[19]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[1]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[1]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[20]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[20]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[21]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[21]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[22]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[22]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[23]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[23]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[24]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[24]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[25]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[25]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[26]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[26]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[27]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[27]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[28]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[28]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[29]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[29]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[2]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[2]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[30]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[30]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[31]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[31]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[3]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[3]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[4]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[4]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[5]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[5]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[6]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[6]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[7]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[7]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[8]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[8]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_addr[9]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_addr[9]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[0]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[0]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[10]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[10]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[11]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[11]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[12]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[12]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[13]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[13]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[14]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[14]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[15]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[15]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[16]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[16]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[17]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[17]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[18]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[18]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[19]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[19]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[1]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[1]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[20]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[20]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[21]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[21]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[22]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[22]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[23]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[23]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[24]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[24]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[25]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[25]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[26]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[26]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[27]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[27]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[28]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[28]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[29]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[29]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[2]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[2]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[30]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[30]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[31]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[31]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[3]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[3]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[4]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[4]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[5]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[5]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[6]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[6]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[7]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[7]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[8]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[8]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_rdata[9]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_rdata[9]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[0]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[0]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[10]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[10]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[11]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[11]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[12]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[12]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[13]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[13]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[14]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[14]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[15]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[15]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[16]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[16]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[17]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[17]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[18]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[18]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[19]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[19]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[1]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[1]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[20]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[20]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[21]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[21]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[22]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[22]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[23]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[23]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[24]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[24]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[25]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[25]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[26]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[26]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[27]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[27]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[28]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[28]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[29]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[29]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[2]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[2]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[30]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[30]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[31]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[31]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[3]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[3]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[4]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[4]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[5]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[5]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[6]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[6]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[7]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[7]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[8]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[8]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_wdata[9]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_wdata[9]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_dmem_we}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_dmem_we}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[0]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[0]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[10]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[10]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[11]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[11]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[12]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[12]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[13]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[13]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[14]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[14]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[15]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[15]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[16]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[16]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[17]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[17]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[18]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[18]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[19]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[19]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[1]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[1]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[20]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[20]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[21]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[21]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[22]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[22]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[23]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[23]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[24]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[24]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[25]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[25]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[26]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[26]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[27]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[27]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[28]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[28]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[29]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[29]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[2]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[2]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[30]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[30]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[31]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[31]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[3]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[3]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[4]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[4]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[5]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[5]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[6]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[6]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[7]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[7]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[8]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[8]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_addr[9]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_addr[9]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[0]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[0]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[10]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[10]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[11]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[11]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[12]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[12]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[13]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[13]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[14]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[14]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[15]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[15]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[16]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[16]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[17]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[17]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[18]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[18]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[19]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[19]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[1]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[1]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[20]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[20]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[21]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[21]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[22]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[22]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[23]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[23]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[24]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[24]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[25]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[25]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[26]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[26]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[27]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[27]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[28]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[28]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[29]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[29]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[2]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[2]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[30]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[30]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[31]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[31]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[3]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[3]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[4]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[4]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[5]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[5]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[6]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[6]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[7]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[7]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[8]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[8]}]
set_output_delay -1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dbg_imem_data[9]}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dbg_imem_data[9]}]
set_multicycle_path -hold\
    -to [list [get_ports {dbg_dmem_addr[0]}]\
           [get_ports {dbg_dmem_addr[10]}]\
           [get_ports {dbg_dmem_addr[11]}]\
           [get_ports {dbg_dmem_addr[12]}]\
           [get_ports {dbg_dmem_addr[13]}]\
           [get_ports {dbg_dmem_addr[14]}]\
           [get_ports {dbg_dmem_addr[15]}]\
           [get_ports {dbg_dmem_addr[16]}]\
           [get_ports {dbg_dmem_addr[17]}]\
           [get_ports {dbg_dmem_addr[18]}]\
           [get_ports {dbg_dmem_addr[19]}]\
           [get_ports {dbg_dmem_addr[1]}]\
           [get_ports {dbg_dmem_addr[20]}]\
           [get_ports {dbg_dmem_addr[21]}]\
           [get_ports {dbg_dmem_addr[22]}]\
           [get_ports {dbg_dmem_addr[23]}]\
           [get_ports {dbg_dmem_addr[24]}]\
           [get_ports {dbg_dmem_addr[25]}]\
           [get_ports {dbg_dmem_addr[26]}]\
           [get_ports {dbg_dmem_addr[27]}]\
           [get_ports {dbg_dmem_addr[28]}]\
           [get_ports {dbg_dmem_addr[29]}]\
           [get_ports {dbg_dmem_addr[2]}]\
           [get_ports {dbg_dmem_addr[30]}]\
           [get_ports {dbg_dmem_addr[31]}]\
           [get_ports {dbg_dmem_addr[3]}]\
           [get_ports {dbg_dmem_addr[4]}]\
           [get_ports {dbg_dmem_addr[5]}]\
           [get_ports {dbg_dmem_addr[6]}]\
           [get_ports {dbg_dmem_addr[7]}]\
           [get_ports {dbg_dmem_addr[8]}]\
           [get_ports {dbg_dmem_addr[9]}]\
           [get_ports {dbg_dmem_rdata[0]}]\
           [get_ports {dbg_dmem_rdata[10]}]\
           [get_ports {dbg_dmem_rdata[11]}]\
           [get_ports {dbg_dmem_rdata[12]}]\
           [get_ports {dbg_dmem_rdata[13]}]\
           [get_ports {dbg_dmem_rdata[14]}]\
           [get_ports {dbg_dmem_rdata[15]}]\
           [get_ports {dbg_dmem_rdata[16]}]\
           [get_ports {dbg_dmem_rdata[17]}]\
           [get_ports {dbg_dmem_rdata[18]}]\
           [get_ports {dbg_dmem_rdata[19]}]\
           [get_ports {dbg_dmem_rdata[1]}]\
           [get_ports {dbg_dmem_rdata[20]}]\
           [get_ports {dbg_dmem_rdata[21]}]\
           [get_ports {dbg_dmem_rdata[22]}]\
           [get_ports {dbg_dmem_rdata[23]}]\
           [get_ports {dbg_dmem_rdata[24]}]\
           [get_ports {dbg_dmem_rdata[25]}]\
           [get_ports {dbg_dmem_rdata[26]}]\
           [get_ports {dbg_dmem_rdata[27]}]\
           [get_ports {dbg_dmem_rdata[28]}]\
           [get_ports {dbg_dmem_rdata[29]}]\
           [get_ports {dbg_dmem_rdata[2]}]\
           [get_ports {dbg_dmem_rdata[30]}]\
           [get_ports {dbg_dmem_rdata[31]}]\
           [get_ports {dbg_dmem_rdata[3]}]\
           [get_ports {dbg_dmem_rdata[4]}]\
           [get_ports {dbg_dmem_rdata[5]}]\
           [get_ports {dbg_dmem_rdata[6]}]\
           [get_ports {dbg_dmem_rdata[7]}]\
           [get_ports {dbg_dmem_rdata[8]}]\
           [get_ports {dbg_dmem_rdata[9]}]\
           [get_ports {dbg_dmem_wdata[0]}]\
           [get_ports {dbg_dmem_wdata[10]}]\
           [get_ports {dbg_dmem_wdata[11]}]\
           [get_ports {dbg_dmem_wdata[12]}]\
           [get_ports {dbg_dmem_wdata[13]}]\
           [get_ports {dbg_dmem_wdata[14]}]\
           [get_ports {dbg_dmem_wdata[15]}]\
           [get_ports {dbg_dmem_wdata[16]}]\
           [get_ports {dbg_dmem_wdata[17]}]\
           [get_ports {dbg_dmem_wdata[18]}]\
           [get_ports {dbg_dmem_wdata[19]}]\
           [get_ports {dbg_dmem_wdata[1]}]\
           [get_ports {dbg_dmem_wdata[20]}]\
           [get_ports {dbg_dmem_wdata[21]}]\
           [get_ports {dbg_dmem_wdata[22]}]\
           [get_ports {dbg_dmem_wdata[23]}]\
           [get_ports {dbg_dmem_wdata[24]}]\
           [get_ports {dbg_dmem_wdata[25]}]\
           [get_ports {dbg_dmem_wdata[26]}]\
           [get_ports {dbg_dmem_wdata[27]}]\
           [get_ports {dbg_dmem_wdata[28]}]\
           [get_ports {dbg_dmem_wdata[29]}]\
           [get_ports {dbg_dmem_wdata[2]}]\
           [get_ports {dbg_dmem_wdata[30]}]\
           [get_ports {dbg_dmem_wdata[31]}]\
           [get_ports {dbg_dmem_wdata[3]}]\
           [get_ports {dbg_dmem_wdata[4]}]\
           [get_ports {dbg_dmem_wdata[5]}]\
           [get_ports {dbg_dmem_wdata[6]}]\
           [get_ports {dbg_dmem_wdata[7]}]\
           [get_ports {dbg_dmem_wdata[8]}]\
           [get_ports {dbg_dmem_wdata[9]}]\
           [get_ports {dbg_dmem_we}]\
           [get_ports {dbg_imem_addr[0]}]\
           [get_ports {dbg_imem_addr[10]}]\
           [get_ports {dbg_imem_addr[11]}]\
           [get_ports {dbg_imem_addr[12]}]\
           [get_ports {dbg_imem_addr[13]}]\
           [get_ports {dbg_imem_addr[14]}]\
           [get_ports {dbg_imem_addr[15]}]\
           [get_ports {dbg_imem_addr[16]}]\
           [get_ports {dbg_imem_addr[17]}]\
           [get_ports {dbg_imem_addr[18]}]\
           [get_ports {dbg_imem_addr[19]}]\
           [get_ports {dbg_imem_addr[1]}]\
           [get_ports {dbg_imem_addr[20]}]\
           [get_ports {dbg_imem_addr[21]}]\
           [get_ports {dbg_imem_addr[22]}]\
           [get_ports {dbg_imem_addr[23]}]\
           [get_ports {dbg_imem_addr[24]}]\
           [get_ports {dbg_imem_addr[25]}]\
           [get_ports {dbg_imem_addr[26]}]\
           [get_ports {dbg_imem_addr[27]}]\
           [get_ports {dbg_imem_addr[28]}]\
           [get_ports {dbg_imem_addr[29]}]\
           [get_ports {dbg_imem_addr[2]}]\
           [get_ports {dbg_imem_addr[30]}]\
           [get_ports {dbg_imem_addr[31]}]\
           [get_ports {dbg_imem_addr[3]}]\
           [get_ports {dbg_imem_addr[4]}]\
           [get_ports {dbg_imem_addr[5]}]\
           [get_ports {dbg_imem_addr[6]}]\
           [get_ports {dbg_imem_addr[7]}]\
           [get_ports {dbg_imem_addr[8]}]\
           [get_ports {dbg_imem_addr[9]}]\
           [get_ports {dbg_imem_data[0]}]\
           [get_ports {dbg_imem_data[10]}]\
           [get_ports {dbg_imem_data[11]}]\
           [get_ports {dbg_imem_data[12]}]\
           [get_ports {dbg_imem_data[13]}]\
           [get_ports {dbg_imem_data[14]}]\
           [get_ports {dbg_imem_data[15]}]\
           [get_ports {dbg_imem_data[16]}]\
           [get_ports {dbg_imem_data[17]}]\
           [get_ports {dbg_imem_data[18]}]\
           [get_ports {dbg_imem_data[19]}]\
           [get_ports {dbg_imem_data[1]}]\
           [get_ports {dbg_imem_data[20]}]\
           [get_ports {dbg_imem_data[21]}]\
           [get_ports {dbg_imem_data[22]}]\
           [get_ports {dbg_imem_data[23]}]\
           [get_ports {dbg_imem_data[24]}]\
           [get_ports {dbg_imem_data[25]}]\
           [get_ports {dbg_imem_data[26]}]\
           [get_ports {dbg_imem_data[27]}]\
           [get_ports {dbg_imem_data[28]}]\
           [get_ports {dbg_imem_data[29]}]\
           [get_ports {dbg_imem_data[2]}]\
           [get_ports {dbg_imem_data[30]}]\
           [get_ports {dbg_imem_data[31]}]\
           [get_ports {dbg_imem_data[3]}]\
           [get_ports {dbg_imem_data[4]}]\
           [get_ports {dbg_imem_data[5]}]\
           [get_ports {dbg_imem_data[6]}]\
           [get_ports {dbg_imem_data[7]}]\
           [get_ports {dbg_imem_data[8]}]\
           [get_ports {dbg_imem_data[9]}]] 1
set_multicycle_path -setup\
    -to [list [get_ports {dbg_dmem_addr[0]}]\
           [get_ports {dbg_dmem_addr[10]}]\
           [get_ports {dbg_dmem_addr[11]}]\
           [get_ports {dbg_dmem_addr[12]}]\
           [get_ports {dbg_dmem_addr[13]}]\
           [get_ports {dbg_dmem_addr[14]}]\
           [get_ports {dbg_dmem_addr[15]}]\
           [get_ports {dbg_dmem_addr[16]}]\
           [get_ports {dbg_dmem_addr[17]}]\
           [get_ports {dbg_dmem_addr[18]}]\
           [get_ports {dbg_dmem_addr[19]}]\
           [get_ports {dbg_dmem_addr[1]}]\
           [get_ports {dbg_dmem_addr[20]}]\
           [get_ports {dbg_dmem_addr[21]}]\
           [get_ports {dbg_dmem_addr[22]}]\
           [get_ports {dbg_dmem_addr[23]}]\
           [get_ports {dbg_dmem_addr[24]}]\
           [get_ports {dbg_dmem_addr[25]}]\
           [get_ports {dbg_dmem_addr[26]}]\
           [get_ports {dbg_dmem_addr[27]}]\
           [get_ports {dbg_dmem_addr[28]}]\
           [get_ports {dbg_dmem_addr[29]}]\
           [get_ports {dbg_dmem_addr[2]}]\
           [get_ports {dbg_dmem_addr[30]}]\
           [get_ports {dbg_dmem_addr[31]}]\
           [get_ports {dbg_dmem_addr[3]}]\
           [get_ports {dbg_dmem_addr[4]}]\
           [get_ports {dbg_dmem_addr[5]}]\
           [get_ports {dbg_dmem_addr[6]}]\
           [get_ports {dbg_dmem_addr[7]}]\
           [get_ports {dbg_dmem_addr[8]}]\
           [get_ports {dbg_dmem_addr[9]}]\
           [get_ports {dbg_dmem_rdata[0]}]\
           [get_ports {dbg_dmem_rdata[10]}]\
           [get_ports {dbg_dmem_rdata[11]}]\
           [get_ports {dbg_dmem_rdata[12]}]\
           [get_ports {dbg_dmem_rdata[13]}]\
           [get_ports {dbg_dmem_rdata[14]}]\
           [get_ports {dbg_dmem_rdata[15]}]\
           [get_ports {dbg_dmem_rdata[16]}]\
           [get_ports {dbg_dmem_rdata[17]}]\
           [get_ports {dbg_dmem_rdata[18]}]\
           [get_ports {dbg_dmem_rdata[19]}]\
           [get_ports {dbg_dmem_rdata[1]}]\
           [get_ports {dbg_dmem_rdata[20]}]\
           [get_ports {dbg_dmem_rdata[21]}]\
           [get_ports {dbg_dmem_rdata[22]}]\
           [get_ports {dbg_dmem_rdata[23]}]\
           [get_ports {dbg_dmem_rdata[24]}]\
           [get_ports {dbg_dmem_rdata[25]}]\
           [get_ports {dbg_dmem_rdata[26]}]\
           [get_ports {dbg_dmem_rdata[27]}]\
           [get_ports {dbg_dmem_rdata[28]}]\
           [get_ports {dbg_dmem_rdata[29]}]\
           [get_ports {dbg_dmem_rdata[2]}]\
           [get_ports {dbg_dmem_rdata[30]}]\
           [get_ports {dbg_dmem_rdata[31]}]\
           [get_ports {dbg_dmem_rdata[3]}]\
           [get_ports {dbg_dmem_rdata[4]}]\
           [get_ports {dbg_dmem_rdata[5]}]\
           [get_ports {dbg_dmem_rdata[6]}]\
           [get_ports {dbg_dmem_rdata[7]}]\
           [get_ports {dbg_dmem_rdata[8]}]\
           [get_ports {dbg_dmem_rdata[9]}]\
           [get_ports {dbg_dmem_wdata[0]}]\
           [get_ports {dbg_dmem_wdata[10]}]\
           [get_ports {dbg_dmem_wdata[11]}]\
           [get_ports {dbg_dmem_wdata[12]}]\
           [get_ports {dbg_dmem_wdata[13]}]\
           [get_ports {dbg_dmem_wdata[14]}]\
           [get_ports {dbg_dmem_wdata[15]}]\
           [get_ports {dbg_dmem_wdata[16]}]\
           [get_ports {dbg_dmem_wdata[17]}]\
           [get_ports {dbg_dmem_wdata[18]}]\
           [get_ports {dbg_dmem_wdata[19]}]\
           [get_ports {dbg_dmem_wdata[1]}]\
           [get_ports {dbg_dmem_wdata[20]}]\
           [get_ports {dbg_dmem_wdata[21]}]\
           [get_ports {dbg_dmem_wdata[22]}]\
           [get_ports {dbg_dmem_wdata[23]}]\
           [get_ports {dbg_dmem_wdata[24]}]\
           [get_ports {dbg_dmem_wdata[25]}]\
           [get_ports {dbg_dmem_wdata[26]}]\
           [get_ports {dbg_dmem_wdata[27]}]\
           [get_ports {dbg_dmem_wdata[28]}]\
           [get_ports {dbg_dmem_wdata[29]}]\
           [get_ports {dbg_dmem_wdata[2]}]\
           [get_ports {dbg_dmem_wdata[30]}]\
           [get_ports {dbg_dmem_wdata[31]}]\
           [get_ports {dbg_dmem_wdata[3]}]\
           [get_ports {dbg_dmem_wdata[4]}]\
           [get_ports {dbg_dmem_wdata[5]}]\
           [get_ports {dbg_dmem_wdata[6]}]\
           [get_ports {dbg_dmem_wdata[7]}]\
           [get_ports {dbg_dmem_wdata[8]}]\
           [get_ports {dbg_dmem_wdata[9]}]\
           [get_ports {dbg_dmem_we}]\
           [get_ports {dbg_imem_addr[0]}]\
           [get_ports {dbg_imem_addr[10]}]\
           [get_ports {dbg_imem_addr[11]}]\
           [get_ports {dbg_imem_addr[12]}]\
           [get_ports {dbg_imem_addr[13]}]\
           [get_ports {dbg_imem_addr[14]}]\
           [get_ports {dbg_imem_addr[15]}]\
           [get_ports {dbg_imem_addr[16]}]\
           [get_ports {dbg_imem_addr[17]}]\
           [get_ports {dbg_imem_addr[18]}]\
           [get_ports {dbg_imem_addr[19]}]\
           [get_ports {dbg_imem_addr[1]}]\
           [get_ports {dbg_imem_addr[20]}]\
           [get_ports {dbg_imem_addr[21]}]\
           [get_ports {dbg_imem_addr[22]}]\
           [get_ports {dbg_imem_addr[23]}]\
           [get_ports {dbg_imem_addr[24]}]\
           [get_ports {dbg_imem_addr[25]}]\
           [get_ports {dbg_imem_addr[26]}]\
           [get_ports {dbg_imem_addr[27]}]\
           [get_ports {dbg_imem_addr[28]}]\
           [get_ports {dbg_imem_addr[29]}]\
           [get_ports {dbg_imem_addr[2]}]\
           [get_ports {dbg_imem_addr[30]}]\
           [get_ports {dbg_imem_addr[31]}]\
           [get_ports {dbg_imem_addr[3]}]\
           [get_ports {dbg_imem_addr[4]}]\
           [get_ports {dbg_imem_addr[5]}]\
           [get_ports {dbg_imem_addr[6]}]\
           [get_ports {dbg_imem_addr[7]}]\
           [get_ports {dbg_imem_addr[8]}]\
           [get_ports {dbg_imem_addr[9]}]\
           [get_ports {dbg_imem_data[0]}]\
           [get_ports {dbg_imem_data[10]}]\
           [get_ports {dbg_imem_data[11]}]\
           [get_ports {dbg_imem_data[12]}]\
           [get_ports {dbg_imem_data[13]}]\
           [get_ports {dbg_imem_data[14]}]\
           [get_ports {dbg_imem_data[15]}]\
           [get_ports {dbg_imem_data[16]}]\
           [get_ports {dbg_imem_data[17]}]\
           [get_ports {dbg_imem_data[18]}]\
           [get_ports {dbg_imem_data[19]}]\
           [get_ports {dbg_imem_data[1]}]\
           [get_ports {dbg_imem_data[20]}]\
           [get_ports {dbg_imem_data[21]}]\
           [get_ports {dbg_imem_data[22]}]\
           [get_ports {dbg_imem_data[23]}]\
           [get_ports {dbg_imem_data[24]}]\
           [get_ports {dbg_imem_data[25]}]\
           [get_ports {dbg_imem_data[26]}]\
           [get_ports {dbg_imem_data[27]}]\
           [get_ports {dbg_imem_data[28]}]\
           [get_ports {dbg_imem_data[29]}]\
           [get_ports {dbg_imem_data[2]}]\
           [get_ports {dbg_imem_data[30]}]\
           [get_ports {dbg_imem_data[31]}]\
           [get_ports {dbg_imem_data[3]}]\
           [get_ports {dbg_imem_data[4]}]\
           [get_ports {dbg_imem_data[5]}]\
           [get_ports {dbg_imem_data[6]}]\
           [get_ports {dbg_imem_data[7]}]\
           [get_ports {dbg_imem_data[8]}]\
           [get_ports {dbg_imem_data[9]}]] 2
set_false_path\
    -from [list [get_ports {prog_addr[0]}]\
           [get_ports {prog_addr[1]}]\
           [get_ports {prog_addr[2]}]\
           [get_ports {prog_addr[3]}]\
           [get_ports {prog_addr[4]}]\
           [get_ports {prog_addr[5]}]\
           [get_ports {prog_addr[6]}]\
           [get_ports {prog_addr[7]}]\
           [get_ports {prog_data[0]}]\
           [get_ports {prog_data[10]}]\
           [get_ports {prog_data[11]}]\
           [get_ports {prog_data[12]}]\
           [get_ports {prog_data[13]}]\
           [get_ports {prog_data[14]}]\
           [get_ports {prog_data[15]}]\
           [get_ports {prog_data[16]}]\
           [get_ports {prog_data[17]}]\
           [get_ports {prog_data[18]}]\
           [get_ports {prog_data[19]}]\
           [get_ports {prog_data[1]}]\
           [get_ports {prog_data[20]}]\
           [get_ports {prog_data[21]}]\
           [get_ports {prog_data[22]}]\
           [get_ports {prog_data[23]}]\
           [get_ports {prog_data[24]}]\
           [get_ports {prog_data[25]}]\
           [get_ports {prog_data[26]}]\
           [get_ports {prog_data[27]}]\
           [get_ports {prog_data[28]}]\
           [get_ports {prog_data[29]}]\
           [get_ports {prog_data[2]}]\
           [get_ports {prog_data[30]}]\
           [get_ports {prog_data[31]}]\
           [get_ports {prog_data[3]}]\
           [get_ports {prog_data[4]}]\
           [get_ports {prog_data[5]}]\
           [get_ports {prog_data[6]}]\
           [get_ports {prog_data[7]}]\
           [get_ports {prog_data[8]}]\
           [get_ports {prog_data[9]}]\
           [get_ports {prog_we}]]
set_false_path\
    -to [list [get_ports {dbg_dmem_addr[0]}]\
           [get_ports {dbg_dmem_addr[10]}]\
           [get_ports {dbg_dmem_addr[11]}]\
           [get_ports {dbg_dmem_addr[12]}]\
           [get_ports {dbg_dmem_addr[13]}]\
           [get_ports {dbg_dmem_addr[14]}]\
           [get_ports {dbg_dmem_addr[15]}]\
           [get_ports {dbg_dmem_addr[16]}]\
           [get_ports {dbg_dmem_addr[17]}]\
           [get_ports {dbg_dmem_addr[18]}]\
           [get_ports {dbg_dmem_addr[19]}]\
           [get_ports {dbg_dmem_addr[1]}]\
           [get_ports {dbg_dmem_addr[20]}]\
           [get_ports {dbg_dmem_addr[21]}]\
           [get_ports {dbg_dmem_addr[22]}]\
           [get_ports {dbg_dmem_addr[23]}]\
           [get_ports {dbg_dmem_addr[24]}]\
           [get_ports {dbg_dmem_addr[25]}]\
           [get_ports {dbg_dmem_addr[26]}]\
           [get_ports {dbg_dmem_addr[27]}]\
           [get_ports {dbg_dmem_addr[28]}]\
           [get_ports {dbg_dmem_addr[29]}]\
           [get_ports {dbg_dmem_addr[2]}]\
           [get_ports {dbg_dmem_addr[30]}]\
           [get_ports {dbg_dmem_addr[31]}]\
           [get_ports {dbg_dmem_addr[3]}]\
           [get_ports {dbg_dmem_addr[4]}]\
           [get_ports {dbg_dmem_addr[5]}]\
           [get_ports {dbg_dmem_addr[6]}]\
           [get_ports {dbg_dmem_addr[7]}]\
           [get_ports {dbg_dmem_addr[8]}]\
           [get_ports {dbg_dmem_addr[9]}]\
           [get_ports {dbg_dmem_rdata[0]}]\
           [get_ports {dbg_dmem_rdata[10]}]\
           [get_ports {dbg_dmem_rdata[11]}]\
           [get_ports {dbg_dmem_rdata[12]}]\
           [get_ports {dbg_dmem_rdata[13]}]\
           [get_ports {dbg_dmem_rdata[14]}]\
           [get_ports {dbg_dmem_rdata[15]}]\
           [get_ports {dbg_dmem_rdata[16]}]\
           [get_ports {dbg_dmem_rdata[17]}]\
           [get_ports {dbg_dmem_rdata[18]}]\
           [get_ports {dbg_dmem_rdata[19]}]\
           [get_ports {dbg_dmem_rdata[1]}]\
           [get_ports {dbg_dmem_rdata[20]}]\
           [get_ports {dbg_dmem_rdata[21]}]\
           [get_ports {dbg_dmem_rdata[22]}]\
           [get_ports {dbg_dmem_rdata[23]}]\
           [get_ports {dbg_dmem_rdata[24]}]\
           [get_ports {dbg_dmem_rdata[25]}]\
           [get_ports {dbg_dmem_rdata[26]}]\
           [get_ports {dbg_dmem_rdata[27]}]\
           [get_ports {dbg_dmem_rdata[28]}]\
           [get_ports {dbg_dmem_rdata[29]}]\
           [get_ports {dbg_dmem_rdata[2]}]\
           [get_ports {dbg_dmem_rdata[30]}]\
           [get_ports {dbg_dmem_rdata[31]}]\
           [get_ports {dbg_dmem_rdata[3]}]\
           [get_ports {dbg_dmem_rdata[4]}]\
           [get_ports {dbg_dmem_rdata[5]}]\
           [get_ports {dbg_dmem_rdata[6]}]\
           [get_ports {dbg_dmem_rdata[7]}]\
           [get_ports {dbg_dmem_rdata[8]}]\
           [get_ports {dbg_dmem_rdata[9]}]\
           [get_ports {dbg_dmem_wdata[0]}]\
           [get_ports {dbg_dmem_wdata[10]}]\
           [get_ports {dbg_dmem_wdata[11]}]\
           [get_ports {dbg_dmem_wdata[12]}]\
           [get_ports {dbg_dmem_wdata[13]}]\
           [get_ports {dbg_dmem_wdata[14]}]\
           [get_ports {dbg_dmem_wdata[15]}]\
           [get_ports {dbg_dmem_wdata[16]}]\
           [get_ports {dbg_dmem_wdata[17]}]\
           [get_ports {dbg_dmem_wdata[18]}]\
           [get_ports {dbg_dmem_wdata[19]}]\
           [get_ports {dbg_dmem_wdata[1]}]\
           [get_ports {dbg_dmem_wdata[20]}]\
           [get_ports {dbg_dmem_wdata[21]}]\
           [get_ports {dbg_dmem_wdata[22]}]\
           [get_ports {dbg_dmem_wdata[23]}]\
           [get_ports {dbg_dmem_wdata[24]}]\
           [get_ports {dbg_dmem_wdata[25]}]\
           [get_ports {dbg_dmem_wdata[26]}]\
           [get_ports {dbg_dmem_wdata[27]}]\
           [get_ports {dbg_dmem_wdata[28]}]\
           [get_ports {dbg_dmem_wdata[29]}]\
           [get_ports {dbg_dmem_wdata[2]}]\
           [get_ports {dbg_dmem_wdata[30]}]\
           [get_ports {dbg_dmem_wdata[31]}]\
           [get_ports {dbg_dmem_wdata[3]}]\
           [get_ports {dbg_dmem_wdata[4]}]\
           [get_ports {dbg_dmem_wdata[5]}]\
           [get_ports {dbg_dmem_wdata[6]}]\
           [get_ports {dbg_dmem_wdata[7]}]\
           [get_ports {dbg_dmem_wdata[8]}]\
           [get_ports {dbg_dmem_wdata[9]}]\
           [get_ports {dbg_dmem_we}]\
           [get_ports {dbg_imem_addr[0]}]\
           [get_ports {dbg_imem_addr[10]}]\
           [get_ports {dbg_imem_addr[11]}]\
           [get_ports {dbg_imem_addr[12]}]\
           [get_ports {dbg_imem_addr[13]}]\
           [get_ports {dbg_imem_addr[14]}]\
           [get_ports {dbg_imem_addr[15]}]\
           [get_ports {dbg_imem_addr[16]}]\
           [get_ports {dbg_imem_addr[17]}]\
           [get_ports {dbg_imem_addr[18]}]\
           [get_ports {dbg_imem_addr[19]}]\
           [get_ports {dbg_imem_addr[1]}]\
           [get_ports {dbg_imem_addr[20]}]\
           [get_ports {dbg_imem_addr[21]}]\
           [get_ports {dbg_imem_addr[22]}]\
           [get_ports {dbg_imem_addr[23]}]\
           [get_ports {dbg_imem_addr[24]}]\
           [get_ports {dbg_imem_addr[25]}]\
           [get_ports {dbg_imem_addr[26]}]\
           [get_ports {dbg_imem_addr[27]}]\
           [get_ports {dbg_imem_addr[28]}]\
           [get_ports {dbg_imem_addr[29]}]\
           [get_ports {dbg_imem_addr[2]}]\
           [get_ports {dbg_imem_addr[30]}]\
           [get_ports {dbg_imem_addr[31]}]\
           [get_ports {dbg_imem_addr[3]}]\
           [get_ports {dbg_imem_addr[4]}]\
           [get_ports {dbg_imem_addr[5]}]\
           [get_ports {dbg_imem_addr[6]}]\
           [get_ports {dbg_imem_addr[7]}]\
           [get_ports {dbg_imem_addr[8]}]\
           [get_ports {dbg_imem_addr[9]}]\
           [get_ports {dbg_imem_data[0]}]\
           [get_ports {dbg_imem_data[10]}]\
           [get_ports {dbg_imem_data[11]}]\
           [get_ports {dbg_imem_data[12]}]\
           [get_ports {dbg_imem_data[13]}]\
           [get_ports {dbg_imem_data[14]}]\
           [get_ports {dbg_imem_data[15]}]\
           [get_ports {dbg_imem_data[16]}]\
           [get_ports {dbg_imem_data[17]}]\
           [get_ports {dbg_imem_data[18]}]\
           [get_ports {dbg_imem_data[19]}]\
           [get_ports {dbg_imem_data[1]}]\
           [get_ports {dbg_imem_data[20]}]\
           [get_ports {dbg_imem_data[21]}]\
           [get_ports {dbg_imem_data[22]}]\
           [get_ports {dbg_imem_data[23]}]\
           [get_ports {dbg_imem_data[24]}]\
           [get_ports {dbg_imem_data[25]}]\
           [get_ports {dbg_imem_data[26]}]\
           [get_ports {dbg_imem_data[27]}]\
           [get_ports {dbg_imem_data[28]}]\
           [get_ports {dbg_imem_data[29]}]\
           [get_ports {dbg_imem_data[2]}]\
           [get_ports {dbg_imem_data[30]}]\
           [get_ports {dbg_imem_data[31]}]\
           [get_ports {dbg_imem_data[3]}]\
           [get_ports {dbg_imem_data[4]}]\
           [get_ports {dbg_imem_data[5]}]\
           [get_ports {dbg_imem_data[6]}]\
           [get_ports {dbg_imem_data[7]}]\
           [get_ports {dbg_imem_data[8]}]\
           [get_ports {dbg_imem_data[9]}]]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
set_max_transition 1.5000 [current_design]
