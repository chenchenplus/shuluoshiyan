module CPU_pipeline(reset,clk,reg1,reg2,reg3,reg4,BCD7);

input clk,reset;
output [11:0] BCD7;
output [2:0] reg1;//这四个寄存器方便后仿监视输出
output [2:0] reg2;
output [2:0] reg3;
output [2:0] reg4;

wire [5:0] IF_Opcode,ID_Opcode;
wire [4:0] IF_rs,ID_rs,EX_rs;
wire [4:0] IF_rt,ID_rt,EX_rt;
wire [4:0] IF_rd,ID_rd,EX_rd;
wire [4:0] IF_Shamt,ID_Shamt;
wire [5:0] IF_Funct,ID_Funct;
wire [4:0] EX_Rw,MEM_Rw,WB_Rw;
wire Stall;
wire IF_Flush;
wire [1:0] ID_PCSrc;
wire ID_Branch;
wire [1:0] ID_RegDst,EX_RegDst;
wire ID_MemRead,EX_MemRead,MEM_MemRead;
wire ID_MemWrite,EX_MemWrite,MEM_MemWrite;
wire ID_LbOp,EX_LbOp,MEM_LbOp,WB_LbOp;
wire ID_RegWrite,EX_RegWrite,MEM_RegWrite,WB_RegWrite;
wire [1:0] ID_MemtoReg,EX_MemtoReg,MEM_MemtoReg,WB_MemtoReg;
wire ID_ALUSrc1,EX_ALUSrc1;
wire ID_ALUSrc2,EX_ALUSrc2;
wire [2:0] ID_BranchType;
wire ID_ExtOp, ID_LuiOp,ID_Sign,EX_Sign;
wire [1:0] ID_ForwardA,ID_ForwardB,EX_ForwardA,EX_ForwardB;
wire [3:0] ID_ALUOp;
wire [4:0] ID_ALUConf,EX_ALUConf;
wire [31:0] PC_i,PC_o;
wire [31:0] IF_PCplus4,ID_PCplus4,EX_PCplus4;
wire [31:0] ID_ReadData1,ID_ReadData2,MEM_ReadData,WB_ReadData;
wire [31:0] ID_Op1,EX_Op1,ID_Op2,EX_Op2,MEM_Op2;
wire [31:0] ID_ExtOut,EX_ExtOut;
wire [31:0] ID_ShamtOut,EX_ShamtOut;
wire [31:0] EX_In1,EX_In2;
wire [31:0] EX_ALUOut,MEM_ALUOut,WB_ALUOut;
wire [31:0] EX_PCplus8,MEM_PCplus8,WB_PCplus8;
wire [31:0] WB_MEMData,MEM_MEMData;
wire [31:0] WB_WriteData;
wire [31:0] MEM_ForwardData;
wire [31:0] RegData1,RegData2;

assign reg1=RF.RF_data[2];
assign reg2=RF.RF_data[9];
assign reg3=RF.RF_data[11];
assign reg4=RF.RF_data[12];


PC_pipeline PC (reset,clk,Stall,PC_i,PC_o);
InstructionMemory IM(PC_o,IF_Opcode,IF_rs,IF_rt,IF_rd,IF_Shamt,IF_Funct);
IF_IDReg IFID(reset,clk,Stall,IF_Flush,IF_PCplus4,IF_Opcode,IF_rs,IF_rt,IF_rd,IF_Shamt,IF_Funct,
                                          ID_PCplus4,ID_Opcode,ID_rs,ID_rt,ID_rd,ID_Shamt,ID_Funct);
RegisterFile RF(reset, clk, WB_RegWrite, ID_rs, ID_rt, WB_Rw, WB_WriteData, RegData1, RegData2);
ID_EXreg IDEX(clk,reset,Stall,
              ID_MemRead,ID_RegWrite,ID_MemWrite,ID_ALUSrc1,ID_ALUSrc2,ID_MemtoReg,ID_ALUConf,ID_Sign,ID_LbOp,
              ID_PCplus4,ID_rs,ID_rt,ID_rd,ID_RegDst,
              ID_Op1,ID_Op2,ID_ExtOut,ID_ShamtOut,
              EX_MemRead,EX_RegWrite,EX_MemWrite,EX_ALUSrc1,EX_ALUSrc2,EX_MemtoReg,EX_ALUConf,EX_Sign,EX_LbOp,
              EX_PCplus4,EX_rs,EX_rt,EX_rd,EX_RegDst,
              EX_Op1,EX_Op2,EX_ExtOut,EX_ShamtOut);
Controller ctrller(ID_Opcode, ID_Funct,
                   ID_PCSrc, ID_BranchType, ID_RegWrite, ID_RegDst, 
                   ID_MemRead, ID_MemWrite, ID_MemtoReg, 
                   ID_ALUSrc1, ID_ALUSrc2, ID_ExtOp, ID_LuiOp,ID_ALUOp,ID_LbOp);
ALUControl aluctrl(ID_ALUOp, ID_Funct, ID_ALUConf, ID_Sign);
BranchControl branchctrl(ID_BranchType,ID_Op1,ID_Op2,ID_Branch);
ALU alu(EX_ALUConf, EX_Sign, EX_In1, EX_In2, EX_ALUOut);
ForwardingUnit forward(ID_rs,ID_rt,EX_rs,EX_rt,EX_Rw,ID_BranchType,ID_PCSrc,EX_RegWrite,MEM_RegWrite,WB_RegWrite,EX_ALUSrc1,EX_ALUSrc2,MEM_Rw,WB_Rw,
                       ID_ForwardA,ID_ForwardB,EX_ForwardA,EX_ForwardB);
