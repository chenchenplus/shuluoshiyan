`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Fundamentals of Digital Logic and Processor
// Designer: Shulin Zeng
// 
// Create Date: 2021/04/30
// Design Name: MultiCycleCPU
// Module Name: MultiCycleCPU
// Project Name: Multi-cycle-cpu
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module MultiCycleCPU (reset, clk);
    //Input Clock Signals
    input reset;
    input clk;   
    //--------------Your code below-----------------------
    wire [31:0] Address;
    //reg [31:0] Instruction;
    wire [5:0]  OpCode;
    wire [5:0]  Funct;
    wire [1:0] RegDst;
    wire [1:0] MemtoReg;
    wire [1:0] ALUSrcA;
    wire [1:0] ALUSrcB;
    wire [1:0] PCSource;
    wire [3:0] ALUOp;
    wire PCWrite, PCWriteCond, IorD, MemWrite, MemRead,IRWrite,RegWrite, ExtOp, LuiOp;
    wire [5:0] Opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] Shamt;
    wire [4:0] Read_register1;
    wire [4:0] Read_register2;
    reg [4:0] Write_register;
    reg [31:0] Write_data_r;
    wire [31:0] Write_data_m;
    wire [31:0] Read_data1;
    wire [31:0] Read_data2;
    wire [4:0] ALUConf;
    wire Sign;
    wire PCWrite_en;
    reg [31:0] In1;
    reg [31:0] In2;
    wire [31:0] Result;
    wire [31:0] Mem_data;
    wire [31:0] ImmExtOut;
    wire [31:0] ImmExtShift;
    wire [31:0] Instruction;
    reg [31:0] PC_i;
    wire [31:0] PC_o;
    wire [31:0] A_o;
    wire [31:0] ALU_o;
    wire [31:0] B_o;
    wire [31:0] MDR_i;
    wire [31:0] MDR_o;
    wire Zero;
    wire [15:0] Imm;
    InstAndDataMemory InstDataMem(reset, clk, Address, Write_data_m, MemRead, MemWrite, Mem_data);
    InstReg Inst_reg(reset, clk, IRWrite, Instruction, OpCode, rs, rt, rd, Shamt, Funct);
    RegTemp MDR(reset, clk, MDR_i, MDR_o);
    Controller controller(reset, clk, OpCode, Funct, 
                PCWrite, PCWriteCond, IorD, MemWrite, MemRead,
                IRWrite, MemtoReg, RegDst, RegWrite, ExtOp, LuiOp,
                ALUSrcA, ALUSrcB, ALUOp, PCSource);
    ALUControl alucontrol(ALUOp, Funct, ALUConf, Sign);
    PC pc(reset, clk, PCWrite_en, PC_i, PC_o);
    RegisterFile RF(reset, clk, RegWrite, Read_register1, Read_register2, Write_register, Write_data_r, Read_data1, Read_data2);
    RegTemp A_reg(reset, clk, Read_data1, A_o);
    RegTemp B_reg(reset, clk, Read_data2, B_o);
    ImmProcess ImmExt(ExtOp, LuiOp, Imm, ImmExtOut, ImmExtShift);
    ALU ALU_m(ALUConf, Sign, In1, In2, Zero, Result);
    RegTemp ALUOut_reg(reset, clk, Result, ALU_o);

//PC
assign PCWrite_en=PCWrite+(Zero&PCWriteCond);
//Mem
assign Address=(IorD==1'b0)?PC_o:ALU_o;
assign Write_data_m=B_o;
//IR,MDR
assign Instruction=Mem_data;
assign MDR_i=Mem_data;
//RF
assign Read_register1=rs;
assign Read_register2=rt;
//ImmExt
assign Imm={rd,Shamt,Funct};

always@(*)
begin
//PC
case(PCSource[1])
1'b0:PC_i=(PCSource[0]==1'b1)?ALU_o:Result;
1'b1:PC_i=(PCSource[0]==1'b1)?A_o:{PC_o[31:28],{rs,rt,Imm}<<2};
endcase
//RF
case(RegDst)
2'b00: Write_register=rt;
2'b01: Write_register=rd;
2'b10: Write_register=5'd31;
endcase
case(MemtoReg)
2'b00: Write_data_r=MDR_o;
2'b01: Write_data_r=Result;
2'b10: Write_data_r=PC_o;//PC已经更新成PC+4了
endcase
//ALU
case(ALUSrcA)
2'b00: In1=PC_o;
2'b01: In1=A_o;
2'b10: In1={27'b0,Shamt};
endcase
case(ALUSrcB)
2'b00: In2=B_o;
2'b01: In2=32'd4;
2'b10: In2=ImmExtOut;
2'b11: In2=ImmExtShift;
endcase
end








    //--------------Your code above-----------------------

endmodule