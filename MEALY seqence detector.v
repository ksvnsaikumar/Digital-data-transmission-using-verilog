//design code for mealy sequence detector
module sequence_0111(clock, reset, in_bit, out_bit
 );
 input clock, reset, in_bit;
 output out_bit;

 reg [2:0] state_reg, next_state;
 
 parameter reset_state = 3'b000;
 parameter read_zero = 3'b001;
 parameter read_0_one = 3'b010;
 parameter read_zero_one_one = 3'b011;
 parameter read_zero_one_one_one= 3'b100;

 
 always @ (posedge clock or posedge reset)
 if (reset == 1)
 state_reg <= reset_state;
 else
 state_reg <= next_state;
 
always @ (state_reg or in_bit)
 case (state_reg)
 reset_state:
 if (in_bit == 0)
 next_state = read_zero;
 else if (in_bit == 1)
 next_state = reset_state;
 else next_state = reset_state;
 read_zero:
 if (in_bit == 0)
 next_state = read_zero;
 else if (in_bit == 1)
 next_state = read_0_one;
 else next_state = reset_state;
 read_0_one:
 if (in_bit == 0)
 next_state = read_zero;
 else if (in_bit == 1)
 next_state = read_zero_one_one;
 else next_state = reset_state;
read_zero_one_one:
 if (in_bit == 0)
 next_state = read_zero;
 else if (in_bit == 1)
 next_state = read_zero_one_one_one;
 else next_state = reset_state;
 read_zero_one_one_one:
 if (in_bit == 0)
 next_state = read_zero;
 else if (in_bit == 1)
 next_state = reset_state;
 else next_state = reset_state;
 default: next_state = reset_state;
endcase
assign out_bit = (state_reg == read_zero_one_one_one)? 1 : 0;
endmodule

//testbench for mealy sequence detector
module test_sequence;
reg clock;
reg reset;
reg in_bit;
wire out_bit;
sequence_0111 uut (
.clock(clock),
.reset(reset),
.in_bit(in_bit),
.out_bit(out_bit)
);
initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
clock = 0;
reset = 0;
in_bit = 0;
#10;
reset = 1;
in_bit = 0;
#10;
reset = 0;
in_bit = 0;
#10;
reset = 0;
in_bit = 1;
#10;
reset = 0;
in_bit = 1;
#10;
reset = 0;
in_bit = 1;
#10;
reset = 1;
in_bit = 1;
#10;
reset = 0;
in_bit = 0;
#10;
reset = 0;
in_bit = 1;
#10;
reset = 0;
in_bit = 1;
#10;
reset = 0;
in_bit = 1;
#10;
  $finish;
end
always begin #5 clock=~clock; end
endmodule
