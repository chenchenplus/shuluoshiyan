module MEM_WBreg(clk,reset,MEM_MemtoReg,MEM_RegWrite,MEM_ALUOut,MEM_ReadData,MEM_Rw,MEM_LbOp,MEM_PCplus8,
              WB_MemtoReg,WB_ALUOut,WB_ReadData,WB_Rw,WB_RegWrite,WB_LbOp,WB_PCplus8
             );

input clk,reset,MEM_RegWrite,MEM_LbOp;
input [1:0] MEM_MemtoReg;
input [4:0] MEM_Rw;
input [31:0] MEM_ALUOut;
input [31:0] MEM_ReadData;
input [31:0] MEM_PCplus8;

output reg WB_RegWrite,WB_LbOp;
output reg [1:0] WB_MemtoReg;
output reg [4:0] WB_Rw;
output reg [31:0] WB_ALUOut;
output reg [31:0] WB_ReadData;
output reg [31:0] WB_PCplus8;

always@(posedge clk or posedge reset)
  if(reset)
   begin
         WB_MemtoReg<=2'b00;
         WB_RegWrite<=1'b0;
         WB_LbOp<=1'b0;
         WB_ALUOut<=32'b0;
         WB_ReadData<=32'b0;
         WB_Rw<=5'b0;
         WB_PCplus8<=32'b0;
   end
  else
    begin
      WB_MemtoReg<=MEM_MemtoReg;
      WB_RegWrite<=MEM_RegWrite;
      WB_LbOp<=MEM_LbOp;
      WB_ALUOut<=MEM_ALUOut;
      WB_ReadData<=MEM_ReadData;
      WB_Rw<=MEM_Rw;
      WB_PCplus8<=MEM_PCplus8;
    end
    
endmodule