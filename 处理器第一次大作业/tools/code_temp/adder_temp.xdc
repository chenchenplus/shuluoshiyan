create_clock -period 10.000 -name clkin [get_ports clk]
set_input_delay -max 5 -clock clkin [get_ports M]
set_input_delay -max 5 -clock clkin [get_ports m]
set_input_delay -max 5 -clock clkin [get_ports Iin]
