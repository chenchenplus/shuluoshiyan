module EX_MEMreg(clk,reset,EX_MemRead,EX_RegWrite,EX_MemWrite,EX_MemtoReg,EX_Op2,EX_Rw,EX_ALUOut,EX_LbOp,EX_PCplus8,
              MEM_MemRead,MEM_RegWrite,MEM_MemWrite,MEM_MemtoReg,MEM_Op2,MEM_Rw,MEM_ALUOut,MEM_LbOp,MEM_PCplus8
              );
input clk,reset,EX_MemRead,EX_RegWrite,EX_MemWrite,EX_LbOp;
input [1:0] EX_MemtoReg;
input [31:0] EX_Op2;
input [4:0] EX_Rw;
input [31:0] EX_ALUOut;
input [31:0] EX_PCplus8;
output reg MEM_MemRead,MEM_RegWrite,MEM_MemWrite,MEM_LbOp;
output reg [1:0] MEM_MemtoReg;
output reg [31:0] MEM_Op2;
output reg [4:0] MEM_Rw;
output reg [31:0] MEM_ALUOut;
output reg [31:0] MEM_PCplus8;


always@(posedge clk or posedge reset)
  if(reset)
    begin
      MEM_MemWrite<=1'b0;
      MEM_RegWrite<=1'b0;
      MEM_MemRead<=1'b0;
      MEM_LbOp<=1'b0;
      MEM_MemtoReg<=2'b00;
      MEM_Op2<=32'b0;
      MEM_ALUOut<=32'b0;
      MEM_Rw<=5'b0;
      MEM_PCplus8<=32'b0;
    end
  else
    begin
      MEM_MemRead<=EX_MemRead;
      MEM_RegWrite<=EX_RegWrite;
      MEM_MemWrite<=EX_MemWrite;
      MEM_MemtoReg<=EX_MemtoReg;
      MEM_LbOp<=EX_LbOp;
      MEM_Op2<=EX_Op2;
      MEM_ALUOut<=EX_ALUOut;
      MEM_Rw<=EX_Rw;
      MEM_PCplus8<=EX_PCplus8;
    end
    
endmodule