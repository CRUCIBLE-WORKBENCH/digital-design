module tb;
  logic a, b, nand_y, nor_y;
  cmos_nand2 u0(.a(a), .b(b), .y(nand_y));
  cmos_nor2  u1(.a(a), .b(b), .y(nor_y));
  initial begin
        $dumpfile("58_cmos_nand_nor.vcd");
        $dumpvars(0, tb);

    for (int i = 0; i < 4; i++) begin
      {a,b} = i[1:0]; #1;
      assert(nand_y == ~(a & b)) else $fatal(1, "NAND mismatch");
      assert(nor_y  == ~(a | b)) else $fatal(1, "NOR mismatch");
    end
    $display("PASS cmos_nand_nor");
  end
endmodule
