module top (an,ano,BTND,system_clk,SWO,leds);
input BTND,system_clk,SWO;
input [3:0] an;
output [6:0] leds;
output [3:0]ano;
assign ano=an;
wire [6:0] leds;
wire clk;
debounce xdebounce(system_clk,BTND,clk);
led cntled(clk,SWO,leds);
endmodule