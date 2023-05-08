module reactspeed(clk_10k,qout,BTND,reset,flag);
input clk_10k,BTND,reset;
output [15:0] qout;
reg [13:0] cnt=0;
output reg [1:0] flag=0;
CNT cnter(clk_10k,qout,flag,reset);
always @(posedge reset or posedge clk_10k)
 begin
 if(reset)
 begin
     cnt<=0;
     flag<=2;
 end
else if(flag==2)
 begin
     cnt<=cnt+1;
     
     if(cnt>14'b10011100010000) begin flag<=1;end
 end
else if(BTND)
 begin
   flag<=3;
 end
end
endmodule 

module CNT(clk_10k,qout,flag,reset);
 input clk_10k,reset;
 input [1:0] flag;
 output reg [15:0] qout=0;
 always @(posedge reset or posedge clk_10k)
 begin
 if(reset)
  qout<=0;
 else if(flag==1)
         begin
          if (qout[3:0]==9)
             begin
                 qout[3:0]<=0;
                 if (qout[7:4]==9)
                  begin
                      qout[7:4]<=0;
                    if(qout[11:8]==9)
                       begin
                           qout[11:8]<=0;
                       if(qout[15:12]==9)
                           qout[15:12]<=0;
                       else
                         qout[15:12]<=qout[15:12]+1;
                       end
                    else
                       qout[11:8]<=qout[11:8]+1;
                  end  
                 else
                  qout[7:4]<=qout[7:4]+1;
              end
           else qout[3:0]<=qout[3:0]+1;
         end
  end
endmodule