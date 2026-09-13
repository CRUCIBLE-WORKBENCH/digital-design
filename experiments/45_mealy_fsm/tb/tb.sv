module tb;
  logic clk=0, rst_n=0, din=0, detected; int hits=0;
  bit [11:0] stream = 12'b101101101011;
  mealy_1011 dut(.clk(clk), .rst_n(rst_n), .din(din), .detected(detected));
  always #5 clk = ~clk;
  initial begin
    repeat (2) @(posedge clk); rst_n = 1;
    for (int i=11; i>=0; i--) begin
      din = stream[i]; #1; if (detected) hits++; @(posedge clk);
    end
    assert(hits == 3) else $fatal(1, "hits=%0d", hits);
    $display("PASS mealy_fsm hits=%0d", hits);
    $finish;
  end
endmodule
