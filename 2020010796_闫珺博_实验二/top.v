module top (BTNU,BTND,sysclk,LED,AN,leds);
    input BTNU,BTND,sysclk;
    output [7:0] leds;
    output [3:0] AN;
    output  LED;
    wire [7:0] leds;
    wire [1:0] flag;
    wire clk_1k,clk_10k;
    wire [15:0]qout;
   
    clk_gen clk1k(sysclk,BTNU,clk_1k);
    clk_gen #(5000) clk10k(sysclk,BTNU,clk_10k);
    reactspeed reacts(clk_10k,qout,BTND,BTNU,flag);
    LEDs LEDS(clk_1k,qout,LED,AN,leds,BTNU,flag);
endmodule