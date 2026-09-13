module add3_8(input logic [7:0] a, b, c, output logic [9:0] sum);
  assign sum = {2'b00,a} + {2'b00,b} + {2'b00,c};
endmodule
