//design code for crc 16 generator
module crc_16(
input x16,
input clk,start,
output reg [15:0]r,
output reg done);
reg temp;
parameter active=1;
integer count;
reg state;
always @(negedge clk) begin
if(start==1) begin
state<=active;
r<=16'hffff; count<=1;
end
end
always @(negedge clk) begin
if(state==active) begin
r[0]<=r[15]+x16;
r[1]<=r[0];
r[2]<=r[1]+r[15]+x16;
r[14:3]<=r[13:2];
r[15]<=r[14]+r[15]+x16;
count<=count+1;
end
if(count==40)
done<=1;
end
endmodule
//test bench for crc 16 generator
module test;
reg x;
reg clk,start;
wire [15:0]r;
wire done;
crc_16 uut(x,clk,start,r,done);
initial begin
$dumpfile("dump.vcd");
$dumpvars(1);
clk=0;
forever #5 clk=~clk;
end
initial fork
start=0;
#10 start=1;
#20 start=0;
#20 x=0;
#80 x=1;
#100 x=0;
#170 x=1;
#180 x=0;
#240 x=1;
#250 x=0;
#320 x=1;
#340 $finish;
join
endmodule
