//design code for moore sequence detector
module Sequence_Detector_MOORE(sequence_in,clock,reset,detector_out
    );
input clock; 
input reset; 
input sequence_in;
output reg detector_out; 
parameter  Zero=3'b000, 
  One=3'b001,
  OneZero=3'b011, 
  OneZeroOne=3'b010, 
  OneZeroOneOne=3'b110;
reg [2:0] current_state, next_state;
always @(posedge clock, posedge reset)
begin
 if(reset==1) 
 current_state <= Zero;
 else
 current_state <= next_state; 
end 

always @(current_state,sequence_in)
begin
 case(current_state) 
 Zero:begin
  if(sequence_in==1)
   next_state = One;
  else
   next_state = Zero;
 end
 One:begin
  if(sequence_in==0)
   next_state = OneZero;
  else
   next_state = One;
 end
 OneZero:begin
  if(sequence_in==0)
   next_state = Zero;
  else
   next_state = OneZeroOne;
 end 
 OneZeroOne:begin
  if(sequence_in==0)
   next_state = OneZero;
  else
   next_state = OneZeroOneOne;
 end
 OneZeroOneOne:begin
  if(sequence_in==0)
   next_state = OneZero;
  else
   next_state = One;
 end
 default:next_state = Zero;
 endcase
end

always @(current_state)
begin 
 case(current_state) 
 Zero:   detector_out = 0;
 One:   detector_out = 0;
 OneZero:  detector_out = 0;
 OneZeroOne:  detector_out = 0;
 OneZeroOneOne:  detector_out = 1;
 default:  detector_out = 0;
 endcase
end 
endmodule

// testbench for Moore sequence detector
module tb_Sequence_Detector_Moore
 reg sequence_in;
 reg clock;
 reg reset;
 wire detector_out;
 Sequence_Detector_MOORE uut (
  .sequence_in(sequence_in), 
  .clock(clock), 
  .reset(reset), 
  .detector_out(detector_out)
 );
 
 initial begin
    $dumpfile("dump.vcd");
  $dumpvars(1);
   clock = 0;
  sequence_in = 0;
  reset = 1; 
  // Wait 100 ns for global reset to finish
  #10;
      reset = 0;
  #10;
  sequence_in = 1;
  #10;
  sequence_in = 0;
  #10;
  sequence_in = 1; 
  #10;
  sequence_in = 1; 
  #10;
  sequence_in = 0; 
  #10;
  sequence_in = 1;  
   $finish;
 end
  initial begin
 forever #5 clock = ~clock;
 end      
endmodule
