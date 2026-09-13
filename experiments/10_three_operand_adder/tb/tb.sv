module tb;
  logic [7:0] a,b,c; logic [9:0] sum;
  add3_8 dut(.a(a), .b(b), .c(c), .sum(sum));
  initial begin
    for (int i=0; i<1000; i++) begin
      a = $urandom_range(0,255); b = $urandom_range(0,255); c = $urandom_range(0,255); #1;
      assert(sum == a + b + c) else $fatal(1, "%0d+%0d+%0d got %0d", a,b,c,sum);
    end
    a=8'hff; b=8'hff; c=8'hff; #1; assert(sum == 10'd765) else $fatal(1, "max sum mismatch");
    $display("PASS three_operand_adder");
  end
endmodule
