module cmos_nand2_v(input a, input b, output y);
  assign y = ~(a & b);
endmodule

module cmos_nor2_v(input a, input b, output y);
  assign y = ~(a | b);
endmodule
