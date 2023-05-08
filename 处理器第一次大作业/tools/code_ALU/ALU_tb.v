`timescale 1ns/1ps
`define PERIOD 10
module ALU_tb();
 reg clk ;
 reg [5:0]OpCode;
 reg [5:0]Funct;
 wire [4:0]ALUCtrl;
 reg [31:0]in1;
 reg [31:0]in2;
 wire Sign;
 wire [31:0]out;
 wire zero;
 initial begin
 forever
 #(`PERIOD/2) clk = ~clk;
 end
 ALUController ALUCtrl_test(OpCode,Funct,ALUCtrl,Sign);
 ALU ALU_test(ALUCtrl,Sign,in1,in2,out,zero);
 initial begin
 clk = 1'b0;
 #(`PERIOD*5)
 $display("Stimulation Start.");
 //lw rt,16(rs),假设rs=32'h00001100,offset=16'h0010符号扩展后是32'h00000010
 in1<=32'h00001100;
 in2<=32'h00000010;
 OpCode<=6'h23;
 Funct<=6'h10;
 #(`PERIOD)
 if(out==32'h00001110&&zero==1'b0)
 $display("lw Correct.");
 else
 $display("lw Error!");
 #(`PERIOD);

//sw rt,16(rs),假设rs=32'h00001100,offset=16'h0011符号扩展后是32'h00000011
 in1<=32'h00001100;
 in2<=32'h00000011;
 OpCode<=6'h2b;
 Funct<=6'h11;
 #(`PERIOD)
 if(out==32'h00001111&&zero==1'b0)
 $display("sw Correct.");
 else
 $display("sw Error!");
 #(`PERIOD);

 //add rd,rs,rt,假设rs=32'h0bc01100,rt=32'h000f0010
 in1<=32'h0bc01100;
 in2<=32'h000f0010;
 OpCode<=6'h0;
 Funct<=6'h20;
 #(`PERIOD)
 if(out==32'h0bcf1110&&zero==1'b0)
 $display("add Correct.");
 else
 $display("add Error!");
 #(`PERIOD);

 //addu rd,rs,rt,假设rs=32'hfbc01100,rt=32'h000f0010
 in1<=32'hfbc01100;
 in2<=32'h000f0010;
 OpCode<=6'h0;
 Funct<=6'h21;
 #(`PERIOD)
 if(out==32'hfbcf1110&&zero==1'b0)
 $display("addu Correct.");
 else
 $display("addu Error!");
 #(`PERIOD);

//sub rd,rs,rt,假设rs=32'h10001111,rt=32'h00000111
 in1<=32'h10001111;
 in2<=32'h00000111;
 OpCode<=6'h0;
 Funct<=6'h22;
 #(`PERIOD)
 if(out==32'h10001000&&zero==1'b0)
 $display("sub Correct.");
 else
 $display("sub Error!");
 #(`PERIOD);
 
 //subu rd,rs,rt,假设rs=32'hf0001111,rt=32'hf0000111
 in1<=32'hf0001111;
 in2<=32'hf0000111;
 OpCode<=6'h0;
 Funct<=6'h23;
 #(`PERIOD)
 if(out==32'h00001000&&zero==1'b0)
 $display("subu Correct.");
 else
 $display("subu Error!");
 #(`PERIOD);

 //addi rd,rs,imm,假设rs=32'h00000001,imm=16'hf010,符号扩展之后32'hfffff010
 in1<=32'h00000001;
 in2<=32'hfffff010;
 OpCode<=6'h08;
 Funct<=6'h10;
 #(`PERIOD)
 if(out==32'hfffff011&&zero==1'b0)
 $display("addi Correct.");
 else
 $display("addi Error!");
 #(`PERIOD);

 //addiu rd,rs,imm,假设rs=32'h00000001,imm=16'hf010,零扩展之�?32'h0000f010
 in1<=32'h00000001;
 in2<=32'h0000f010;
 OpCode<=6'h09;
 Funct<=6'h10;
 #(`PERIOD)
 if(out==32'h0000f011&&zero==1'b0)
 $display("addiu Correct.");
 else
 $display("addiu Error!");
 #(`PERIOD);

 //and rd,rs,rt,假设rs=32'hf0000001,rt=32'h00001101
 in1<=32'hf0000001;
 in2<=32'h00001101;
 OpCode<=6'h0;
 Funct<=6'h24;
 #(`PERIOD)
 if(out==32'h00000001&&zero==1'b0)
 $display("and Correct.");
 else
 $display("and Error!");
 #(`PERIOD);

 //or rd,rs,rt,假设rs=32'hf0000001,rt=32'h00001101
 in1<=32'hf0000001;
 in2<=32'h00001101;
 OpCode<=6'h0;
 Funct<=6'h25;
 #(`PERIOD)
 if(out==32'hf0001101&&zero==1'b0)
 $display("or Correct.");
 else
 $display("or Error!");
 #(`PERIOD);
 
 //xor rd,rs,rt,假设rs=32'hf0000001,rt=32'hf0001101
 in1<=32'hf0000001;
 in2<=32'hf0001101;
 OpCode<=6'h0;
 Funct<=6'h26;
 #(`PERIOD)
 if(out==32'h00001100&&zero==1'b0)
 $display("xor Correct.");
 else
 $display("xor Error!");
 #(`PERIOD);

