module ForwardingUnit(ID_rs,ID_rt,EX_rs,EX_rt,EX_Rw,BranchType,ID_PCSrc,EX_RegWrite,MEM_RegWrite,WB_RegWrite,EX_ALUSrc1,EX_ALUSrc2,MEM_Rw,WB_Rw,ID_ForwardA,ID_ForwardB,EX_ForwardA,EX_ForwardB);

  input [4:0] ID_rs;
  input [4:0] ID_rt;
  input [4:0] EX_rs;
  input [4:0] EX_rt;
  input [2:0] BranchType;
  input EX_RegWrite,MEM_RegWrite,WB_RegWrite,EX_ALUSrc1,EX_ALUSrc2;
  input [1:0] ID_PCSrc;
  input [4:0] EX_Rw;
  input [4:0] MEM_Rw;
  input [4:0] WB_Rw;
  output reg [1:0] ID_ForwardA;
  output reg [1:0] ID_ForwardB;
  output reg [1:0] EX_ForwardA;
  output reg [1:0] EX_ForwardB;
  
always@(*)
begin
  if((BranchType!=3'b000||ID_PCSrc==2'b11)&&EX_Rw!=0&&ID_rs==EX_Rw&&EX_RegWrite)
     ID_ForwardA=2'b01;
  else if((BranchType!=3'b000||ID_PCSrc==2'b11)&&MEM_Rw!=0&&ID_rs==MEM_Rw&&MEM_RegWrite)
     ID_ForwardA=2'b10;
  else if((BranchType!=3'b000||ID_PCSrc==2'b11)&&WB_Rw!=0&&ID_rs==WB_Rw&&WB_RegWrite)
     ID_ForwardA=2'b11;
  else 
     ID_ForwardA=2'b00;

  if(BranchType!=3'b000&&EX_Rw!=0&&ID_rt==EX_Rw&&EX_RegWrite)
     ID_ForwardB=2'b01;
  else if(BranchType!=3'b000&&MEM_Rw!=0&&ID_rt==MEM_Rw&&MEM_RegWrite)
     ID_ForwardB=2'b10;
  else if(BranchType!=3'b000&&WB_Rw!=0&&ID_rt==WB_Rw&&WB_RegWrite)
     ID_ForwardB=2'b11;
  else 
     ID_ForwardB=2'b00;
    
 if (MEM_RegWrite&&MEM_Rw!=0&&MEM_Rw==EX_rs)
          EX_ForwardA=2'b10;  
  else if (WB_RegWrite&&WB_Rw!=0&&WB_Rw==EX_rs)
     EX_ForwardA=2'b11;
  else
     EX_ForwardA={1'b0,EX_ALUSrc1};
if (MEM_RegWrite&&MEM_Rw!=0&&MEM_Rw==EX_rt)
          EX_ForwardB=2'b10;       
else if (WB_RegWrite&&WB_Rw!=0&&WB_Rw==EX_rt)
     EX_ForwardB=2'b11;
  else
     EX_ForwardB=2'b00;
     
     
     
  
     
end

endmodule