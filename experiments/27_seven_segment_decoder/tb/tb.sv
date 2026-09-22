module tb;
  logic [3:0] hex; logic [6:0] seg;
  logic [6:0] expected [0:15];
  seven_segment_decoder dut(.hex(hex), .seg(seg));
  initial begin
        $dumpfile("27_seven_segment_decoder.vcd");
        $dumpvars(0, tb);

    expected[0]=7'b1111110; expected[1]=7'b0110000; expected[2]=7'b1101101; expected[3]=7'b1111001;
    expected[4]=7'b0110011; expected[5]=7'b1011011; expected[6]=7'b1011111; expected[7]=7'b1110000;
    expected[8]=7'b1111111; expected[9]=7'b1111011; expected[10]=7'b1110111; expected[11]=7'b0011111;
    expected[12]=7'b1001110; expected[13]=7'b0111101; expected[14]=7'b1001111; expected[15]=7'b1000111;
    for (int i = 0; i < 16; i++) begin
      hex = i[3:0]; #1;
      assert(seg == expected[i]) else $fatal(1, "hex=%0h seg=%b expected=%b", hex, seg, expected[i]);
    end
    $display("PASS seven_segment_decoder");
  end
endmodule
