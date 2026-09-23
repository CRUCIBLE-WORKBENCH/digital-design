// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/29_d_flipflop_async_reset/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;

    reg d, clk, rst;
    wire q;
    integer errors;

    d_flipflop dut (.d(d), .clk(clk), .rst(rst), .q(q));

    always #5 clk = ~clk;

    task check_q;
        input expected;
        input [127:0] name;
        begin
            if (q === expected) begin
                $display("PASS: %s d=%b rst=%b -> q=%b (expected %b)", name, d, rst, q, expected);
            end else begin
                $display("FAIL: %s d=%b rst=%b -> q=%b (expected %b)", name, d, rst, q, expected);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("29_d_flipflop_async_reset.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        clk = 0;
        d   = 0;
        rst = 1;

        @(posedge clk); #1;
        check_q(1'b0, "async reset");

        rst = 0;
        d   = 1;
        @(posedge clk); #1;
        check_q(1'b1, "d=1 captured");

        d = 0;
        @(posedge clk); #1;
        check_q(1'b0, "d=0 captured");

        d = 1;
        @(posedge clk); #1;
        check_q(1'b1, "d=1 captured again");

        #2;
        rst = 1;
        #1;
        check_q(1'b0, "async reset mid-cycle");
        rst = 0;

        d = 0;
        @(posedge clk); #1;
        check_q(1'b0, "d=0 after reset release");

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
