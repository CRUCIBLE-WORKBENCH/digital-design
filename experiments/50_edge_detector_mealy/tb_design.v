`timescale 1ns/1ps

module tb_design;

reg clk;
reg rst;
reg sig_in;
wire edge_pulse;

integer errors;
integer pulse_count;

riseedge_mealy DUT (
    .clk(clk),
    .rst(rst),
    .sig_in(sig_in),
    .edge_pulse(edge_pulse)
);

always #5 clk = ~clk;

task check;
    input expected;
    input [127:0] label;
    begin
        if (edge_pulse === expected) begin
            $display("PASS: time=%0t %0s edge_pulse=%b expected=%b", $time, label, edge_pulse, expected);
        end else begin
            $display("FAIL: time=%0t %0s edge_pulse=%b expected=%b", $time, label, edge_pulse, expected);
            errors = errors + 1;
        end
    end
endtask

always @(posedge clk) begin
    if (edge_pulse)
        pulse_count = pulse_count + 1;
end

initial begin
        $dumpfile("50_edge_detector_mealy.vcd");
        $dumpvars(0, tb_design);

    clk = 0;
    rst = 1;
    sig_in = 0;
    errors = 0;
    pulse_count = 0;

    repeat (2) @(posedge clk);
    rst = 0;
    check(1'b0, "reset released, low input, no pulse");

    // Mealy: pulse appears combinationally as soon as sig_in rises
    // while state is still S0 (before next clock edge), unlike Moore
    // which needs a clock edge first.
    @(negedge clk);
    sig_in = 1;
    #1;
    check(1'b1, "combinational pulse immediately on rising edge (Mealy)");

    @(posedge clk); // state moves to S1 now
    #1;
    check(1'b0, "pulse deasserted once state reaches S1");

    // hold high, no new edge, no pulse
    repeat (3) @(posedge clk);
    check(1'b0, "held high, no pulse");

    // falling edge, no pulse expected
    @(negedge clk);
    sig_in = 0;
    #1;
    check(1'b0, "falling edge produces no pulse");
    @(posedge clk);
    repeat (2) @(posedge clk);
    check(1'b0, "held low, no pulse");

    // second rising edge
    @(negedge clk);
    sig_in = 1;
    #1;
    check(1'b1, "combinational pulse on rising edge #2");
    @(posedge clk);
    #1;
    check(1'b0, "pulse deasserted after edge #2 clock");

    // third rising edge after a low period
    @(negedge clk);
    sig_in = 0;
    #1;
    @(posedge clk);
    @(negedge clk);
    sig_in = 1;
    #1;
    check(1'b1, "combinational pulse on rising edge #3");
    @(posedge clk);
    #1;
    check(1'b0, "pulse deasserted after edge #3 clock");

    if (pulse_count == 3) begin
        $display("PASS: registered pulse_count sampled at posedge = %0d (matches 3 rising edges)", pulse_count);
    end else begin
        $display("FAIL: unexpected registered pulse_count = %0d (expected 3)", pulse_count);
        errors = errors + 1;
    end

    if (errors == 0)
        $display("SUMMARY: ALL TESTS PASSED");
    else
        $display("SUMMARY: %0d TEST(S) FAILED", errors);

    $finish;
end

endmodule
