module ID_EXreg( clk,reset,ID_Stall,
              ID_MemRead,ID_RegWrite,ID_MemWrite,ID_ALUSrc1,ID_ALUSrc2,ID_MemtoReg,ID_ALUConf,ID_Sign,ID_LbOp,
              ID_PCplus4,ID_rs,ID_rt,ID_rd,ID_RegDst,
              ID_Op1,ID_Op2,ID_ExtOut,ID_ShamtOut,
              EX_MemRead,EX_RegWrite,EX_MemWrite,EX_ALUSrc1,EX_ALUSrc2,EX_MemtoReg,EX_ALUConf,EX_Sign,EX_LbOp,
              EX_PCplus4,EX_rs,EX_rt,EX_rd,EX_RegDst,
              EX_Op1,EX_Op2,EX_ExtOut,EX_ShamtOut);
input clk,reset,ID_Stall,ID_MemRead,ID_RegWrite,ID_MemWrite,ID_ALUSrc1,ID_ALUSrc2,ID_Sign,ID_LbOp;
input [1:0] ID_MemtoReg;
input [4:0] ID_ALUConf;
input [31:0] ID_PCplus4;
input [4:0] ID_rs;
input [4:0] ID_rt;
input [4:0] ID_rd;
input [1:0] ID_RegDst;
input [31:0] ID_Op1;
input [31:0] ID_Op2;
input [31:0] ID_ExtOut;
input [31:0] ID_ShamtOut;

output reg EX_MemRead,EX_RegWrite,EX_MemWrite,EX_ALUSrc1,EX_ALUSrc2,EX_Sign,EX_LbOp;
output reg [1:0] EX_MemtoReg;
output reg [4:0] EX_ALUConf;
output reg [31:0] EX_PCplus4;
output reg [4:0] EX_rs;
output reg [4:0] EX_rt;
output reg [4:0] EX_rd;
output reg [1:0] EX_RegDst;
output reg [31:0] EX_Op1;
output reg [31:0] EX_Op2;
output reg [31:0] EX_ExtOut;
output reg [31:0] EX_ShamtOut;

always@(posedge reset or posedge clk)
  if(reset)
    begin
          EX_MemRead<=1'b0;
          EX_RegWrite<=1'b0;
          EX_MemWrite<=1'b0;
          EX_ALUSrc1<=1'b0;
          EX_ALUSrc2<=1'b0;
          EX_MemtoReg<=2'b00;
          EX_ALUConf<=5'b0;
          EX_PCplus4<=32'b0;
          EX_Sign<=1'b0;
          EX_Op1<=32'b0;
          EX_Op2<=32'b0;
          EX_LbOp<=1'b0;
          EX_RegDst<=2'b00;
          EX_ExtOut<=32'b0;
          EX_ShamtOut<=32'b0;
          EX_rs<=5'b0;
          EX_rt<=5'b0;
          EX_rd<=5'b0;
    end
  else if(ID_Stall)
  begin
       
       EX_MemWrite<=1'b0;
       EX_RegWrite<=1'b0;
       EX_MemRead<=1'b0;
       EX_LbOp<=1'b0;
 end
  else
    begin
      EX_MemRead<=ID_MemRead;
      EX_RegWrite<=ID_RegWrite;
      EX_MemWrite<=ID_MemWrite;
      EX_ALUSrc1<=ID_ALUSrc1;
      EX_ALUSrc2<=ID_ALUSrc2;
      EX_MemtoReg<=ID_MemtoReg;
      EX_ALUConf<=ID_ALUConf;
      EX_PCplus4<=ID_PCplus4;
      EX_Sign<=ID_Sign;
      EX_Op1<=ID_Op1;
      EX_Op2<=ID_Op2;
      EX_LbOp<=ID_LbOp;
      EX_RegDst<=ID_RegDst;
      EX_ExtOut<=ID_ExtOut;
      EX_ShamtOut<=ID_ShamtOut;
      EX_rs<=ID_rs;
      EX_rt<=ID_rt;
      EX_rd<=ID_rd;
    end
  


endmodule