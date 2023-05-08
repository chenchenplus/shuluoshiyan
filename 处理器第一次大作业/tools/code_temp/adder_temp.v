`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC) \
                generate \
                genvar unpk_idx; \
                for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) \
                begin \
                        assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; \
                end \
                endgenerate
module adder_temp(Iin,M,m,Y,clk,rst);
  input wire [31:0]Iin;
  input clk;
  input rst;
  input wire [2:0]M;
  input wire [2:0]m;
  output reg [7:0]Y=8'b0;
  reg add_done;
  wire [3:0]I[7:0];
  `UNPACK_ARRAY(4,8,I,Iin)
  reg[3:0] current_state,next_state;
  always @(posedge rst or posedge clk)
  begin
   if(rst) 
   begin 
       current_state<=4'b0;
       next_state<=4'b0;
       Y<=8'b0;
       add_done<=1'b0;
   end
   else if(!add_done)
   begin
   case(current_state)
     //¸´Î»Ì¬ 
      4'b0000:
      begin 
            if(M<m) next_state={1'b0,M};
            else next_state={1'b1,m};
            if(M==0)begin
             Y<=I[0];
             if(m==0) add_done=1'b1;            
             else begin
             next_state=4'b0001;
             end
             end
            else if(m==0)begin
            Y<=I[0];
            next_state=4'b1001;
            end
      end
      4'b0001: 
      begin Y<=Y+I[1];
            if(m==3'b001)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b0010;
            
      end
      4'b0010: 
      begin Y<=Y+I[2];
            if(m==3'b010)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b0011;
      end
      4'b0011: 
      begin Y<=Y+I[3];
            if(m==3'b011)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b0100;
      end
      4'b0100: 
      begin Y<=Y+I[4];
            if(m==3'b100)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b0101;
      end
      4'b0101: 
      begin 
            Y<=Y+I[5];
            if(m==3'b101)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b0110;
      end
      4'b0110: 
      begin Y<=Y+I[6];
            if(m==3'b110)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b0111;
      end
      4'b0111: 
      begin Y<=Y+I[7];
            next_state=4'b0000;
            add_done=1'b1;     
      end
      /*4'b1000:
      begin 
            if(M==0) begin next_state=4'b0000;
            add_done<=1'b1;
            end
            else begin
            end
      end*/
      4'b1001: 
      begin Y<=Y+I[1];
            if(M==3'b001)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b1010;
            
      end
      4'b1010: 
      begin Y<=Y+I[2];
            if(M==3'b010)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b1011;
      end
      4'b1011: 
      begin Y<=Y+I[3];
            if(M==3'b011)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b1100;
      end
      4'b1100: 
      begin Y<=Y+I[4];
            if(M==3'b100)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b1101;
      end
      4'b1101: 
      begin 
            Y<=Y+I[5];
            if(M==3'b101)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b1110;
      end
      4'b1110: 
      begin Y<=Y+I[6];
            if(M==3'b110)begin next_state=4'b0000;
            add_done=1'b1;
            end
            else next_state=4'b1111;
      end
      4'b1111: 
      begin Y<=Y+I[7];
            next_state=4'b0000;
            add_done=1'b1;
      end
      endcase
      current_state<=next_state;
      end
  end
  
endmodule