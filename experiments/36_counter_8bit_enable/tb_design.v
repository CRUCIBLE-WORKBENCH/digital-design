// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/36_counter_8bit_enable/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;

reg clk;
reg rst;
reg en;
wire [7:0] count;

integer errors;
integer i;

cnt DUT (
    .clk(clk),
    .rst(rst),
    .en(en),
    .count(count)
);

always #5 clk = ~clk;

task check;
    input [7:0] expected;
    begin
        if (count === expected) begin
            $display("PASS: time=%0t count=%0d expected=%0d", $time, count, expected);
        end else begin
            $display("FAIL: time=%0t count=%0d expected=%0d", $time, count, expected);
            errors = errors + 1;
        end
    end
endtask

initial begin
        $dumpfile("36_counter_8bit_enable.vcd");
        $dumpvars(0, tb_design);

    clk = 0;
    rst = 1;
    en = 0;
    errors = 0;

    @(posedge clk);
    @(posedge clk);
    #1;
    check(8'd0);

    @(negedge clk);
    rst = 0;
    en = 1;
    for (i = 1; i <= 5; i = i + 1) begin
        @(posedge clk);
        #1;
        check(i[7:0]);
    end

    @(negedge clk);
    en = 0;
    @(posedge clk);
    #1;
    check(8'd5);
    @(posedge clk);
    #1;
    check(8'd5);

    @(negedge clk);
    en = 1;
    @(posedge clk);
    #1;
    check(8'd6);

    @(negedge clk);
    rst = 1;
    @(posedge clk);
    #1;
    check(8'd0);

    @(negedge clk);
    rst = 0;
    @(posedge clk);
    #1;
    check(8'd1);

    if (errors == 0)
        $display("SUMMARY: ALL TESTS PASSED");
    else
        $display("SUMMARY: %0d TEST(S) FAILED", errors);

    $finish;
end

endmodule
