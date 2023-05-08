module ALU(input [4:0]ALUCtrl,
           input Sign,
           input [31:0] in1,
           input [31:0] in2,
           output reg [31:0] out,
           output zero
);
assign zero=(out==32'b0)?1'b1 : 1'b0;
always @(*) begin
    case(ALUCtrl)
    //加法
    5'b00000:if(Sign==1'b1) begin 
             out=$signed(in1)+$signed(in2);
             end
             else begin
             out=in1+in2;
             end
    //减法
    5'b00001:if(Sign==1'b1) begin 
             out=$signed(in1)-$signed(in2);
             end
             else begin
             out=in1-in2;
             end
    //逻辑�?
    5'b00010:begin 
             out=in1&in2;
             end
    //逻辑�?
    5'b00011:begin 
             out=in1|in2;
             end
    //逻辑异或
    5'b00100:begin 
             out=in1^in2;
             end
    //逻辑或非
    5'b00101:begin 
             out=~(in1|in2);
             end
    //左移
    5'b00110:begin 
             out=in2<<in1;
             end
    //逻辑右移
    5'b00111:begin 
             out=in2>>in1;
             end
    //算数右移
    5'b01000:begin 
             out=$signed(in2)>>>in1;
             end
    //slt,sltu,slti,sltiu
    5'b01001:if(Sign==1'b1) begin 
             out=($signed(in1)<$signed(in2))?32'b1:32'b0;
             end
             else begin
             out=(in1<in2)?32'b1:32'b0;
             end
    
    endcase
end
endmodule