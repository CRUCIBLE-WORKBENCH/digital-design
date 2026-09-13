module cmos_nand2(input logic a, b, output logic y);
  assign y = ~(a & b);
endmodule

module cmos_nor2(input logic a, b, output logic y);
  assign y = ~(a | b);
endmodule
