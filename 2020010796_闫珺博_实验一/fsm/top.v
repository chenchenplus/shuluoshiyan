module top (reset,BTND,SW1,system_clk,led0,led5,led6,led7);
input BTND,system_clk,SW1,reset;
output led0,led5,led6,led7;
wire clk;
debounce xdebounce(system_clk,BTND,clk);
fsm detector(clk,led0,led5,led6,led7,SW1,reset);
endmodule