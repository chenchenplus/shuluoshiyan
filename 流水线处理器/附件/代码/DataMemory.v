
module DataMemory(reset, clk, Address, Write_data, Read_data, MemRead, MemWrite, BCD7);
  input reset, clk;
  input [31:0] Address, Write_data;
  input MemRead, MemWrite;
  output [31:0] Read_data;
  output [11:0] BCD7;
  reg [31:0] digi;
  reg [31:0] led;
  reg [31:0] Mem_data;
  
  parameter RAM_SIZE = 512;
  parameter RAM_SIZE_BIT = 8;
  
  reg [31:0] RAM_data[RAM_SIZE - 1: 0];
  assign Read_data = Address[30]?((Address[7:0]==8'h0C)?{24'b0,led}:{20'b0,digi}):(MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000);
  assign BCD7=digi[11:0];
    integer i;
  always @(posedge reset or posedge clk)
    if (reset) begin
                    RAM_data[0] <= 32'h6c696e75;
                        RAM_data[1] <= 32'h6c696e75;
                        RAM_data[2] <= 32'h78206973;
                        RAM_data[3] <= 32'h206e6f74;
                        RAM_data[4] <= 32'h6c696e75;
                        RAM_data[5] <= 32'h78206973;
                        RAM_data[6] <= 32'h206e6f74;
                        RAM_data[7] <= 32'h6c696e75;
                        RAM_data[8] <= 32'h78206973;
                        RAM_data[9] <= 32'h206e6f74;
                        RAM_data[10] <= 32'h6c696e75;
                        RAM_data[11] <= 32'h6c696e75;
                        RAM_data[12] <= 32'h78206973;
                        RAM_data[13] <= 32'h206e6f74;
                        RAM_data[14] <= 32'h6c696e75;
                        RAM_data[15] <= 32'h78206973;
                        RAM_data[16] <= 32'h206e6f74;
                        RAM_data[17] <= 32'h6c696e75;
                        RAM_data[18] <= 32'h78206973;
                        RAM_data[19] <= 32'h206e6f74;
                        RAM_data[20] <= 32'h6c696e75;
                        RAM_data[21] <= 32'h78206973;
                        RAM_data[22] <= 32'h206e6f74;
                        RAM_data[23] <= 32'h6c696e75;
                        RAM_data[24] <= 32'h78206973;
                        RAM_data[25] <= 32'h206e6f74;
                        RAM_data[26] <= 32'h6c696e75;
                        RAM_data[27] <= 32'h78206973;
                        RAM_data[28] <= 32'h206e6f74;
                        RAM_data[29] <= 32'h6c696e75;
                        RAM_data[30] <= 32'h78206973;
                        RAM_data[31] <= 32'h206e6f74;
                        RAM_data[32] <= 32'h6c696e75;
                        RAM_data[33] <= 32'h78206973;
                        RAM_data[34] <= 32'h206e6f74;
                        RAM_data[35] <= 32'h6c696e75;
                        RAM_data[36] <= 32'h78206973;
                        RAM_data[37] <= 32'h206e6f74;
                        RAM_data[38] <= 32'h6c696e75;
                        RAM_data[39] <= 32'h78206973;
                        RAM_data[40] <= 32'h206e6f74;
                        RAM_data[41] <= 32'h6c696e75;
                        RAM_data[42] <= 32'h78206973; 
                        RAM_data[43] <= 32'h206e6f74;
                        RAM_data[44] <= 32'h6c696e75;
                        RAM_data[45] <= 32'h78206973;
                        RAM_data[46] <= 32'h206e6f74;
                        RAM_data[47] <= 32'h6c696e75;
                        RAM_data[48] <= 32'h6c696e75;
                        RAM_data[49] <= 32'h6c696e75;
                        RAM_data[50] <= 32'h20696e77;
                        RAM_data[51] <= 32'h20696e77;
                        RAM_data[52] <= 32'h20696e77;
                        RAM_data[53] <= 32'h20696e77;
                        RAM_data[54] <= 32'h20696e77;
                        RAM_data[55] <= 32'h6c696e75;
                        RAM_data[56] <= 32'h6c696e75;
                        RAM_data[57] <= 32'h6c696e75;
                        RAM_data[58] <= 32'h6c696e75;
                        RAM_data[59] <= 32'h6c696e75;
                        RAM_data[60] <= 32'h6c696e75;
                        RAM_data[61] <= 32'h6c696e75;
                        RAM_data[62] <= 32'h6c696e75;
                        RAM_data[63] <= 32'h780a0000;
                
                       // for (i = 64; i < RAM_SIZE; i = i + 1)
                         //       RAM_data[i] <= 32'h00000000;
                        digi<=32'hffffffff;
                        led<=32'h00000000;

    end
    else if (MemWrite) begin
      if(~Address[30]) begin
      RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data; 
      end
      else begin
        case(Address[7:0])
        8'h0C: led <= {24'b0,Write_data[7:0]};
        8'h10: digi <= {20'b0,Write_data[11:0]};
        endcase
      end
    end
      
endmodule
