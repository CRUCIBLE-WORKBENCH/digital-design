module add3_8_v(input [7:0] a, input [7:0] b, input [7:0] c, output [9:0] sum);
  assign sum = {2'b00,a} + {2'b00,b} + {2'b00,c};
endmodule
