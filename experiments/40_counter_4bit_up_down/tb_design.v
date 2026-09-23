// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/40_counter_4bit_up_down/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;
    reg clk, rst, updown, en;
    wire [3:0] count;

    integer errors;
    integer i;

    counter_updown_4bit u_dut(
        .clk(clk), .rst(rst), .updown(updown), .en(en), .count(count)
    );

    always #5 clk = ~clk;

    task check;
        input [127:0] label;
        input [3:0] exp;
        begin
            if (count !== exp) begin
                $display("FAIL: %0s count=%d exp=%d", label, count, exp);
                errors = errors + 1;
            end else begin
                $display("PASS: %0s count=%d", label, count);
            end
        end
    endtask

    initial begin
        $dumpfile("40_counter_4bit_up_down.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        clk = 0; rst = 1; updown = 1; en = 0;

        @(posedge clk); #1;
        check("reset", 4'd0);

        rst = 0; en = 0; updown = 1;
        @(posedge clk); #1;
        check("hold_en0_a", 4'd0);
        @(posedge clk); #1;
        check("hold_en0_b", 4'd0);

        // Count up
        en = 1; updown = 1;
        for (i = 1; i <= 5; i = i + 1) begin
            @(posedge clk); #1;
            check("count_up", i[3:0]);
        end

        // Enable off - hold at 5
        en = 0;
        @(posedge clk); #1;
        check("hold_after_up", 4'd5);
        @(posedge clk); #1;
        check("hold_after_up2", 4'd5);

        // Count down from 5
        en = 1; updown = 0;
        for (i = 4; i >= 0; i = i - 1) begin
            @(posedge clk); #1;
            check("count_down", i[3:0]);
        end

        // Underflow wraps to 15
        @(posedge clk); #1;
        check("underflow_wrap", 4'd15);

        // Reset again mid count
        rst = 1;
        @(posedge clk); #1;
        check("reset_again", 4'd0);
        rst = 0;

        // Overflow wraps from 15 to 0
        en = 1; updown = 1;
        for (i = 1; i <= 15; i = i + 1) begin
            @(posedge clk); #1;
        end
        check("at_15", 4'd15);
        @(posedge clk); #1;
        check("overflow_wrap", 4'd0);

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
