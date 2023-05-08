module fsm(BTND,led0,led5,led6,led7,SW1,reset);
input BTND,SW1,reset;
output led0,led5,led6,led7;
reg led0,led5,led6,led7;
reg[2:0] current_state,next_state;
always @(posedge reset or posedge BTND)
 begin
  if(reset) current_state<=0;
  else current_state<=next_state;
 end
always @(*) begin
  case(current_state) 
   3'b000:
   begin led0<=0;
         led5<=current_state[0];
         led6<=current_state[1];
         led7<=current_state[2];
         if(SW1) next_state=3'b001;
         else next_state=3'b000;
   end
   3'b001: 
   begin led0<=0;
         led5<=current_state[0];
         led6<=current_state[1];
         led7<=current_state[2];
         if(SW1) next_state=3'b001;
         else next_state=3'b010;
         
   end
   3'b010: 
   begin led0<=0;
         led5<=current_state[0];
         led6<=current_state[1];
         led7<=current_state[2];
         if(SW1) next_state=3'b011;
         else next_state=3'b000;
   end
   3'b011: 
   begin led0<=0;
         led5<=current_state[0];
         led6<=current_state[1];
         led7<=current_state[2];
         if(SW1) next_state=3'b001;
         else next_state=3'b100;
   end
   3'b100: 
   begin led0<=0;
         led5<=current_state[0];
         led6<=current_state[1];
         led7<=current_state[2];
         if(SW1) next_state=3'b101;
         else next_state=3'b000;
   end
   3'b101: 
   begin 
         led5<=current_state[0];
         led6<=current_state[1];
         led7<=current_state[2];
         if(SW1) 
         next_state=3'b110;
         else 
         next_state=3'b000;
   end
   3'b110: 
   begin led0<=1;
         led5<=current_state[0];
         led6<=current_state[1];
         led7<=current_state[2];
         if(SW1) next_state=3'b001;
         else next_state=3'b010;
   end
  endcase
  end
endmodule 