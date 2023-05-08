module shiftreg(BTND,led,out,SW1,reset);
input BTND,SW1,reset;
output[5:0]led;
output out;
reg[5:0]led;
assign out=(led== 6'b101011) ? 1'b1:1'b0;
always @(posedge reset or posedge BTND)
 begin
  if(reset) led<=6'd0;
  else led<={led[4:0],SW1};
  
  
 end

endmodule 