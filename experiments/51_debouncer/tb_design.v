// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/51_debouncer/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;

reg clk;
reg rst;
reg btn_in;
wire btn_out;

integer errors;
integer i;

debouncing #(.N(4)) DUT (
    .clk(clk),
    .rst(rst),
    .btn_in(btn_in),
    .btn_out(btn_out)
);

always #5 clk = ~clk;

task check;
    input expected;
    input [127:0] label;
    begin
        if (btn_out === expected) begin
            $display("PASS: time=%0t %0s btn_out=%b expected=%b", $time, label, btn_out, expected);
        end else begin
            $display("FAIL: time=%0t %0s btn_out=%b expected=%b", $time, label, btn_out, expected);
            errors = errors + 1;
        end
    end
endtask

initial begin
        $dumpfile("51_debouncer.vcd");
        $dumpvars(0, tb_design);

    clk = 0;
    rst = 1;
    btn_in = 0;
    errors = 0;

    repeat (2) @(posedge clk);
    rst = 0;
    check(1'b0, "after reset");

    // noisy bouncing pattern on btn_in
    for (i = 0; i < 10; i = i + 1) begin
        btn_in = ~btn_in;
        @(posedge clk);
    end
    btn_in = 0;
    @(posedge clk);
    check(1'b0, "during bounce, output still low");

    // stable high level applied
    btn_in = 1;
    repeat (2) @(posedge clk);
    check(1'b0, "stable high too early");

    repeat (20) @(posedge clk);
    check(1'b1, "stable high after N cycles");

    // bounce again before settling low
    for (i = 0; i < 10; i = i + 1) begin
        btn_in = ~btn_in;
        @(posedge clk);
    end
    btn_in = 1;
    @(posedge clk);
    check(1'b1, "during bounce near high, output still high");

    // stable low level applied
    btn_in = 0;
    repeat (2) @(posedge clk);
    check(1'b1, "stable low too early");

    repeat (20) @(posedge clk);
    check(1'b0, "stable low after N cycles");

    if (errors == 0)
        $display("SUMMARY: ALL TESTS PASSED");
    else
        $display("SUMMARY: %0d TEST(S) FAILED", errors);

    $finish;
end

endmodule
