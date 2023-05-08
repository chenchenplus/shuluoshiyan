module HazardUnit(ID_rs,ID_rt,Branchtype,Branch,WB_RegWrite,ID_PCSrc,EX_RegWrite,EX_MemRead,EX_Rw,WB_Rw,Stall);
  input[4:0] ID_rs;
  input[4:0] ID_rt;
  input [2:0] Branchtype;
  input Branch;
  input EX_MemRead,EX_RegWrite,WB_RegWrite;
  input [1:0] ID_PCSrc;
  input [4:0] EX_Rw,WB_Rw;
  output reg Stall;
  always@(*)
  begin
    
    if(EX_MemRead&&(EX_Rw==ID_rs||EX_Rw==ID_rt))
      begin Stall=1'b1;
      end
    //else if((Branchtype!=3'b000||ID_PCSrc==2'b11)&&EX_Rw==ID_rs&&EX_RegWrite)
    //  begin Stall=1'b1;
    //  end
    //else if(WB_RegWrite&&(WB_Rw==ID_rs||WB_Rw==ID_rt))
       //     begin Stall=1'b1;
       //     end
    
    else begin
      Stall=1'b0;     
    end      
 
  end
  
endmodule