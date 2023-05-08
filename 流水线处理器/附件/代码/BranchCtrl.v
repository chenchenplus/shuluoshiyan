module BranchControl(BranchType,Op1,Op2,Branch);
	input [2:0] BranchType;
	input [31:0] Op1;
	input [31:0] Op2;
	output reg Branch;

    always@(*)
	begin
		case(BranchType)
        //beq
		3'b001:Branch=(Op1==Op2)?1'b1:1'b0;
        //bne
        3'b010:Branch=(Op1==Op2)?1'b0:1'b1;
        //blez
        3'b011:Branch=(Op1>Op2)?1'b0:1'b1;
        //bgtz
        3'b100:Branch=(Op1>Op2)?1'b1:1'b0;
        //bltz
        3'b101:Branch=(Op1<Op2)?1'b1:1'b0;
        default:Branch=1'b0;
		endcase
	end
    

endmodule
