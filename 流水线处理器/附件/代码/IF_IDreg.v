module IF_IDReg(reset,clk,IF_Stall,IF_Flush,IF_PCplus4,IF_OpCode,IF_rs,IF_rt,IF_rd,IF_Shamt,IF_Funct,
                                            ID_PCplus4,ID_OpCode,ID_rs,ID_rt,ID_rd,ID_Shamt,ID_Funct);
                                            
    input reset, clk,IF_Stall,IF_Flush;
    input [31:0] IF_PCplus4;
    input [5:0] IF_OpCode;
    input [4:0] IF_rs;
    input [4:0] IF_rt;
    input [4:0] IF_rd;
    input [4:0] IF_Shamt;
    input [5:0] IF_Funct;
    
    output reg [31:0] ID_PCplus4;
    output reg [5:0] ID_OpCode;
    output reg [4:0] ID_rs;
    output reg [4:0] ID_rt;
    output reg [4:0] ID_rd;
    output reg [4:0] ID_Shamt;
    output reg [5:0] ID_Funct;

    always@(posedge reset or posedge clk) begin
        if (reset) begin
            ID_OpCode<=6'b0;
            ID_rs<=5'b0;
            ID_rt<=5'b0;
            ID_rd<=5'b0;
            ID_Shamt<=5'b0;
            ID_Funct<= 6'b0;
            ID_PCplus4<=32'b0;
        end 
        else if(IF_Flush) begin
                            ID_OpCode<=6'b0;
                            ID_rs<=5'b0;
                            ID_rt<=5'b0;
                            ID_rd<=5'b0;
                            ID_Shamt<=5'b0;
                            ID_Funct<= 6'h0;
        end 
        else if (~IF_Stall) begin
            ID_PCplus4<=IF_PCplus4;
            ID_OpCode<=IF_OpCode;
            ID_rs<=IF_rs;
            ID_rt<=IF_rt;
            ID_rd<=IF_rd;
            ID_Shamt<=IF_Shamt;
            ID_Funct<=IF_Funct;
        end
     end   
endmodule
