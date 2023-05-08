`timescale 1ns/1ps
module test_cpu();
    
    reg reset;
    reg clk;
    wire [2:0] reg1;
    wire [2:0] reg2;
    wire [2:0] reg3;
    wire [2:0] reg4;
    wire [11:0] BCD7;

    
    CPU_pipeline CPUtest(reset,clk,reg1,reg2,reg3,reg4,BCD7);
    
    initial begin
        reset = 1;
        clk = 1;
        #100 reset = 0;
    end
    
    always #50 clk = ~clk;
    
endmodule