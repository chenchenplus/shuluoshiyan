module LEDs(clk_1k,qout,LED,AN,leds,reset,flag);
  input clk_1k,reset;
  input [15:0] qout;
  input [1:0] flag;
  output [3:0] AN;
  output reg LED=0;
  reg [3:0]AN=4'b1111;
  output [7:0] leds;
  reg [7:0] leds=0;
  reg [4:0] ledi=0;

always @(posedge clk_1k or posedge reset)
 begin
  if(reset) begin AN<=4'b1111; LED<=0;end
  else
  begin 
  if(flag==1) LED<=1;
  if(flag==3)
    begin
    LED<=0;
    case(AN)   
        4'b0111:AN<=4'b1110;
        4'b1011:AN<=4'b0111;
        4'b1101:AN<=4'b1011;
        4'b1110:AN<=4'b1101;
        4'b1111:AN<=4'b0111;
    endcase
  
    end
  end
 end
always @(*)begin
    case(AN)   
        4'b0111:ledi<={qout[15:12],1'b1};
        4'b1011:ledi<={qout[11:8],1'b1};
        4'b1101:ledi<={qout[7:4],1'b0};
        4'b1110:ledi<={qout[3:0],1'b1};
        default:ledi<=5'b11111;
    endcase
    case(ledi)   
          5'd0: leds[7:0]<=8'b01000000;
          5'd1: leds[7:0]<=8'b11000000;
          5'd2: leds[7:0]<=8'b01111001;
          5'd3: leds[7:0]<=8'b11111001;
          5'd4: leds[7:0]<=8'b00100100;
          5'd5: leds[7:0]<=8'b10100100;
          5'd6: leds[7:0]<=8'b00110000;
          5'd7: leds[7:0]<=8'b10110000;
          5'd8: leds[7:0]<=8'b00011001;
          5'd9: leds[7:0]<=8'b10011001;
          5'd10:leds[7:0]<=8'b00010010;
          5'd11:leds[7:0]<=8'b10010010;
          5'd12:leds[7:0]<=8'b00000010;
          5'd13:leds[7:0]<=8'b10000010;
          5'd14:leds[7:0]<=8'b01111000;
          5'd15:leds[7:0]<=8'b11111000; 
          5'd16:leds[7:0]<=8'b00000000;
          5'd17:leds[7:0]<=8'b10000000;
          5'd18:leds[7:0]<=8'b00010000;
          5'd19:leds[7:0]<=8'b10010000;
          default:leds[7:0]<=8'b11111111;
    endcase
    
   end
endmodule