HazardUnit hazard (ID_rs,ID_rt,ID_BranchType,ID_Branch,WB_RegWrite,ID_PCSrc,EX_RegWrite,EX_MemRead,EX_Rw,WB_Rw,Stall);
EX_MEMreg EXMEM(clk,reset,EX_MemRead,EX_RegWrite,EX_MemWrite,EX_MemtoReg,EX_Op2,EX_Rw,EX_ALUOut,EX_LbOp,EX_PCplus8,
              MEM_MemRead,MEM_RegWrite,MEM_MemWrite,MEM_MemtoReg,MEM_Op2,MEM_Rw,MEM_ALUOut,MEM_LbOp,MEM_PCplus8);
DataMemory DM(reset, clk,MEM_ALUOut,MEM_Op2, MEM_ReadData, MEM_MemRead, MEM_MemWrite,BCD7);
MEM_WBreg MEMWB(clk,reset,MEM_MemtoReg,MEM_RegWrite,MEM_ALUOut,MEM_ReadData,MEM_Rw,MEM_LbOp,MEM_PCplus8,
                WB_MemtoReg,WB_ALUOut,WB_ReadData,WB_Rw,WB_RegWrite,WB_LbOp,WB_PCplus8);




//PC
assign IF_PCplus4=PC_o+32'd4;
assign PC_i=(ID_PCSrc[1]==1'b0)?((ID_Branch==1'b1)?ID_PCplus4+(ID_ExtOut<<2):IF_PCplus4):((ID_PCSrc[0]==1'b1)?ID_Op1:{ID_PCplus4[31:28],{ID_rs,ID_rt,ID_rd,ID_Shamt,ID_Funct}<<2});

//IF
assign IF_Flush=(ID_Branch&~Stall||ID_PCSrc==2'b10||ID_PCSrc==2'b11)? 1:0;

//ID
assign ID_ReadData1=(WB_Rw!=0&&ID_rs==WB_Rw&&WB_RegWrite)?WB_WriteData:RegData1;
assign ID_ReadData2=(WB_Rw!=0&&ID_rt==WB_Rw&&WB_RegWrite)?WB_WriteData:RegData2;
assign ID_Op1=(ID_ForwardA[1]==1'b1)?((ID_ForwardA[0]==1'b1)?WB_WriteData:MEM_ForwardData):((ID_ForwardA[0]==1'b1)?EX_ALUOut:ID_ReadData1);
assign ID_Op2=(ID_ForwardB[1]==1'b1)?((ID_ForwardB[0]==1'b1)?WB_WriteData:MEM_ForwardData):((ID_ForwardB[0]==1'b1)?EX_ALUOut:ID_ReadData2);
assign ID_ShamtOut={27'b0,ID_Shamt};
assign ID_ExtOut=(ID_LuiOp==1'b1)?{ID_rd,ID_Shamt,ID_Funct,16'b0}:((ID_ExtOp==1'b1)?{{16{ID_rd[4]}},ID_rd,ID_Shamt,ID_Funct}:{16'b0,ID_rd,ID_Shamt,ID_Funct});


//EX
assign EX_In1=(EX_ForwardA[1]==1'b0)?((EX_ForwardA[0]==1'b0)?EX_Op1:EX_ShamtOut):((EX_ForwardA[0]==1'b0)? MEM_ForwardData:WB_WriteData);
assign EX_In2=(EX_ALUSrc2==1'b1)?EX_ExtOut:((EX_ForwardB[1]==1'b1)?((EX_ForwardB[0]==1'b0)? MEM_ForwardData:WB_WriteData):EX_Op2);
assign EX_Rw=(EX_RegDst[1]==1'b0)?((EX_RegDst[0]==1'b0)?EX_rt:EX_rd):32'd31;
assign EX_PCplus8=EX_PCplus4+32'd4;

//MEM


assign MEM_MEMData=(MEM_LbOp==1'b1)?((MEM_ALUOut[1]==1'b1)?((MEM_ALUOut[0]==1'b1)?{24'b0,MEM_ReadData[31:24]}:{24'b0,MEM_ReadData[23:16]}):((MEM_ALUOut[0]==1'b1)?{24'b0,MEM_ReadData[15:8]}:{24'b0,MEM_ReadData[7:0]})):MEM_ReadData;

		
assign MEM_ForwardData=(MEM_MemtoReg[1]==1'b0)?((MEM_MemtoReg[0]==1'b0)?MEM_ALUOut:MEM_MEMData):MEM_PCplus8;
//WB
assign WB_MEMData=(WB_LbOp==1'b1)?((WB_ALUOut[1]==1'b1)?((WB_ALUOut[0]==1'b1)?{24'b0,WB_ReadData[31:24]}:{24'b0,WB_ReadData[23:16]}):((WB_ALUOut[0]==1'b1)?{24'b0,WB_ReadData[15:8]}:{24'b0,WB_ReadData[7:0]})):WB_ReadData;
assign WB_WriteData=(WB_MemtoReg[1]==1'b0)?((WB_MemtoReg[0]==1'b0)?WB_ALUOut:WB_MEMData):WB_PCplus8;




endmodule