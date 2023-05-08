module counter(clk,cnt,reset);
  input clk,reset;
  output [3:0] cnt;
  reg [3:0] cnt;
always @(posedge reset or posedge clk)
 begin
  if(reset) cnt<=4'b0000;
  else begin
  if(cnt==4'b1001) cnt<=4'b0000;
  else cnt<=cnt+1;
  end
 end
endmodule
module led(clk,reset,dout);
 input 	clk,reset;
 output [6:0] dout;
 reg [6:0] dout;
 wire [3:0] count;
counter deccnt(clk,count,reset);
always @(*)
 begin
    case(count)   
        4'h0: dout=7'b1000000;
        4'h1: dout=7'b1111001;
        4'h2: dout=7'b0100100;
        4'h3: dout=7'b0110000;
        4'h4: dout=7'b0011001;
        4'h5: dout=7'b0010010;
        4'h6: dout=7'b0000010;
        4'h7: dout=7'b1111000;
        4'h8: dout=7'b0000000;
        4'h9: dout=7'b0010000;
        default: dout=7'b1111111;
    endcase

end

endmodule