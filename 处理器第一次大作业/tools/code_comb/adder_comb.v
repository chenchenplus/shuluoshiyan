`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC) \
                generate \
                genvar unpk_idx; \
                for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) \
                begin \
                        assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; \
                end \
                endgenerate
module adder_comb(Iin,M,m,Y);
  input wire [31:0]Iin;
  input wire [2:0]M;
  input wire [2:0]m;
  output [7:0]Y;
  wire [3:0]I[7:0];
  `UNPACK_ARRAY(4,8,I,Iin)
  reg [4:0]s01;
  reg [4:0]s23;
  reg [4:0]s45;
  reg [4:0]s67;
  reg [5:0]s0123;
  reg [5:0]s4567;
  reg [3:0]I_mux[7:0];
  always @(*)
  begin
        I_mux[0]=((!M[2]&!M[1]&!M[0])|(!m[2]&!m[1]&!m[0]))?I[0]:4'b0;
        I_mux[1]=(((!M[2]&!M[1])^(!m[2]&!m[1]))|(!M[2]&!M[1]&M[0])|(!m[2]&!m[1]&m[0]))?I[1]:4'b0;
        I_mux[2]=((((!M[2]&!M[1])|(!M[2]&!M[0]))^((!m[2]&!m[1])|(!m[2]&!m[0])))|(!M[2]&M[1]&!M[0])|(!m[2]&m[1]&!m[0]))?I[2]:4'b0;
        I_mux[3]=((!M[2]^!m[2])|(!M[2]&M[1]&M[0])|(!m[2]&m[1]&m[0]))?I[3]:4'b0;
        I_mux[4]=((((M[2]&M[1])|(M[2]&M[0]))^((m[2]&m[1])|(m[2]&m[0])))|(M[2]&!M[1]&!M[0])|(m[2]&!m[1]&!m[0]))?I[4]:4'b0;
        I_mux[5]=((((M[2]&M[1])^(m[2]&m[1])))|(M[2]&!M[1]&M[0])|(m[2]&!m[1]&m[0]))?I[5]:4'b0;
        I_mux[6]=(((M[2]&M[1]&M[0])^(m[2]&m[1]&m[0]))|(M[2]&M[1]&!M[0])|(m[2]&m[1]&!m[0]))?I[6]:4'b0;
        I_mux[7]=((M[2]&M[1]&M[0])|(m[2]&m[1]&m[0]))?I[7]:4'b0;
        s01=I_mux[0]+I_mux[1];
        s23=I_mux[2]+I_mux[3];
        s45=I_mux[4]+I_mux[5];
        s67=I_mux[6]+I_mux[7];
        s0123=s01+s23;
        s4567=s45+s67;
    end
  assign Y=s0123+s4567;
endmodule