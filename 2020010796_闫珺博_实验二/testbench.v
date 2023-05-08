`timescale 1ns/1ps
`define PERIOD 10
`define PERIOD2 100000
module react_tb();
 reg clk ;
 reg rst_n;
 reg button;
 wire LED_out;
 wire [3:0] AN_out;
 wire [7:0] leds_out;
 reg [14:0]dtime;
 reg [14:0]temp1;
 reg [14:0]temp2;

 // Generate the clock
 initial begin
 forever
 #(`PERIOD/2) clk = ~clk;
 end

 // Adder Instance
 top react (
 .sysclk (clk),
 .BTNU (rst_n),
 .BTND(button),
 .LED(LED_out),
 .AN(AN_out),
 .leds(leds_out)
 );
 // Check Output
 task get_dtime();
 begin
 case(leds_out[6:0])   
          7'b1000000: temp1=0;
          7'b1111001: temp1=1;
          7'b0100100: temp1=2;
          7'b0110000: temp1=3;
          7'b0011001: temp1=4;
          7'b0010010: temp1=5;
          7'b0000010: temp1=6;
          7'b1111000: temp1=7;          
          7'b0000000: temp1=8;
          7'b0010000: temp1=9;
 endcase
 case(AN_out)     
        4'b0111:temp2=1000;
        4'b1011:temp2=100;
        4'b1101:temp2=10;
        4'b1110:temp2=1;
 endcase
 dtime=dtime+temp1*temp2;
 
 end
 endtask
initial begin
 // Initialization
 rst_n = 1'b1;
 clk = 1'b0;
 temp1=0;
 temp2=0;
 dtime=0;
 button=0;
 #(`PERIOD2*500);
 rst_n = 1'b0;
 #(`PERIOD2*13456);
 button=1;
 #(`PERIOD2*500);
 button=0;
 $display("Stimulation Start.");
 // Test
 #(`PERIOD*10);
 get_dtime();
 #(`PERIOD2*10);
 get_dtime();
 #(`PERIOD2*10);
 get_dtime();
 #(`PERIOD2*10);
 get_dtime();
 #(`PERIOD*1000000);
 $display(dtime);
 if (dtime==3455)begin
 $display("Correct!");
 end
 else begin
 $display("Wrong!");
 end
 #(`PERIOD*2);
 
 $finish;
 end
 
endmodule