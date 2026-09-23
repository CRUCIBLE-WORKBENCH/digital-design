// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/59_rtl_design_example/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;
    reg clk, rst;
    wire ns_red, ns_green, ew_red, ew_green;

    integer errors;
    integer cyc;

    // Expected ns_green/ew_green per cycle index (0..11), period=12
    // Sequence from cyc=0: NS_GREEN(0-2), NS_YELLOW(3-4), EW_GREEN(5-8), EW_YELLOW(9-10), repeats at 11
    reg [11:0] exp_ns_green = 12'b100000000111; // cycles 0,1,2,11 NS_GREEN
    reg [11:0] exp_ew_green = 12'b000111100000; // cycles 5,6,7,8 EW_GREEN

    rtl_traffic_controller u_dut(
        .clk(clk), .rst(rst),
        .ns_red(ns_red), .ns_green(ns_green),
        .ew_red(ew_red), .ew_green(ew_green)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("59_rtl_design_example.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        clk = 0; rst = 1;

        @(posedge clk); #1;
        if (ns_green !== 1'b1 || ew_green !== 1'b0) begin
            $display("FAIL: reset state ns_green=%b ew_green=%b (expect NS_GREEN)", ns_green, ew_green);
            errors = errors + 1;
        end else begin
            $display("PASS: reset state ns_green=%b ew_green=%b", ns_green, ew_green);
        end
        rst = 0;

        // Run two full cycles (24 clocks) checking mutual exclusivity and sequence
        for (cyc = 0; cyc < 24; cyc = cyc + 1) begin
            @(posedge clk); #1;

            if (ns_green && ew_green) begin
                $display("FAIL: cycle %0d both ns_green and ew_green asserted", cyc);
                errors = errors + 1;
            end

            if (ns_green !== exp_ns_green[cyc % 12]) begin
                $display("FAIL: cycle %0d ns_green=%b exp=%b", cyc, ns_green, exp_ns_green[cyc % 12]);
                errors = errors + 1;
            end else begin
                $display("PASS: cycle %0d ns_green=%b ew_green=%b ns_red=%b ew_red=%b",
                          cyc, ns_green, ew_green, ns_red, ew_red);
            end

            if (ew_green !== exp_ew_green[cyc % 12]) begin
                $display("FAIL: cycle %0d ew_green=%b exp=%b", cyc, ew_green, exp_ew_green[cyc % 12]);
                errors = errors + 1;
            end
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
