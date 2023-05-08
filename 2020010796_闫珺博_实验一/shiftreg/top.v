module top (reset,BTND,SW1,system_clk,led,out);
input BTND,system_clk,SW1,reset;
output [5:0]led;
output out;
wire clk;
debounce xdebounce(system_clk,BTND,clk);
shiftreg detector(clk,led,out,SW1,reset);
endmodule