//nor rd,rs,rt,假设rs=32'hf0000001,rt=32'h00001101
 in1<=32'hf0000001;
 in2<=32'h00001101;
 OpCode<=6'h0;
 Funct<=6'h27;
 #(`PERIOD)
 if(out==32'h0fffeefe&&zero==1'b0)
 $display("nor Correct.");
 else
 $display("nor Error!");
 #(`PERIOD);

 //andi rt,rs,imm,假设rs=32'hf0000001,imm=16'hf010,符号扩展之后32'hfffff010
 in1<=32'hf0000001;
 in2<=32'hfffff010;
 OpCode<=6'h0c;
 Funct<=6'h10;
 #(`PERIOD)
 if(out==32'hf0000000&&zero==1'b0)
 $display("andi Correct.");
 else
 $display("andi Error!");
 #(`PERIOD);

//sll rd,rt,shamt,假设rt=32'h00000001,shamt=5'h01,零扩展之�?32'h00000001
 in1<=32'h00000001;
 in2<=32'h00000001;
 OpCode<=6'h0;
 Funct<=6'h0;
 #(`PERIOD)
 if(out==32'h00000002&&zero==1'b0)
 $display("sll Correct.");
 else
 $display("sll Error!");
 #(`PERIOD);

 //srl rd,rt,shamt,假设rt=32'h00000100,shamt=5'h01,零扩展之�?32'h00000001
 in1<=32'h00000001;
 in2<=32'h00000100;
 OpCode<=6'h0;
 Funct<=6'h02;
 #(`PERIOD)
 if(out==32'h00000080&&zero==1'b0)
 $display("srl Correct.");
 else
 $display("srl Error!");
 #(`PERIOD);

 //sra rd,rt,shamt,假设rt=32'hf0000100,shamt=5'h01,零扩展之�?32'h00000001
 in1<=32'h00000001;
 in2<=32'hf0000100;
 OpCode<=6'h0;
 Funct<=6'h03;
 #(`PERIOD)
 if(out==32'hf8000080&&zero==1'b0)
 $display("sra Correct.");
 else
 $display("sra Error!");
 #(`PERIOD);

 //slt rd,rs,rt,假设rs=32'hf0000100,rt=32'h00000001
 in1<=32'hf0000100;
 in2<=32'h00000001;
 OpCode<=6'h0;
 Funct<=6'h2a;
 #(`PERIOD)
 if(out==32'h1&&zero==1'b0)
 $display("slt Correct.");
 else
 $display("slt Error!");
 #(`PERIOD);

 //sltu rd,rs,rt,假设rs=32'hf0000100,rt=32'h00000001
 in1<=32'hf0000100;
 in2<=32'h00000001;
 OpCode<=6'h0;
 Funct<=6'h2b;
 #(`PERIOD)
 if(out==32'h0&&zero==1'b1)
 $display("sltu Correct.");
 else
 $display("sltu Error!");
 #(`PERIOD);

 //slti rt,rs,imm,假设rs=32'h00000100,imm=16'hf001,符号扩展�?32'hfffff001
 in1<=32'h00000100;
 in2<=32'hfffff001;
 OpCode<=6'h0a;
 Funct<=6'h01;
 #(`PERIOD)
 if(out==32'h0&&zero==1'b1)
 $display("slti Correct.");
 else
 $display("slti Error!");
 #(`PERIOD);

 //sltiu rt,rs,imm,假设rs=32'h00000100,imm=16'hf001,零扩展后32'h0000f001
 in1<=32'h00000100;
 in2<=32'h0000f001;
 OpCode<=6'h0b;
 Funct<=6'h01;
 #(`PERIOD)
 if(out==32'h1&&zero==1'b0)
 $display("sltiu Correct.");
 else
 $display("sltiu Error!");
 #(`PERIOD);

 //beq rs,rt,label,假设rs=32'h00000100,rt=32'h00000100,offset=16'hf001
 in1<=32'h00000100;
 in2<=32'h00000100;
 OpCode<=6'h04;
 Funct<=6'h01;
 #(`PERIOD)
 if(out==32'h0&&zero==1'b1)
 $display("beq Correct.");
 else
 $display("beq Error!");
 #(`PERIOD);
 $finish;
 
 end

endmodule