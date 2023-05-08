
module Controller(OpCode, Funct,
                  PCSrc, BranchType, RegWrite, RegDst, 
                  MemRead, MemWrite, MemtoReg, 
                  ALUSrc1, ALUSrc2, ExtOp, LuiOp,ALUOp,LbOp);
    input [5:0] OpCode;
	input [5:0] Funct;
	output reg [1:0] PCSrc;
	output reg [2:0] BranchType;
	output reg RegWrite;
	output reg [1:0] RegDst;
	output reg MemRead;
	output reg MemWrite;
	output reg [1:0] MemtoReg;
	output reg ALUSrc1;
	output reg ALUSrc2;
	output reg ExtOp;
	output reg LuiOp;
	output reg LbOp;
    output reg [3:0] ALUOp;

initial begin
			PCSrc=2'b00;
			BranchType=3'b0;
			RegWrite=1'b0;
			RegDst=2'b00;
			MemRead=1'b0;
			MemWrite=1'b0;
			MemtoReg=2'b00;
			ALUSrc1=1'b0;
			ALUSrc2=1'b0;
			ExtOp=1'b0;
			LuiOp=1'b0;	
			LbOp=1'b0;
	end
	always @(*) begin
   		 case(OpCode)
			6'h00:begin
				case(Funct)
				//add
				6'h20:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b1;
					LbOp=1'b0;
					end
				//addu
				6'h21:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//sub
				6'h22:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//subu
				6'h23:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//and
				6'h24:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//or
				6'h25:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//xor
				6'h26:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//nor
				6'h27:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//sll
				6'h00:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b1;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//srl
				6'h02:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b1;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//sra
				6'h03:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b1;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//slt
				6'h2a:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//sltu
				6'h2b:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//jr
				6'h08:begin
					PCSrc=2'b11;
					BranchType=3'b0;
					RegWrite=1'b0;
					//RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					//MemtoReg=2'b00;
					//ALUSrc1=1'b0;
					//ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
				//jalr
				6'h09:begin
					PCSrc=2'b11;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b10;
					//ALUSrc1=1'b0;
					//ALUSrc2=1'b0;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
					end
                 default:begin
                   PCSrc=2'b00;
                   BranchType=3'b0;
                   RegWrite=1'b0;
                   RegDst=2'b00;
                   MemRead=1'b0;
                   MemWrite=1'b0;
                   MemtoReg=2'b00;
                   ALUSrc1=1'b0;
                   ALUSrc2=1'b0;
                   ExtOp=1'b0;
                   LuiOp=1'b0;
                   LbOp=1'b0;
                end					
				endcase
				end
			//lw
			6'h23:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b00;
					MemRead=1'b1;
					MemWrite=1'b0;
					MemtoReg=2'b01;
					ALUSrc1=1'b0;
					ALUSrc2=1'b1;
					ExtOp=1'b1;
					LuiOp=1'b0;
					LbOp=1'b0;
				end
			//lb
			6'h20:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b00;
					MemRead=1'b1;
					MemWrite=1'b0;
					MemtoReg=2'b01;
					ALUSrc1=1'b0;
					ALUSrc2=1'b1;
					ExtOp=1'b1;
					LuiOp=1'b0;
					LbOp=1'b1;
				end
			//sw
			6'h2b:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b0;
					//RegDst=2'b01;
					//MemRead=1'b0;
					MemWrite=1'b1;
					//MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b1;
					ExtOp=1'b1;
					LuiOp=1'b0;
					LbOp=1'b0;
				end
			//addi
			6'h08:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b1;
					ExtOp=1'b1;
					LuiOp=1'b0;
					LbOp=1'b0;
				end
			//addiu
			6'h09:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b1;
					ExtOp=1'b1;
					LuiOp=1'b0;
					LbOp=1'b0;
				end
			//andi
			6'h0c:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b1;
					ExtOp=1'b0;
					LuiOp=1'b0;
					LbOp=1'b0;
				end
			//slti
			6'h0a:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b1;
					ExtOp=1'b1;
					LuiOp=1'b0;
					LbOp=1'b0;
				end
			//sltiu
			6'h0b:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b1;
					ExtOp=1'b1;
					LuiOp=1'b0;
					LbOp=1'b0;
				end
			//beq
			6'h04:begin
					PCSrc=2'b01;
					BranchType=3'b001;
					RegWrite=1'b0;
					//RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					//MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					ExtOp=1'b1;
					//LuiOp=1'b0;
					LbOp=1'b0;
				end
            //bne
			6'h05:begin
					PCSrc=2'b01;
					BranchType=3'b010;
					RegWrite=1'b0;
					//RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					//MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					ExtOp=1'b1;
					//LuiOp=1'b0;
					LbOp=1'b0;
				end
            //blez
			6'h06:begin
					PCSrc=2'b01;
					BranchType=3'b011;
					RegWrite=1'b0;
					//RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					//MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					ExtOp=1'b1;
					//LuiOp=1'b0;
					LbOp=1'b0;
				end
            //bgtz
			6'h07:begin
					PCSrc=2'b01;
					BranchType=3'b100;
					RegWrite=1'b0;
					//RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					//MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					ExtOp=1'b1;
					//LuiOp=1'b0;
					LbOp=1'b0;
				end
            //bltz
			6'h01:begin
					PCSrc=2'b01;
					BranchType=3'b101;
					RegWrite=1'b0;
					//RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					//MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					ExtOp=1'b1;
					//LuiOp=1'b0;
					LbOp=1'b0;
				end
			//lui
			6'h0f:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b1;
					//ExtOp=1'b0;
					LuiOp=1'b1;
					LbOp=1'b0;
				end
			//j
			6'h02:begin
					PCSrc=2'b10;
					BranchType=3'b0;
					RegWrite=1'b0;
					//RegDst=2'b00;
					//MemRead=1'b0;
					MemWrite=1'b0;
					//MemtoReg=2'b00;
					//ALUSrc1=1'b0;
					//ALUSrc2=1'b1;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
				end
			//jal
			6'h03:begin
					PCSrc=2'b10;
					BranchType=3'b0;
					RegWrite=1'b1;
					RegDst=2'b10;
					//MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b10;
					//ALUSrc1=1'b0;
					//ALUSrc2=1'b1;
					//ExtOp=1'b0;
					//LuiOp=1'b0;
					LbOp=1'b0;
				end
			default:begin
					PCSrc=2'b00;
					BranchType=3'b0;
					RegWrite=1'b0;
					RegDst=2'b00;
					MemRead=1'b0;
					MemWrite=1'b0;
					MemtoReg=2'b00;
					ALUSrc1=1'b0;
					ALUSrc2=1'b0;
					ExtOp=1'b0;
					LuiOp=1'b0;
					LbOp=1'b0;
					end
			endcase
		end
		
	



 
    always @(*) 
    begin
        
            case(OpCode)
                6'h0:ALUOp<=4'b0011;// R-type
                6'h09:ALUOp<=4'b0;//addiu
                6'h08,6'h23,6'h2b:ALUOp<=4'b0100;//addi,lw,sw
                6'h0a:ALUOp<=4'b0101;//slti
                6'h0b:ALUOp<=4'b0001;//sltiu
                6'h0c:ALUOp<=4'b0010;//andi
                default:ALUOp<=4'b0; 
            endcase

    end







	
endmodule
   
