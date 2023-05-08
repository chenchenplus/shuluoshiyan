module PC_pipeline(reset,clk,Stall,PC_i,PC_o);
    
    input reset,clk,Stall;            
    input [31:0] PC_i;
    output reg [31:0] PC_o; 
    reg [31:0] cnt=0;

    always@(posedge reset or posedge clk)
    begin
        if(reset) begin
            PC_o <= 0;
            cnt<=cnt+1;
        end else if(Stall) begin
            PC_o <= PC_o;
        end else begin
            PC_o <= PC_i;
            cnt<=cnt+1;
        end
    end
endmodule