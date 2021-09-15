//design code for Hamming encoder
module hamenc(clk,d,c ); 
  input clk;
  input [3:0] d;
  output reg[6:0] c;
  always@(posedge clk)
    begin 
      c[6]=d[3];
      c[5]=d[2]; 
      c[4]=d[1];
      c[3]=d[1]^d[2]^d[3];
      c[2]=d[0];
      c[1]=d[0]^d[2]^d[3]; 
      c[0]=d[0]^d[1]^d[3]; 
    end 
endmodule
//test bench for hamming encoder
module test_encoder;
reg clk;
  reg [3:0]d;
  wire [6:0] c;
hamenc uut (
.clk(clk),
  .d(d),
  .c(c)
);
initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
clk = 0;
  d[3:0] = 4'b0000;
#10;
  d[3:0]=4'b1011;
#10;
  $finish;
end
always begin #1 clk=~clk; end
endmodule
//design code for Hamming decoder
module hamdec(c,clk,s,c2,d );
  input clk;
  input[6:0] c;
  output reg[2:0]s; 
  output reg[6:0] c2;
  output reg[3:0]d; 
  always@(posedge clk)
    begin 
      s[2]=c[0]^c[4]^c[5]^c[6];
      s[1]=c[1]^c[2]^c[5]^c[6];
      s[0]=c[0]^c[2]^c[4]^c[6]; 
      c2=c;
      if(s) 
        c2[s-1]=~c[s-1];
end 
always@(c2)
  begin
    d[0]=c2[2];
    d[1]=c2[4];
    d[2]=c2[5];
    d[3]=c2[6]; 
  end
endmodule
//test bench for hamming encoder
module test_decoder;
reg clk;
reg [6:0]c;
  wire [2:0] s;
  wire [6:0] c2;
  wire [3:0] d;
  hamdec uut (.c(c),
.clk(clk), .s(s) ,
 .c2(c2),
  .d(d)  );
initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
clk = 0;
  c[6:0] = 7'b0000000;
#10;
  c[6:0]=7'b1010101;
#10;
  $finish;
end
always begin #1 clk=~clk; end
endmodule
