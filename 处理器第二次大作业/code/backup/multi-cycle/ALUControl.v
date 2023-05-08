`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Fundamentals of Digital Logic and Processor
// Designer: Shulin Zeng
// 
// Create Date: 2021/04/30
// Design Name: MultiCycleCPU
// Module Name: ALUControl
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


module ALUControl(ALUOp, Funct, ALUConf, Sign);
	//Control Signals
	input [3:0] ALUOp;
	//Inst. Signals
	input [5:0] Funct;
	//Output Control Signals
	output reg [4:0] ALUConf;
	output reg Sign;

    //--------------Your code below-----------------------
    always@(*)
	begin
		case(ALUOp)
		//addiu
		4'h0:begin
			ALUConf=5'b00000;
			Sign=1'b0;
		end
		//R-type
		4'b0011:begin
			case(Funct)
				//add
				6'h20:begin
					ALUConf=5'b00000;
					Sign=1'b1;
					end
				//addu
				6'h21:begin
					ALUConf=5'b00000;
					Sign=1'b0;
					end
				//sub
				6'h22:begin
					ALUConf=5'b00001;
					Sign=1'b1;
					end
				//subu
				6'h23:begin
					ALUConf=5'b00001;
					Sign=1'b0;
					end
				//and
				6'h24:begin
					ALUConf=5'b00010;
					Sign=1'b1;
					end
				//or
				6'h25:begin
					ALUConf=5'b00011;
					Sign=1'b1;
					end
				//xor
				6'h26:begin
					ALUConf=5'b00100;
					Sign=1'b1;
					end
				//nor
				6'h27:begin
					ALUConf=5'b00101;
					Sign=1'b1;
					end
				//sll
				6'h00:begin
					ALUConf=5'b00110;
					Sign=1'b0;
					end
				//srl
				6'h02:begin
					ALUConf=5'b00111;
					Sign=1'b0;
					end
				//sra
				6'h03:begin
					ALUConf=5'b01000;
					Sign=1'b1;
					end
				//slt
				6'h2a:begin
					ALUConf=5'b01001;
					Sign=1'b1;
					end
				//sltu
				6'h2b:begin
					ALUConf=5'b01001;
					Sign=1'b0;
					end
				default:
				begin
                    ALUConf=5'b00000;
                    Sign=1'b0;
                    end
			endcase			
		end
		//addi,lw,sw
		4'b0100:begin
			ALUConf=5'b0;
			Sign=1'b1;
		end
		//slti
		4'b0101:begin
			ALUConf=5'b01001;
			Sign=1'b1;
		end	
		//sltiu
		4'b0001:begin
			ALUConf=5'b01001;
			Sign=1'b0;
		end	
		//andi
		4'b0010:begin
			ALUConf=5'b00010;
			Sign=1'b0;
		end	
		//beq
        4'b0110:begin
            ALUConf=5'b00001;
            Sign=1'b0;
        end    
		
		endcase
	end
    
        
    //--------------Your code above-----------------------

endmodule
