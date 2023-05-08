set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {led0}]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports {led5}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {led6}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {led7}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {BTND}]
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33}  [get_ports {system_clk}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {SW1}]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {reset}]
create_clock -period 10.00 [get_ports system_clk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {BTND}]



