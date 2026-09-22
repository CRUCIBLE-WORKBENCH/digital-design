module tb;
  logic en; logic [1:0] sel; logic [7:0] d0=8'h12,d1=8'h34,d2=8'h56,d3=8'h78; tri [7:0] y;
  logic [7:0] exp [0:3];
  tri_state_mux4 dut(.en(en), .sel(sel), .d0(d0), .d1(d1), .d2(d2), .d3(d3), .y(y));
  initial begin
        $dumpfile("21_tri_state_mux4.vcd");
        $dumpvars(0, tb);

    exp[0]=d0; exp[1]=d1; exp[2]=d2; exp[3]=d3;
    en=0; sel=0; #1; assert(y === 8'hzz) else $fatal(1, "expected z");
    en=1;
    for (int i=0; i<4; i++) begin sel=i[1:0]; #1; assert(y === exp[i]) else $fatal(1, "sel=%0d y=%h", i, y); end
    $display("PASS tri_state_mux4");
  end
endmodule
