
module CPU(reset, clk);
	input reset, clk;
	
    //--------------Your code below-----------------------
wire [5:0]  OpCode;
reg [31:0] PC;
wire [31:0] Instruction;
wire [1:0] PCSrc;
wire [1:0] RegDst;
wire [1:0] MemtoReg;
wire Branch, RegWrite, MemRead, MemWrite, ALUSrc1, ALUSrc2, ExtOp, LuOp;
wire [5:0] Opcode;
wire [5:0] Funct;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [4:0] Shamt;
wire [4:0] Ra;
wire [4:0] Rb;
reg [4:0] Rw;
reg [31:0] WriteData_RF;
wire [31:0] WriteData_DM;
wire [31:0] Address;
wire [31:0] Op1;
wire [31:0] Op2;
wire [4:0] ALUCtrl;
wire Sign;
wire [31:0] in1;
wire [31:0] in2;
wire [31:0] ALUOut;
reg [31:0] ExtOut;
wire [31:0] MemData;
wire zero;
InstructionMemory IM(PC, Instruction);
Control Ctrl(OpCode, Funct, PCSrc, Branch, RegWrite, RegDst, MemRead, MemWrite, MemtoReg, ALUSrc1, ALUSrc2, ExtOp, LuOp);
RegisterFile RF(reset, clk, RegWrite, Ra, Rb, Rw, WriteData_RF, Op1, Op2);
ALUController aluctrl(OpCode,Funct,ALUCtrl,Sign);
ALU alu(ALUCtrl,Sign,in1,in2,ALUOut,zero);
DataMemory DM(reset, clk, Address, WriteData_DM, MemData, MemRead, MemWrite);


assign OpCode=Instruction[31:26];
assign rs=Instruction[25:21];
assign rt=Instruction[20:16];
assign rd=Instruction[15:11];
assign Shamt=Instruction[10:6];
assign Funct=Instruction[5:0];
//Register File
assign Ra=rs;
assign Rb=rt;
//ALU
assign in1=(ALUSrc1==1'b1)?{27'b0,Shamt}:Op1;
assign in2=(ALUSrc2==1'b1)?ExtOut:Op2;
//DataMem
assign Address=ALUOut;
assign WriteData_DM=Op2;

always@(*)
begin
//Register File    
case(RegDst)
   2'b00: Rw=rt;
   2'b01: Rw=rd;
   2'b10: Rw=5'd31;  
endcase
case(MemtoReg)
   2'b00: WriteData_RF=ALUOut;
   2'b01: WriteData_RF=MemData;
   2'b10: WriteData_RF=PC+32'd4;  
endcase
//ImmExt
case({ExtOp,LuOp})
   2'b00: ExtOut={16'b0,rd,Shamt,Funct};
   2'b10: ExtOut={{16{rd[4]}},rd,Shamt,Funct};
   default: ExtOut={rd,Shamt,Funct,16'b0};
endcase
end

//PC
always@(posedge reset or posedge clk)
begin
if(reset)
  PC<=32'b0;
else begin
case(PCSrc[1])
1'b0:begin 
        case(zero&Branch)
        1'b0:PC<=PC+32'd4;
        1'b1:PC<=PC+32'd4+{ExtOut<<2};
        endcase
     end
1'b1:begin 
        case(PCSrc[0])
        1'b0:begin PC<=PC+32'd4;
        PC<={PC[31:28],{rs,rt,rd,Shamt,Funct}<<2};
        end
        1'b1:PC<=Op1;
        endcase
     end
endcase
end
end

    //--------------Your code above-----------------------

endmodule
	