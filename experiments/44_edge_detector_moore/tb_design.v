// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/44_edge_detector_moore/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;

reg clk;
reg rst;
reg sig_in;
wire edge_pulse;

integer errors;
integer pulse_count;

edg_detection_moore DUT (
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
        $dumpfile("44_edge_detector_moore.vcd");
        $dumpvars(0, tb_design);

    clk = 0;
    rst = 1;
    sig_in = 0;
    errors = 0;
    pulse_count = 0;

    repeat (2) @(posedge clk);
    rst = 0;
    check(1'b0, "reset released, low input");

    // first rising edge
    @(negedge clk);
    sig_in = 1;
    @(posedge clk); // state moves S0 -> S2
    @(posedge clk);
    check(1'b1, "one cycle after rising edge #1");
    @(posedge clk);
    check(1'b0, "pulse deasserted next cycle");

    // hold high, no new edge
    repeat (3) @(posedge clk);
    check(1'b0, "held high, no pulse");

    // falling edge, no pulse expected
    @(negedge clk);
    sig_in = 0;
    @(posedge clk);
    check(1'b0, "falling edge produces no pulse");
    repeat (2) @(posedge clk);
    check(1'b0, "held low, no pulse");

    // second rising edge
    @(negedge clk);
    sig_in = 1;
    @(posedge clk); // state moves S0 -> S2
    @(posedge clk);
    check(1'b1, "one cycle after rising edge #2");
    @(posedge clk);
    check(1'b0, "pulse deasserted after edge #2");

    // third rising edge after low pulse
    @(negedge clk);
    sig_in = 0;
    @(posedge clk);
    @(negedge clk);
    sig_in = 1;
    @(posedge clk); // state moves S0 -> S2
    @(posedge clk);
    check(1'b1, "one cycle after rising edge #3");
    @(posedge clk);
    check(1'b0, "pulse deasserted after edge #3");

    if (pulse_count == 3) begin
        $display("PASS: total pulses observed = %0d (expected 3)", pulse_count);
    end else begin
        $display("FAIL: total pulses observed = %0d (expected 3)", pulse_count);
        errors = errors + 1;
    end

    if (errors == 0)
        $display("SUMMARY: ALL TESTS PASSED");
    else
        $display("SUMMARY: %0d TEST(S) FAILED", errors);

    $finish;
end

endmodule
