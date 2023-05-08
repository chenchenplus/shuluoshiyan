`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Fundamentals of Digital Logic and Processor
// Designer: Shulin Zeng
// 
// Create Date: 2021/04/30
// Design Name: MultiCycleCPU
// Module Name: ALU
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


module ALU(ALUConf, Sign, In1, In2, Zero, Result);
    // Control Signals
    input [4:0] ALUConf;
    input Sign;
    // Input Data Signals
    input [31:0] In1;
    input [31:0] In2;
    // Output 
    output Zero;
    output reg [31:0] Result;

    //--------------Your code below-----------------------
    assign Zero=(Result==32'b0)?1'b1 : 1'b0;
    always @(*) begin
    case(ALUConf)
    //加法
    5'b00000:begin
                 if(Sign==1'b1) begin 
                 Result=$signed(In1)+$signed(In2);
                 end
                 else begin
                 Result=In1+In2;
                 end
             end
    //减法
    5'b00001:begin
                 if(Sign==1'b1) begin 
                 Result=$signed(In1)-$signed(In2);
                 end
                 else begin
                 Result=In1-In2;
                 end
             end
    //逻辑�?
    5'b00010:begin 
             Result=In1&In2;
             end
    //逻辑�?
    5'b00011:begin 
             Result=In1|In2;
             end
    //逻辑异或
    5'b00100:begin 
             Result=In1^In2;
             end
    //逻辑或非
    5'b00101:begin 
             Result=~(In1|In2);
             end
    //左移
    5'b00110:begin 
             Result=In2<<In1;
             end
    //逻辑右移
    5'b00111:begin 
             Result=In2>>In1;
             end
    //算数右移
    5'b01000:begin 
             Result=($signed(In2))>>>In1;
             end
    //slt,sltu,slti,sltiu
    5'b01001:begin
                if(Sign==1'b1) begin 
                Result=($signed(In1)<$signed(In2))?32'b1:32'b0;
                end
                else begin
                Result=(In1<In2)?32'b1:32'b0;
                end
             end
    default:begin
            Result=32'b0;
            end
    
    endcase
end
         
    //--------------Your code above-----------------------

endmodule
