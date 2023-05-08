`timescale 1ns/1ps
`define PERIOD 10
module adder_temp_tb();
 reg clk;
 reg rst;
 reg [31:0]Iin;
 reg [3:0]I[7:0];
 reg [2:0]M;
 reg [2:0]m;
 wire [7:0]Y;
 initial begin
 forever
 #(`PERIOD/2) clk = ~clk;
 end
 adder_temp adder (
 .Iin(Iin),
 .M(M),
 .m(m),
 .Y(Y),
 .clk(clk),
 .rst(rst)
 );
 initial begin
 clk = 1'b0;
 rst = 1'b1;
 Iin=$random;
  I[0]=Iin[3:0];
  I[1]=Iin[7:4];
  I[2]=Iin[11:8];
  I[3]=Iin[15:12];
  I[4]=Iin[19:16];
  I[5]=Iin[23:20];
  I[6]=Iin[27:24];
  I[7]=Iin[31:28];
 #(`PERIOD*5)
 rst=1'b0;
 #(`PERIOD*5)
 $display("Stimulation Start.");
 //M==m
 M=3'b110;
 m=3'b110;
 rst=1'b1;
 #(`PERIOD*5)
 rst=1'b0;
 #(`PERIOD*20)
 if(Y==I[6])
 $display("Adder Correct.");
 else
 $display("Adder Error!");
 #(`PERIOD);

 M=3'b010;
 m=3'b010;
 rst=1'b1;
 #(`PERIOD*5)
 rst=1'b0;
 #(`PERIOD*20)
 if(Y==I[2])
 $display("Adder Correct.");
 else
 $display("Adder Error!");
 #(`PERIOD);

 M=3'b111;
 m=3'b111;
 rst=1'b1;
 #(`PERIOD*5)
 rst=1'b0;
 #(`PERIOD*20)
 if(Y==I[7])
 $display("Adder Correct.");
 else
 $display("Adder Error!");
 #(`PERIOD);

 //M>m
 M=3'b111;
 m=3'b110;
 rst=1'b1;
 #(`PERIOD*5)
 rst=1'b0;
 #(`PERIOD*20)
 if(Y==I[6]+I[7])
 $display("Adder Correct.");
 else
 $display("Adder Error!");
 #(`PERIOD);

 M=3'b110;
 m=3'b000;
 rst=1'b1;
 #(`PERIOD*5)
 rst=1'b0;
 #(`PERIOD*20)
 if(Y==I[6]+I[5]+I[4]+I[3]+I[2]+I[1]+I[0])
 $display("Adder Correct.");
 else
 $display("Adder Error!");
 #(`PERIOD);

 M=3'b001;
 m=3'b000;
 rst=1'b1;
 #(`PERIOD*5)
 rst=1'b0;
 #(`PERIOD*20)
 if(Y==I[1]+I[0])
 $display("Adder Correct.");
 else
 $display("Adder Error!");
 #(`PERIOD);

 //M<m
 M=3'b000;
 m=3'b100;
 rst=1'b1;
 #(`PERIOD*5)
 rst=1'b0;
 #(`PERIOD*20)
 if(Y==I[4]+I[3]+I[2]+I[1]+I[0])
 $display("Adder Correct.");
 else
 $display("Adder Error!");
 #(`PERIOD);

 M=3'b001;
 m=3'b010;
 rst=1'b1;
 #(`PERIOD*5)
 rst=1'b0;
 #(`PERIOD*20)
 if(Y==I[2]+I[1])
 $display("Adder Correct.");
 else
 $display("Adder Error!");
 #(`PERIOD);

 M=3'b100;
 m=3'b101;
 rst=1'b1;
 #(`PERIOD*5)
 rst=1'b0;
 #(`PERIOD*20)
 if(Y==I[5]+I[4])
 $display("Adder Correct.");
 else
 $display("Adder Error!");
 #(`PERIOD*5);
  $finish;
 end

endmodule