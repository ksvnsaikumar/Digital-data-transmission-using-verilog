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
