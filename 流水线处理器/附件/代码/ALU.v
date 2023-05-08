module ALU(ALUConf, Sign, In1, In2, Result);
    // Control Signals
    input [4:0] ALUConf;
    input Sign;
    // Input Data Signals
    input [31:0] In1;
    input [31:0] In2;
    // Output 
    output reg [31:0] Result;
    
    always @(*) begin
    case(ALUConf)
    //加法
    5'b00000:if(Sign==1'b1) begin 
             Result=$signed(In1)+$signed(In2);
             end
             else begin
             Result=In1+In2;
             end
    //减法
    5'b00001:if(Sign==1'b1) begin 
             Result=$signed(In1)-$signed(In2);
             end
             else begin
             Result=In1-In2;
             end
    //逻辑与
    5'b00010:begin 
             Result=In1&In2;
             end
    //逻辑或
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
             Result=$signed(In2)>>>In1;
             end
    //slt,sltu,slti,sltiu
    5'b01001:if(Sign==1'b1) begin 
             Result=($signed(In1)<$signed(In2))?32'b1:32'b0;
             end
             else begin
             Result=(In1<In2)?32'b1:32'b0;
             end
    
    endcase
end

endmodule