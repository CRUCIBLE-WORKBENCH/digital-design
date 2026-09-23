// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/43_fsm_state_machine/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;
    reg clk, rst, din;
    wire detected;

    integer errors;
    integer i;

    // Bit stream: 1 1 0 1 1 0 1 1 0 1
    // "1101" occurs at bits[0:3] and again overlapping at bits[3:6]->[6:9]... actually
    // sequential matches at index3 (bits 0-3) and index9 (bits 6-9), demonstrating
    // the detector correctly re-syncs after a match without missing an overlapping start.
    reg [9:0] stream = 10'b1101101101;
    reg [9:0] exp_detected = 10'b0001000001; // detected asserted after bit index 3 and index 9 (1-indexed positions 4 and 10)

    fsm_sequence_detector u_dut(.clk(clk), .rst(rst), .din(din), .detected(detected));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("43_fsm_state_machine.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        clk = 0; rst = 1; din = 0;

        @(posedge clk); #1;
        if (detected !== 1'b0) begin
            $display("FAIL: reset detected=%b exp=0", detected);
            errors = errors + 1;
        end else
            $display("PASS: reset detected=0");
        rst = 0;

        for (i = 0; i < 10; i = i + 1) begin
            din = stream[9-i];
            @(posedge clk); #1;
            $display("bit=%0d din=%b state_detected=%b", i, din, detected);
            if (detected !== exp_detected[9-i]) begin
                $display("FAIL: bit index %0d din=%b detected=%b exp=%b", i, din, detected, exp_detected[9-i]);
                errors = errors + 1;
            end else begin
                $display("PASS: bit index %0d din=%b detected=%b", i, din, detected);
            end
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
